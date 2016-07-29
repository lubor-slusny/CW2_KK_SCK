AddCSLuaFile()

local PANEL
local WEAPON

local fovDesire = GetConVar("fov_desired")

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then return end
	
	if not WEAPON._kkSCKVMFreeze then
		
		local butt
		butt = vgui.Create("DButton", PANEL)
		-- butt:SetTooltip("Loads changes made outside of this tool.")
		butt:DockMargin(0, 0, 8, 8)	
		butt:SetText("Freeze view model")
		
		function butt:DoClick()
			if not WEAPON._kkSCKVMFreezeBackup then
				WEAPON._kkSCKVMFreezeBackup = WEAPON.applyOffsetToVM
			end
			
			local vm = WEAPON.CW_VM
			
			local pos = vm:GetPos()
			local ang = vm:GetAngles()
			
			function WEAPON:applyOffsetToVM()
				self.ViewModelFOV = fovDesire:GetInt()
				self.CW_VM:SetPos(pos)
				self.CW_VM:SetAngles(ang)
			end
			
			WEAPON._kkSCKVMFreeze = true
			
			updatePanel()
		end
		
		PANEL:AddItem(butt)
	
	else
	
		local butt
		butt = vgui.Create("DButton", PANEL)
		-- butt:SetTooltip("Loads changes made outside of this tool.")
		butt:DockMargin(0, 0, 8, 8)	
		butt:SetText("Un-Freeze view model")
		
		function butt:DoClick()
			local vm = WEAPON.CW_VM
			
			WEAPON.applyOffsetToVM = WEAPON._kkSCKVMFreezeBackup
			WEAPON._kkSCKVMFreeze = false
			
			updatePanel()
		end
		
		PANEL:AddItem(butt)
	
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

hook.Add("PopulateToolMenu", "KK_SCK_VMFr", function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_VMFr", "VM Freeze", "", "", function(panel)
		PANEL = panel
		updatePanel()
		
		hook.Add("Think", "KK_SCK_VMFr_Think", think)
	end)
end)

hook.Add("PostReloadToolsMenu", "KKK_SCK_VMFr_Remove", function()
	hook.Remove("Think", "KK_SCK_VMFr_Think")
end)

RunConsoleCommand("spawnmenu_reload")
