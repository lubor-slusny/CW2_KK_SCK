AddCSLuaFile()

local PANEL
local WEAPON

local grn = Color(63, 127, 79, 255)
local blu = Color(220, 0, 255, 255)

function clickMeh(self)
	SetClipboardText(self:GetText())
end

local function updatePanel()
	if !IsValid(PANEL) then return end
	PANEL:ClearControls()
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then return end
	
	// refresh button
	do
		local butt
		butt = vgui.Create("DButton", PANEL)
		butt:SetText("Recheck")
		butt.DoClick = updatePanel
		PANEL:AddItem(butt)
	end
	
	// swep info
	do
		PANEL:AddControl("Label", {Text = string.upper(WEAPON:GetClass())}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
		local label = PANEL:AddControl("Label", {Text = WEAPON.ViewModel})
		label:DockMargin(16,0,8,0)
		label:SetMouseInputEnabled(true)
		label.DoClick = clickMeh
		PANEL:AddControl("Label", {Text = " "})
	end
	
	// shared variables
	local errors = {}
	local used = {}
	local vm = WEAPON.CW_VM
	
	// invalid animation entries
	do
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
			PANEL:AddControl("Label", {Text = "Non-existing anims (" .. errorCount .. "):"}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
			for k,vs in pairs(errors) do
				PANEL:AddControl("Label", {Text = "[\"" .. k .. "\"] = {"}):DockMargin(16,0,8,0)
				
				for i,v in pairs(vs) do
					local label = PANEL:AddControl("Label", {Text = "[" .. i .. "] = \"" .. v .. "\","})
					label:SetTextColor(blu)
					label:DockMargin(24,0,8,0)
				end
				
				PANEL:AddControl("Label", {Text = "}"}):DockMargin(16,0,8,0)
			end
			PANEL:AddControl("Label", {Text = ""})
		else
			-- PANEL:AddControl("Label", {Text = "No invalid entries in \"SWEP.Animations\". GG WP"}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
		end
	end
	
	// unused viewmodel animations
	do
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
			for _,pat in pairs({"delta","layer","menu"}) do
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
			PANEL:AddControl("Label", {Text = "Unused sequences (" .. unusedCount .. "/" .. vm:GetSequenceCount() .. "):"}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
			for _,v in pairs(unused) do
				local label = PANEL:AddControl("Label", {Text = v})
				label:SetTextColor(grn)
				label:DockMargin(16,0,8,0)
				label:SetMouseInputEnabled(true)
				label.DoClick = clickMeh
			end
			PANEL:AddControl("Label", {Text = ""})
		else
			-- PANEL:AddControl("Label", {Text = "All VM sequences linked."}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
		end
	end
	
	// soundtables for unused/non-existing animations
	do
		local unreachable = {}
		local unreachableCount = 0
		
		for k,_ in pairs(WEAPON.Sounds) do
			if k == "BaseClass" then
				continue
			end
			
			local keyFoundInAnimTable = false
			
			for _,tab in pairs(WEAPON.Animations) do
				if type(tab) == "table" then
					for _,itab in pairs(tab) do
						keyFoundInAnimTable = k == itab
						if keyFoundInAnimTable then break end
					end
				else
					keyFoundInAnimTable = k == tab				
				end
				
				if keyFoundInAnimTable then break end
			end
			
			local exists = (vm:LookupSequence(k) != -1)
			
			if !(keyFoundInAnimTable and exists) then
				table.insert(unreachable, {name = k, exists = exists})
				unreachableCount = unreachableCount + 1
			end
		end
		
		if unreachableCount > 0 then
			PANEL:AddControl("Label", {Text = "Soudscripts for non-existing or unused anims (" .. unreachableCount .. "):"}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
			for _,v in pairs(unreachable) do
				local label = PANEL:AddControl("Label", {Text = v.name})
				label:DockMargin(16,0,8,0)
				label:SetTextColor(v.exists and grn or blu)
				label:SetMouseInputEnabled(true)
				label.DoClick = clickMeh
			end
			PANEL:AddControl("Label", {Text = ""})
		else
			-- PANEL:AddControl("Label", {Text = "No invalid entries in \"SWEP.Sounds\". neato"}):SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
		end
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

-- RunConsoleCommand("spawnmenu_reload")
