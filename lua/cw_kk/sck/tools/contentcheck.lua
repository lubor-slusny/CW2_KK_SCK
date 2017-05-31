AddCSLuaFile()

local TOOL = {}

TOOL.Name = "contentcheck"
TOOL.PrintName = "Content Check"

local icm = CustomizableWeaponry_KK.ins2.isContentMounted4
local iconOk = "icon16/tick.png"
local iconNOk = "icon16/cross.png"

function TOOL:_addSectionBase(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if icm({Folder = "weapons/cw_kk_ins2_base"}) then
			icon:SetImage(iconOk)
		else
			icon:SetImage(iconNOk)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Base pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionAO5(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if icm({Folder = "weapons/cw_kk_ins2_ao5"}) then
			icon:SetImage(iconOk)
		else
			icon:SetImage(iconNOk)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Army of Five pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionNam(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if icm({Folder = "weapons/cw_kk_ins2_nam"}) then
			icon:SetImage(iconOk)
		else
			icon:SetImage(iconNOk)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Born to Kill pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionDOI(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if icm({Folder = "weapons/cw_kk_ins2_doi"}) then
			icon:SetImage(iconOk)
		else
			icon:SetImage(iconNOk)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Day of Infamy pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end
	
function TOOL:_addSectionExt(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if icm({Folder = "weapons/cw_kk_ins2_cstm"}) then
			icon:SetImage(iconOk)
		else
			icon:SetImage(iconNOk)
		end

		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("EXT pack")
		label:SetDark(true)
		label:Dock(LEFT)
		label:SizeToContents()

	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(26,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_updatePanel()
	local panel = self._panel
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	self:_addSectionBase(panel)
	self:_addSectionAO5(panel)
	self:_addSectionNam(panel)
	self:_addSectionDOI(panel)
	self:_addSectionExt(panel)
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
