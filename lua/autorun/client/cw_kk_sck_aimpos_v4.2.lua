AddCSLuaFile()

local BUILD = "429"

// static
local IRONSIGHTSATT = {
	name = "nil",
	displayName = "None (iron sights)",
	_KK_SCK_prefix = "Ironsight",
	aimPos = {
		"IronsightPos", 
		"IronsightAng"
	},
	isSight = true
}

local GRENADELAUNCHER = {
	name = "gl",
	displayName = "CW2 grenade launcher",
	_KK_SCK_prefix = "M203",
	aimPos = {
		"M203Pos", 
		"M203Ang"
	},
	isSight = true
}

// menu items
local MENU = {
	SLIDERS = {},
	LABELS = {},
	BUTTS = {},
	PANELS = {},
	OTHER = {},
}

// weapon data
local WEAPON			// current weapon ENT
local SIGHT				// current weapon sight attachment table

local SUFFIX

local function vectorClone(v)
	return Vector(math.Round(v.x,4), math.Round(v.y,4), math.Round(v.z,4))
end

local function getWeaponAtt(wep)
	local att
	
	for attId,isActive in pairs(wep.ActiveAttachments) do
		local data = CustomizableWeaponry.registeredAttachmentsSKey[attId]
		if isActive and data and data.isGrenadeLauncher and ((wep.dt.M203Active and wep.M203Chamber) or wep.dt.INS2GLActive)then
			GRENADELAUNCHER.name = attId
			att = GRENADELAUNCHER
		end
	end

	if not att then	
		for attId,isActive in pairs(wep.ActiveAttachments) do
			local data = CustomizableWeaponry.registeredAttachmentsSKey[attId]
			if isActive and data and data.isSecondarySight then
				att = data
			end
		end
	end
	
	if not att then
		for attId,isActive in pairs(wep.ActiveAttachments) do
			if isActive and CustomizableWeaponry.sights[attId] then
				att = CustomizableWeaponry.sights[attId]
			end
		end
	end
	
	if not att then
		att = IRONSIGHTSATT
	end
	
	if not att._KK_SCK_prefix then
		att.aimPos = att.aimPos or {"IronsightPos", "IronsightAng"}
		att._KK_SCK_prefix = string.sub(att.aimPos[1], 1, string.len(att.aimPos[1]) - 3)
	end
	
	return att
end

local _LOCK

local function updateSliders()
	_LOCK = true
	for _,slider in pairs(MENU.SLIDERS) do
		slider:_KK_SCK_update()
	end
	_LOCK = false
end

local function vec2fstring(v)
	return v and ("Vector(" .. math.Round(v.x,4) .. ", " .. math.Round(v.y,4) .. ", " .. math.Round(v.z,4) .. ")") or "nil"
end

local function controlsSetEnabled(b)
	for _,slider in pairs(MENU.SLIDERS) do
		slider:SetEnabled(b)
	end
	for _,button in pairs(MENU.BUTTS) do
		button:SetEnabled(b)
	end
end

local function getSightModel()
	if not WEAPON or not SIGHT then return "N/A" end
	
	if not WEAPON.AttachmentModelsVM then return "N/A" end
	if not WEAPON.AttachmentModelsVM[SIGHT.name] then return "N/A" end
	
	return WEAPON.AttachmentModelsVM[SIGHT.name].model
end

local function updateLabels()
	if WEAPON and SIGHT then
		MENU.LABELS.sightPrint:_KK_setText(SIGHT.displayName)
		MENU.LABELS.sightCode:_KK_setText(SIGHT.name)
		MENU.LABELS.sightModel:_KK_setText(getSightModel())
		MENU.LABELS.sightPrefix:_KK_setText(SIGHT._KK_SCK_prefix)
		
		SUFFIX = SUFFIX or ""
		
		MENU.LABELS.sumHeader:SetText("AimPos Code:")
		MENU.LABELS.sumPos:SetText("SWEP." .. SIGHT.aimPos[1] .. SUFFIX .. " = " .. vec2fstring(WEAPON[SIGHT.aimPos[1]]))
		MENU.LABELS.sumAng:SetText("SWEP." .. SIGHT.aimPos[2] .. SUFFIX .. " = " .. vec2fstring(WEAPON[SIGHT.aimPos[2]]))
		
		controlsSetEnabled(true)
		
		return
	end
	
	MENU.LABELS.sightPrint:SetText("Your active weapon does not use CW2 Base.")
	MENU.LABELS.sightCode:SetText("")
	MENU.LABELS.sightModel:SetText("")
	MENU.LABELS.sightPrefix:SetText("")

	MENU.LABELS.sumHeader:SetText("")
	MENU.LABELS.sumPos:SetText("")
	MENU.LABELS.sumAng:SetText("")
	
	for _,slider in pairs(MENU.SLIDERS) do
		slider:SetValue(0)
	end
	
	controlsSetEnabled(false)
