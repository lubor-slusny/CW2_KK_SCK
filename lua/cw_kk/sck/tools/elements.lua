AddCSLuaFile()

local TOOL = {}

TOOL.Name = "elements"
TOOL.PrintName = "Element Browser 3"
TOOL.Version = "3.0"

TOOL.elementTables = {"AttachmentModelsVM", "AttachmentModelsWM"}
TOOL.elementProperties = {
	"model", "pos", "angle", "size", 
}

TOOL.headerBackground = Color(0,160,255,100)

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

function TOOL:_addSectionRefreshButt()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetSize(150,20)
		butt:SetText("Refresh")
		butt:SetTooltip("Loads changes made outside of this tool.")
		
		function butt:DoClick()
			TOOL:_updatePanel()
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

function PB:_addSectionETHeader(tableName)
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP." .. tableName .. ":")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local butt
		butt = vgui.Create("DButton", backgroundPanel)
		butt:SetText("Add")
		butt:SetTooltip("Add new item to " .. tableName .. ".")
		butt:Dock(RIGHT)
		butt:DockMargin(0,4,8,4)
		
		function butt:DoClick()
			TOOL:_setBuilder("make")
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetBackgroundColor(self.headerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:_addSectionETItem(tableName, elementName)
	local panel = self._panel
	local element = self._wep[tableName][elementName]
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local DoClick = function()
			TOOL._state.elementID = elementName
			TOOL:_setBuilder("edit")
		end
		
		local Think = function(self)
			if self:IsHovered() then
				if input.IsMouseDown(MOUSE_RIGHT) then
					SetClipboardText(elementName)
				end
			end
		end
		
		local icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(0,0)
		icon:SetSize(20,20)
		icon:SetMouseInputEnabled(true)
		icon.DoClick = DoClick
		icon.Think = Think

		if element.active then
			icon:SetImage("icon16/bullet_green.png")
		else
			icon:SetImage("icon16/bullet_red.png")
		end

		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(elementName)
		label:SetDark(true)
		label:Dock(FILL)
		label:DockMargin(20,0,4,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		label.Think = Think
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("[˅]")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		label.Think = Think
		
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
	
	for _,tableName in pairs(self.elementTables) do
		self:_addSectionETHeader(tableName)
		
		wep[tableName] = wep[tableName] or {}
		
		local sortKeys = {}
		for elementName,element in pairs(wep[tableName]) do
			sortKeys[(element.active and "a_" or "b_") .. tostring(elementName)] = elementName
		end
		
		for _,elementName in SortedPairs(sortKeys) do
			self:_addSectionETItem(tableName, elementName)
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
	
	panel:AddControl("Label", {Text = "header tableName w/ butt add"})
	panel:AddControl("Label", {Text = "header elementName w/ butt gooback"})
	panel:AddControl("Label", {Text = "tickbox active"})
	panel:AddControl("Label", {Text = "tentry model"})
	panel:AddControl("Label", {Text = "combobox models"})
	panel:AddControl("Label", {Text = "listview POA func"})
	panel:AddControl("Label", {Text = "3sliders pos"})
	panel:AddControl("Label", {Text = "3sliders ang"})
	panel:AddControl("Label", {Text = "slider size uni"})
	panel:AddControl("Label", {Text = "3sliders size"})
	panel:AddControl("Label", {Text = "header w/ butt add -- sight adjust"})
	panel:AddControl("Label", {Text = "tentry material"})
	panel:AddControl("Label", {Text = "tentry parent"})
	panel:AddControl("Label", {Text = "tickbox nodraw"})
	panel:AddControl("Label", {Text = "tickbox hide cwvm"})
	panel:AddControl("Label", {Text = "tickbox recomp light"})
	panel:AddControl("Label", {Text = "tickbox animated"})
	panel:AddControl("Label", {Text = "header shortcunts"})
	panel:AddControl("Label", {Text = "goto/add other element of same name"})
	
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
	
	panel:AddControl("Label", {Text = "header w/ butt cancer"})
	panel:AddControl("Label", {Text = "tentry elementName"})
	panel:AddControl("Label", {Text = "tentry model"})
	
	for _,tableName in pairs(self.elementTables) do
		panel:AddControl("Label", {Text = "tickbox " .. tableName .. " (disabled if exsts)"})
	end
	
	panel:AddControl("Label", {Text = "butt add"})
	
	self:_addSectionGooback()
end

TOOL:addPanelBuilder(PB)

// Export thing

local PB = {}
PB.Name = "expo"

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	panel:AddControl("Label", {Text = "header w/ butt cancer"})
	
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
	
	self:_addSectionRefreshButt()
	
	self:_runBuilder()
	
	panel:AddControl("Label", {Text = ""})
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
