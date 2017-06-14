AddCSLuaFile()

local POS = Vector(0, 0, 0)
local ANG = Vector(0, 0, 0)

local sliders = {}
local labels = {}
local prefix = "Ironsight"
local lockSettings

local last_wep
local last_att

local function KKSCK_Think()
	// save last weap chk for change
	// save last att chk for change
	// eh?
	
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	
	local wep
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then return end
	
	if not wep.CW20Weapon then
		labels.sight:SetText("No CW2 weapon equiped.")
		if wep == last_wep then return end
	end
	
	last_wep = wep
	
	
	
	
	last_att = att
end

local function settingsToString()
	return "SWEP." .. prefix .. "Pos = Vector(" .. math.Round(POS.x,4) .. ", " .. math.Round(POS.y,4) .. ", " .. math.Round(POS.z,4) .. ")\nSWEP." .. prefix .. "Ang = Vector(" .. math.Round(ANG.x,4) .. ", " .. math.Round(ANG.y,4) .. ", " .. math.Round(ANG.z,4) .. ")"
end

local function applySettings()
	if lockSettings then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	
	local wep
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then return end
	
	if not wep.CW20Weapon then
		labels.sight:SetText("No CW2 weapon equiped.")
		return 
	end
	
	wep.AimPos = Vector(POS.x, POS.y, POS.z)
	wep.AimAng = Vector(ANG.x, ANG.y, ANG.z)
	wep.BlendPos = Vector(POS.x, POS.y, POS.z)
	wep.BlendAng = Vector(ANG.x, ANG.y, ANG.z)
	wep[prefix .. "Pos"] = Vector(POS.x, POS.y, POS.z)
	wep[prefix .. "Ang"] = Vector(ANG.x, ANG.y, ANG.z)
	
	labels.sum:SetText(settingsToString())
end

local function loadAimPos()
	ply = LocalPlayer()
	if not IsValid(ply) then return end
	
	local wep
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then return end
	if not wep.CW20Weapon then
		labels.sight:SetText("No CW2 weapon equiped.")
		return 
	end
	
	local sightName
	sightName = wep:getActiveAttachmentInCategory(1)

	if not sightName then
		prefix = "Ironsight"
		labels.sight:SetText("Sight: none (iron sights)\nPrefix: " .. prefix)
	else
		local sightTable = CustomizableWeaponry.sights[sightName]
		if sightTable then
			prefix = string.sub(sightTable.aimPos[1], 1, string.len(sightTable.aimPos[1]) - 3) 
			labels.sight:SetText("Sight: " .. sightTable.displayName .. "[" .. sightTable.name .. "]" .. "\nPrefix: " .. prefix)
		end
	end
	
	local AimPos = wep.AimPos
	local AimAng = wep.AimAng
	
	lockSettings = true
	
	sliders["px"]:SetValue(AimPos.x)
	sliders["py"]:SetValue(AimPos.y)
	sliders["pz"]:SetValue(AimPos.z)
	sliders["ax"]:SetValue(AimAng.x)
	sliders["ay"]:SetValue(AimAng.y)
	sliders["az"]:SetValue(AimAng.z)
	
	lockSettings = false
	
	labels.sum:SetText(settingsToString())
end

local function resetSliders()
	sliders["px"]:SetValue(0)
	sliders["py"]:SetValue(0)
	sliders["pz"]:SetValue(0)
	sliders["ax"]:SetValue(0)
	sliders["ay"]:SetValue(0)
	sliders["az"]:SetValue(0)
	
	labels.sum:SetText(settingsToString())
end

local function exportSettings()
	-- SetClipboardText(settingsToString())
	
	local out
	out = "\n	SWEP." .. prefix .. "Pos = Vector("
	out = out .. math.Round(POS.x,4) .. ", " .. math.Round(POS.y,4) .. ", " .. math.Round(POS.z,4)
	out = out .. ")\n	SWEP." .. prefix .. "Ang = Vector("
	out = out .. math.Round(ANG.x,4) .. ", " .. math.Round(ANG.y,4) .. ", " .. math.Round(ANG.z,4)
	out = out .. ")\n"
	SetClipboardText(out)