end

local _LAST_SETUP

local function menuThink()
	local ply = LocalPlayer()
	if !IsValid(ply) then 
		_LAST_SETUP = nil
		return 
	end
	
	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then 
		_LAST_SETUP = nil
		return 
	end
	
	if wep.CW20Weapon then
		local wepClass = wep:GetClass()
		
		local att = getWeaponAtt(wep)
		
		local setup = wepClass .. "|" .. att.name
		
		if setup != _LAST_SETUP then
			WEAPON = wep
			SIGHT = att
			
			WEAPON._KK_SCK_modifiedPositions = WEAPON._KK_SCK_modifiedPositions or {}
			WEAPON[SIGHT.aimPos[1]] = WEAPON[SIGHT.aimPos[1]] or Vector(0, 0, 0)
			WEAPON[SIGHT.aimPos[2]] = WEAPON[SIGHT.aimPos[2]] or Vector(0, 0, 0)
			
			updateSliders()
		end
		_LAST_SETUP = setup
	else
		WEAPON = nil
		SIGHT = nil
		_LAST_SETUP = nil
	end
	
	updateLabels()
end

// slider sensitivity storage (thx to velement editor)

local stored = {}

local function initSliderStorage(id)
	if not stored[id] then
		stored[id] = CreateClientConVar("_kk_sck_apb_slsens_" .. id, 1, true, false)
	end
end

local function storeSliderZoom(slider)
	local id = slider._KK_SCK_vec .. slider._KK_SCK_vec_pos
	
	initSliderStorage(id)
	
	RunConsoleCommand("_kk_sck_apb_slsens_" .. id, slider.Wang:GetZoom())
end

local function loadSliderZoom(slider)
	local id = slider._KK_SCK_vec .. slider._KK_SCK_vec_pos
	
	initSliderStorage(id)
	
	slider.Wang:SetZoom(stored[id]:GetFloat())
end

// menu element funcs

local function sliderChanged(slider, val)
	if WEAPON and SIGHT and not _LOCK then
		RunConsoleCommand("cw_kk_sck_lock_ads","1")
		RunConsoleCommand("cw_kk_freeze_reticles","1")
		RunConsoleCommand("cw_freeaim","0")
	
		WEAPON._KK_SCK_modifiedPositions[SIGHT.name] = true
		
		local new = math.Round(val,4)
	
		local vec = vectorClone(WEAPON[SIGHT._KK_SCK_prefix .. slider._KK_SCK_vec])
		vec[slider._KK_SCK_vec_pos] = new
		
		WEAPON["Aim" .. slider._KK_SCK_vec] = vectorClone(vec)
		WEAPON["Blend" .. slider._KK_SCK_vec] = vectorClone(vec)
		WEAPON[SIGHT._KK_SCK_prefix .. slider._KK_SCK_vec] = vectorClone(vec)  // does affect weapon.stored? // nope, does not, we re good
		
		storeSliderZoom(slider)
	end
end

local function sliderUpdate(slider)
	if not WEAPON or not SIGHT then return end
	
	if not WEAPON[SIGHT._KK_SCK_prefix .. slider._KK_SCK_vec] then
		WEAPON[SIGHT._KK_SCK_prefix .. slider._KK_SCK_vec] = Vector(0, 0, 0)
	end
	
	slider:SetValue(WEAPON[SIGHT._KK_SCK_prefix .. slider._KK_SCK_vec][slider._KK_SCK_vec_pos])
end

local function buttonReloadAimPos()
	if not WEAPON or not SIGHT then return end
	
	local stored = weapons.GetStored(WEAPON:GetClass())

	local posCopy = vectorClone(stored[SIGHT.aimPos[1]] or Vector(0, 0, 0))
	local angCopy = vectorClone(stored[SIGHT.aimPos[2]] or Vector(0, 0, 0))
	
	WEAPON[SIGHT.aimPos[1]] = posCopy
	WEAPON[SIGHT.aimPos[2]] = angCopy
	
	WEAPON["AimPos"] = posCopy
	WEAPON["AimAng"] = angCopy
	
	WEAPON._KK_SCK_modifiedPositions[SIGHT.name] = false
	
	updateSliders()
