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
		
		butt:SetText("Refresh")
		butt:SetTooltip("Loads changes made outside of this tool.")
		
		function butt:DoClick()
			TOOL:_updatePanel()
		end
		
		-- butt:SetText("Reset")
		-- butt:SetTooltip("Wipes current sessions")
		
		-- function butt:DoClick()
			-- TOOL._states = {}
			-- TOOL:_updatePanel()
		-- end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionExportButt()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		
		butt:SetText("Export options")
		
		function butt:DoClick()
			TOOL:_setBuilder("export")
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
		label:SetMouseInputEnabled(true)
		
		function label:DoClick()
			TOOL:_setBuilder("list")
		end
		
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
	local wep = self._wep
	local element = wep[tableName][elementName]
	
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

//////////////////
// Element List //
//////////////////

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
	
	self:_addSectionExportButt()
end

TOOL:addPanelBuilder(PB)

//////////////////
// Element Edit //
//////////////////

local PB = {}
PB.Name = "edit"

PB.darkerBackground = Color(0,0,0,50)

PB.elementTableProperties = {
	["AttachmentModelsVM"] = {
		adjustable = true,
		defParent = "CW_VM",
	},
	["AttachmentModelsWM"] = {
		defParent = "WMEnt",
	},
}

PB.defaultAdjustment = {
	min = 0, 
	max = 0, 
	axis = "x", 
	inverse = false,
	inverseOffsetCalc = false,
}

PB.elementPropertiesLayout = {
	"Active",
	"ModelEntry",
	"POAF",
	"SelectAtt",
	"PosSliders",
	"AngSliders",
	"SizeUniform",
	"SizeSliders",
	"SightAdjustment",
	"Skin",
	"Bodygroups",
	"MaterialEntry",
	"ParentEntry",
	"Nodraw",
	"HideVM",
	"Lighting",
	"Animated",
	"Restore",
}

function PB:_addSectionActive()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Active")
		cbox:SetChecked(state.editData.active)
		cbox:SetDark(true)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			state.editData.active = val
			PB:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall()
end

function PB:_addSectionModelEntry()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SetText("Model:")
		label:SetDark(true)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,8,0)
		entry:SetText(data.model)
		
		function entry:OnChange()
			local f = self:GetValue()
			
			if file.Exists(f, "GAME") then
				data.model = f
				data.ent:SetModel(f)
				PB:_updatePanel()
			end
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall()
end

function PB:_addSectionPOAF()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local view = vgui.Create("DListView", backgroundPanel)
		view:Dock(FILL)
		view:DockMargin(8,8,8,8)
		view:SetTall(84)
		view:SetMultiSelect(false)
		view:AddColumn("Point-of-attachment function:")
		view:AddLine("[CW20] Bone on parent entity")
		
		if wep.KKINS2Wep then
			local ent = self:_getParentEnt()
			
			if IsValid(ent) and table.Count(ent:GetAttachments()) > 0 then
				view:AddLine("[KKIN2] QC Attachment on parent entity")
			else
				view:AddLine("[DISABLED] No QC Attachments found")
			end
			
			view:AddLine("[KKIN2] Bone-Merge to parent entity")
		end
		
		function view:SortByColumn() end
		
		if data.merge then
			view._lastRow = 3
			view:SelectItem(view:GetLine(3))
		elseif data._attachment then
			view._lastRow = 2
			view:SelectItem(view:GetLine(2))
		else
			view._lastRow = 1
			view:SelectItem(view:GetLine(1))
		end
		
		function view:OnRowSelected(val)
			if val == self._lastRow then
				return
			end
			
			self._lastRow = val
			
			local parent = PB:_getParentEnt()
			
			if val == 1 then
				data.merge = false
				data.attachment = nil
				data._attachment = nil
				data.bone = parent:GetBoneName(0)
				data._bone = nil
			elseif val == 2 then
				local att = parent:GetAttachments()[1]
				
				if att then
					data.merge = false
					data.attachment = att.name
					data._attachment = nil 
					data.bone = nil
					data._bone = nil
				end
			elseif val == 3 then
				data.merge = true
				data.attachment = nil
				data._attachment = nil
				data.bone = nil
				data._bone = nil
			end
			
			PB:_recreateElement()
			PB:_updatePanel()
		end
		
		state.editFuncSelector = view
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(view:GetTall())
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall()
end

