AddCSLuaFile()

CreateClientConVar("cw_kk_aim_px", 0, false, false)
CreateClientConVar("cw_kk_aim_py", 0, false, false)
CreateClientConVar("cw_kk_aim_pz", 0, false, false)
CreateClientConVar("cw_kk_aim_ap", 0, false, false)
CreateClientConVar("cw_kk_aim_ay", 0, false, false)
CreateClientConVar("cw_kk_aim_ar", 0, false, false)

local sliders = {}
local labels = {}
local prefix = "Ironsight"
local lock

local function loadAimPos(ply)	// ply should always b LocalPlayer() (I guess)
	if not IsValid(ply) then return end
	
	local wep
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then return end
	
	if not wep.CW20Weapon then
		labels.sightName:SetText("No CW2 weapon equiped.")
		labels.sightPrefix:SetText("")
		return 
	end
	
	local sightName
	sightName = wep:getActiveAttachmentInCategory(1)

	if not sightName then
		labels.sightName:SetText("Sight: none (iron sights)")
		prefix = "Ironsight"
		labels.sightPrefix:SetText("Prefix: " .. prefix)
	else
		local sightTable = CustomizableWeaponry.sights[sightName]
		if sightTable then
			labels.sightName:SetText("Sight: " .. sightTable.displayName)
			prefix = string.sub(sightTable.aimPos[1], 1, string.len(sightTable.aimPos[1]) - 3) 
			labels.sightPrefix:SetText("Prefix: " .. prefix)
		end
	end
	
	local AimPos = wep.AimPos
	local AimAng = wep.AimAng
	
	lock = true
	
	sliders["px"]:SetValue(AimPos.x)
	sliders["py"]:SetValue(AimPos.y)
	sliders["pz"]:SetValue(AimPos.z)
	sliders["ap"]:SetValue(AimAng.x)
	sliders["ay"]:SetValue(AimAng.y)
	sliders["ar"]:SetValue(AimAng.z)
	
	lock = false
	
	local AimPosString
	local AimAngString
	
	AimPosString = "SWEP." .. prefix .. "Pos = Vector(" .. math.Round(AimPos.x,4) .. ", " .. math.Round(AimPos.y,4) .. ", " .. math.Round(AimPos.z,4) .. ")"
	AimAngString = "SWEP." .. prefix .. "Ang = Vector(" .. math.Round(AimAng.x,4) .. ", " .. math.Round(AimAng.y,4) .. ", " .. math.Round(AimAng.z,4) .. ")"
	
	-- AimPos = "SWEP." .. prefix .. "Pos = Vector(" .. GetConVarNumber("cw_kk_aim_px") .. ", " .. GetConVarNumber("cw_kk_aim_py") .. ", " .. GetConVarNumber("cw_kk_aim_pz") .. ")"
	-- AimAng = "SWEP." .. prefix .. "Ang = Vector(" .. GetConVarNumber("cw_kk_aim_ap") .. ", " .. GetConVarNumber("cw_kk_aim_ay") .. ", " .. GetConVarNumber("cw_kk_aim_ar") .. ")"
	
	labels.sumPos:SetText(AimPosString)
	labels.sumAng:SetText(AimAngString)
	
end

concommand.Add("cw_kk_aim_load", loadAimPos)

local function exportSettings()
	local AimPos
	local AimAng
	
	AimPos = "SWEP." .. prefix .. "Pos = Vector(" .. math.Round(GetConVarNumber("cw_kk_aim_px"),4) .. ", " .. math.Round(GetConVarNumber("cw_kk_aim_py"),4) .. ", " .. math.Round(GetConVarNumber("cw_kk_aim_pz"),4) .. ")"
	AimAng = "SWEP." .. prefix .. "Ang = Vector(" .. math.Round(GetConVarNumber("cw_kk_aim_ap"),4) .. ", " .. math.Round(GetConVarNumber("cw_kk_aim_ay"),4) .. ", " .. math.Round(GetConVarNumber("cw_kk_aim_ar"),4) .. ")"
	
	SetClipboardText(AimPos .. "\n" .. AimAng)
end

concommand.Add("cw_kk_aim_export", exportSettings)

