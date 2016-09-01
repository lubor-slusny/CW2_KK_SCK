if not CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()

local PANEL
local WEAPON

local colHover = Color(0,255,0,25)
local colIdle = Color(0,0,0,60)

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then return end
	
	local vm = wep.CW_VM
	
	for i = 0, vm:GetSequenceCount() - 1 do
		local txt = vm:GetSequenceName(i)
		
		local buttonPanel = vgui.Create("DPanel", PANEL)
		
			local label
			label = vgui.Create("DLabel", buttonPanel)
			label:SetText(string.format("%3d# %s", i, string.upper(txt)))
			label:SetDark(true)
			label:Dock(FILL)
			label:DockMargin(8,0,8,0)
			label:SizeToContents()
			label:SetMouseInputEnabled(true)
			
			function label:DoClick()
				RunConsoleCommand("cvmt_playanim", txt, 0, 1)
			end
			
			function label:Think()
				if self:IsHovered() then
					buttonPanel:SetBackgroundColor(colHover)
				else
					buttonPanel:SetBackgroundColor(colIdle)
				end
			end
			
		buttonPanel:Dock(TOP)
		buttonPanel:SetSize(200,20)
		buttonPanel:SetPaintBackground(true)
		buttonPanel:SizeToContents()
		buttonPanel:SetMouseInputEnabled(true)
		
		function buttonPanel:DoClick()
			RunConsoleCommand("cvmt_playanim", txt, 0, 1)
		end
		
		function buttonPanel:Think()
			if self:IsHovered() then
				self:SetBackgroundColor(colHover)
			else
				self:SetBackgroundColor(colIdle)
			end
		end
		
		PANEL:AddItem(buttonPanel)
	end
	
	KK_SCK_CVMT_EXT_PANEL = PANEL
end

local _LAST_SETUP

local function think()
	WEAPON = LocalPlayer():GetActiveWeapon()
	
	if _LAST_SETUP != WEAPON then
		updatePanel()
	end
	
	_LAST_SETUP = WEAPON
end

hook.Add("PopulateToolMenu", "KK_SCK_CVMT_EXT", function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_CVMT_EXT", "CVMT Panel Ext", "", "", function(panel)
		PANEL = panel
		updatePanel()
		
		hook.Add("Think", "KK_SCK_VMFr_Think", think)
	end)
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_CVMT_EXT_Remove", function()
	hook.Remove("Think", "KK_SCK_VMFr_Think")
end)

RunConsoleCommand("spawnmenu_reload")
