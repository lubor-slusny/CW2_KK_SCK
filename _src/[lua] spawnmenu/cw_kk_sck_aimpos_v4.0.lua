AddCSLuaFile()

local BUILD = "40"

// static
local IRONSIGHTSATT = {
	name = "nil",
	displayName = "None (iron sights)",
	KKSCK_prefix = "Ironsight",
	aimPos = {
		"IronsightPos", 
		"IronsightAng"
	},
	isSight = true
}

// menu items
local MENU = {
	SLIDERS = {},
	LABELS = {},
	BUTTS = {},
}

// weapon data
local BACKUP = {} 		// table of original aimpositions
local MODIFIED = {}		// table of modified aimpositions - for "Export All"
local WEAPON			// current weapon ENT
local SIGHT				// current weapon sight attachment table

// mem access sync
local LOCK

local function vectorClone(v) 
	-- return Vector(v.x, v.y, v.z)
	
	if !v or !v.x or !v.y or !v.z then return nil end
	return Vector(math.Round(v.x,4), math.Round(v.y,4), math.Round(v.z,4))
end

local function getWeaponAtt(wep)
	local att
	
	for k,v in pairs(wep.ActiveAttachments) do
		if v and CustomizableWeaponry.registeredAttachmentsSKey[k].isSecondarySight then
			att = CustomizableWeaponry.registeredAttachmentsSKey[k]
		end
	end
	
	if not att then
		for k,v in pairs(wep.ActiveAttachments) do
			if v and CustomizableWeaponry.sights[k] then
				att = CustomizableWeaponry.sights[k]
			end
		end
	end
	
	if not att then
		att = IRONSIGHTSATT
	end
	
	if not att.KKSCK_prefix then
		att.KKSCK_prefix = string.sub(att.aimPos[1], 1, string.len(att.aimPos[1]) - 3)
	end
	
	return att
end

local LAST_SETUP

local function updateSliders()
	LOCK = true
	for k,v in pairs(MENU.SLIDERS) do
		if not WEAPON[SIGHT.KKSCK_prefix .. v.KKSCK_vec] then
			WEAPON[SIGHT.KKSCK_prefix .. v.KKSCK_vec] = Vector(0, 0, 0)
		end
		v:SetValue(WEAPON[SIGHT.KKSCK_prefix .. v.KKSCK_vec][v.KKSCK_vec_pos])
	end
	LOCK = false
end

local function vec2fstring(v)
	return "Vector(" .. math.Round(v.x,4) .. ", " .. math.Round(v.y,4) .. ", " .. math.Round(v.z,4) .. ")"
end

local function controlsSetEnabled(b)
	for k,v in pairs(MENU.SLIDERS) do
		v:SetEnabled(b)
	end
	for k,v in pairs(MENU.BUTTS) do
		v:SetEnabled(b)
	end
end

local function updateLabels()
	if WEAPON and SIGHT then
		-- MENU.LABELS.sumHeader:SetText("AimPos Code:")
		
		local sightText = "Print: " .. SIGHT.displayName .. "\n"
		sightText = sightText .. "Code: [" .. SIGHT.name .. "]\n"
		sightText = sightText .. "Prefix: " .. SIGHT.KKSCK_prefix
		
		MENU.LABELS.sight:SetText(sightText)
		
		local sumText
		sumText = "SWEP." .. SIGHT.aimPos[1] .. " = "
		sumText = sumText .. vec2fstring(WEAPON[SIGHT.aimPos[1]]) .. "\n"
		sumText = sumText .. "SWEP." .. SIGHT.aimPos[2] .. " = "
		sumText = sumText .. vec2fstring(WEAPON[SIGHT.aimPos[2]])
		
		MENU.LABELS.sum:SetText(sumText)
		controlsSetEnabled(true)
		
		return
	end
	
	MENU.LABELS.sight:SetText("Current weapon does not use CW2 Base.")
	-- MENU.LABELS.sumHeader:SetText("")
	MENU.LABELS.sum:SetText("SWEP.IronsightPos = Vector(0, 0, 0)\nSWEP.IronsightAng = Vector(0, 0, 0)")
	
	for k,v in pairs(MENU.SLIDERS) do
		v:SetValue(0)
	end
	
	controlsSetEnabled(false)
end

local function menuThink()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end
	
	if wep.CW20Weapon then
		local wepClass = wep:GetClass()
		
		local att = getWeaponAtt(wep)
		
		local setup = wepClass .. "|" .. att.name
		
		if setup != LAST_SETUP then
			// store original aimpos
			if not BACKUP[wepClass] then BACKUP[wepClass] = {} end
			if not BACKUP[wepClass][att.name] then 
				local pos = wep[att.aimPos[1]]
				local ang = wep[att.aimPos[2]]
			
				if pos and ang then
					BACKUP[wepClass][att.name] = {
						pos = vectorClone(pos),
						ang = vectorClone(ang)
					}
				else
					wep[att.aimPos[1]] = Vector(0, 0, 0)
					wep[att.aimPos[2]] = Vector(0, 0, 0)
					wep["AimPos"] = Vector(0, 0, 0)
					wep["AimAng"] = Vector(0, 0, 0)
					
					BACKUP[wepClass][att.name] = {
						pos = Vector(0, 0, 0),
						ang = Vector(0, 0, 0)
					}
				end
			end
			
			if not MODIFIED[wepClass] then MODIFIED[wepClass] = {} end
			
			// butt wait, theres more
			WEAPON = wep
			SIGHT = att
			
			updateSliders()
		end
		LAST_SETUP = setup
	else
		WEAPON = nil
		SIGHT = nil
		LAST_SETUP = nil
	end
	
	updateLabels()