end

concommand.Add("cw_kk_aim_load", loadAimPos)
concommand.Add("cw_kk_aim_reset", resetSliders)
concommand.Add("cw_kk_aim_export", exportSettings)

local function onValueChanged(val)
	val.KK_vec[val.KK_vecPos] = val:GetValue() // rewrite value in shared vector // yup im eeeeevul
	applySettings()
end

local function createSlider(panel, id)
	sliders[id] = vgui.Create("DNumSlider", panel)
	
	sliders[id]:DockMargin(8, 0, 8, 8)
	sliders[id]:SetDecimals(4)
	
	local pa
	if id[1] == "p" then
		sliders[id].KK_vec = POS // store pointer to shared vector
		sliders[id]:SetMinMax(-50, 50)
		pa = "Pos"
	else
		sliders[id].KK_vec = ANG
		sliders[id]:SetMinMax(-180, 180)
		pa = "Ang"
	end
	sliders[id].KK_vecPos = id[2] // store position for pointer to shared vector
	
	sliders[id]:SetValue(0)
	
	sliders[id]:SetText(pa .. "." .. id[2])
	sliders[id]:SetDark(true)
	
	sliders[id].OnValueChanged = onValueChanged
	
	panel:AddItem(sliders[id])
end

local function getKey(cc)
	local k = input.LookupBinding(cc)
	
	if k != nil then
		return "[" .. k .. "]"
	end
	
	return ""
end