function PB:_addSectionSelectAtt()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	local selection = self:_getAttSelection()
	
	if !selection then
		return 0
	end
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		box:DockMargin(8,0,8,8)
		box:SetValue(selection.value)
		
		for k,v in pairs(selection.choices) do
			box:AddChoice(k, v)
		end
		
		box.OnSelect = selection.onSelect
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(32)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall()
end

function PB:_addSectionPosSliders()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	data.pos = Vector(data.pos)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		for _,s in pairs({
			{"pos", "x", -100, 100},
			{"pos", "y", -100, 100},
			{"pos", "z", -100, 100},
		}) do
			local slider = vgui.Create("DNumSlider", backgroundPanel)
			slider:Dock(TOP)
			slider:DockMargin(8,0,8,0)
			slider:SetTall(24)
			slider:SetText(s[1] .. "." .. s[2])
			slider:SetDark(true)
			slider:SetMinMax(s[3], s[4])
			slider:SetDecimals(4)
			slider:SetValue(data[s[1]][s[2]])
			
			self:LoadSliderZoom(slider)
			
			function slider:OnValueChanged(val)
				data[s[1]][s[2]] = val
				PB:SaveSliderZoom(self)
			end
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetTall(72)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall()
end

function PB:_addSectionAngSliders()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	data.angle = Angle(data.angle)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		for _,s in pairs({
			{"angle", "p", -180, 180},
			{"angle", "y", -180, 180},
			{"angle", "r", -180, 180},
		}) do
			local slider = vgui.Create("DNumSlider", backgroundPanel)
			slider:Dock(TOP)
			slider:DockMargin(8,0,8,0)
			slider:SetTall(24)
			slider:SetText(s[1] .. "." .. s[2])
			slider:SetDark(true)
			slider:SetMinMax(s[3], s[4])
			slider:SetDecimals(4)
			slider:SetValue(data[s[1]][s[2]])
			
			self:LoadSliderZoom(slider)
			
			function slider:OnValueChanged(val)
				data[s[1]][s[2]] = val
				PB:SaveSliderZoom(self)
			end
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetTall(72)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionSizeUniform()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	data.size = Vector(data.size)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(TOP)
		slider:DockMargin(8,0,8,0)
		slider:SetTall(24)
		slider:SetText("size.xyz")
		slider:SetDark(true)
		slider:SetMinMax(0.001, 10)
		slider:SetDecimals(4)
		slider:SetValue(data.size.x)
		
		self:LoadSliderZoom(slider)
	
		function slider:OnValueChanged(val)
			if !state.editSizeSliders then
				return
			end
			
			for slider,_ in pairs(state.editSizeSliders) do
				slider._pauseSendingUpdates = true
				slider:SetValue(val)
				slider._pauseSendingUpdates = false
			end
			
			PB:SaveSliderZoom(self)
			PB:_recreateElement()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionSizeSliders()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	state.editSizeSliders = {}
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		for _,s in pairs({
			{"size", "x", 0.001, 10},
			{"size", "y", 0.001, 10},
			{"size", "z", 0.001, 10},
		}) do
			local slider = vgui.Create("DNumSlider", backgroundPanel)
			slider:Dock(TOP)
			slider:DockMargin(8,0,8,0)
			slider:SetTall(24)
			slider:SetText(s[1] .. "." .. s[2])
			slider:SetDark(true)
			slider:SetMinMax(s[3], s[4])
			slider:SetDecimals(4)
			slider:SetValue(data[s[1]][s[2]])
			
			self:LoadSliderZoom(slider)
			
			function slider:OnValueChanged(val)
				data[s[1]][s[2]] = val
				
				if !self._pauseSendingUpdates then
					PB:SaveSliderZoom(self)
					PB:_recreateElement()
				end
			end
			
			state.editSizeSliders[slider] = slider
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetTall(72)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionSightAdjustment()
	local state = self._state
	
	if !self.elementTableProperties[state.editTable].adjustable then
		return 0
	end
	
	local data = state.editData
	
	local long = data.adjustment != nil
	local tall = self:_sightAdjustmentHeader(long)
	
	if long then
		tall = tall + self:_sightAdjustmentLong()
	end
	
	return tall