end

// menu element funcs

local function sliderChanged(slider, val)
	if WEAPON and SIGHT and not LOCK then
		RunConsoleCommand("cw_kk_sck_lock_ads","1")
		RunConsoleCommand("cw_kk_freeze_reticles","1")
		RunConsoleCommand("cw_freeaim","0")
	
		MODIFIED[WEAPON:GetClass()][SIGHT.name] = true
		
		local new = math.Round(val,4)
	
		local vec = vectorClone(WEAPON[SIGHT.KKSCK_prefix .. slider.KKSCK_vec])
		vec[slider.KKSCK_vec_pos] = new
		
		WEAPON["Aim" .. slider.KKSCK_vec] = vectorClone(vec)
		WEAPON["Blend" .. slider.KKSCK_vec] = vectorClone(vec)
		WEAPON[SIGHT.KKSCK_prefix .. slider.KKSCK_vec] = vectorClone(vec)
	end
end

local function buttonReloadAimPos()
	if not WEAPON or not SIGHT then return end
	
	local posCopy = vectorClone(BACKUP[WEAPON:GetClass()][SIGHT.name].pos)
	local angCopy = vectorClone(BACKUP[WEAPON:GetClass()][SIGHT.name].ang)
	
	WEAPON[SIGHT.aimPos[1]] = posCopy
	WEAPON[SIGHT.aimPos[2]] = angCopy
	
	WEAPON["AimPos"] = posCopy
	WEAPON["AimAng"] = angCopy
	
	MODIFIED[WEAPON:GetClass()][SIGHT.name] = false
	
	updateSliders()
end

local function buttonResetSliders()
	if not WEAPON or not SIGHT then return end
	
	for k,v in pairs(MENU.SLIDERS) do
		v:SetValue(0)
	end
	
	MODIFIED[WEAPON:GetClass()][SIGHT.name] = true
end

local function buttonExportCurrent()
	if not WEAPON or not SIGHT then return end
	
	local out = "\n"
	out = out .. "	SWEP." .. SIGHT.aimPos[1] .. " = "
	out = out .. vec2fstring(WEAPON[SIGHT.aimPos[1]]) .. "\n	"
	out = out .. "SWEP." .. SIGHT.aimPos[2] .. " = "
	out = out .. vec2fstring(WEAPON[SIGHT.aimPos[2]]) .. "\n"
	
	SetClipboardText(out)
end

local function buttonExportAll()
	if not WEAPON or not SIGHT then return end
	
	local out = "\n"
	
	for k,v in pairs(MODIFIED[WEAPON:GetClass()]) do 
		if v then 
			local sight = CustomizableWeaponry.registeredAttachmentsSKey[k]
			
			if !sight and k == IRONSIGHTSATT.name then
				sight = IRONSIGHTSATT
			end
			
			out = out .. "	SWEP." .. sight.aimPos[1] .. " = "
			out = out .. vec2fstring(WEAPON[sight.aimPos[1]]) .. "\n	"
			out = out .. "SWEP." .. sight.aimPos[2] .. " = "
			out = out .. vec2fstring(WEAPON[sight.aimPos[2]]) .. "\n\n"
		end
	end
	
	SetClipboardText(out)
end

