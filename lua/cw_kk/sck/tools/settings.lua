AddCSLuaFile()

local SCK = CustomizableWeaponry_KK.sck
local TOOL = {}

TOOL.Name = "settingstab"
TOOL.PrintName = "[SCK] Settings"

function TOOL:_addSectionLocation()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Spawnmenu tab:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,0,0)
		entry:SetConVar(SCK.strCVMenuTab)
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Spawnmenu tab section:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,4,0)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(4,0,0,0)
		entry:SetConVar(SCK.strCVMenuTabSection)
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionLocationApply()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetSize(150,20)
		butt:SetText("Apply *")
		butt:SetCommand("spawnmenu_reload")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionRescan()
	local panel = self._panel
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetSize(150,20)
		butt:SetText("Rescan tool folder *")
		butt:SetConsoleCommand("cw_kk_sck_reload_folder")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_updatePanel()
	local panel = self._panel
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	self:AddHeaderSimpleLR(panel, "Location:")
	self:_addSectionLocation()
	self:_addSectionLocationApply()
	self:AddHeaderSimpleLR(panel, "Other:")
	self:_addSectionRescan()
	
	panel:AddControl("Label", {Text = "* reloads spawn menu"})
	panel:AddControl("Label", {Text = ""})
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

SCK:AddTool(TOOL)

TOOL:_updatePanel()
