AddCSLuaFile()

local PANEL
local WEAPON

local fovDesire = GetConVar("fov_desired")

local function storeSliderZoom() end
local function loadSliderZoom() end

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then
		PANEL:AddControl("Label", {Text = "Not a CW2 swep, move along."})
		return
	end
	
	if not WEAPON._kkSCKVMFreeze then
		
		local butt
		butt = vgui.Create("DButton", PANEL)
		-- butt:SetTooltip("Loads changes made outside of this tool.")
		butt:DockMargin(8, 0, 8, 8)	
		butt:SetText("Freeze view model")
		
		function butt:DoClick()
			if not WEAPON._kkSCKVMFreezeBackup then
				WEAPON._kkSCKVMFreezeBackup = WEAPON.applyOffsetToVM
			end
			
			local vm = WEAPON.CW_VM
			
			local pos = vm:GetPos()
			
			WEAPON._kkSCKVMFreezePosOffset = Vector()
			WEAPON._kkSCKVMFreezeAng = vm:GetAngles()
			
			function WEAPON:applyOffsetToVM()
				self.ViewModelFOV = fovDesire:GetInt()
				self.CW_VM:SetPos(pos + self._kkSCKVMFreezePosOffset)
				self.CW_VM:SetAngles(self._kkSCKVMFreezeAng)
			end
			
			WEAPON._kkSCKVMFreeze = true
			
			updatePanel()
		end
		
		PANEL:AddItem(butt)
	
	else
	
		local butt
		
			butt = vgui.Create("DButton", PANEL)
			-- butt:SetTooltip("Loads changes made outside of this tool.")
			butt:DockMargin(8, 0, 8, 8)	
			butt:SetText("Un-Freeze view model")
			
			function butt:DoClick()
				local vm = WEAPON.CW_VM
				
				WEAPON.applyOffsetToVM = WEAPON._kkSCKVMFreezeBackup
				WEAPON._kkSCKVMFreeze = false
				
				updatePanel()
			end
			
		PANEL:AddItem(butt)

		local butt
		
			butt = vgui.Create("DButton", PANEL)
			-- butt:SetTooltip("Loads changes made outside of this tool.")
			butt:DockMargin(8, 0, 8, 8)	
			butt:SetText("Auto Align")
			
			function butt:DoClick()
				WEAPON._kkSCKVMFreezePosOffset = Vector()
				WEAPON._kkSCKVMFreezeAng = Angle()
				
				updatePanel()
			end
			
		PANEL:AddItem(butt)

		local slider
			
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8,0,8,0)
			slider:SetDecimals(4)
			slider:SetMinMax(-50, 50)
			slider:SetValue(WEAPON._kkSCKVMFreezePosOffset.x)
			slider:SetText("offset.x")
			slider:SetDark(true)
			function slider:OnValueChanged(val)
				WEAPON._kkSCKVMFreezePosOffset.x = val
				
				storeSliderZoom(self)
			end

			slider._kk_sck_id = "settPosX"
			loadSliderZoom(slider)
			
		PANEL:AddItem(slider)
		
		local slider
			
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8,0,8,0)
			slider:SetDecimals(4)
			slider:SetMinMax(-50, 50)
			slider:SetValue(WEAPON._kkSCKVMFreezePosOffset.y)
			slider:SetText("offset.y")
			slider:SetDark(true)
			function slider:OnValueChanged(val)
				WEAPON._kkSCKVMFreezePosOffset.y = val
				
				storeSliderZoom(self)
			end

			slider._kk_sck_id = "settPosY"
			loadSliderZoom(slider)
			
		PANEL:AddItem(slider)
		
		local slider
			
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8,0,8,0)
			slider:SetDecimals(4)
			slider:SetMinMax(-50, 50)
			slider:SetValue(WEAPON._kkSCKVMFreezePosOffset.z)
			slider:SetText("offset.z")
			slider:SetDark(true)
			function slider:OnValueChanged(val)
				WEAPON._kkSCKVMFreezePosOffset.z = val
				
				storeSliderZoom(self)
			end

			slider._kk_sck_id = "settPosZ"
			loadSliderZoom(slider)
			
		PANEL:AddItem(slider)
		
		local slider
			
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8,0,8,0)
			slider:SetDecimals(4)
			slider:SetMinMax(-180, 180)
			slider:SetValue(WEAPON._kkSCKVMFreezeAng.p)
			slider:SetText("angle.p")
			slider:SetDark(true)
			function slider:OnValueChanged(val)
				WEAPON._kkSCKVMFreezeAng.p = val
			
				storeSliderZoom(self)
			end

			slider._kk_sck_id = "settAngP"
			loadSliderZoom(slider)
			
		PANEL:AddItem(slider)
		
		local slider
		
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8,0,8,0)
			slider:SetDecimals(4)
			slider:SetMinMax(-180, 180)
			slider:SetValue(WEAPON._kkSCKVMFreezeAng.y)
			slider:SetText("angle.y")
			slider:SetDark(true)
			function slider:OnValueChanged(val)
				WEAPON._kkSCKVMFreezeAng.y = val
			
				storeSliderZoom(self)
			end

			slider._kk_sck_id = "settAngY"
			loadSliderZoom(slider)
		
		PANEL:AddItem(slider)
	
		local slider
		
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8,0,8,0)
			slider:SetDecimals(4)
			slider:SetMinMax(-180, 180)
			slider:SetValue(WEAPON._kkSCKVMFreezeAng.r)
			slider:SetText("angle.r")
			slider:SetDark(true)
			function slider:OnValueChanged(val)
				WEAPON._kkSCKVMFreezeAng.r = val
			
				storeSliderZoom(self)
			end

			slider._kk_sck_id = "settAngR"
			loadSliderZoom(slider)
			
		PANEL:AddItem(slider)
	
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

-- RunConsoleCommand("spawnmenu_reload")
