AddCSLuaFile()

local TOOL = {}

TOOL.Name = "viewmodelmodel"
TOOL.PrintName = "VM Model"

function TOOL:_addSectionEntry()
	local panel = self._panel
	local wep = self._wep
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:SetText(wep.CW_VM:GetModel())
		
		function entry:OnEnter()
			wep.CW_VM:SetModel(self:GetValue())
		end
		
		function entry:OnChange()
			if file.Exists(self:GetValue(), "GAME") then
				self:OnEnter()
			end
		end
		
		self._entry = entry
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionButt()
	local panel = self._panel
	local wep = self._wep
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Reset")
		
		function butt:DoClick()
			local mdl = wep.ViewModel
			wep.CW_VM:SetModel(mdl)
			TOOL._entry:SetText(mdl)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	if !IsValid(wep) then
		self:ThrowNewInvalidWeapon()
		return
	end
	
	if !wep.CW20Weapon then
		self:ThrowNewNotCW2Weapon()
		return
	end
	
	self:_addSectionEntry()
	self:_addSectionButt()
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
