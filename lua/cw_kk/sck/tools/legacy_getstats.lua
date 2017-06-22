AddCSLuaFile()

if not CustomizableWeaponry_KK.HOME then return end // layZ to make original stats

local PANEL
local WEAPON

local outFormat = [[
SWEP.Recoil = %s

SWEP.HipSpread = %s
SWEP.AimSpread = %s
SWEP.VelocitySensitivity = %s
SWEP.MaxSpreadInc = %s
SWEP.SpreadPerShot = %s
SWEP.SpreadCooldown = %s
]]

local outFormat2 = [[
SWEP.RecoilToSpread = %s
SWEP.ClumpSpread = %s
SWEP.BipodRecoilModifier = %s
]]

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then return end
	
	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:DockMargin(8, 0, 8, 8)	
	butt:SetText("GETEMSTATS")
	
	function butt:DoClick()
		local wep = WEAPON
		
		local out = string.format(outFormat,
			tostring(wep.Recoil),
			tostring(wep.HipSpread),
			tostring(wep.AimSpread),
			tostring(wep.VelocitySensitivity),
			tostring(wep.MaxSpreadInc),
			tostring(wep.SpreadPerShot),
			tostring(wep.SpreadCooldown)
		)
		
		SetClipboardText(out)
	end
	
	PANEL:AddItem(butt)
	
	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:DockMargin(8, 0, 8, 8)	
	butt:SetText("GETEMSTATSex")
	
	function butt:DoClick()
		local wep = WEAPON
		
		local out = string.format(outFormat2,
			tostring(wep.RecoilToSpread),
			tostring(wep.ClumpSpread),
			tostring(wep.BipodRecoilModifier)
		)
		
		SetClipboardText(out)
	end
	
	PANEL:AddItem(butt)
end

local _LAST_SETUP

local function think()
	WEAPON = LocalPlayer():GetActiveWeapon()
	
	if _LAST_SETUP != WEAPON then
		updatePanel()
	end
	
	_LAST_SETUP = WEAPON
end

local toolName = "getstats"
local toolPrintName = "GETEMSTATS"

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

-- RunConsoleCommand("spawnmenu_reload")
