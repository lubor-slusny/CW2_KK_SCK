local TOOL = {}

TOOL.Name = "vmfreeze"
TOOL.PrintName = "VM Freeze"
TOOL.Version = "1.1"

local fovDesire = GetConVar("fov_desired")

function TOOL:_freezeWep(wep)
	local vm = wep.CW_VM
	local pos = vm:GetPos()
	
	local tab = {
		origAOTV = wep.applyOffsetToVM,
		Pos = Vector(),
		Ang = vm:GetAngles(),
	}
	
	function wep:applyOffsetToVM()
		self.ViewModelFOV = fovDesire:GetInt()
		self.CW_VM:SetPos(pos + tab.Pos)
		self.CW_VM:SetAngles(tab.Ang)
	end
	
	self._frozen[wep] = tab
end

function TOOL:_unfreezeWep(wep)
	local tab = TOOL._frozen[wep]
	TOOL._frozen[wep] = nil
	wep.applyOffsetToVM = tab and tab.origAOTV
end

function TOOL:_unfreezeAll()
	for k,_ in pairs(self._frozen) do
		self:_unfreezeWep(k)
	end
end

function TOOL:_buildFreezeSection()
	local panel = self._panel
	local wep = self._wep
	
	local butt
	butt = vgui.Create("DButton", panel)
	butt:DockMargin(8, 0, 8, 8)	
	butt:SetText("Freeze view model")
	
	function butt:DoClick()
		TOOL:_freezeWep(wep)
		TOOL:_updatePanel()
	end
	
	panel:AddItem(butt)
end

function TOOL:_buildUnFreezeSection()
	local panel = self._panel
	local wep = self._wep

	local butt
	butt = vgui.Create("DButton", panel)
	butt:DockMargin(8, 0, 8, 8)	
	butt:SetText("Un-Freeze view model")

	function butt:DoClick()
		TOOL:_unfreezeWep(wep)
		TOOL:_updatePanel()
	end

	panel:AddItem(butt)

	local butt
	butt = vgui.Create("DButton", panel)
	butt:DockMargin(8, 0, 8, 8)	
	butt:SetText("Auto Align")

	function butt:DoClick()
		local tab = TOOL._frozen[wep]
		tab.Pos = Vector()
		tab.Ang = Angle()
		TOOL:_updatePanel()
	end

	panel:AddItem(butt)

	local tab = self._frozen[wep]

	for _,s in pairs({
		{"Pos", "x", -50, 50},
		{"Pos", "y", -50, 50},
		{"Pos", "z", -50, 50},
		{"Ang", "p", -90, 90},
		{"Ang", "y", -180, 180},
		{"Ang", "r", -180, 180},
	}) do 
		local slider = vgui.Create("DNumSlider", panel)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(4)
		slider:SetMinMax(s[3], s[4])
		slider:SetValue(tab[s[1]][s[2]])
		slider:SetText(s[1] .. "." .. s[2])
		slider:SetDark(true)
		
		self:LoadSliderZoom(slider)
		
		function slider:OnValueChanged(val)
			tab[s[1]][s[2]] = val
			TOOL:SaveSliderZoom(self)
		end

		panel:AddItem(slider)
	end
end

function TOOL:_buildUnFreezeAllSection(threshold)
	local panel = self._panel
	local wep = self._wep
	
	local curFrozen = table.Count(self._frozen)
	if curFrozen > threshold then
		local butt
		butt = vgui.Create("DButton", panel)
		butt:DockMargin(8, 0, 8, 8)	
		butt:SetText("Un-Freeze all (" .. curFrozen .. ")")

		function butt:DoClick()
			TOOL:_unfreezeAll()
			TOOL:_updatePanel()
		end

		panel:AddItem(butt)
		
		return true
	end
end

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	self._frozen = self._frozen or {}
	
	self:_buildUnFreezeAllSection(0)
	
	if !IsValid(wep) then
		self:ThrowNewInvalidWeapon()
		return
	end
	
	if !wep.CW20Weapon then
		self:ThrowNewNotCW2Weapon()
		return
	end
	
	if self._frozen[self._wep] then
		self:_buildUnFreezeSection()
		self:_buildUnFreezeAllSection(1)
		return
	end
	
	self:_buildFreezeSection()
	self:_buildUnFreezeAllSection(0)
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
