AddCSLuaFile()

local TOOL = {}

TOOL.Name = "elements"
TOOL.PrintName = "Element Browser 3"
TOOL.Version = "3.0"

TOOL.elementTables = {
	"AttachmentModelsVM",
	"AttachmentModelsWM"
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
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addHeaderETName(tableName, fill)
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
			TOOL._state.makeElement = fill
			TOOL:_setBuilder("make")
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetBackgroundColor(self.headerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addHeaderEName(tableName, elementName, reverse)
	local panel = self._panel
	local element = self._wep[tableName][elementName]
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local DoClick = function()
			if !reverse then
				TOOL._state.editTable = tableName
				TOOL._state.editElement = elementName
				TOOL:_setBuilder("edit")
			else
				TOOL:_setBuilder("list")
			end
		end
		
		local Think = function(self)
			if self:IsHovered() then
				if input.IsMouseDown(MOUSE_RIGHT) then
					SetClipboardText(elementName)
				end
			end
		end
		
		local icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(0,2)
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
		label:SetText(reverse and "[˄]" or "[˅]")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)
		label.DoClick = DoClick
		label.Think = Think
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

// Element List

local PB = {}
PB.Name = "list"

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	for _,tableName in pairs(self.elementTables) do
		self:_addHeaderETName(tableName)
		
		wep[tableName] = wep[tableName] or {}
		local aa = wep.ActiveAttachments or {}
		
		local sortKeys = {}
		for elementName,element in pairs(wep[tableName]) do
			// rest
			local priority = "c_"
			
			// active elements
			priority = element.active and "b_" or priority
			
			// elements of active attachment
			priority = aa[elementName] and "a_" or priority
			
			sortKeys[priority .. tostring(elementName)] = elementName
		end
		
		for _,elementName in SortedPairs(sortKeys) do
			self:_addHeaderEName(tableName, elementName)
		end
	end
end

TOOL:addPanelBuilder(PB)

// Element Edit

local PB = {}
PB.Name = "edit"

PB.elementProperties = {
	["AttachmentModelsVM"] = {
		adjustable = true,
	},
	["AttachmentModelsWM"] = {},
}

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	self:_addHeaderETName(state.editTable, state.editElement)
	self:_addHeaderEName(state.editTable, state.editElement, true)
	
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
end

TOOL:addPanelBuilder(PB)

// Element Make

local PB = {}
PB.Name = "make"

function PB:_addHeader()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Create new")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local butt
		butt = vgui.Create("DButton", backgroundPanel)
		butt:SetText("Cancel")
		butt:Dock(RIGHT)
		butt:DockMargin(0,4,8,4)
		
		function butt:DoClick()
			TOOL._state.makeElement = nil
			TOOL:_setBuilder()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetBackgroundColor(self.headerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:_addSectionNameEntry()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Element Name:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,0,0)
		entry:SetText(state.makeElement)
		
		function entry:OnChange()
			PB._state.makeElement = self:GetValue()
			PB:_updateCBoxes()
			PB:_updateButt()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:_addSectionModelEntry()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	-- panel:AddControl("Label", {Text = "tentry model"})
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Model:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,0,0)
		entry:SetText(state.makeModel)
		
		function entry:OnChange()
			PB._state.makeModel = self:GetValue()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:_addSectionETMark(tableName, elementName)
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetDark(true)
		cbox:Dock(LEFT)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			PB:_updateButt()
		end
		
		self._targets = self._targets or {}
		self._targets[cbox] = function(self)
			local elementName = state.makeElement
			local exists = wep[tableName][elementName] != nil
			local valid = elementName != ""
			local can = (!exists) and valid
			
			self:SetText(tableName .. (exists and " (already exists)" or ""))
			self:SetChecked(can)
			self:SetEnabled(can)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	self:_updateCBoxes()
end

function PB:_addSectionButtFinish()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetSize(150,20)
		butt:SetText("Finish")
		
		function butt:DoClick()
			PB:_finishMaking()
		end
		
		self._finisher = butt
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	self:_updateButt()
end

function PB:_updateCBoxes()
	local t = self._targets
	for cbox,updateCBox in pairs(t) do
		if IsValid(cbox) then
			updateCBox(cbox)
		else
			t[cbox] = nil
		end
	end
end

function PB:_updateButt()
	if !IsValid(self._finisher) then
		return
	end
	
	local numSelected = #self:_getTargets()
	
	self._finisher:SetEnabled(numSelected > 0)
end

function PB:_getTargets()
	local t = self._targets
	local out = {}
	
	for cbox,_ in pairs(t) do
		if IsValid(cbox) then
			if cbox:GetChecked() then
				table.insert(out, cbox:GetText())
			end
		else
			t[cbox] = nil
		end
	end
	
	return out
end

function PB:_finishMaking()
	// do stuff
	// add to elementTable, init
	
	PB:ThrowNewNotImplemented()
	
	-- PB._state.editTable = targets[1]
	-- PB._state.editElement = PB._state.makeElement
	-- PB:_setBuilder("edit")
end

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	state.makeElement = state.makeElement or "kk_was_here_lol"
	state.makeModel = state.makeModel or "models/maxofs2d/cube_tool.mdl"
	
	self:_addHeader()
	self:_addSectionNameEntry()
	self:_addSectionModelEntry()
	
	for _,tableName in pairs(self.elementTables) do
		self:_addSectionETMark(tableName)
	end
	
	self:_addSectionButtFinish()
end

TOOL:addPanelBuilder(PB)

// Export thing
/*
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
*/
// Session manager

function TOOL:Initialize()
	self._states = self._states or {}
end

function TOOL:_setBuilder(id)
	id = id or self._statePrevious
	
	local new = id and (self._panelBuilders[id] and id) or "list"
	
	self._statePrevious = self._state.builderId
	self._state.builderId = new
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
