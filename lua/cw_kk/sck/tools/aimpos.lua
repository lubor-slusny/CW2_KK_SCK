if not CustomizableWeaponry_KK.HOME then return end

CustomizableWeaponry.originalValue:add("AimSwayIntensity", false, false)

local TOOL = {}

TOOL.Name = "aimpos"
TOOL.PrintName = "AimPos Builder 5"
TOOL.Version = "5.0"

function TOOL:Initialize()
	self._relevantAttsCache = false // deleteme
	
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
	end
	
	self._relevantAttsCache.fallback = {
		name = "nil",
		displayName = "Blank (iron sights)",
		prefix = "Ironsight"
	}
end

function TOOL:_addSectionCvars(panel)
	local cbox = panel:AddControl("CheckBox", {Label = "Force GM crosshair", Command = "_cw_kk_gm_xhair"})
	cbox:DockMargin(8, 0, 8, 0)
	
	local cbox = panel:AddControl("CheckBox", {Label = "Freeze reticles (supported sights only)", Command = "cw_kk_freeze_reticles"})
	cbox:DockMargin(8, 0, 8, 0)
	
	local cbox = panel:AddControl("CheckBox", {Label = "Hold aim (+attack2 spam)", Command = "_cw_kk_sck_lock_ads"})
	cbox:DockMargin(8, 0, 8, 0)
	
	local cbox = panel:AddControl("CheckBox", {Label = "Free Aim: Enabled (shortcut)", Command = "cw_freeaim"})
	cbox:DockMargin(8, 0, 8, 0)
	
	panel:AddControl("Label", {Text = "tentry auto-off^^"})
end

function TOOL:_addSectionHeaderAttInfo(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Sight setup:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("[LMB - COPY]")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:SizeToContents()
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(16)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionAttInfo(panel, wep, att)
	self:_addSectionHeaderAttInfo(panel)

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
		
		function entry:OnEnter()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionWipeReload(panel, wep, att, wepStored)
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
				for _,slider in pairs(TOOL._sightSliders) do
					slider:SetValue(0)
				end
				
				return
			end
			
			// reload
			if wepStored then
				local prefix = att.prefix
				local suffix = ""
			
				for _,part in pairs({"Pos", "Ang"}) do
					local key = prefix .. part .. suffix
					local vec = wepStored[key]
					
					wep[key] = Vector(vec)
					wep["Aim" .. part] = Vector(vec)
					wep["Blend" .. part] = Vector(vec)
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

function TOOL:_addSectionSlidersSight(panel, wep, att)
	local prefix = att.prefix
	local suffix = ""
	
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
			
			RunConsoleCommand("_cw_kk_sck_lock_ads","1")
			RunConsoleCommand("cw_kk_freeze_reticles","1")
			RunConsoleCommand("cw_freeaim","0")
			
			local key = prefix .. s[1] .. suffix
			local vec = wep[key]
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

function TOOL:_addSectionHeaderExports(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Sight Code:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("[LMB - COPY]")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:SizeToContents()
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(16)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function TOOL:_updatePreviews()
	for label,update in pairs(self._codePreviews) do
		update(label)
	end
end

function TOOL:_addSectionExportPreviews(panel, wep, att)
	self:_addSectionHeaderExports(panel)

	self._codePreviews = {}
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		
		self._codePreviews[label] = function(l)
			local key = att.prefix .. "Pos"
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
		
		self._codePreviews[label] = function(l)
			local key = att.prefix .. "Ang"
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
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("[\"" .. att.name .. "\"] = {")
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(4,4,4,0)
		label:SizeToContents()
		
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
	
	self:_updatePreviews()
end

function TOOL:_addSectionExportButts(panel, wep)
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
			TOOL:ThrowNewNotImplemented()
			
			// normal
			if (i == 1) then
				return
			end
			
			// backup
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionMisc(panel, wep)
	panel:AddControl("Label", {Text = "Misc:"}):DockMargin(0,0,0,0)
	
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
		slider:SetValue(0)
		
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
		slider:SetValue(0)
		
		function slider:OnValueChanged(val)
			TOOL._wep.AimViewModelFOV = val
		end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP.AimSwayIntensity*")
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
		slider:SetValue(0)
		
		function slider:OnValueChanged(val)
			TOOL._wep.AimSwayIntensity = val
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,32*3 + 18*3)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	panel:AddControl("Label", {Text = "*original value registered and stored by this tool"})
	panel:AddControl("Label", {Text = ""})
end

function TOOL:_prepareAttInfo(wep)
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

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	if !IsValid(wep) or !wep.CW20Weapon then
		panel:AddControl("Label", {Text = "Not a CW2 swep, move along."})
		return
	end
	
	local wepStored = weapons.GetStored(wep:GetClass())
	
	self:_prepareAttInfo(wep)
	local att = self._att
	
	self:_addSectionCvars(panel)
	self:_addSectionAttInfo(panel, wep, att)
	self:_addSectionWipeReload(panel, wep, att, wepStored)
	self:_addSectionSlidersSight(panel, wep, att)
	self:_addSectionExportPreviews(panel, wep, att)
	self:_addSectionExportButts(panel, wep)
	self:_addSectionMisc(panel, wep)
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

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