end

function PB:_sightAdjustmentHeader(long)
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local DoClick = function()
			if long then
				data.adjustment = nil
			else
				data.adjustment = table.Copy(PB.defaultAdjustment)
			end
			PB:_updatePanel()
		end
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Sight Adjustment:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local butt
		butt = vgui.Create("DButton", backgroundPanel)
		butt:SetText(long and "Remove" or "Add")
		butt:Dock(RIGHT)
		butt:DockMargin(0,4,8,4)
		butt.DoClick = DoClick
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8, long and 0 or 8)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + (long and 0 or 8)
end

function PB:_sightAdjustmentLong()
	local panel = self._panel
	local state = self._state
	local data = state.editData
	
	data.adjustment = table.Copy(data.adjustment)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		self:_sightAdjustmentLongAxis(backgroundPanel)
		self:_sightAdjustmentLongMin(backgroundPanel)
		self:_sightAdjustmentLongMax(backgroundPanel)
		self:_sightAdjustmentLongInverts(backgroundPanel)
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(96)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_sightAdjustmentLongAxis(panel)
	local wep = self._wep
	local state = self._state
	local data = state.editData

	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Axis: ")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,0,0)
		label:SizeToContents()
		
		local ax = {x = 1, y = 2, z = 3}
		local xa = {"x", "y", "z"}
		
		local unselect = {"X", "Y", "Z"}
		local selected = {"[X]", "[Y]", "[Z]"}
		
		local listView = vgui.Create("DListView", backgroundPanel)
		listView:AddColumn("")
		listView:AddColumn("")
		listView:AddColumn("")
		listView:SetHeaderHeight(20)
		
		listView:Dock(FILL)
		listView:DockMargin(16,0,8,0)
		listView:SizeToContents()
		listView:SetBackgroundColor(Color(0,0,0,255))
		listView:SetPaintBackground(false)
		listView:FixColumnsLayout()
		
		function listView:SortByColumn(i)
			data.adjustment.axis = xa[i]
			
			for k,v in pairs(self.Columns) do
				if k == i then 
					v:SetName(selected[k])
				else
					v:SetName(unselect[k])
				end
			end
		end
		
		function listView:OnRequestResize(val) end
		
		listView:SortByColumn(ax[data.adjustment.axis])
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function PB:_sightAdjustmentLongMin(panel)
	local wep = self._wep
	local state = self._state
	local data = state.editData

	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(4)
		slider:SetMinMax(-100, 100)
		slider:SetValue(data.adjustment.min)
		slider:SetText("Min:")
		slider:SetDark(true)
		
		PB:LoadSliderZoom(slider)
		
		function slider:OnValueChanged(val)
			data.adjustment.min = val
			PB:SaveSliderZoom(self)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function PB:_sightAdjustmentLongMax(panel)
	local wep = self._wep
	local state = self._state
	local data = state.editData

	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(4)
		slider:SetMinMax(-100, 100)
		slider:SetValue(data.adjustment.max)
		slider:SetText("Max:")
		slider:SetDark(true)
		
		PB:LoadSliderZoom(slider)
		
		function slider:OnValueChanged(val)
			data.adjustment.max = val
			PB:SaveSliderZoom(self)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function PB:_sightAdjustmentLongInverts(panel)
	local wep = self._wep
	local state = self._state
	local data = state.editData

	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:DockMargin(8,0,8,0)
		cbox:SetText("Invert input")
		cbox:SetChecked(data.adjustment.inverse)
		cbox:SetDark(true)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			data.adjustment.inverse = val
			PB:_updatePanel()
		end
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(RIGHT)
		cbox:DockMargin(8,0,8,0)
		cbox:SetText("Invert calculation")
		cbox:SetChecked(data.adjustment.inverseOffsetCalc)
		cbox:SetDark(true)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			data.adjustment.inverseOffsetCalc = val
			PB:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function PB:_addSectionSkin()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	local count = data.ent:SkinCount()
	
	if count < 2 then
		return 0
	end
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(0)
		slider:SetMinMax(0, count - 1)
		slider:SetValue(data.ent:GetSkin())
		slider:SetText("Skin:")
		slider:SetDark(true)
		
		function slider:OnValueChanged(val)
			math.Round(val)
			data.skin = val
			data.ent:SetSkin(val)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionBodygroups()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	local options = {}
	
	for i = 0, data.ent:GetNumBodyGroups() do
		if (data.ent:GetBodygroupCount(i) - 1 > 0) then
			table.insert(options, i)
		end
	end
	
	if #options < 1 then
		return 0
	end
	
	data.bodygroups = data.bodygroups or {}
	data.bodygroups = table.Copy(data.bodygroups)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Bodygroups:")
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(8,4,8,4)
		label:SizeToContents()
		
		for _,i in pairs(options) do
			local slider = vgui.Create("DNumSlider", backgroundPanel)
			slider:Dock(TOP)
			slider:DockMargin(8,0,8,0)
			slider:SetTall(24)
			slider:SetDecimals(0)
			slider:SetMinMax(0, data.ent:GetBodygroupCount(i) - 1)
			slider:SetValue(data.ent:GetBodygroup(i))
			slider:SetText(i .. "# " .. data.ent:GetBodygroupName(i))
			slider:SetDark(true)
			
			function slider:OnValueChanged(val)
				math.Round(val)
				data.bodygroups[i] = val
				data.ent:SetBodygroup(i, val)
			end
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall((#options + 1) * 24)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionMaterialEntry()
	local wep = self._wep
	
	if !wep.KKINS2Wep then
		return 0
	end
	
	local panel = self._panel
	local state = self._state
	local data = state.editData
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:Dock(LEFT)
		label:DockMargin(0,0,4,0)
		label:SetText("Material override:")
		label:SetDark(true)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,0,0)
		entry:SetText(data.material or "")
		
		function entry:OnChange()
			local f = self:GetValue()
			data.material = f
			data.ent:SetMaterial(f)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionParentEntry()
	local wep = self._wep
	
	if !wep.KKINS2Wep then
		return 0
	end
	
	local panel = self._panel
	local state = self._state
	local data = state.editData
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:Dock(LEFT)
		label:DockMargin(0,0,4,0)
		label:SetText("Parent override:")
		label:SetDark(true)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,0,0)
		entry:SetText(data.rel or "")
		
		function entry:OnChange()
			local rel = self:GetValue()
			
			if wep[state.editTable][rel] then
				data.rel = rel
				PB:_recreateElement()
				PB:_updatePanel()
			end
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionNodraw()
	local wep = self._wep
	
	if !wep.KKINS2Wep then
		return 0
	end
	
	local panel = self._panel
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Hide (only update Pos/Ang)")
		cbox:SetChecked(state.editData.nodraw)
		cbox:SetDark(true)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			state.editData.nodraw = val
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionHideVM()
	local wep = self._wep
	
	if !wep.KKINS2Wep then
		return 0
	end
	
	local panel = self._panel
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Hide CW_VM when active")
		cbox:SetChecked(state.editData.hideVM)
		cbox:SetDark(true)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			state.editData.hideVM = val
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionLighting()
	local wep = self._wep
	
	if !wep.KKINS2Wep then
		return 0
	end
	
	local panel = self._panel
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Recompute lighting")
		cbox:SetChecked(state.editData.rLight)
		cbox:SetDark(true)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			state.editData.rLight = val
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionAnimated()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Animated")
		cbox:SetChecked(state.editData.animated)
		cbox:SetDark(true)
		
		cbox.Label:Dock(RIGHT)
		
		function cbox:OnChange(val)
			state.editData.animated = val
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionRestore()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		
		butt:SetText("Restore from weapon.lua")
		
		function butt:DoClick()
			PB:_restoreElement()
			PB:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,8,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
	
	return backgroundPanel:GetTall() + 8