end

local function buttonResetCurrent()
	if not WEAPON or not SIGHT then return end
	
	for id,slider in pairs(MENU.SLIDERS) do
		if #id == 2 and slider._KK_SCK_vec then
			slider:SetValue(0)
		end
	end
	
	WEAPON._KK_SCK_modifiedPositions[SIGHT.name] = true
end

local function buttonExportCurrent()
	if not WEAPON or not SIGHT then return end
	
	SUFFIX = SUFFIX or ""
			
	local out = "\n	"
	out = out .. "SWEP." .. SIGHT.aimPos[1] .. SUFFIX .. " = "
	out = out .. vec2fstring(WEAPON[SIGHT.aimPos[1]]) .. "\n	"
	out = out .. "SWEP." .. SIGHT.aimPos[2] .. SUFFIX .. " = "
	out = out .. vec2fstring(WEAPON[SIGHT.aimPos[2]]) .. "\n"
	
	SetClipboardText(out)
end

local function buttonExportAll()
	if not WEAPON or not SIGHT or not WEAPON._KK_SCK_modifiedPositions then return end
	
	local out = ""
	
	for attId,wasModified in pairs(WEAPON._KK_SCK_modifiedPositions) do 
		if wasModified then 
			local sight = CustomizableWeaponry.registeredAttachmentsSKey[attId]
			
			if !sight and attId == IRONSIGHTSATT.name then
				sight = IRONSIGHTSATT
			end
			
			if sight and sight.isGrenadeLauncher /*woop*/ then
				sight = GRENADELAUNCHER
			end
			
			SUFFIX = SUFFIX or ""
			
			out = out .. "\n"
			-- out = out .. "	SWEP." .. sight.aimPos[1] .. " = " .. vec2fstring(WEAPON[sight.aimPos[1]]) .. "\n"
			-- out = out .. "	SWEP." .. sight.aimPos[2] .. " = " .. vec2fstring(WEAPON[sight.aimPos[2]]) .. "\n"
			
			out = out .. "	SWEP." .. sight.aimPos[1] 
			out = out .. SUFFIX .. " = " 
			out = out .. vec2fstring(WEAPON[sight.aimPos[1]]) .. "\n"
			
			out = out .. "	SWEP." .. sight.aimPos[2]
			out = out .. SUFFIX .. " = " 
			out = out .. vec2fstring(WEAPON[sight.aimPos[2]]) .. "\n"
		end
	end
	
	SetClipboardText(out)
end

local function buttonExportCurrentBackup()
	if not WEAPON or not SIGHT then return end
	
	local out = ""
	
	if !WEAPON.BackupSights then
		out = "\n	SWEP.BackupSights = {"
	end
	
	out = out .. "\n		"
	out = out .. "[\"" .. SIGHT.name .. "\"] = {\n			"
	out = out .. vec2fstring(WEAPON[SIGHT.aimPos[1]]) .. ",\n			"
	out = out .. vec2fstring(WEAPON[SIGHT.aimPos[2]]) .. "\n		},\n"
	
	if !WEAPON.BackupSights then
		out = out .. "	}\n	"
	end
	
	SetClipboardText(out)
end

