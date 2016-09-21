if not CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()

local PANEL
local WEAPON

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then return end
	
	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:SetText("Recheck")
	
	function butt:DoClick()
		updatePanel()
	end
	
	PANEL:AddItem(butt)
	
	PANEL:AddControl("Label", {Text = string.upper(WEAPON:GetClass())}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
		
	local errors = {}
	local used = {}
	local vm = WEAPON.CW_VM
	
	local errorCount = 0
	
	for k,v in pairs(WEAPON.Animations) do
		if type(v) == "string" then
			if vm:LookupSequence(v) == -1 then
				errors[k] = {v}
				errorCount = errorCount + 1
			end
			
			used[v] = true
		elseif type(v) == "table" then
			for i,v in pairs(v) do
				if vm:LookupSequence(v) == -1 then
					errors[k] = errors[k] or {}
					errors[k][i] = v
					errorCount = errorCount + 1
				end
				
				used[v] = true
			end
		end
	end
	
	if table.Count(errors) > 0 then
		PANEL:AddControl("Label", {Text = "Non-existing anims:"})
		for k,vs in pairs(errors) do
			PANEL:AddControl("Label", {Text = "[\"" .. k .. "\"] = {"}):DockMargin(16,0,8,0)
			
			for i,v in pairs(vs) do
				PANEL:AddControl("Label", {Text = "[" .. i .. "] = \"" .. v .. "\","}):DockMargin(24,0,8,0)
			end
			
			PANEL:AddControl("Label", {Text = "}"}):DockMargin(16,0,8,0)
		end
	else
		PANEL:AddControl("Label", {Text = "No errs. GG WP"})
	end
	
	PANEL:AddControl("Label", {Text = " "})
	
	local unused = {}
	local unusedCount = 0
	
	for i = 0, vm:GetSequenceCount() - 1 do
		local v = vm:GetSequenceName(i)
		if not used[v] then
			table.insert(unused, v)
			unusedCount = unusedCount + 1
		end
	end
	
	local deltas = 0
	for k,v in pairs(unused) do
		for _,pat in pairs({"delta","layer","menu","blend"}) do
			if string.find(string.lower(v), pat) then
				unused[k] = nil
				deltas = deltas + 1
			end
		end
	end
	if deltas > 0 then
		table.insert(unused, 1, "[DELTAS]: " ..deltas)
	end
	
	if unusedCount > 0 then
		PANEL:AddControl("Label", {Text = "Unused sequences (" .. unusedCount .. "/" .. vm:GetSequenceCount() .. "):"})

		for _,v in pairs(unused) do
			local l = PANEL:AddControl("Label", {Text = v})
			l:DockMargin(16,0,8,0)
			l:SetMouseInputEnabled(true)
			function l:DoClick()
				SetClipboardText(v)
			end
		end
	else
		PANEL:AddControl("Label", {Text = "All VM sequences linked."})
	end
end

local _LAST_SETUP

local function think()
	WEAPON = LocalPlayer():GetActiveWeapon()
	
	if _LAST_SETUP != WEAPON then
		updatePanel()
	end
	
	_LAST_SETUP = WEAPON
end

local toolName = "KK_SCK_ANIMCHECK"
local toolPrintName = "Check Anim Table"

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
