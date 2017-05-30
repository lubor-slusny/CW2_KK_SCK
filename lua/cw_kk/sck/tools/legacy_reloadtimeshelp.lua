
if true then return end // layZ to type {} over and over again

AddCSLuaFile()

local PANEL
local WEAPON

local function makeStuff()
	local out = "\nSWEP.ReloadTimes = {"
	
	for animName, _ in pairs(WEAPON.reloadProgressAnimsRaw) do
		local seqName = WEAPON.Animations[animName]
		
		if not seqName or !isstring(seqName) then 
			continue 
		end
		
		local _, dur = WEAPON.CW_VM:LookupSequence(seqName)
		
		out = out .. "\n	" .. seqName .. string.format(" = {%.2f, %.2f},", dur, dur)
	end
	
	out = out .. "\n}\n"

	SetClipboardText(out)
end

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then return end

	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:DockMargin(8, 0, 8, 8)	
	butt:SetText("GIMMI")
	
	function butt:DoClick()
		makeStuff()
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

local toolName = "reloadTimesGimmier"
local toolPrintName = "RELOAD TIEMS"

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
