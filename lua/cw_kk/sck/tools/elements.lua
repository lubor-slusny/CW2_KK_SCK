AddCSLuaFile()

local strFormat = string.format

local TOOL = {}

TOOL.Name = "elements"
TOOL.PrintName = "03 | Element Browser 3"
TOOL.Version = "3.0"

TOOL.elementTables = {
	["AttachmentModelsVM"] = {
		tableName = "AttachmentModelsVM",
		adjustable = true,
		defParent = "CW_VM",
	},
	["AttachmentModelsWM"] = {
		tableName = "AttachmentModelsWM",
		defParent = "WMEnt",
	},
}

TOOL.headerBackground = Color(0,160,255,100)
TOOL.darkerBackground = Color(0,0,0,50)

TOOL.__index = TOOL

function TOOL:addPanelBuilder(panelBuilder)
	self._panelBuilders = self._panelBuilders or {}

	setmetatable(panelBuilder, self)
	self._panelBuilders[panelBuilder.Name] = panelBuilder
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

function TOOL:_addSectionExportButt(addToSelected)
	local panel = self._panel

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)

		butt:SetText("Export")

		function butt:DoClick()
			TOOL._state.export.addToSelected = addToSelected
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
		label:Dock(FILL)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		-- label:SetMouseInputEnabled(true)

		-- function label:DoClick()
			-- TOOL:_setBuilder("list")
		-- end

		local butt
		butt = vgui.Create("DButton", backgroundPanel)
		butt:SetText("Add")
		butt:SetTooltip("Add new item to " .. tableName .. ".")
		butt:Dock(RIGHT)
		butt:DockMargin(0,4,8,4)

		function butt:DoClick()
			TOOL._state.make.elementName = fill
			TOOL._state.make.model = fill and TOOL._state.edit.data.model
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
	local data = wep[tableName][elementName]

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local DoClick = function()
			if !reverse then
				TOOL._state.edit.tableName = tableName
				TOOL._state.edit.elementName = elementName
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

		if data.active then
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

function TOOL:_createElement(tableName, elementName)
	local wep = self._wep
	local data = wep[tableName][elementName]

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

function TOOL:_getParentEnt(tableName, elementName, subElementIndex)
	local wep = self._wep
	local data = wep[tableName][elementName]

	if data.models then
		data = data.models[subElementIndex]
	end

	if IsValid(data.ent:GetParent()) then
		return data.ent:GetParent()
	end

	if data.rel and wep[tableName][rel] and IsValid(wep[tableName][rel].ent) then
		return wep[tableName][rel].ent
	end

	local entName = self.elementTables[tableName].defParent
	return wep[entName]
end