local function buildPanel(panel)
	panel:ClearControls()
	
	panel:AddControl("CheckBox", {Label = "Force GM crosshair", Command = "cw_kk_gm_xhair"}):DockMargin(8, 0, 8, 0)
	panel:AddControl("CheckBox", {Label = "Freeze reticles (supported sights only)", Command = "cw_kk_freeze_reticles"}):DockMargin(8, 0, 8, 0)
	panel:AddControl("CheckBox", {Label = "Hold aim (+attack2 spam)", Command = "cw_kk_sck_lock_ads"}):DockMargin(8, 0, 8, 0)
	panel:AddControl("CheckBox", {Label = "Free Aim: Enabled (shortcut)", Command = "cw_freeaim"}):DockMargin(8, 0, 8, 0)
	
	MENU.LABELS.buildHeader = panel:AddControl("Label", {Text = "Sight setup:"})
	MENU.LABELS.buildHeader:DockMargin(0, 0, 0, 0)
	
	MENU.BUTTS.apb_reload = vgui.Create("DButton", panel)
	MENU.BUTTS.apb_reload:SetText("Reload AimPos")
	MENU.BUTTS.apb_reload:SetTooltip("Reloads original AimPos.")
	MENU.BUTTS.apb_reload:DockMargin(8, 0, 8, 0)
	MENU.BUTTS.apb_reload.DoClick = buttonReloadAimPos
	panel:AddItem(MENU.BUTTS.apb_reload)
	
	MENU.BUTTS.apb_000000 = vgui.Create("DButton", panel)
	MENU.BUTTS.apb_000000:SetText("Wipe AimPos")
	MENU.BUTTS.apb_000000:SetTooltip("Sets all aimpos sliders to 0.")
	MENU.BUTTS.apb_000000:DockMargin(8, 0, 8, 0)
	MENU.BUTTS.apb_000000.DoClick = buttonResetCurrent
	panel:AddItem(MENU.BUTTS.apb_000000)
	
	MENU.PANELS.sightPrint = vgui.Create("DPanel", panel)
	
		MENU.LABELS.sightPrint = vgui.Create("DLabel", MENU.PANELS.sightPrint)
		MENU.LABELS.sightPrint:SetDark(true)
		MENU.LABELS.sightPrint:Dock(FILL)
		MENU.LABELS.sightPrint:SizeToContents()
		MENU.LABELS.sightPrint:SetMouseInputEnabled(true)
		
		function MENU.LABELS.sightPrint:_KK_setText(t)
			self:SetText("Print: " .. t)
		end
		
		function MENU.LABELS.sightPrint:DoClick()
			if not WEAPON or not SIGHT then return end
			SetClipboardText(SIGHT.displayName)
		end
	
		MENU.PANELS.sightPrint:DockMargin(8, 0, 8, -4)
		MENU.PANELS.sightPrint:SetTall(16)
		
	panel:AddItem(MENU.PANELS.sightPrint)
	
	MENU.PANELS.sightCode = vgui.Create("DPanel", panel)
	
		MENU.LABELS.sightCode = vgui.Create("DLabel", MENU.PANELS.sightCode)
		MENU.LABELS.sightCode:SetDark(true)
		MENU.LABELS.sightCode:Dock(FILL)
		MENU.LABELS.sightCode:SizeToContents()
		MENU.LABELS.sightCode:SetMouseInputEnabled(true)
		
		function MENU.LABELS.sightCode:_KK_setText(t)
			t = t == ("nil") and "N/A" or "[\"" .. t .. "\"]"
			self:SetText("Code: " .. t)
		end
		
		function MENU.LABELS.sightCode:DoClick()
			if not WEAPON or not SIGHT then return end
		
			if SIGHT.name == ("nil") then
				SetClipboardText("N/A")
			else
				SetClipboardText(SIGHT.name)
			end
		end
		
		MENU.PANELS.sightCode:DockMargin(8, -4, 8, -4)
		MENU.PANELS.sightCode:SetTall(16)
		
	panel:AddItem(MENU.PANELS.sightCode)
	
	MENU.PANELS.sightModel = vgui.Create("DPanel", panel)
	
		MENU.LABELS.sightModel = vgui.Create("DLabel", MENU.PANELS.sightModel)
		MENU.LABELS.sightModel:SetDark(true)
		MENU.LABELS.sightModel:Dock(FILL)
		MENU.LABELS.sightModel:SizeToContents()
		MENU.LABELS.sightModel:SetMouseInputEnabled(true)
		
		function MENU.LABELS.sightModel:_KK_setText(t)
			self:SetText("Model: " .. t)
		end
		
		function MENU.LABELS.sightModel:DoClick()
			if not WEAPON or not SIGHT then return end
			SetClipboardText(getSightModel())
		end
		
		MENU.PANELS.sightModel:DockMargin(8, -4, 8, -4)
		MENU.PANELS.sightModel:SetTall(16)
		
	panel:AddItem(MENU.PANELS.sightModel)
	
	MENU.PANELS.sightPrefix = vgui.Create("DPanel", panel)
			
		MENU.LABELS.sightPrefix = vgui.Create("DLabel", MENU.PANELS.sightPrefix)
		MENU.LABELS.sightPrefix:SetDark(true)
		MENU.LABELS.sightPrefix:Dock(FILL)
		MENU.LABELS.sightPrefix:SizeToContents()
		MENU.LABELS.sightPrefix:SetMouseInputEnabled(true)
		
		function MENU.LABELS.sightPrefix:_KK_setText(t)
			self:SetText("Prefix: " .. t)
		end
		
		function MENU.LABELS.sightPrefix:DoClick()
			if not WEAPON or not SIGHT then return end
			SetClipboardText(SIGHT._KK_SCK_prefix)
		end
		
		MENU.PANELS.sightPrefix:DockMargin(8, -4, 8, -4)
		MENU.PANELS.sightPrefix:SetTall(16)
	
	panel:AddItem(MENU.PANELS.sightPrefix)
	
	MENU.LABELS.suffixLabel = vgui.Create("DLabel", panel)
	MENU.LABELS.suffixLabel:SetText("Mod suffix:")
	MENU.LABELS.suffixLabel:SetDark(true)
	MENU.LABELS.suffixLabel:DockMargin(12, 0, 0, 0)
	
	MENU.OTHER.suffixEntry = vgui.Create("DTextEntry", panel)
	MENU.OTHER.suffixEntry:Dock(TOP)
	MENU.OTHER.suffixEntry:DockMargin(0, 0, 8, 0)
	
	function MENU.OTHER.suffixEntry:OnEnter()
		SUFFIX = self:GetValue()
	end
	
	panel:AddItem(MENU.LABELS.suffixLabel, MENU.OTHER.suffixEntry)
	
	local id
	
	id = "px"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-50, 50)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pos.x")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id]._KK_SCK_vec = "Pos"
	MENU.SLIDERS[id]._KK_SCK_vec_pos = "x"
	MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
	panel:AddItem(MENU.SLIDERS[id])

	loadSliderZoom(MENU.SLIDERS[id])
	
	id = "py"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-50, 50)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pos.y")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id]._KK_SCK_vec = "Pos"
	MENU.SLIDERS[id]._KK_SCK_vec_pos = "y"
	MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
	panel:AddItem(MENU.SLIDERS[id])

	loadSliderZoom(MENU.SLIDERS[id])
	
	id = "pz"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-50, 50)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pos.z")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id]._KK_SCK_vec = "Pos"
	MENU.SLIDERS[id]._KK_SCK_vec_pos = "z"
	MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
	panel:AddItem(MENU.SLIDERS[id])

	loadSliderZoom(MENU.SLIDERS[id])
	
	id = "ax"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-180, 180)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pitch")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id]._KK_SCK_vec = "Ang"
	MENU.SLIDERS[id]._KK_SCK_vec_pos = "x"
	MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
	panel:AddItem(MENU.SLIDERS[id])

	loadSliderZoom(MENU.SLIDERS[id])
	
	id = "ay"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-180, 180)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Yaw")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id]._KK_SCK_vec = "Ang"
	MENU.SLIDERS[id]._KK_SCK_vec_pos = "y"
	MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
	panel:AddItem(MENU.SLIDERS[id])

	loadSliderZoom(MENU.SLIDERS[id])
	
	id = "az"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-180, 180)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Roll")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id]._KK_SCK_vec = "Ang"
	MENU.SLIDERS[id]._KK_SCK_vec_pos = "z"
	MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
	panel:AddItem(MENU.SLIDERS[id])
	
	loadSliderZoom(MENU.SLIDERS[id])
	
	MENU.PANELS.sum = vgui.Create("DPanel", panel)
	
		MENU.LABELS.sumHeader = vgui.Create("DLabel", MENU.PANELS.sum)
		MENU.LABELS.sumHeader:SetText("AimPos Code:")
		MENU.LABELS.sumHeader:SetDark(true)
		MENU.LABELS.sumHeader:Dock(TOP)
		MENU.LABELS.sumHeader:DockMargin(0,0,0,-12)
		MENU.LABELS.sumHeader:SetMouseInputEnabled(true)
		MENU.LABELS.sumHeader.DoClick = buttonExportCurrent
		
		MENU.LABELS.sumPos = vgui.Create("DLabel", MENU.PANELS.sum)
		MENU.LABELS.sumPos:SetDark(true)
		MENU.LABELS.sumPos:Dock(FILL)
		MENU.LABELS.sumPos:DockMargin(0,-12,0,-12)
		MENU.LABELS.sumPos:SetMouseInputEnabled(true)
		MENU.LABELS.sumPos.DoClick = buttonExportCurrent
		
		MENU.LABELS.sumAng = vgui.Create("DLabel", MENU.PANELS.sum)
		MENU.LABELS.sumAng:SetDark(true)
		MENU.LABELS.sumAng:Dock(BOTTOM)
		MENU.LABELS.sumAng:DockMargin(0,-12,0,0)
		MENU.LABELS.sumAng:SetMouseInputEnabled(true)
		MENU.LABELS.sumAng.DoClick = buttonExportCurrent
		
		MENU.PANELS.sum:DockMargin(8, 0, 8, 0)
		MENU.PANELS.sum:SetTall(48)
		
	panel:AddItem(MENU.PANELS.sum)
	
	MENU.BUTTS.apb_exportbackup = vgui.Create("DButton", panel)
	MENU.BUTTS.apb_exportbackup:SetText("Export as backup sight")
	MENU.BUTTS.apb_exportbackup:SetTooltip("Copy current AimPositions in backup sight format to clipboard.")
	MENU.BUTTS.apb_exportbackup:DockMargin(8, 0, 8, 0)
	MENU.BUTTS.apb_exportbackup.DoClick = buttonExportCurrentBackup
	panel:AddItem(MENU.BUTTS.apb_exportbackup)
	
	MENU.BUTTS.apb_export2 = vgui.Create("DButton", panel)
	MENU.BUTTS.apb_export2:SetText("Export all modified")
	MENU.BUTTS.apb_export2:SetTooltip("Copy all modified AimPositions of current weapon to clipboard.")
	MENU.BUTTS.apb_export2:DockMargin(8, 0, 8, 0)
	MENU.BUTTS.apb_export2.DoClick = buttonExportAll
	panel:AddItem(MENU.BUTTS.apb_export2)
	
	// AIM PLAYER FOV ADJUSTMENT
		
		MENU.LABELS.fovAimSlider = panel:AddControl("Label", {Text = "SWEP.ZoomAmount"})
		MENU.LABELS.fovAimSlider:DockMargin(8, 0, 0, 0)
		
		MENU.SLIDERS.fovAim = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS.fovAim:DockMargin(16, 0, 8, 0)
		MENU.SLIDERS.fovAim:SetDecimals(0)
		MENU.SLIDERS.fovAim:SetMinMax(0, 85)
		MENU.SLIDERS.fovAim:SetValue(0)
		MENU.SLIDERS.fovAim:SetText("_Orig =")
		MENU.SLIDERS.fovAim:SetDark(true)
		
		function MENU.SLIDERS.fovAim:OnValueChanged(val)
			if not WEAPON or not SIGHT then return end
			
			WEAPON.ZoomAmount = val
		end
		
		function MENU.SLIDERS.fovAim:_KK_SCK_update()
			if not WEAPON or not SIGHT then return end
			
			self:SetText("_Orig = " .. WEAPON.ZoomAmount_Orig)
			self:SetValue(WEAPON.ZoomAmount)
		end
		
		panel:AddItem(MENU.SLIDERS.fovAim)

	// AIM VM FOV ADJUSTMENT
		
		MENU.LABELS.fovVMSlider = panel:AddControl("Label", {Text = "SWEP.AimViewModelFOV"})
		MENU.LABELS.fovVMSlider:DockMargin(8, 0, 0, 0)
		
		MENU.SLIDERS.fovVM = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS.fovVM:DockMargin(16, 0, 8, 0)
		MENU.SLIDERS.fovVM:SetDecimals(0)
		MENU.SLIDERS.fovVM:SetMinMax(1, 150)
		MENU.SLIDERS.fovVM:SetValue(0)
		MENU.SLIDERS.fovVM:SetText("_Orig =")
		MENU.SLIDERS.fovVM:SetDark(true)
		
		function MENU.SLIDERS.fovVM:OnValueChanged(val)
			if not WEAPON or not SIGHT then return end
			
			WEAPON.AimViewModelFOV = val
		end
		
		function MENU.SLIDERS.fovVM:_KK_SCK_update()
			if not WEAPON or not SIGHT then return end
			
			self:SetText("_Orig = " .. WEAPON.AimViewModelFOV_Orig)
			self:SetValue(WEAPON.AimViewModelFOV)
		end
		
		panel:AddItem(MENU.SLIDERS.fovVM)

	// AIM VM SWAY ADJUSTMENT
		
		MENU.LABELS.aimSwaySlider = panel:AddControl("Label", {Text = "SWEP.AimSwayIntensity"})
		MENU.LABELS.aimSwaySlider:DockMargin(8, 0, 0, 0)
		
		MENU.SLIDERS.aimSway = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS.aimSway:DockMargin(16, 0, 8, 0)
		MENU.SLIDERS.aimSway:SetDecimals(2)
		MENU.SLIDERS.aimSway:SetMinMax(0, 2)
		MENU.SLIDERS.aimSway:SetValue(0)
		MENU.SLIDERS.aimSway:SetText("_Orig =")
		MENU.SLIDERS.aimSway:SetDark(true)
		
		function MENU.SLIDERS.aimSway:OnValueChanged(val)
			if not WEAPON or not SIGHT then return end
			
			WEAPON.AimSwayIntensity = val
		end
		
		function MENU.SLIDERS.aimSway:_KK_SCK_update()
			if not WEAPON or not SIGHT then return end
			
			local num = nil
			local class = WEAPON:GetClass()
			
			while (num == nil and class != nil) do
				num = weapons.GetStored(class).AimSwayIntensity
				class = weapons.GetStored(class).Base
			end
			
			num = num or 911
			self:SetText("_Orig = " .. num)
			self:SetValue(WEAPON.AimSwayIntensity)
		end
		
		panel:AddItem(MENU.SLIDERS.aimSway)

	// ALTERNATIVE ORIGIN TEMP
		
		MENU.LABELS.alternativePosSliders = panel:AddControl("Label", {Text = "SWEP.AlternativePos"})
		MENU.LABELS.alternativePosSliders:DockMargin(0, 0, 0, 0)
		
		local function sliderUpdate(slider)
			if not WEAPON or not SIGHT then return end
			
			if not WEAPON["Alternative" .. slider._KK_SCK_vec] then
				WEAPON["Alternative" .. slider._KK_SCK_vec] = Vector(0, 0, 0)
			end
			
			slider:SetValue(WEAPON["Alternative" .. slider._KK_SCK_vec][slider._KK_SCK_vec_pos])
		end

		local function sliderChanged(slider, val)
			if WEAPON and SIGHT and not _LOCK then
				local new = math.Round(val,4)
			
				local vec = vectorClone(WEAPON["Alternative" .. slider._KK_SCK_vec])
				vec[slider._KK_SCK_vec_pos] = new
				
				WEAPON["Blend" .. slider._KK_SCK_vec] = vectorClone(vec)
				WEAPON["Alternative" .. slider._KK_SCK_vec] = vectorClone(vec)  // does affect weapon.stored? // nope, does not, we re good
			end
		end
		
		MENU.BUTTS.origin_wipe = vgui.Create("DButton", panel)
		MENU.BUTTS.origin_wipe:SetText("Wipe origin")
		MENU.BUTTS.origin_wipe:SetTooltip("Resets origin settings to zeros.")
		MENU.BUTTS.origin_wipe:DockMargin(8, 0, 8, 0)
		
		function MENU.BUTTS.origin_wipe:DoClick()
			if not WEAPON or not SIGHT then return end
			
			for id,slider in pairs(MENU.SLIDERS) do
				if #id == 5 and slider._KK_SCK_vec then
					slider:SetValue(0)
				end
			end
		end
		
		panel:AddItem(MENU.BUTTS.origin_wipe)
		
		id = "ap_px"
		MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
		MENU.SLIDERS[id]:SetDecimals(4)
		MENU.SLIDERS[id]:SetMinMax(-50, 50)
		MENU.SLIDERS[id]:SetValue(0)
		MENU.SLIDERS[id]:SetText("Pos.x")
		MENU.SLIDERS[id]:SetDark(true)
		MENU.SLIDERS[id].OnValueChanged = sliderChanged
		MENU.SLIDERS[id]._KK_SCK_vec = "Pos"
		MENU.SLIDERS[id]._KK_SCK_vec_pos = "x"
		MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
		panel:AddItem(MENU.SLIDERS[id])

		id = "ap_py"
		MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
		MENU.SLIDERS[id]:SetDecimals(4)
		MENU.SLIDERS[id]:SetMinMax(-50, 50)
		MENU.SLIDERS[id]:SetValue(0)
		MENU.SLIDERS[id]:SetText("Pos.y")
		MENU.SLIDERS[id]:SetDark(true)
		MENU.SLIDERS[id].OnValueChanged = sliderChanged
		MENU.SLIDERS[id]._KK_SCK_vec = "Pos"
		MENU.SLIDERS[id]._KK_SCK_vec_pos = "y"
		MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
		panel:AddItem(MENU.SLIDERS[id])

		id = "ap_pz"
		MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
		MENU.SLIDERS[id]:SetDecimals(4)
		MENU.SLIDERS[id]:SetMinMax(-50, 50)
		MENU.SLIDERS[id]:SetValue(0)
		MENU.SLIDERS[id]:SetText("Pos.z")
		MENU.SLIDERS[id]:SetDark(true)
		MENU.SLIDERS[id].OnValueChanged = sliderChanged
		MENU.SLIDERS[id]._KK_SCK_vec = "Pos"
		MENU.SLIDERS[id]._KK_SCK_vec_pos = "z"
		MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
		panel:AddItem(MENU.SLIDERS[id])

		id = "ap_ax"
		MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
		MENU.SLIDERS[id]:SetDecimals(4)
		MENU.SLIDERS[id]:SetMinMax(-180, 180)
		MENU.SLIDERS[id]:SetValue(0)
		MENU.SLIDERS[id]:SetText("Pitch")
		MENU.SLIDERS[id]:SetDark(true)
		MENU.SLIDERS[id].OnValueChanged = sliderChanged
		MENU.SLIDERS[id]._KK_SCK_vec = "Ang"
		MENU.SLIDERS[id]._KK_SCK_vec_pos = "x"
		MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
		panel:AddItem(MENU.SLIDERS[id])

		id = "ap_ay"
		MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
		MENU.SLIDERS[id]:SetDecimals(4)
		MENU.SLIDERS[id]:SetMinMax(-180, 180)
		MENU.SLIDERS[id]:SetValue(0)
		MENU.SLIDERS[id]:SetText("Yaw")
		MENU.SLIDERS[id]:SetDark(true)
		MENU.SLIDERS[id].OnValueChanged = sliderChanged
		MENU.SLIDERS[id]._KK_SCK_vec = "Ang"
		MENU.SLIDERS[id]._KK_SCK_vec_pos = "y"
		MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
		panel:AddItem(MENU.SLIDERS[id])

		id = "ap_az"
		MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
		MENU.SLIDERS[id]:DockMargin(8, 0, 8, 0)
		MENU.SLIDERS[id]:SetDecimals(4)
		MENU.SLIDERS[id]:SetMinMax(-180, 180)
		MENU.SLIDERS[id]:SetValue(0)
		MENU.SLIDERS[id]:SetText("Roll")
		MENU.SLIDERS[id]:SetDark(true)
		MENU.SLIDERS[id].OnValueChanged = sliderChanged
		MENU.SLIDERS[id]._KK_SCK_vec = "Ang"
		MENU.SLIDERS[id]._KK_SCK_vec_pos = "z"
		MENU.SLIDERS[id]._KK_SCK_update = sliderUpdate
		panel:AddItem(MENU.SLIDERS[id])
	
		MENU.BUTTS.origin_export = vgui.Create("DButton", panel)
		MENU.BUTTS.origin_export:SetText("Export origin")
		MENU.BUTTS.origin_export:SetTooltip("Copy formated origin setting from above to clipboard.")
		MENU.BUTTS.origin_export:DockMargin(8, 0, 8, 0)
		
		function MENU.BUTTS.origin_export:DoClick()
			if not WEAPON or not SIGHT then return end
			
			local out = "\n	"
			out = out .. "SWEP.AlternativePos = "
			out = out .. vec2fstring(WEAPON.AlternativePos) .. "\n	"
			out = out .. "SWEP.AlternativeAng = "
			out = out .. vec2fstring(WEAPON.AlternativeAng) .. "\n"
			
			SetClipboardText(out)
		end
		
		panel:AddItem(MENU.BUTTS.origin_export)
		
	// hint hint
	
	for _,dpanel in pairs(MENU.PANELS) do
		dpanel:DockPadding(4, 0, 4, 0)
		dpanel:SetTooltip("Copy to clipboard.")
	end
	
	hook.Add("Think", "CW_KK_DEV_MENU_" .. BUILD, menuThink)
end

hook.Add( "PopulateToolMenu", "KK_SCK_AIMPOS_" .. BUILD, function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_AIMPOS_" .. BUILD, "AimPos Builder 4.2", "", "", buildPanel)
end)

hook.Add("PostReloadToolsMenu", "CW_KK_DEV_MENU_" .. BUILD .. "_REMOVER", function()
	hook.Remove("Think", "CW_KK_DEV_MENU_" .. BUILD)
end)

-- RunConsoleCommand("spawnmenu_reload")

KK_SCK_AIMPOS_ELEMENTS = MENU