local function CW2_ClientsidePanelDev(panel)
	panel:ClearControls()
	
	panel:AddControl("CheckBox", {Label = "[Override] Force GM crosshair", Command = "cw_kk_gm_xhair"}):DockMargin(8, 0, 8, 8)
	panel:AddControl("CheckBox", {Label = "Freeze reticles (RT and Stencils only)", Command = "cw_kk_freeze_reticles"}):DockMargin(8, 0, 8, 8)
	panel:AddControl("CheckBox", {Label = "Lock ADS", Command = "cw_kk_aim_lock_ads"}):DockMargin(8, 0, 8, 8)
	
	labels.buildHeader = panel:AddControl("Label", {Text = "AimPos Building:"})
	labels.buildHeader:DockMargin(0, 0, 0, 0)
	
	panel:AddControl("Button", {Label = "Load", Command = "cw_kk_aim_load"}):DockMargin(8, 0, 8, 8)
	panel:AddControl("Button", {Label = "000000", Command = "cw_kk_aim_reset"}):DockMargin(8, 0, 8, 8)
	
	labels.sight = panel:AddControl("Label", {Text = "Sight: none (iron sights)\nPrefix: " .. prefix})
	labels.sight:DockMargin(8, 0, 8, 8)
	
	createSlider(panel,"px")
	createSlider(panel,"py")
	createSlider(panel,"pz")
	createSlider(panel,"ax")
	createSlider(panel,"ay")
	createSlider(panel,"az")
	
	labels.sumHeader = panel:AddControl("Label", {Text = "Code:"})
	labels.sumHeader:DockMargin(8, 0, 8, 8)
	
	labels.sum = panel:AddControl("Label", {Text = "SWEP.IronsightPos = Vector(0, 0, 0)\nSWEP.IronsightAng = Vector(0, 0, 0)"})
	labels.sum:DockMargin(8, 0, 8, 8)
	
	panel:AddControl("Button", {Label = "Copy to clipboard", Command = "cw_kk_aim_export"}):DockMargin(8, 0, 8, 8)
	
	labels.cvmtHeader = panel:AddControl("Label", {Text = "CVMT:"})
	labels.cvmtHeader:DockMargin(0, 0, 0, 0)
	
	panel:AddControl("CheckBox", {Label = "Enable HUD", Command = "cvmt_enabled"}):DockMargin(8, 0, 8, 8)
	panel:AddControl("CheckBox", {Label = "Show anim list", Command = "cvmt_animlist"}):DockMargin(8, 0, 8, 8)
	
	// cvmt_freeze
	// cvmt_setcycle
	// cvmt_seek
	// cvmt_setplaybackrate
	// cvmt_playanim
	// cvmt_playanim_freeze
	
	sliders["cvmt_cycle"] = vgui.Create("DNumSlider", panel)
	sliders["cvmt_cycle"]:DockMargin(8, 0, 8, 8)
	sliders["cvmt_cycle"]:SetDecimals(4)
	sliders["cvmt_cycle"]:SetMinMax(0, 1)
	sliders["cvmt_cycle"]:SetConVar("cvmt_setcycle")
	sliders["cvmt_cycle"]:SetText("Set cycle")
	sliders["cvmt_cycle"]:SetDark(true)
	panel:AddItem(sliders["cvmt_cycle"])
	
	sliders["cvmt_pbr"] = vgui.Create("DNumSlider", panel)
	sliders["cvmt_pbr"]:DockMargin(8, 0, 8, 8)
	sliders["cvmt_pbr"]:SetDecimals(4)
	sliders["cvmt_pbr"]:SetMinMax(-3, 3)
	sliders["cvmt_pbr"]:SetConVar("cvmt_setplaybackrate")
	sliders["cvmt_pbr"]:SetText("Set playback rate")
	sliders["cvmt_pbr"]:SetDark(true)
	panel:AddItem(sliders["cvmt_pbr"])
	
	sliders["cvmt_cycle"]:SetValue(1)
	sliders["cvmt_pbr"]:SetValue(1)
	
	-- sliders["cvmt_cycle"].OnValueChanged = function() RunConsoleCommand("cvmt_setplaybackrate","0") end
	sliders["cvmt_cycle"].OnValueChanged = function()
		sliders["cvmt_pbr"]:SetValue("0") 
		RunConsoleCommand("cvmt_setplaybackrate","0")
	end
	
	local left = vgui.Create("DLabel", panel)
	left:SetText("Play anim:")
	left:SetDark(true)
	left:DockMargin(8, 0, 8, 8)
	
	local right = vgui.Create( "DTextEntry", panel )
	right:SetConVar("cvmt_playanim_freeze")
	right:Dock(TOP)
	
	panel:AddItem( left, right )
	
	local left = vgui.Create("DLabel", panel)
	left:SetText("Play anim:")
	left:SetDark(true)
	left:DockMargin(8, 0, 8, 8)
	
	local right = vgui.Create( "DTextEntry", panel )
	right:SetConVar("cvmt_playanim_freeze")
	right:Dock(TOP)
	
	panel:AddItem( left, right )
	
	labels.cvmtHeader2 = panel:AddControl("Label", {Text = "List of ConCommands:"})
	labels.cvmtHeader2:DockMargin(8, 0, 8, 8)
	
	labels.cvmtFuncList = panel:AddControl("Label", {Text = "cvmt_freeze\ncvmt_setcycle\ncvmt_seek\ncvmt_setplaybackrate\ncvmt_playanim\ncvmt_playanim_freeze\n"})
	labels.cvmtFuncList:DockMargin(16, 0, 8, 8)
	
	hook.Add("Think", "KKSCK_Think", KKSCK_Think)
end

local function CW_KK_PopulateToolMenuDev()
	spawnmenu.AddToolMenuOption("Utilities", "CW 2.0 SWEPs", "Client (DEV v3)", "Client (DEV v3)", "", "", CW2_ClientsidePanelDev)
end

hook.Add( "PopulateToolMenu", "CW_KK_PopulateToolMenuDev_30", CW_KK_PopulateToolMenuDev )