function TOOL:_addSectionMeh()
	local panel = self._panel
	local wep = self._wep

	panel:AddControl("Label", {Text = "Active elementRender function count: " .. table.Count(wep.elementRender)})
	local i = 0

	for _,ent in pairs(CustomizableWeaponry.cmodels.curModels) do
		if ent.wepParent == wep then
			i = i + 1
		end
	end

	panel:AddControl("Label", {Text = "Current weapon cl model count: " .. i})
	panel:AddControl("Label", {Text = "Current total cl model count: " .. #CustomizableWeaponry.cmodels.curModels})
end

local function stringToString(str)
	if not str then
		return "nil"
	end

	return "\"" .. str .. "\""
end

local function adjustmentToString(adj)
	if not adj then
		return "nil"
	end

	local formatIndex = "index = %s, "

	return strFormat(
		"{%saxis = \"%s\", min = %s, max = %s, inverse = %s, inverseOffsetCalc = %s}",

			adj.index != nil and
				strFormat(formatIndex, tostring(adj.index)) or "",

			tostring(adj.axis),
			tostring(adj.min),
			tostring(adj.max),
			tostring(adj.inverse),
			tostring(adj.inverseOffsetCalc)
	)
end

function TOOL:_subElementToString(data, wrapAround)
	local formatMain		= "model = %s, pos = %s, angle = %s, size = %s%s%s%s"
	local formatWrapped		= "{%s},"

	local formatBone		= ", bone = %s"
	local formatAttachment	= ", attachment = %s"
	local formatMerge		= ", merge = %s"

	local formatBlank		= ""

	local out = strFormat(
		formatMain,
			stringToString(data.model),
			self:VectorToString(data.pos),
			self:AngleToString(data.angle),
			self:VectorToString(data.size),

			data.bone != nil and
				strFormat(formatBone, stringToString(data.bone)) or formatBlank,

			data.attachment != nil and
				strFormat(formatAttachment, stringToString(data.attachment)) or formatBlank,

			data.merge != nil and
				strFormat(formatMerge, tostring(data.merge)) or formatBlank
	)

	if wrapAround then
		out = strFormat(formatWrapped, out)
	end

	return out
end

function TOOL:_getElementCode(tableName, elementName)
	local wep = self._wep
	local data = wep[tableName][elementName]

	local formatMain			= "[\"%s\"] = {%s%s},"
	local formatAdjustment		= ", adjustment = %s"

	local codeMain = ""

	if data.models then
		formatMain				= "[\"%s\"] = {\n\t\t\tmodels = {\n\t\t\t\t%s\n\t\t\t},\n\t\t%s},"
		local formatSeparator	= "\n\t\t\t\t"

		local outSeparator = ""

		for _,data in pairs(data.models) do
			codeMain = codeMain .. outSeparator .. self:_subElementToString(data, true)
			outSeparator = formatSeparator
		end
	else
		codeMain = self:_subElementToString(data, false)
	end

	return strFormat(
		formatMain,
			elementName,
			codeMain,
			data.adjustment != nil and strFormat(formatAdjustment, adjustmentToString(data.adjustment)) or ""
	)
end

///////////////
// Clipboard //
///////////////

TOOL.clipboard = {}
CB = TOOL.clipboard

function CB:copy(key, sourceData, sourceWep)
	self._data = {}
	pbEdit = TOOL._panelBuilders["edit"] // so nasty...
	for property,clone in pairs(pbEdit.restoreProperties) do
		self._data[property] = clone(sourceData[property])
	end

	self._meta = {}
	self._meta.origin = sourceWep:GetClass()
	self._meta.key = key
	self._meta.time = CurTime()
end

function CB:getMeta()
	return self._meta
end

function CB:getData()
	return self._data
end

function CB:clear()
	self._data = nil
	self._meta = nil
end

function CB:empty()
	return self._meta == nil
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

	state.list.lastSort = {}

	for tableName,_ in pairs(self.elementTables) do
		self:_addHeaderETName(tableName)

		state.list.lastSort[tableName] = {}

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
			table.insert(state.list.lastSort[tableName], elementName)
			self:_addHeaderEName(tableName, elementName)
		end
	end

	self:_addSectionExportButt()
	self:_addSectionMeh()
end

TOOL:addPanelBuilder(PB)

//////////////////
// Element Edit //
//////////////////

local PB = {}
PB.Name = "edit"

PB.defaultAdjustment = {
	min = 0,
	max = 0,
	axis = "x",
	inverse = false,
	inverseOffsetCalc = false,
}

local function id(out)
	return out
end

PB.restoreProperties = {
	angle = Angle,
	pos = Vector,
	size = Vector,
	adjustment = table.Copy,
	bodygroups = table.Copy,
	materials = table.Copy,
	-- active = id,
	animated = id,
	attachment = id,
	bone = id,
	hideVM = id,
	ignoreKKBGO = id,
	material = id,
	merge = id,
	model = id,
	nodraw = id,
	rel = id,
	retSizeMult = id,
	rLight = id,
	skin = id,
}

function PB:_addHeaderNext()
	local panel = self._panel
	local wep = self._wep
	local state = self._state

	local sorted = state.list.lastSort[state.edit.tableName]
	local count = #sorted
	local curID
	for i,k in pairs(sorted) do
		if k == state.edit.elementName then
			curID = i - 1
		end
	end

	if not curID then
		return
	end

	local prevID, nextID = curID - 1, curID + 1
	local prevElement = sorted[prevID % count + 1]
	local nextElement = sorted[nextID % count + 1]

	if nextElement == state.edit.elementName then
		return
	end

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("[˂] " .. prevElement)
		label:SetDark(true)
		label:Dock(FILL)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)

		function label:DoClick()
			TOOL._state.edit.elementName = prevElement
			TOOL:_setBuilder("edit")
		end

		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText(nextElement .. " [˃]")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		label:SetMouseInputEnabled(true)

		function label:DoClick()
			TOOL._state.edit.elementName = nextElement
			TOOL:_setBuilder("edit")
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

PB.elementPropertiesLayout = {
	"Active",
	"SubElementSelector",
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
	"Unknowns",
	"CopyElement",
	"Restore",
	"ExportSingle",
}

function PB:_addSectionActive(panel, wep, state)
	local backgroundPanel = vgui.Create("DPanel", panel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Active")
		cbox:SetChecked(state.edit.data.active)
		cbox:SetDark(true)

		cbox.Label:Dock(RIGHT)

		function cbox:OnChange(val)
			state.edit.data.active = val
			PB:_updatePanel()
		end

		// TODO: RIGHT: add subelement button
			// TODO: convert func single->multi

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall()
end

function PB:_addSectionSubElementSelector(panel, wep, state)
	local data = state.edit.data

	if not data.models then
		return
	end

	local backgroundPanel = vgui.Create("DPanel", panel)

		local function makeChoice(index)
			return string.format(
				"[%s] - %s",
				tostring(index),
				string.GetFileFromFilename(data.models[index].model)
			)
		end

		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		box:DockMargin(8,0,8,8)
		box:SetValue(makeChoice(state.edit.subElementIndex))

		for k,_ in pairs(data.models) do
			box:AddChoice(makeChoice(k), k)
		end

		function box:OnSelect(_, _, data)
			state.edit.subElementIndex = data
			TOOL:_updatePanel()
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(32)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall()
end

function PB:_addSectionModelEntry(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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

function PB:_addSectionPOAF(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

	state.edit.POALastAtt = nil
	state.edit.POALastBone = nil

	local backgroundPanel = vgui.Create("DPanel", panel)

		local listView = vgui.Create("DListView", backgroundPanel)
		listView:Dock(FILL)
		listView:DockMargin(8,8,8,8)
		listView:SetTall(84)
		listView:SetMultiSelect(false)
		listView:AddColumn("Point-of-attachment function:")
		listView:AddLine("[CW20] Bone on parent entity")

		if wep.KKINS2Wep or wep.KKPOASet then
			local ent = self:_getParentEnt()

			if IsValid(ent) and table.Count(ent:GetAttachments()) > 0 then
				listView:AddLine("[KKIN2] QC Attachment on parent entity")
			else
				listView:AddLine("[DISABLED] No QC Attachments found")
			end

			listView:AddLine("[KKIN2] Bone-Merge to parent entity")
		end

		function listView:SortByColumn() end

		if data.merge then
			listView._lastRow = 3
			listView:SelectItem(listView:GetLine(3))
		elseif data._attachment then
			listView._lastRow = 2
			listView:SelectItem(listView:GetLine(2))

			state.edit.POALastAtt = data.attachment
		else
			listView._lastRow = 1
			listView:SelectItem(listView:GetLine(1))

			state.edit.POALastBone = data.bone
		end

		function listView:OnRowSelected(val)
			if val == self._lastRow then
				return
			end

			self._lastRow = val

			local parent = PB:_getParentEnt()

			if val == 1 then
				data.merge = false
				data.attachment = nil
				data._attachment = nil
				data.bone = state.edit.POALastBone or parent:GetBoneName(0)
				data._bone = nil
			elseif val == 2 then
				local att = parent:GetAttachments()[1]

				if att then
					data.merge = false
					data.attachment = state.edit.POALastAtt or att.name
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

		state.edit.POASelect = listView

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetTall(listView:GetTall())
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall()
end

function PB:_addSectionSelectAtt(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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

function PB:_addSectionPosSliders(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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

function PB:_addSectionAngSliders(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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

function PB:_addSectionSizeUniform(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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
			if !state.edit.sizeSliders then
				return
			end

			for slider,_ in pairs(state.edit.sizeSliders) do
				slider:SetValue(val)
			end

			PB:SaveSliderZoom(self)
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionSizeSliders(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

	data.size = Vector(data.size)

	state.edit.sizeSliders = {}

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

				data.matrix = Matrix()
				data.matrix:Scale(data.size)
				data.ent:EnableMatrix("RenderMultiply", data.matrix)

				PB:SaveSliderZoom(self)
			end

			state.edit.sizeSliders[slider] = slider
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,8)
	backgroundPanel:SetTall(72)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionSightAdjustment(panel, wep, state)
	if !self.elementTables[state.edit.tableName].adjustable then
		return 0
	end

	local data = state.edit.data

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
	local data = state.edit.data

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
	local data = state.edit.data

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
	local data = state.edit.data

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
	local data = state.edit.data

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
	local data = state.edit.data

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
	local data = state.edit.data

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

function PB:_addSectionSkin(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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

function PB:_addSectionBodygroups(panel, wep, state)
	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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

function PB:_addSectionMaterialEntry(panel, wep, state)
	if !wep.KKINS2Wep then
		return 0
	end

	local data = state.edit.data

	if data.models then
		data = data.models[state.edit.subElementIndex]
	end

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

function PB:_addSectionParentEntry(panel, wep, state)
	if !wep.KKINS2Wep then
		return 0
	end

	local data = state.edit.data

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

			if wep[state.edit.tableName][rel] then
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

function PB:_addSectionNodraw(panel, wep, state)
	if !wep.KKINS2Wep then
		return 0
	end

	local backgroundPanel = vgui.Create("DPanel", panel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Hide (only update Pos/Ang)")
		cbox:SetChecked(state.edit.data.nodraw)
		cbox:SetDark(true)

		cbox.Label:Dock(RIGHT)

		function cbox:OnChange(val)
			state.edit.data.nodraw = val
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionHideVM(panel, wep, state)
	if !wep.KKINS2Wep then
		return 0
	end

	local backgroundPanel = vgui.Create("DPanel", panel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Hide CW_VM when active")
		cbox:SetChecked(state.edit.data.hideVM)
		cbox:SetDark(true)

		cbox.Label:Dock(RIGHT)

		function cbox:OnChange(val)
			state.edit.data.hideVM = val
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionLighting(panel, wep, state)
	if !wep.KKINS2Wep then
		return 0
	end

	local backgroundPanel = vgui.Create("DPanel", panel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Recompute lighting")
		cbox:SetChecked(state.edit.data.rLight)
		cbox:SetDark(true)

		cbox.Label:Dock(RIGHT)

		function cbox:OnChange(val)
			state.edit.data.rLight = val
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionUnknowns(panel, wep, state)
	// TODO:
end

function PB:_addSectionAnimated(panel, wep, state)
	local backgroundPanel = vgui.Create("DPanel", panel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:SetText("Animated")
		cbox:SetChecked(state.edit.data.animated)
		cbox:SetDark(true)

		cbox.Label:Dock(RIGHT)

		function cbox:OnChange(val)
			state.edit.data.animated = val
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall() + 2
end

function PB:_addSectionCopyElement(panel, wep, state)
	local backgroundPanel = vgui.Create("DPanel", panel)

		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Copy to other swep")

		function butt:DoClick()
			PB.clipboard:copy(
				state.edit.elementName,
				state.edit.data,
				wep
			)
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,8,8,0)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()

	return backgroundPanel:GetTall() + 8
end

function PB:_addSectionRestore(panel, wep, state)
	local storedWep = weapons.GetStored(wep:GetClass())
	local storedWepElements = storedWep[state.edit.tableName] or {}
	local stored = storedWepElements[state.edit.elementName]
	state.edit.stored = stored

	local backgroundPanel = vgui.Create("DPanel", panel)

		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)

		butt:SetText("Restore from weapon.lua")
		butt:SetEnabled(stored != nil)

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

function PB:_addSectionExportSingle(panel, wep, state)
	local backgroundPanel = vgui.Create("DPanel", panel)

		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)

		butt:SetText("Export single")

		function butt:DoClick()
			local out = PB:_getElementCode(state.edit.tableName, state.edit.elementName)
			SetClipboardText(out)
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
	local data = state.edit.data

	return TOOL:_getParentEnt(state.edit.tableName, state.edit.elementName, state.edit.subElementIndex)
end

function PB:_getAttSelection()
	local state = self._state
	local data = state.edit.data
	local parent = self:_getParentEnt()
	local out

	if state.edit.POASelect:GetSelectedLine() == 1 then
		out = {}
		out.value = data.bone or "-select bone-"

		out.choices = {}
		for i=0,(parent:GetBoneCount() - 1) do
			local boneName = parent:GetBoneName(i)
			out.choices[strFormat("[%03d] %s", i, boneName)] = boneName
		end

		function out:onSelect(_, _, name)
			data.bone = name
			PB:_recreateElement()
			PB:_updatePanel()
		end
	end

	if state.edit.POASelect:GetSelectedLine() == 2 then
		out = {}
		out.value = data.attachment or "-select attachment-"

		out.choices = {}
		local atts = parent:GetAttachments()
		for i=1,#atts do
			local attName = atts[i].name
			out.choices[strFormat("[%03d] %s", i, attName)] = attName
		end

		function out:onSelect(_, _, name)
			data.attachment = name
			PB:_recreateElement()
			PB:_updatePanel()
		end
	end

	return out
end

function PB:_recreateElement()
	local state = self._state
	local data = state.edit.data

	self:_createElement(state.edit.tableName, state.edit.elementName)
end

function PB:_restoreElement()
	local state = self._state
	local data = state.edit.data
	local stored = state.edit.stored

	for property,copyOf in pairs(self.restoreProperties) do
		data[property] = copyOf(stored[property])
	end

	data.active = true

	PB:_recreateElement()
	PB:_updatePanel()
end

function PB:run()
	self._panel = nil

	local panel = self._panel
	local wep = self._wep
	local state = self._state

	state.edit.data = wep[state.edit.tableName][state.edit.elementName]

	if state.edit.data.models then
		state.edit.subElementIndex = state.edit.subElementIndex or
			table.GetKeys(state.edit.data.models)[1]
	end

	self:_addHeaderETName(state.edit.tableName, state.edit.elementName)
	self:_addHeaderNext()
	self:_addHeaderEName(state.edit.tableName, state.edit.elementName, true)

	local backgroundPanel = vgui.Create("DPanel", panel)
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)

	self._panel = backgroundPanel

	local tall = 0
	for _,section in pairs(self.elementPropertiesLayout) do
		local addSection = self["_addSection" .. section]
		tall = tall + (addSection(self, self._panel, wep, state) or 0)
	end
	backgroundPanel:SetTall(tall + 8)

	self._panel = nil

	for tableName,_ in pairs(self.elementTables) do
		if tableName != state.edit.tableName and wep[tableName] and wep[tableName][state.edit.elementName] then
			self:_addHeaderETName(tableName, state.edit.elementName)
			self:_addHeaderEName(tableName, state.edit.elementName)
		end
	end

	self:_addSectionExportButt(state.edit.elementName)
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
			TOOL._state.make.elementName = nil
			TOOL._state.make.model = nil
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
		entry:SetText(state.make.elementName)

		function entry:OnChange()
			PB._state.make.elementName = self:GetValue()
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
		entry:SetText(state.make.model)

		function entry:OnChange()
			PB._state.make.model = self:GetValue()
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
			local elementName = state.make.elementName
			local exists = wep[tableName][elementName] != nil
			local valid = elementName != ""
			local can = (!exists) and valid

			can = can or !PB.clipboard:empty()

			self:SetText(tableName .. (exists and " (already exists)" or ""))
			self:SetChecked(can)
			self:SetEnabled(can)
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()

	self:_updateCBoxes()
end

function PB:_addSectionButtPaste()
	local panel = self._panel
	local wep = self._wep
	local cb = self.clipboard

	if cb:empty() then
		return
	end

	local cbMeta = cb:getMeta()

	if cbMeta.origin == wep:GetClass() then
		return
	end

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)

		butt:SetText(strFormat(
			"Paste \"%s\"",
			cbMeta.key
		))
		butt:SetTooltip(strFormat(
			"Create new element %s using data from %s.",
			cbMeta.key,
			cbMeta.origin
			-- tostring(CurTime() - cbMeta.time)
		))

		function butt:DoClick()
			PB:_finishMaking(!cb:empty())
		end

		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(RIGHT)
		butt:SetText("Clear")
		function butt:DoClick()
			cb:clear()
			TOOL:_updatePanel()
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
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

function PB:_newElementData(elementTableName)
	local wep = self._wep
	local state = self._state

	local out = {}

	out.model = state.make.model
	out.pos = Vector()
	out.angle = Angle()

	if out.model == "models/maxofs2d/cube_tool.mdl" then
		out.size = Vector(0.075, 0.075, 0.075)
		out.bodygroups = {1}
	else
		out.size = Vector(1,1,1)
	end

	if wep.KKINS2Wep then
		out.merge = true
	else
		parent = TOOL.elementTables[elementTableName].defParent
		out.bone = wep[parent]:GetBoneName(0)
	end

	return out
end

function PB:_copyElementData(source, elementTableName)
	local wep = self._wep
	local state = self._state

	local parent = TOOL.elementTables[elementTableName].defParent
	local parEnt = wep[parent]
	local out = table.Copy(source)

	if wep.KKINS2Wep then
		if out.attachment != nil and parEnt:LookupAttachment(out.attachment) < 1 then
			out.attachment = parEnt:GetAttachments()[1] and parEnt:GetAttachments()[1].name
		end
	else
		out.attachment = nil
		out.merge = nil
	end

	if out.bone != nil and parEnt:LookupBone(out.bone) == nil then
		out.bone = parEnt:GetBoneName(1)
	end

	return out
end

function PB:_finishMaking(useClipboard)
	local wep = self._wep
	local state = self._state
	local targets = self:_getTargets()

	for _,elementTableName in pairs(targets) do
		local data = self:_newElementData(elementTableName)

		if useClipboard then
			data = self:_copyElementData(self.clipboard:getData(), elementTableName)
			state.make.elementName = self.clipboard:getMeta().key
		end

		wep[elementTableName] = wep[elementTableName] or {}
		wep[elementTableName][state.make.elementName] = data
		self:_createElement(elementTableName, state.make.elementName)
		data.active = true
	end

	PB._state.edit.tableName = targets[1]
	PB._state.edit.elementName = PB._state.make.elementName
	PB:_setBuilder("edit")
end

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state

	state.make.elementName = state.make.elementName or "kk_was_here_lol"
	state.make.model = state.make.model or "models/maxofs2d/cube_tool.mdl"

	if !self.clipboard:empty() then
		state.make.elementName = self.clipboard:getMeta().key
		state.make.model = self.clipboard:getData().model
	end

	self:_addHeader()
	self:_addSectionNameEntry()
	self:_addSectionModelEntry()

	for tableName,_ in pairs(self.elementTables) do
		self:_addSectionETMark(tableName)
	end

	self:_addSectionButtPaste()
	self:_addSectionButtFinish()
end

TOOL:addPanelBuilder(PB)

//////////////////
// Export Thing //
//////////////////

local PB = {}
PB.Name = "export"

PB.quickSelects = {
	function(self)
		self:SetChecked(true)
	end,

	function(self)
		self:SetChecked(false)
	end,

	function(self)
		self:SetChecked(!self:GetChecked())
	end,
}

function PB:_addHeader()
	local panel = self._panel
	local wep = self._wep
	local state = self._state

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Select elements for export")
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

function PB:_addSectionQuickSelect()
	local panel = self._panel
	local wep = self._wep
	local state = self._state

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Quick-select:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()

		local listView = vgui.Create("DListView", backgroundPanel)
		listView:AddColumn("All")
		listView:AddColumn("None")
		listView:AddColumn("Invert")
		listView:SetHeaderHeight(16)

		listView:Dock(FILL)
		listView:DockMargin(8,4,8,0)
		listView:SizeToContents()
		listView:SetPaintBackground(false)
		listView:FixColumnsLayout()

		function listView:SortByColumn(i)
			local update = PB.quickSelects[i]

			-- for _,cboxes in pairs(state.export.cboxes) do
				-- for _,cbox in pairs(cboxes) do
					-- update(cbox)
				-- end
			-- end
		end

		function listView:OnRequestResize(val) end

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:mainReceiver(tableOfDroppedPanels, isDropped, menuIndex, mouseX, mouseY)
	tableOfDroppedPanels[1]:SetAlpha(isDropped and 255 or 0)

	print()
	PrintTable(tableOfDroppedPanels)
end

function PB:_addSectionHeader(tableName)
	local panel = self._panel
	local wep = self._wep
	local data = wep[tableName][elementName]

	local backgroundPanel = vgui.Create("DPanel", panel)

		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP." .. tableName)
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(false)
	backgroundPanel:SizeToContents()
end

function PB:_addSectionItem(tableName, elementName)
	local panel = self._panel
	local state = self._state
	local order = state.export.order[tableName]

	local backgroundPanel = vgui.Create("DPanel", panel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:Dock(LEFT)
		cbox:DockMargin(8,0,8,0)
		cbox:SetText(elementName)
		cbox:SetChecked(state.export.addToSelected == elementName)
		cbox:SetDark(true)

		cbox.Label:Dock(RIGHT)

		-- table.insert(state.export.cboxes[tableName], cbox)

		local listView = vgui.Create("DListView", backgroundPanel)
		listView:AddColumn("˄")
		listView:AddColumn("˅")
		listView:AddColumn("T") // listView:AddColumn("┳")
		listView:AddColumn("B") // listView:AddColumn("┻")
		listView:SetHeaderHeight(20)

		listView:Dock(RIGHT)
		listView:DockMargin(8,2,2,0)
		listView:SetWide(20 * 4)
		listView:SetPaintBackground(false)
		listView:FixColumnsLayout()

		function listView:SortByColumn(i)
			local pos = table.KeyFromValue(order, elementName)
			table.remove(order, pos)

			if i == 1 then
				table.insert(order, pos - 1, elementName)
			end

			if i == 2 then
				table.insert(order, pos + 1, elementName)
			end

			if i == 3 then
				table.insert(order, 1, elementName)
			end

			if i == 4 then
				table.insert(order, elementName)
			end

			PB:_updatePanel()
		end

		function listView:OnRequestResize(val) end

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,8,8,0)
	backgroundPanel:SetBackgroundColor(self.darkerBackground)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()

	-- backgroundPanel:SetMouseInputEnabled(true)
	-- backgroundPanel:Droppable(tableName)
end

function PB:_addSectionFinish()
	local panel = self._panel
	local state = self._state

	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)

		butt:SetText("Export selected - copy code to clipboard")

		function butt:DoClick()
			PB:ThrowNewNotImplemented()
		end

	backgroundPanel:Dock(TOP)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function PB:run()
	local panel = self._panel
	local wep = self._wep
	local state = self._state

	local order = state.export.order or {}

	if table.Count(order) < 1 then
		for tableName,_ in pairs(self.elementTables) do
			if !wep[tableName] then
				continue
			end

			if table.Count(wep[tableName]) < 1 then
				continue
			end

			order[tableName] = {}
		end

		for tableName,target in pairs(order) do
			for elementName,_ in SortedPairs(wep[tableName]) do
				table.insert(target,elementName)
			end
		end
	end

	state.export.order = order

	self:_addHeader()
	self:_addSectionQuickSelect()

	for tableName,elementTable in pairs(order) do
		local backgroundPanel = vgui.Create("DPanel", panel)
		backgroundPanel:Dock(TOP)
		backgroundPanel:SetPaintBackground(true)
		backgroundPanel:SetTall((table.Count(elementTable) + 1) * 32)
		-- backgroundPanel:Receiver(tableName, self.mainReceiver, {})
		panel:AddItem(backgroundPanel)

		self._panel = backgroundPanel

		self:_addSectionHeader(tableName)

		for i,elementName in pairs(elementTable) do
			self:_addSectionItem(tableName, elementName)
		end

		self._panel = nil
	end

	self:_addSectionFinish()
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

function TOOL:_newStateStruct()
	local out = {builderId = "list"}

	for k,_ in pairs(self._panelBuilders) do
		out[k] = {}
	end

	return out
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

	self._states[wep] = self._states[wep] or self:_newStateStruct()
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
