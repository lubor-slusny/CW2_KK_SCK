AddCSLuaFile()

local POS = Vector(0, 0, 0)
local ANG = Vector(0, 0, 0)

local sliders = {}
local labels = {}
local prefix = "Ironsight"
local lockSettings
local toggleADS = {}

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
	wep[prefix .. "Pos"] = Vector(POS.x, POS.y, POS.z)
	wep[prefix .. "Ang"] = Vector(ANG.x, ANG.y, ANG.z)
	
	labels.sum:SetText(settingsToString())
end

local function setValue(val)
	val.KK_vec[val.KK_vecPos] = val:GetValue() // rewrite value in shared vector // yup im eeeeevul
	applySettings()
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
	SetClipboardText(settingsToString())
end

concommand.Add("cw_kk_aim_load", loadAimPos)
concommand.Add("cw_kk_aim_reset", resetSliders)
concommand.Add("cw_kk_aim_export", exportSettings)

local function createSlider(panel, id)
	sliders[id] = vgui.Create("DNumSlider", panel)
	
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
	
	sliders[id].OnValueChanged = setValue
	
	panel:AddItem(sliders[id])
end

local function getKey(cc)
	-- local k = input.LookupBinding(cc)
	
	-- if k then
		-- return "[" .. k .. "]"
	-- end
	
	return ""
end

local function CW2_ClientsidePanelDev(panel)
	panel:ClearControls()
	
	panel:AddControl("CheckBox", {Label = "[Override] Force GM crosshair" .. getKey("cw_kk_gm_xhair"), Command = "cw_kk_gm_xhair"})
	panel:AddControl("CheckBox", {Label = "Freeze reticles (RT and Stencils only)" .. getKey("cw_kk_freeze_reticles"), Command = "cw_kk_freeze_reticles"})
	panel:AddControl("CheckBox", {Label = "Lock ADS" .. getKey("cw_kk_aim_lock_ads"), Command = "cw_kk_aim_lock_ads"})
	
	labels.buildHeader = panel:AddControl("Label", {Text = "AimPos Building:"})
	labels.buildHeader:DockMargin( 0, 0, 0, 0 )
	
	panel:AddControl("Button", {Label = "Load" .. getKey("cw_kk_aim_load"), Command = "cw_kk_aim_load"})
	
	labels.sight = panel:AddControl("Label", {Text = "Sight: none (iron sights)\nPrefix: " .. prefix})
	labels.sight:DockMargin( 0, 0, 0, 0 )
	
	createSlider(panel,"px")
	createSlider(panel,"py")
	createSlider(panel,"pz")
	createSlider(panel,"ax")
	createSlider(panel,"ay")
	createSlider(panel,"az")
	
	panel:AddControl("Button", {Label = "Reset" .. getKey("cw_kk_aim_reset"), Command = "cw_kk_aim_reset"})
	
	labels.sumHeader = panel:AddControl("Label", {Text = "Code:"})
	labels.sumHeader:DockMargin( 0, 0, 0, 0 )
	
	labels.sum = panel:AddControl("Label", {Text = "SWEP.IronsightPos = Vector(0, 0, 0)\nSWEP.IronsightAng = Vector(0, 0, 0)"})
	labels.sum:DockMargin( 0, 0, 0, 0 )
	
	panel:AddControl("Button", {Label = "Copy to clipboard" .. getKey("cw_kk_aim_export"), Command = "cw_kk_aim_export"})
	
	labels.cvmtHeader = panel:AddControl("Label", {Text = "CVMT:"})
	labels.cvmtHeader:DockMargin( 0, 0, 0, 0 )
	
	panel:AddControl("CheckBox", {Label = "Enable HUD" .. getKey("cvmt_enabled"), Command = "cvmt_enabled"})
	panel:AddControl("CheckBox", {Label = "Show anim list" .. getKey("cvmt_animlist"), Command = "cvmt_animlist"})
	
	// cvmt_freeze
	// cvmt_setcycle
	// cvmt_seek
	// cvmt_setplaybackrate
	// cvmt_playanim
	// cvmt_playanim_freeze
	
	sliders["cvmt_cycle"] = vgui.Create("DNumSlider", panel)
	sliders["cvmt_cycle"]:SetDecimals(4)
	sliders["cvmt_cycle"]:SetMinMax(0, 1)
	sliders["cvmt_cycle"]:SetConVar("cvmt_setcycle")
	sliders["cvmt_cycle"]:SetText("Set cycle")
	sliders["cvmt_cycle"]:SetDark(true)
	-- sliders["cvmt_cycle"].OnValueChanged = function() RunConsoleCommand("cvmt_setplaybackrate","0") end
	sliders["cvmt_cycle"].OnValueChanged = function() sliders["cvmt_pbr"]:SetValue("0") end
	panel:AddItem(sliders["cvmt_cycle"])
	
	sliders["cvmt_pbr"] = vgui.Create("DNumSlider", panel)
	sliders["cvmt_pbr"]:SetDecimals(4)
	sliders["cvmt_pbr"]:SetMinMax(-3, 3)
	sliders["cvmt_pbr"]:SetConVar("cvmt_setplaybackrate")
	sliders["cvmt_pbr"]:SetText("Set playback rate")
	sliders["cvmt_pbr"]:SetDark(true)
	panel:AddItem(sliders["cvmt_pbr"])
	
	sliders["cvmt_cycle"]:SetValue("1")
	sliders["cvmt_pbr"]:SetValue("1")
	
	panel:AddControl("TextBox", {Label = "Play anim:", Command = "cvmt_playanim_freeze", WaitForEnter = "1"})
	
	labels.cvmtHeader2 = panel:AddControl("Label", {Text = "CVMT ConCommands List:"})
	labels.cvmtHeader2:DockMargin( 0, 0, 8, 8 )
	
	labels.cvmtFuncList = panel:AddControl("Label", {Text = "cvmt_freeze\ncvmt_setcycle\ncvmt_seek\ncvmt_setplaybackrate\ncvmt_playanim\ncvmt_playanim_freeze"})
	labels.cvmtFuncList:DockMargin( 8, 0, 8, 8 )
	
end

local function CW_KK_PopulateToolMenuDev()
	spawnmenu.AddToolMenuOption("Utilities", "CW 2.0 SWEPs", "Client (DEV)", "Client (DEV)", "", "", CW2_ClientsidePanelDev)
end

hook.Add( "PopulateToolMenu", "CW_KK_PopulateToolMenuDev", CW_KK_PopulateToolMenuDev )

CreateClientConVar("cw_kk_aim_lock_ads", 0, false, false)
local cw_kk_aim_lock_ads_prev
hook.Add("Think", "cw_kk_aim_lock_ads", function() 
	local cur = GetConVarNumber("cw_kk_aim_lock_ads")
	if cur != cw_kk_aim_lock_ads_prev and cw_kk_aim_lock_ads_prev!= nil then
		if cur == 0 then
			RunConsoleCommand("-attack2")
		else
			RunConsoleCommand("+attack2")
		end
	end
	
	cw_kk_aim_lock_ads_prev = cur
end)
