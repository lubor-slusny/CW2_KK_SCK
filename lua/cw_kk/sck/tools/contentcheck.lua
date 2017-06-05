if not CustomizableWeaponry_KK.HOME then return end

local TOOL = {}

TOOL.Name = "contentcheck"
TOOL.PrintName = "Content Check"

TOOL.icm = CustomizableWeaponry_KK.ins2.isContentMounted4
-- TOOL.icm = function() return false end
TOOL.iconOk = "icon16/tick.png"
TOOL.iconNOk = "icon16/cross.png"
TOOL.colOk = Color(0,150,0)
TOOL.colNOk = Color(200,0,0)

function TOOL:_individualLabelDockMargin(label)
	label:DockMargin(16,0,16,0)
end

function TOOL:_packLabelDockMargin(panel)
	panel:DockMargin(8,0,8,0)
end

// individual mounts

function TOOL:_addLineBaseGame(panel)
	local ok = self.icm({Folder = "weapons/baseGameContentOK"})
	local label = panel:AddControl("Label", {Text = 
		(ok and "[OK]" or "[MISSING]") ..
		" INS2 / INS2-DS content"
	})
	
	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function TOOL:_addLineAO5Mod(panel)
	local ok = self.icm({Folder = "weapons/ao5ModContentOK"})
	local label = panel:AddControl("Label", {Text = 
		(ok and "[OK]" or "[MISSING]") ..
		" AO5 content"
	})
	
	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function TOOL:_addLineDOIGame(panel)
	local ok = self.icm({Folder = "weapons/doiGameContentOK"})
	local label = panel:AddControl("Label", {Text = 
		(ok and "[OK]" or "[MISSING]") ..
		" DOI / DOI-DS content"
	})
	
	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function TOOL:_addLineNamMod(panel)
	local ok = self.icm({Folder = "weapons/namModContentOK"})
	local label = panel:AddControl("Label", {Text = 
		(ok and "[OK]" or "[MISSING]") ..
		" B2K content"
	})
	
	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

function TOOL:_addLineEXTPack(panel)
	local ok = self.icm({Folder = "weapons/extPackContentOK"})
	local label = panel:AddControl("Label", {Text = 
		(ok and "[OK]" or 
		(CustomizableWeaponry_KK.ins2.ws and "[OUTDATED]" or "[MISSING]")) ..
		" EXT Pack content"
	})
	
	self:_individualLabelDockMargin(label)
	label:SetTextColor(ok and self.colOk or self.colNOk)
end

// combos

function TOOL:_addSectionBase(panel)
	local backgroundPanel = vgui.Create("DPanel", panel)
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_base"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)
			self:_addLineBaseGame(panel)
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
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_ao5"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)
			
			self:_addLineBaseGame(panel)
			self:_addLineAO5Mod(panel)
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
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_nam"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)
			
			self:_addLineDOIGame(panel)
			self:_addLineNamMod(panel)
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
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_doi"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)
			
			self:_addLineDOIGame(panel)
			self:_addLineEXTPack(panel)
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
	self:_packLabelDockMargin(backgroundPanel)
	panel:AddItem(backgroundPanel)
	
		local icon
		icon = vgui.Create("DImage", backgroundPanel)
		icon:SetPos(5,2)
		icon:SetSize(16,16)

		if self.icm({Folder = "weapons/cw_kk_ins2_cstm"}) then
			icon:SetImage(self.iconOk)
		else
			icon:SetImage(self.iconNOk)
			
			self:_addLineBaseGame(panel)
			self:_addLineEXTPack(panel)
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

// panel

function TOOL:_updatePanel()
	local panel = self._panel
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	self:_addSectionBase(panel)
	self:_addSectionExt(panel)
	self:_addSectionDOI(panel)
	self:_addSectionNam(panel)
	self:_addSectionAO5(panel)
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
