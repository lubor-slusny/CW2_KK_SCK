AddCSLuaFile()

local TOOL = {}

TOOL.Name = "vmbgsv5"
TOOL.PrintName = "Bodygroups v5"

TOOL.entsDefault = {
	[1] = {label = "Weapon View Model: ", slider = "vm"},
	[2] = {label = "Hands View Model: ", slider = "rig"},
	[3] = {label = "Weapon World Model: ", slider = "wm"},
}

function TOOL:_loadEnts()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end
	
	self._ents = self._ents or self.entsDefault
	
	self._ents[1].ent = ply:GetViewModel()
	self._ents[2].ent = ply:GetHands()
	self._ents[3].ent = wep
	
	if IsValid(wep) then		
		self._ents[1].ent = 
			wep.CW_VM or 
			wep.Wep or 
			ply:GetViewModel()

		self._ents[2].ent = 
			((!wep:IsScripted() or wep.UseHands) and ply:GetHands()) or 
			wep.CW_KK_HANDS or 
			wep.CW_HANDS_VM 

		self._ents[3].ent = 
			wep.WMEnt or 
			wep
	end
end

function TOOL:_addSectionRefresh(panel, entTab)
	local butt = vgui.Create("DButton", panel)
	butt:SetTooltip("Loads changes made outside of this tool.")
	butt:DockMargin(0, 0, 0, 0)	
	butt:SetText("Refresh")
	butt.DoClick = function() TOOL:_updatePanel() end
	panel:AddItem(butt)
end

function TOOL:_addSectionHeader(panel, entTab)
	local ent = entTab.ent
	
	local label = vgui.Create("DLabel", panel)
	label:SetWrap(true)
	label:SetTextInset(0, 0)
	label:SetText(entTab.label)
	label:SetContentAlignment(7)
	label:SetAutoStretchVertical(true)
	label:DockMargin(0, 0, 0, 0)
	label:SetDark(true)
	label:SetTextColor(panel:GetSkin().Colours.Tree.Hover)
	panel:AddItem(label)

	if not ent:GetModel() then
		local label = panel:AddControl("Label", {text = "GetModel ERROR"})
		label:DockMargin(8, 0, 0, 0)
		return true
	end

	local mdl = ent:GetModel()
	local mdlLabel = mdl
	-- mdlLabel = string.Split(mdlLabel, "/")
	-- mdlLabel = mdlLabel[#mdlLabel]
	-- mdlLabel = "[" .. mdlLabel .. "]"

	local label = vgui.Create("DLabel", panel)
	label:SetWrap(true)
	label:SetText(mdlLabel)
	-- label:SetTooltip(mdl)
	label:DockMargin(8, 0, 0, 0)
	-- label:DockMargin(0, 0, 0, 0)
	label:SetDark(true)
	label:SetMouseInputEnabled(true)
	function label:DoClick() SetClipboardText(mdl) end
	panel:AddItem(label)
end

function TOOL:_addSectionSkinSlider(panel, entTab)
	local ent = entTab.ent

	if not ent:SkinCount() then
		local label = panel:AddControl("Label", {text = "SkinCount ERROR"})
		label:DockMargin(8, 0, 0, 0)
		return true
	end

	if not ent:GetSkin() then
		local label = panel:AddControl("Label", {text = "GetSkin ERROR"})
		label:DockMargin(8, 0, 0, 0)
		return true
	end

	local slider
	local skinCount = ent:SkinCount() - 1

	slider = vgui.Create("DNumSlider", panel)
	slider:DockMargin(8, 0, 0, 0)
	slider:SetDecimals(0)
	slider:SetMinMax(0, skinCount)
	slider:SetValue(0)
	slider:SetText("Skin")

	function slider:_kkReload()
		self:SetValue(ent:GetSkin())
	end
	
	self._sliders = self._sliders or {}
	self._sliders[entTab.slider .. "_skin"] = slider
	
	if skinCount > 0 then slider:SetDark(true) end

	function slider:OnValueChanged(val)
		if IsValid(ent) then
			ent:SetSkin(math.Round(val, 0))
		end
	end	

	panel:AddItem(slider)
end

function TOOL:_addSectionBodygroupsHeader(panel, entTab)
	local ent = entTab.ent
	
	local label = vgui.Create("DLabel", panel)
	label:SetText("Bodygroups")
	label:DockMargin(8, 0, 0, 0)
	panel:AddItem(label)
	self._bodygroupsSectionLabel = label

	if not ent:GetNumBodyGroups() then
		local label = panel:AddControl("Label", {text = "GetNumBodyGroups ERROR"})
		label:DockMargin(0, 0, 0, 0)
		return true
	end
end

function TOOL:_addSectionBodygroups(panel, entTab, i)
	local ent = entTab.ent
	
	if not ent:GetBodygroupName(i) then
		local label = panel:AddControl("Label", {text = "GetBodygroupName ERROR"})
		label:DockMargin(0, 0, 0, 0)
		return true
	end

	if not ent:GetBodygroupCount(i) then
		local label = panel:AddControl("Label", {text = "GetBodygroupCount ERROR"})
		label:DockMargin(0, 0, 0, 0)
		return true
	end

	if not ent:GetBodygroup(i) then
		local label = panel:AddControl("Label", {text = "GetBodygroup ERROR"})
		label:DockMargin(0, 0, 0, 0)
		return true
	end

	local bgText = i .. "# " .. ent:GetBodygroupName(i)
	local bgCount = ent:GetBodygroupCount(i) - 1

	slider = vgui.Create("DNumSlider", panel)
	slider:DockMargin(8, 0, 0, 0)
	slider:SetDecimals(0)
	slider:SetMinMax(0, bgCount)
	slider:SetValue(0)
	slider:SetText(bgText)

	function slider:_kkReload()
		self:SetValue(ent:GetBodygroup(i))
	end
	
	self._sliders = self._sliders or {}
	self._sliders[entTab.slider .. "_bg" .. i] = slider
	
	function slider:OnValueChanged(val)
		if IsValid(ent) then
			ent:SetBodygroup(i, math.Round(val, 0))
		end
	end

	panel:AddItem(slider)

	if bgCount > 0 then 
		slider:SetDark(true) 
		self._bodygroupsSectionLabel:SetDark(true)
	end
end

function TOOL:_updateSliders()
	self._sliders = self._sliders or {}
	for _,slider in pairs(self._sliders) do
		slider:_kkReload()
	end
end

function TOOL:_updatePanel()
	local panel = self._panel

	if !IsValid(panel) then return end

	panel:ClearControls()

	self:_addSectionRefresh(panel)
	
	self:_loadEnts()

	for _,entTab in pairs(self._ents) do
		local ent = entTab.ent

		if not IsValid(ent) then
			continue 
		end

		if self:_addSectionHeader(panel, entTab) then
			continue
		end
		
		if self:_addSectionSkinSlider(panel, entTab) then
			continue
		end
		
		if self:_addSectionBodygroupsHeader(panel, entTab) then
			continue
		end
		
		local bgCount = ent:GetNumBodyGroups()

		for i = 0, bgCount - 1 do
			self:_addSectionBodygroups(panel, entTab, i)
		end
	end
	
	self:_updateSliders()
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

function TOOL:OnWeaponChanged(new, old)
	self:_updatePanel()
end

function TOOL:OnWeaponSetupChanged(new, old)
	self:_updatePanel()
end

function TOOL:OnWeaponClipChanged(new, old)
	self:_updateSliders()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
