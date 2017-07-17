AddCSLuaFile()

////////////
// LEGACY //
////////////

if CLIENT then
	local SP = game.SinglePlayer()
	local cvXH = CreateClientConVar("_cw_kk_gm_xhair", 0, false, false)
	local cvLA = CreateClientConVar("_cw_kk_sck_lock_ads", 0, false, false)
	
	if SP then
		local ply, wep
		
		hook.Add("Think", "_cw_kk_gm_xhair_think", function()
			ply = LocalPlayer()
			wep = ply:GetActiveWeapon()
			
			if !wep.CW20Weapon then return end
			
			wep.DrawCrosshair = cvXH:GetInt() == 1
		end)
		
		local _ADS_LAST, cur
		hook.Add("Think", "_cw_kk_sck_lock_ads_think", function() 
			cur = cvLA:GetInt()
			if cur != _ADS_LAST and _ADS_LAST != nil then
				if cur == 0 then
					RunConsoleCommand("-attack2")
				else
					RunConsoleCommand("+attack2")
				end
			end
			_ADS_LAST = cur
		end)
	end
end

////////////
//   V5   //
////////////

CustomizableWeaponry.originalValue:add("AimSwayIntensity", false, false)

local TOOL = {}

TOOL.Name = "aimpos"
TOOL.PrintName = "AimPos Builder 5"
TOOL.Version = "5.0"

TOOL.cvarPresetEdit = {
	["_cw_kk_sck_lock_ads"] = "1",
	["cw_kk_freeze_reticles"] = "1",
	["cw_freeaim"] = "0",
}

function TOOL:Initialize()
	if not self._relevantAttsCache then
		local primary = {}
		local secondary = {}
		local grenade = {}
		
		for _,att in pairs(CustomizableWeaponry.registeredAttachments) do
			local attInfo = {}
			local subCache
			
			if att.isSight then
				subCache = primary
			elseif att.isSecondarySight then
				subCache = secondary
			elseif att.isGrenadeLauncher then
				attInfo.prefix = "M203"
				subCache = grenade
			else
				continue
			end
			
			attInfo.name = att.name
			attInfo.displayName = att.displayName
			attInfo.prefix = attInfo.prefix
				or att.aimPos and
					string.sub(att.aimPos[1], 1, string.len(att.aimPos[1]) - 3)
				or "Aim"
			
			table.insert(subCache, attInfo)
		end
		
		self._relevantAttsCache = {}
		self._relevantAttsCache.secondary = secondary
		self._relevantAttsCache.grenade = grenade
		self._relevantAttsCache.primary = primary
		
		self.cvarResetDelay = 3
		self._suffix = ""
		self._curSet = {}
	end
	
	self._relevantAttsCache.fallback = {
		name = "nil",
		displayName = "Blank (iron sights)",
		prefix = "Ironsight"
	}
end

function TOOL:_addSectionCvars()
	local panel = self._panel
	
	local cbox = panel:AddControl("CheckBox", {Label = "Freeze reticles (supported sights only)", Command = "cw_kk_freeze_reticles"})
	cbox:DockMargin(8, 0, 8, 0)
	
	local cbox = panel:AddControl("CheckBox", {Label = "Hold aim (+attack2 spam)", Command = "_cw_kk_sck_lock_ads"})
	cbox:DockMargin(8, 0, 8, 0)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("^^ auto-restore in (-1 dont):")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(0,0,4,0)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,4,0)
		-- entry:SetWide(32)
		entry:SetNumeric(true)
		entry:SetText(self.cvarResetDelay)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("s")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(4,0,0,0)
		label:SizeToContents()
		
		function entry:OnEnter()
			TOOL.cvarResetDelay = self:GetFloat()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	local cbox = panel:AddControl("CheckBox", {Label = "Force GM crosshair", Command = "_cw_kk_gm_xhair"})
	cbox:DockMargin(8, 0, 8, 0)
	
	local cbox = panel:AddControl("CheckBox", {Label = "Free Aim: Enabled (shortcut)", Command = "cw_freeaim"})
	cbox:DockMargin(8, 0, 8, 0)
	
end