end

function PB:_getParentEnt()
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	if IsValid(data.ent:GetParent()) then
		return data.ent:GetParent()
	end
	
	if data.rel and wep[state.editTable][rel] and IsValid(wep[state.editTable][rel].ent) then
		return wep[state.editTable][rel].ent
	end
	
	local entName = self.elementTableProperties[state.editTable].defParent
	return wep[entName]
end

function PB:_getAttSelection()
	local state = self._state
	local data = state.editData
	local parent = self:_getParentEnt()
	local out
	
	if state.editFuncSelector:GetSelectedLine() == 1 then
		out = {}
		out.value = data.bone or "-select bone-"
		
		out.choices = {}
		for i=0,(parent:GetBoneCount() - 1) do
			local boneName = parent:GetBoneName(i)
			out.choices[string.format("[%03d] %s", i, boneName)] = boneName
		end
		
		function out:onSelect(_, _, name) 
			data.bone = name
			PB:_recreateElement()
			PB:_updatePanel()
		end
	end
	
	if state.editFuncSelector:GetSelectedLine() == 2 then
		out = {}
		out.value = data.attachment or "-select attachment-"
		
		out.choices = {}		
		local atts = parent:GetAttachments()		
		for i=1,#atts do
			local attName = atts[i].name
			out.choices[string.format("[%03d] %s", i, attName)] = attName
		end
		
		function out:onSelect(_, _, name)
			data.attachment = name
			PB:_recreateElement()
			PB:_updatePanel()
		end
	end
	
	return out
