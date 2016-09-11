if not CustomizableWeaponry_KK.HOME then return end
if CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()

local PANEL
local WEAPON

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then return end
	
end

local _LAST_SETUP

local function think()
	WEAPON = LocalPlayer():GetActiveWeapon()
	
	if _LAST_SETUP != WEAPON then
		updatePanel()
	end
	
	_LAST_SETUP = WEAPON
end

local toolName = "somename"
local toolPrintName = "Template Tool"

hook.Add("PopulateToolMenu", toolName, function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", toolName, toolPrintName, "", "", function(panel)
		PANEL = panel
		updatePanel()
		
		hook.Add("Think", toolName .. "_Think", think)
	end)
end)

hook.Add("PostReloadToolsMenu", toolName .. "_Remove", function()
	hook.Remove("Think", toolName .. "_Think")
end)

RunConsoleCommand("spawnmenu_reload")