local function applyAimPos()
	if lock then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	
	local wep
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then return end
	
	if not wep.CW20Weapon then
		labels.sightName:SetText("No CW2 weapon equiped.")
		labels.sightPrefix:SetText("")
		return 
	end
	
	local AimPos
	local AimAng
	
	AimPos = Vector(math.Round(GetConVarNumber("cw_kk_aim_px"),4), math.Round(GetConVarNumber("cw_kk_aim_py"),4), math.Round(GetConVarNumber("cw_kk_aim_pz"),4))
	AimAng = Vector(math.Round(GetConVarNumber("cw_kk_aim_ap"),4), math.Round(GetConVarNumber("cw_kk_aim_ay"),4), math.Round(GetConVarNumber("cw_kk_aim_ar"),4))
	
	wep.AimPos = AimPos
	wep.AimAng = AimAng
	wep[prefix .. "Pos"] = AimPos
	wep[prefix .. "Ang"] = AimAng
end

local function resetSliders()
	sliders["px"]:SetValue(0)
	sliders["py"]:SetValue(0)
	sliders["pz"]:SetValue(0)
	sliders["ap"]:SetValue(0)
	sliders["ay"]:SetValue(0)
	sliders["ar"]:SetValue(0)
	
	labels.sumPos:SetText("SWEP." .. prefix .. "Pos = Vector(0, 0, 0)")
	labels.sumAng:SetText("SWEP." .. prefix .. "Ang = Vector(0, 0, 0)")
	
	applyAimPos()
end

concommand.Add("cw_kk_aim_reset", resetSliders)

local function createSlider(panel, id)
	sliders[id] = vgui.Create("DNumSlider", panel)
	
	sliders[id]:SetDecimals(4)
	sliders[id]:SetMinMax(-50, 50)
	
	sliders[id]:SetConVar("cw_kk_aim_" .. id)
	sliders[id]:SetValue(0)
	
	local pa
	if id[1] == "p" then
		pa = "Pos"
	else
		pa = "Ang"
	end
	
	sliders[id]:SetText(pa .. "." .. id[2])
	sliders[id]:SetDark(true)
	
	sliders[id].OnValueChanged = applyAimPos
	
	panel:AddItem(sliders[id])
end

local function CW2_ClientsidePanelDev(panel)
	panel:ClearControls()
	
	panel:AddControl("CheckBox", {Label = "[Override] Force GM crosshair", Command = "cw_kk_gm_xhair"})
	panel:AddControl("CheckBox", {Label = "Freeze reticles (RT and Stencils only)", Command = "cw_kk_freeze_reticles"})
	panel:AddControl("CheckBox", {Label = "Lock Aim", Command = "cw_kk_freeze_reticles"})
	
	labels.buildHeader = panel:AddControl("Label", {Text = "AimPos Building:"})
	labels.buildHeader:DockMargin( 0, 0, 8, 8 )
	
	panel:AddControl("Button", {Label = "Load", Command = "cw_kk_aim_load"})
	
	labels.sightName = panel:AddControl("Label", {Text = "Sight: none (iron sights)"})
	labels.sightPrefix = panel:AddControl("Label", {Text = "Prefix: " .. prefix})
	
	createSlider(panel,"px")
	createSlider(panel,"py")
	createSlider(panel,"pz")
	createSlider(panel,"ap")
	createSlider(panel,"ay")
	createSlider(panel,"ar")
	
	labels.sumPos = panel:AddControl("Label", {Text = "SWEP.IronsightPos = Vector(0, 0, 0)"})
	labels.sumAng = panel:AddControl("Label", {Text = "SWEP.IronsightAng = Vector(0, 0, 0)"})
	
	panel:AddControl("Button", {Label = "Reset", Command = "cw_kk_aim_reset"})
	panel:AddControl("Button", {Label = "Copy to clipboard", Command = "cw_kk_aim_export"})
end

local function CW_KK_PopulateToolMenuDev()
	spawnmenu.AddToolMenuOption("Utilities", "CW 2.0 SWEPs", "Client (DEV)", "Client (DEV)", "", "", CW2_ClientsidePanelDev)
end

hook.Add( "PopulateToolMenu", "CW_KK_PopulateToolMenuDev", CW_KK_PopulateToolMenuDev )