end

// 2doo: improv
function PB:_recreateElement()
	local wep = self._wep
	local state = self._state
	local data = state.editData

	if data.models then
		for _,data in ipairs(data.models) do
			wep:_setupAttachmentModel(data)
		end
	else
		wep:_setupAttachmentModel(data)
	end
	
	if wep.KKINS2Wep then	
		if data.models then
			for _,data in ipairs(data.models) do
				wep:_setupAttachmentModelMerge(data)
			end
		else
			wep:_setupAttachmentModelMerge(data)
		end
	end
end

// 2doo: everything
function PB:_restoreElement()
	local wep = self._wep
	local state = self._state
	local data = state.editData
	
	
end

function PB:run()
	self._panel = nil
	
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	state.editData = wep[state.editTable][state.editElement]
	
	self:_addHeaderETName(state.editTable, state.editElement)
	self:_addHeaderEName(state.editTable, state.editElement, true)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
	
	self._panel = backgroundPanel
	
	local tall = 0
	for _,section in pairs(self.elementPropertiesLayout) do
		local addSection = self["_addSection" .. section]
		tall = tall + addSection(self)
	end
	backgroundPanel:SetTall(tall + 8)
	
	self._panel = nil
	
	for _,elementTable in pairs(self.elementTables) do
		if elementTable != state.editTable and wep[elementTable] and wep[elementTable][state.editElement] then
			self:_addHeaderETName(elementTable, state.editElement)
			self:_addHeaderEName(elementTable, state.editElement)
		end
	end
	
	self:_addSectionExportButt()
end

TOOL:addPanelBuilder(PB)

//////////////////
// Element Make //
//////////////////

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
		label:SetText("Element name:")
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

//////////////////
// Export Thing //
//////////////////

local PB = {}
PB.Name = "export"

function PB:_addHeader()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Export selected")
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
			TOOL:_setBuilder()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetBackgroundColor(self.headerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state
	
	self:_addHeader()
end

TOOL:addPanelBuilder(PB)

/////////////////////
// Session Manager //
/////////////////////

function TOOL:Initialize()
	self._states = self._states or {}
end

function TOOL:_setBuilder(id)
	id = id or self._state.builderIdPrevious
	
	local new = id and (self._panelBuilders[id] and id) or "list"
	
	self._state.builderIdPrevious = self._state.builderId
	self._state.builderId = new
	self:_updatePanel()
end

function TOOL:_runBuilder()
	local builderId = self._state.builderId
	local builder = self._panelBuilders[builderId]
	
	if !builder then
		return
	end
	
	builder._state = self._state
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