function TOOL:_addSectionHeader(left, right)
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(left or "")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(right or "")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:SizeToContents()
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(16)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionAttInfo()
	local panel = self._panel
	local wep = self._wep
	local att = self._att

	self:_addSectionHeader("Sight setup:", "[LMB - COPY]")

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local value = att.displayName
		local function DoClick() SetClipboardText(value) end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Print:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(value)
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(4,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	backgroundPanel:SetMouseInputEnabled(true)
	backgroundPanel.DoClick = DoClick
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local value = att.name
		local function DoClick() SetClipboardText(value) end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Code:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(value)
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(4,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local value = 
			wep.AttachmentModelsVM and
			wep.AttachmentModelsVM[att.name] and 
			wep.AttachmentModelsVM[att.name].model or
			""
		local function DoClick() SetClipboardText(value) end
		local parts = string.Explode("/", value)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Model:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(parts[#parts])
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(4,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local value = att.prefix
		local function DoClick() SetClipboardText(value) end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Prefix:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(value)
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(4,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Custom Suffix:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,0,0)
		entry:SetText(self._suffix)
		
		function entry:OnEnter()
			TOOL._suffix = self:GetValue()
			TOOL:_updatePanel()
		end
		
		function entry:OnChange()
			local suffix = self:GetValue()
			if wep[att.prefix .. "Pos" .. suffix] then
				self:OnEnter()
			end
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionWipeReload()
	local panel = self._panel
	local wep = self._wep
	local att = self._att
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
			TOOL:_forceCVarSettings()
			
			// wipe
			if (i == 1) then
				for _,slider in pairs(TOOL._sightSliders) do
					slider:SetValue(0)
				end
				
				return
			end
			
			// reload
			if wepStored then
				local prefix = att.prefix
				local suffix = TOOL._suffix
			
				for _,part in pairs({"Pos", "Ang"}) do
					local key = prefix .. part .. suffix
					local vec = wepStored[key]
					
					wep[key] = Vector(vec)
					wep["Aim" .. part] = Vector(vec)
					wep["Blend" .. part] = Vector(vec)
				end
			end
			
			TOOL:_curSetRemove()
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_forceCVarSettings()
	local cvs = {}
	
	for id,val in pairs(self.cvarPresetEdit) do
		cvs[id] = GetConVar(id):GetString()
		RunConsoleCommand(id, val)
	end
	
	self._cvarPresetRestore = self._cvarPresetRestore or cvs
	self._nextCvarReset = CurTime() + self.cvarResetDelay
end

function TOOL:_curSetAdd(name, prefix, suffix)
	name = name or self._att.name
	prefix = prefix or self._att.prefix
	suffix = suffix or self._suffix
	
	local key = prefix .. "|" .. suffix
	if not TOOL._curSet[wep].skey[key] then
		TOOL._curSet[wep].skey[key] =
			table.insert(TOOL._curSet[wep].ikey,
				{name = name, prefix = prefix, suffix = suffix}
			)
	end
end

function TOOL:_curSetRemove(prefix, suffix)
	prefix = prefix or self._att.prefix
	suffix = suffix or self._suffix
	
	local key = prefix .. "|" .. suffix
	if TOOL._curSet[wep].skey[key] then
		table.remove(
			TOOL._curSet[wep].ikey,
			TOOL._curSet[wep].skey[key]
		)
		TOOL._curSet[wep].skey[key] = nil
	end
end

function TOOL:_addSectionSlidersSight()
	local panel = self._panel
	local wep = self._wep
	local att = self._att

	local prefix = att.prefix
	local suffix = self._suffix
	
	for _,part in pairs({"Pos", "Ang"}) do
		local key = prefix .. part .. suffix
		wep[key] = 
			wep[key] and 
			Vector(wep[key]) or
			Vector()
	end
	
	self._sightSliders = {}
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
	for _,s in pairs({
		{"Pos", "x", -50, 50},
		{"Pos", "y", -50, 50},
		{"Pos", "z", -50, 50},
		{"Ang", "x", -90, 90},
		{"Ang", "y", -90, 90},
		{"Ang", "z", -90, 90},
	}) do
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(TOP)
		slider:DockMargin(8,0,8,0)
		slider:SetText(s[1] .. "." .. s[2])
		slider:SetDark(true)
		slider:SetMinMax(s[3], s[4])
		slider:SetDecimals(4)
		slider:SetValue(wep[prefix .. s[1] .. suffix][s[2]])
		
		self:LoadSliderZoom(slider)
		
		function slider:OnValueChanged(val)
			TOOL:SaveSliderZoom(self)
			
			TOOL:_forceCVarSettings()
			
			TOOL:_curSetAdd()
			
			local key = prefix .. s[1] .. suffix
			local vec = wep[key] or Vector()
			
			vec[s[2]] = val
			
			wep[key] = Vector(vec)
			wep["Aim" .. s[1]] = Vector(vec)
			wep["Blend" .. s[1]] = Vector(vec)
			
			TOOL:_updatePreviews()
		end
		
		table.insert(self._sightSliders, slider)
	end
	
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,32*6)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_updatePreviews()
	for label,update in pairs(self._codePreviews) do
		update(label)
	end
end

function TOOL:_getAimPosCode(prefix, suffix)
	local wep = self._wep
	
	prefix = prefix or self._att.prefix
	suffix = suffix or self._suffix
	
	local pos = prefix .. "Pos" .. suffix
	local ang = prefix .. "Ang" .. suffix
	
	local out = string.format(
		"\n	SWEP.%s = %s\n	SWEP.%s = %s\n",
		pos,
		self:VectorToString(wep[pos]),
		ang,
		self:VectorToString(wep[ang])
	)
	
	return out
end

function TOOL:_getBackupCode(name, prefix, suffix)
	local wep = self._wep
	
	name = name or self._att.name
	prefix = prefix or self._att.prefix
	suffix = suffix or self._suffix
	
	local pos = prefix .. "Pos" .. suffix
	local ang = prefix .. "Ang" .. suffix
	
	local out = string.format(
		"\n		[\"%s\"] = {\n			[1] = %s,\n			[2] = %s,\n		},\n",
		name,
		self:VectorToString(wep[pos]),
		self:VectorToString(wep[ang])
	)
	
	return out
end

function TOOL:_exportAllNormal()
	local out = ""
	
	for _,kv in pairs(self._curSet[wep].ikey) do
		out = out .. self:_getAimPosCode(kv.prefix, kv.suffix)
	end
	
	return out
end

function TOOL:_exportAllBackup()
	local out = ""
	
	for _,kv in pairs(self._curSet[wep].ikey) do
		out = out .. self:_getBackupCode(kv.name, kv.prefix, kv.suffix)
	end
	
	return out
end

function TOOL:_finalizeBackupCode(code)
	local wep = self._wep
	
	if !wep.BackupSights then
		code = string.format(
			"\n	SWEP.BackupSights = {%s	}\n",
			code
		)
	end
	
	return code
end

function TOOL:_addSectionExportPreviews()
	local panel = self._panel
	local wep = self._wep
	local att = self._att

	self:_addSectionHeader("Sight Code:", "[LMB - COPY]")

	self._codePreviews = {}
	
	local function DoClick()
		SetClipboardText(TOOL:_getAimPosCode())
	end
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		self._codePreviews[label] = function(l)
			local key = att.prefix .. "Pos" .. TOOL._suffix
			l:SetText(string.format(
				"SWEP.%s = %s",
				key,
				self:VectorToString(wep[key])
			))
		end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		self._codePreviews[label] = function(l)
			local key = att.prefix .. "Ang" .. TOOL._suffix
			l:SetText(string.format(
				"SWEP.%s = %s",
				key,
				self:VectorToString(wep[key])
			))
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,38)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	backgroundPanel:SetMouseInputEnabled(true)
	backgroundPanel.DoClick = DoClick
	
	local function DoClick()
		local code = TOOL:_getBackupCode()
		code = TOOL:_finalizeBackupCode(code)
		
		SetClipboardText(code)
	end
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("[\"" .. att.name .. "\"] = {")
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		self._codePreviews[label] = function(l)
			local key = att.prefix .. "Pos"
			l:SetText(string.format(
				"        [1] = %s,",
				self:VectorToString(wep[key])
			))
		end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		self._codePreviews[label] = function(l)
			local key = att.prefix .. "Ang"
			l:SetText(string.format(
				"        [2] = %s,",
				self:VectorToString(wep[key])
			))
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,56)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	backgroundPanel:SetMouseInputEnabled(true)
	backgroundPanel.DoClick = DoClick
	
	self:_updatePreviews()
end

function TOOL:_addSectionExportButts()
	local panel = self._panel
	local wep = self._wep

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local listView = vgui.Create("DListView", backgroundPanel)
		listView:SetHeaderHeight(20)
		listView:AddColumn("Export all as normal")
		listView:AddColumn("Export all as backup")
		
		listView:Dock(FILL)
		listView:SizeToContents()
		listView:SetPaintBackground(false)
		listView:FixColumnsLayout()
		listView.OnRequestResize = function() end
		
		function listView:SortByColumn(i)			
			// normal
			if (i == 1) then
				SetClipboardText(TOOL:_exportAllNormal())
				return
			end
			
			// backup
			local code = TOOL:_exportAllBackup()
			SetClipboardText(TOOL:_finalizeBackupCode(code))
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionMisc()
	local panel = self._panel
	local wep = self._wep

	self:_addSectionHeader("Misc:")
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP.ZoomAmount")
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(8,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(TOP)
		slider:DockMargin(8,0,8,0)
		slider:SetText("_Orig = " .. tostring(self._wep.ZoomAmount_Orig))
		slider:SetDark(true)
		slider:SetMinMax(0, 85)
		slider:SetDecimals(4)
		slider:SetValue(self._wep.ZoomAmount)
		
		function slider:OnValueChanged(val)
			TOOL._wep.ZoomAmount = val
		end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP.AimViewModelFOV")
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(8,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(TOP)
		slider:DockMargin(8,0,8,0)
		slider:SetText("_Orig = " .. tostring(self._wep.AimViewModelFOV_Orig))
		slider:SetDark(true)
		slider:SetMinMax(1,150)
		slider:SetDecimals(4)
		slider:SetValue(self._wep.AimViewModelFOV)
		
		function slider:OnValueChanged(val)
			TOOL._wep.AimViewModelFOV = val
		end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP.AimSwayIntensity *")
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(8,4,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(TOP)
		slider:DockMargin(8,0,8,0)
		slider:SetText("_Orig = " .. tostring(self._wep.AimSwayIntensity_Orig))
		slider:SetDark(true)
		slider:SetMinMax(-5,5)
		slider:SetDecimals(4)
		slider:SetValue(self._wep.AimSwayIntensity)
		
		function slider:OnValueChanged(val)
			TOOL._wep.AimSwayIntensity = val
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,32*3 + 18*3)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	panel:AddControl("Label", {Text = "* original value registered and stored by this tool"})
end

function TOOL:_prepareAttInfo()
	local wep = self._wep

	if (wep.dt.INS2GLActive or wep.dt.M203Active) then
		for _,att in pairs(self._relevantAttsCache.grenade) do
			if wep.ActiveAttachments[att.name] then
				self._att = att
				return
			end
		end
	end
	
	for _,att in pairs(self._relevantAttsCache.secondary) do
		if wep.ActiveAttachments[att.name] then
			self._att = att
			return
		end
	end
	
	for _,att in pairs(self._relevantAttsCache.primary) do
		if wep.ActiveAttachments[att.name] then
			self._att = att
			return
		end
	end
	
	self._att = self._relevantAttsCache.fallback
end

function TOOL:GetCurrentAttachmentInfo()
	return self._att
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
	
	self:_prepareAttInfo()
	self._wepStored = weapons.GetStored(wep:GetClass())
	
	self._curSet[wep] = self._curSet[wep] or {
		skey = {},
		ikey = {}
	}
	
	self:_addSectionCvars()
	self:_addSectionAttInfo()
	self:_addSectionWipeReload()
	self:_addSectionSlidersSight()
	self:_addSectionExportPreviews()
	self:_addSectionExportButts()
	self:_addSectionMisc()
	
	panel:AddControl("Label", {Text = ""})
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

function TOOL:OnWeaponGLStateChanged()
	self:_updatePanel()
end

function TOOL:Think()
	if self._nextCvarReset and self.cvarResetDelay > 0 and self._nextCvarReset < CurTime() then
		self._nextCvarReset = false
		
		for id,val in pairs(self._cvarPresetRestore) do
			RunConsoleCommand(id, val)
		end
		
		self._cvarPresetRestore = nil
	end
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