local function buildPanel(panel)
	panel:ClearControls()

	panel:AddControl("CheckBox", {Label = "[Override] Force GM crosshair", Command = "cw_kk_gm_xhair"}):DockMargin(8, 0, 8, 8)
	panel:AddControl("CheckBox", {Label = "Freeze reticles (RT and Stencils only)", Command = "cw_kk_freeze_reticles"}):DockMargin(8, 0, 8, 8)
	panel:AddControl("CheckBox", {Label = "Hold aim", Command = "cw_kk_sck_lock_ads"}):DockMargin(8, 0, 8, 8)
		
	MENU.LABELS.buildHeader = panel:AddControl("Label", {Text = "AimPos Building:"})
	MENU.LABELS.buildHeader:DockMargin(0, 0, 0, 0)
	
	MENU.BUTTS.apb_reload = vgui.Create("DButton", PANEL)
	MENU.BUTTS.apb_reload:SetText("Reload")
	MENU.BUTTS.apb_reload:SetTooltip("Reloads original AimPos.")
	MENU.BUTTS.apb_reload:DockMargin(8, 0, 8, 8)
	MENU.BUTTS.apb_reload.DoClick = buttonReloadAimPos
	panel:AddItem(MENU.BUTTS.apb_reload)
	
	MENU.BUTTS.apb_000000 = vgui.Create("DButton", PANEL)
	MENU.BUTTS.apb_000000:SetText("000000")
	MENU.BUTTS.apb_000000:SetTooltip("Sets all sliders to 0.")
	MENU.BUTTS.apb_000000:DockMargin(8, 0, 8, 8)
	MENU.BUTTS.apb_000000.DoClick = buttonResetSliders
	panel:AddItem(MENU.BUTTS.apb_000000)
	
	MENU.LABELS.sight = panel:AddControl("Label", {Text = "Sight: none (iron sights)\nPrefix: Ironsight"})
	MENU.LABELS.sight:DockMargin(8, 0, 8, 8)

	local id
	
	id = "px"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 8)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-50, 50)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pos.x")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id].KKSCK_vec = "Pos"
	MENU.SLIDERS[id].KKSCK_vec_pos = "x"
	panel:AddItem(MENU.SLIDERS[id])

	id = "py"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 8)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-50, 50)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pos.y")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id].KKSCK_vec = "Pos"
	MENU.SLIDERS[id].KKSCK_vec_pos = "y"
	panel:AddItem(MENU.SLIDERS[id])

	id = "pz"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 8)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-50, 50)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pos.z")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id].KKSCK_vec = "Pos"
	MENU.SLIDERS[id].KKSCK_vec_pos = "z"
	panel:AddItem(MENU.SLIDERS[id])

	id = "ax"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 8)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-180, 180)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Pitch")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id].KKSCK_vec = "Ang"
	MENU.SLIDERS[id].KKSCK_vec_pos = "x"
	panel:AddItem(MENU.SLIDERS[id])

	id = "ay"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 8)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-180, 180)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Yaw")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id].KKSCK_vec = "Ang"
	MENU.SLIDERS[id].KKSCK_vec_pos = "y"
	panel:AddItem(MENU.SLIDERS[id])

	id = "az"
	MENU.SLIDERS[id] = vgui.Create("DNumSlider", panel)
	MENU.SLIDERS[id]:DockMargin(8, 0, 8, 8)
	MENU.SLIDERS[id]:SetDecimals(4)
	MENU.SLIDERS[id]:SetMinMax(-180, 180)
	MENU.SLIDERS[id]:SetValue(0)
	MENU.SLIDERS[id]:SetText("Roll")
	MENU.SLIDERS[id]:SetDark(true)
	MENU.SLIDERS[id].OnValueChanged = sliderChanged
	MENU.SLIDERS[id].KKSCK_vec = "Ang"
	MENU.SLIDERS[id].KKSCK_vec_pos = "z"
	panel:AddItem(MENU.SLIDERS[id])

	MENU.LABELS.sumHeader = panel:AddControl("Label", {Text = "AimPos Code:"})
	MENU.LABELS.sumHeader:DockMargin(8, 0, 8, 8)
	
	MENU.LABELS.sum = panel:AddControl("Label", {Text = "SWEP.IronsightPos = Vector(0, 0, 0)\nSWEP.IronsightAng = Vector(0, 0, 0)"})
	MENU.LABELS.sum:DockMargin(8, 0, 8, 8)

	MENU.BUTTS.apb_export = vgui.Create("DButton", PANEL)
	MENU.BUTTS.apb_export:SetText("Export current")
	MENU.BUTTS.apb_export:SetTooltip("Copies AimPos displayed above to clipboard.")
	MENU.BUTTS.apb_export:DockMargin(8, 0, 8, 8)
	MENU.BUTTS.apb_export.DoClick = buttonExportCurrent
	panel:AddItem(MENU.BUTTS.apb_export)
	
	MENU.BUTTS.apb_export2 = vgui.Create("DButton", PANEL)
	MENU.BUTTS.apb_export2:SetText("Export all modified")
	MENU.BUTTS.apb_export2:SetTooltip("Copies all modified AimPositions of current weapon to clipboard.")
	MENU.BUTTS.apb_export2:DockMargin(8, 0, 8, 8)
	MENU.BUTTS.apb_export2.DoClick = buttonExportAll
	panel:AddItem(MENU.BUTTS.apb_export2)
	
	hook.Add("Think", "CW_KK_DEV_MENU_" .. BUILD, menuThink)
end

local function populateMenu()
	if GetConVarNumber("cw_kk_dev_menu") != 0 then 
		spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_AIMPOS_" .. BUILD, "Sight positions", "", "", buildPanel)
		-- spawnmenu.AddToolMenuOption("Utilities", "CW 2.0 SWEPs", "Client (DEV v4)", "Client (DEV v4)", "", "", buildPanel)
	end
end

hook.Add( "PopulateToolMenu", "KK_SCK_AIMPOS_" .. BUILD, populateMenu)

hook.Add("PostReloadToolsMenu", "CW_KK_DEV_MENU_" .. BUILD .. "_REMOVER", function()
	hook.Remove("Think", "CW_KK_DEV_MENU_" .. BUILD)
end)

// DELETE BELOW // debug code
RunConsoleCommand("spawnmenu_reload")
