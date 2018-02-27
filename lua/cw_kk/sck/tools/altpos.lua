AddCSLuaFile()

// some globals

if CLIENT then
	local cvPB = CreateClientConVar("_cw_kk_pause_blend", 0, false, false)

	if game.SinglePlayer() then
		local ply, wep

		local origVMMSs = {}
		local attribute = "performViewmodelMovement"
		local overrideValue = function(wep)
			wep.BlendPos = Vector(wep.AlternativePos)
			wep.BlendAng = Vector(wep.AlternativeAng)
		end
		hook.Add("Think", "_cw_kk_sck_lock_ads_think", function()
			ply = LocalPlayer()
			wep = ply:GetActiveWeapon()

			if !wep.CW20Weapon then return end

			if cvPB:GetInt() == 1 then
				origVMMSs[wep] = origVMMSs[wep] or wep[attribute]
				wep[attribute] = overrideValue
			else
				for wep,val in pairs(origVMMSs) do
					if !IsValid(wep) then
						continue
					end

					wep[attribute] = val
				end

				origVMMSs = {}
			end
		end)
	end
end

// tool

local TOOL = {}

TOOL.Name = "altpos"
TOOL.PrintName = "01 | AltPos Builder"
TOOL.Version = "1.0"

function TOOL:_addSectionWipeReload()
	local panel = self._panel
	local wep = self._wep
	local wepStored = self._wepStored

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local listView = vgui.Create("DListView", backgroundPanel)
		listView:SetHeaderHeight(20)
		listView:AddColumn("Wipe")
		listView:AddColumn("Reload")

		listView:Dock(FILL)
		listView:SizeToContents()
		listView:SetPaintBackground(false)
		listView:FixColumnsLayout()
		listView.OnRequestResize = function() end

		function listView:SortByColumn(i)
			// wipe
			if (i == 1) then
				for _,slider in pairs(TOOL._sliders) do
					slider:SetValue(0)
				end

				return
			end

			// reload
			if wepStored then
				for _,part in pairs({"Pos", "Ang"}) do
					local key = "Alternative" .. part
					local vec = wepStored[key]
					wep[key] = vec
				end
			end

			TOOL:_updatePanel()
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionSliders()
	local panel = self._panel
	local wep = self._wep

	for _,part in pairs({"Pos", "Ang"}) do
		local key = "Alternative" .. part
		wep[key] =
			wep[key] and
			Vector(wep[key]) or
			Vector()
	end

	self._sliders = {}

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

	for _,s in pairs({
		{"Pos", "x", -100, 100},
		{"Pos", "y", -100, 100},
		{"Pos", "z", -100, 100},
		{"Ang", "x", -90, 90},
		{"Ang", "y", -180, 180},
		{"Ang", "z", -180, 180},
	}) do
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(TOP)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(4)
		slider:SetMinMax(s[3], s[4])
		slider:SetText(s[1] .. "." .. s[2])
		slider:SetDark(true)
		slider:SetValue(wep["Alternative" .. s[1]][s[2]])

		self:LoadSliderZoom(slider)

		function slider:OnValueChanged(val)
			TOOL:SaveSliderZoom(self)

			local key = "Alternative" .. s[1]
			local vec = wep[key]
			vec[s[2]] = val
			wep[key] = vec

			TOOL:_updatePreviews()
		end

		-- panel:AddItem(slider)

		table.insert(self._sliders, slider)
	end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,32*6)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionPreviewExport()
	local panel = self._panel
	local wep = self._wep

	self._codePreviews = {}

	local function DoClick()
		SetClipboardText(TOOL:_getCode())
	end

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick

		self._codePreviews[label] = function(l)
			l:SetText(
				"SWEP.AlternativePos = " ..
				self:VectorToString(wep.AlternativePos)
			)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick

		self._codePreviews[label] = function(l)
			l:SetText(
				"SWEP.AlternativeAng = " ..
				self:VectorToString(wep.AlternativeAng)
			)
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,38)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	backgroundPanel:SetMouseInputEnabled(true)
	backgroundPanel.DoClick = DoClick

	self:_updatePreviews()
end

function TOOL:_updatePreviews()
	for label,update in pairs(self._codePreviews) do
		update(label)
	end
end

function TOOL:_getCode()
	local wep = self._wep

	local pos = "AlternativePos"
	local ang = "AlternativeAng"

	local out = string.format(
		"\n	SWEP.%s = %s\n	SWEP.%s = %s\n",
		pos,
		self:VectorToString(wep[pos]),
		ang,
		self:VectorToString(wep[ang])
	)

	return out
end

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep

	if !IsValid(panel) then return end

	panel:ClearControls()

	if !IsValid(wep) then
		self:ThrowNewInvalidWeapon()
		return
	end

	if !wep.CW20Weapon then
		self:ThrowNewNotCW2Weapon()
		return
	end

	local cbox = panel:AddControl("CheckBox", {Label = "Custom weapon origins? (shortcut)", Command = "cw_alternative_vm_pos"})
	cbox:DockMargin(8,0,8,0)

	local cbox = panel:AddControl("CheckBox", {Label = "Freeze blend pos", Command = "_cw_kk_pause_blend"})
	cbox:DockMargin(8,0,8,0)

	self._wepStored = weapons.GetStored(wep:GetClass())

	self:_addSectionWipeReload()
	self:_addSectionSliders()
	self:AddHeaderSimpleLR(panel, "Code:", "[LMB - COPY]")
	self:_addSectionPreviewExport()
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

function TOOL:OnWeaponChanged(new, old)
	self._wep = new
	self:_updatePanel()
end

function TOOL:OnWeaponSetupChanged()
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
