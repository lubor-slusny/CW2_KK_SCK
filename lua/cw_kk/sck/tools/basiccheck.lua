AddCSLuaFile()

local TOOL = {}

TOOL.Name = "basiccheck"
TOOL.PrintName = "Check basics"
TOOL.Version = "1.1"

TOOL.colorExists = Color(63, 127, 79, 255)
TOOL.colorDoesnt = Color(220, 0, 255, 255)

TOOL.elementFuncs = {
	ButtonDoClick = function(self) TOOL:_updatePanel() end,
	LabelDoClick = function(self) SetClipboardText(self:GetText()) end,
}

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	if !IsValid(wep) or !wep.CW20Weapon then
		panel:AddControl("Label", {Text = "Not a CW2 swep, move along."})
		return
	end
	
	// refresh button
	do
		local butt
		butt = vgui.Create("DButton", panel)
		butt:SetText("Recheck")
		butt:DockMargin(8, 0, 8, 0)
		butt.DoClick = self.elementFuncs.ButtonDoClick
		panel:AddItem(butt)
	end
	
	// swep info
	do
		local label
		label = panel:AddControl("Label", {Text = string.upper(wep:GetClass())})
		label:SetTextColor(panel:GetSkin().Colours.Tree.Hover)
		
		label = panel:AddControl("Label", {Text = wep.ViewModel})
		label:DockMargin(16,0,8,0)
		label:SetMouseInputEnabled(true)
		label.DoClick = self.elementFuncs.LabelDoClick
		panel:AddControl("Label", {Text = ""})
	end
	
	// shared variables
	local errors = {}
	local used = {}
	local vm = wep.CW_VM
	
	// invalid animation entries
	do
		local errorCount = 0
		
		for k,v in pairs(wep.Animations) do
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
			panel:AddControl("Label", {Text = "Non-existing anims (" .. errorCount .. "):"}):SetTextColor(panel:GetSkin().Colours.Tree.Hover)
			for k,vs in pairs(errors) do
				panel:AddControl("Label", {Text = "[\"" .. k .. "\"] = {"}):DockMargin(16,0,8,0)
				
				for i,v in pairs(vs) do
					local label = panel:AddControl("Label", {Text = "[" .. i .. "] = \"" .. v .. "\","})
					label:SetTextColor(self.colorDoesnt)
					label:DockMargin(24,0,8,0)
				end
				
				panel:AddControl("Label", {Text = "}"}):DockMargin(16,0,8,0)
			end
			panel:AddControl("Label", {Text = ""})
		else
			-- panel:AddControl("Label", {Text = "No invalid entries in \"SWEP.Animations\". GG WP"}):SetTextColor(panel:GetSkin().Colours.Tree.Hover)
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
			panel:AddControl("Label", {Text = "Unused sequences (" .. unusedCount .. "/" .. vm:GetSequenceCount() .. "):"}):SetTextColor(panel:GetSkin().Colours.Tree.Hover)
			for _,v in pairs(unused) do
				local label = panel:AddControl("Label", {Text = v})
				label:SetTextColor(self.colorExists)
				label:DockMargin(16,0,8,0)
				label:SetMouseInputEnabled(true)
				label.DoClick = self.elementFuncs.LabelDoClick
			end
			panel:AddControl("Label", {Text = ""})
		else
			-- panel:AddControl("Label", {Text = "All VM sequences linked."}):SetTextColor(panel:GetSkin().Colours.Tree.Hover)
		end
	end
	
	// soundtables for unused/non-existing animations
	do
		local unreachable = {}
		local unreachableCount = 0
		
		for k,_ in pairs(wep.Sounds) do
			if k == "BaseClass" then
				continue
			end
			
			local keyFoundInAnimTable = false
			
			for _,tab in pairs(wep.Animations) do
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
			panel:AddControl("Label", {Text = "Soudscripts for non-existing or unused anims (" .. unreachableCount .. "):"}):SetTextColor(panel:GetSkin().Colours.Tree.Hover)
			for _,v in pairs(unreachable) do
				local label = panel:AddControl("Label", {Text = v.name})
				label:DockMargin(16,0,8,0)
				label:SetTextColor(v.exists and self.colorExists or self.colorDoesnt)
				label:SetMouseInputEnabled(true)
				label.DoClick = self.elementFuncs.LabelDoClick
			end
			panel:AddControl("Label", {Text = ""})
		else
			-- panel:AddControl("Label", {Text = "No invalid entries in \"SWEP.Sounds\". neato"}):SetTextColor(panel:GetSkin().Colours.Tree.Hover)
		end
	end
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

function TOOL:OnWeaponChanged(new, old)
	self._wep = new
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
