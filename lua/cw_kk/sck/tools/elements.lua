AddCSLuaFile()

local TOOL = {}

TOOL.Name = "elements"
TOOL.PrintName = "Element Browser 3"
TOOL.Version = "3.0"

TOOL.elementTables = {"AttachmentModelsVM", "AttachmentModelsWM"}
TOOL.elementProperties = {
	"model", "pos", "angle", "size", 
}

TOOL.__index = TOOL

function TOOL:addPanelBuilder(tab)
	self._panelBuilders = self._panelBuilders or {}
	
	setmetatable(tab, self)
	self._panelBuilders[tab.Name] = tab
end

function TOOL:_addSectionGooback()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetSize(150,20)
		butt:SetText("Go Back")
		
		function butt:DoClick()
			TOOL:_setBuilder("list")
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

// Element List

local PB = {}
PB.Name = "list"

function PB:_addSectionMake()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetSize(150,20)
		butt:SetText("Add new")
		
		function butt:DoClick()
			TOOL:_setBuilder("make")
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:_addSectionEdit(key)
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetSize(150,20)
		butt:SetText(key)
		
		function butt:DoClick()
			TOOL._state.elementID = key
			TOOL:_setBuilder("edit")
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	for _,elementTable in pairs(self.elementTables) do
		panel:AddControl("Label", {Text = elementTable})
		
		self:_addSectionMake()
		
		wep[elementTable] = wep[elementTable] or {}
		
		for k,v in pairs(wep[elementTable]) do
			-- panel:AddControl("Label", {Text = k})
			self:_addSectionEdit(k)
		end
	end
end

TOOL:addPanelBuilder(PB)

// Element Edit

local PB = {}
PB.Name = "edit"

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	panel:AddControl("Label", {Text = "2doo edit"})
	panel:AddControl("Label", {Text = "noaw editing " .. state.elementID})
	
	self:_addSectionGooback()
end

TOOL:addPanelBuilder(PB)

// Element Make

local PB = {}
PB.Name = "make"

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	panel:AddControl("Label", {Text = "2doo make"})
	
	self:_addSectionGooback()
end

TOOL:addPanelBuilder(PB)

// Session manager

function TOOL:Initialize()
	self._states = self._states or {}
end

function TOOL:_setBuilder(id)
	self._state.builderId = id and (self._panelBuilders[id] and id) or "list"
	self:_updatePanel()
end

function TOOL:_runBuilder()
	local builderId = self._state.builderId
	local builder = self._panelBuilders[builderId]
	
	if !builder then
		return
	end
	
	builder:run()
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
	
	self._states[wep] = self._states[wep] or {builderId = "list"}
	self._state = self._states[wep]
	
	self:_runBuilder()
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

function TOOL:OnWeaponChanged(new, old)
	self._wep = new
	self:_updatePanel()
end

function TOOL:OnWeaponSetupChanged()
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
