
local TOOL = {}

TOOL.Name = "bonemods"
TOOL.PrintName = "Bonemod Editor (v0.3)"

local label, backgroundPanel

function TOOL:_addForegripOverrideToggleSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetText("SWEP.ForegripOverride")
		cbox:SetDark(true)
		cbox:SetValue(wep.ForegripOverride)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		function cbox:OnChange(val)
			wep.ForegripOverride = val
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
	
	return wep.ForegripOverride
end

function TOOL:_addWipeReloadAllSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		-- butt:SetTooltip("Copies current element table to your clipboard.")
		butt:Dock(LEFT)
		butt:SetSize(150,20)
		butt:SetText("Wipe all bonemods")
		
		local butt = vgui.Create("DButton", backgroundPanel)
		-- butt:SetTooltip("Copies current element table to your clipboard.")
		butt:Dock(RIGHT)
		butt:SetSize(150,20)
		butt:SetText("Reload all bonemods")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addNewParentSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Add new parent:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,0,0)
		label:SizeToContents()
		
		local entry
		entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(8,0,0,0)
		
		function entry:OnEnter()
			wep.ForegripOverridePos[self:GetValue()] = {}
			wep.ForegripParent = wep.ForegripParent or self:GetValue()
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSelectParentSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Current parent:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		
		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		
		box:SetValue(wep.ForegripParent)
		
		for k,_ in pairs(wep.ForegripOverridePos) do
			box:AddChoice(k)
		end
		
		function box:OnSelect(i, name)
			wep.ForegripParent = name
			TOOL._curBoneBoxView = nil
			TOOL._curBoneName = nil
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addRemoveParentSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Remove current parent")
		
		function butt:DoClick()
			wep.ForegripOverridePos[wep.ForegripParent] = nil
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSelectBoneSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Current bone:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		
		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		
		box:SetValue(self._curBoneBoxView)
		
		for i = 0, (wep.CW_VM:GetBoneCount() - 1) do
			local data = wep.CW_VM:GetBoneName(i)
			box:AddChoice(string.format("[%03d] %s", i, data), data)
		end
		
		function box:OnSelect(i, name, data)
			TOOL._curBoneBoxView = name
			TOOL._curBoneName = data
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addWipeReloadCurPosSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		-- butt:SetTooltip("Copies current element table to your clipboard.")
		butt:Dock(LEFT)
		butt:SetSize(150,20)
		butt:SetText("Wipe all bones")
		
		local butt = vgui.Create("DButton", backgroundPanel)
		-- butt:SetTooltip("Copies current element table to your clipboard.")
		butt:Dock(RIGHT)
		butt:SetSize(150,20)
		butt:SetText("Reload all bones")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addWipeReloadCurBoneSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		-- butt:SetTooltip("Copies current element table to your clipboard.")
		butt:Dock(LEFT)
		butt:SetSize(150,20)
		butt:SetText("Wipe sliders")
		
		local butt = vgui.Create("DButton", backgroundPanel)
		-- butt:SetTooltip("Copies current element table to your clipboard.")
		butt:Dock(RIGHT)
		butt:SetSize(150,20)
		butt:SetText("Reload sliders")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSlidersSection(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
	
	local t
	wep.ForegripOverridePos = wep.ForegripOverridePos or {}
	t = wep.ForegripOverridePos
	
	t[wep.ForegripParent] = t[wep.ForegripParent] or {}
	t = t[wep.ForegripParent]
	
	t[self._curBoneName] = t[self._curBoneName] or {pos = Vector(), angle = Angle()}
	t = t[self._curBoneName]
	
	for k,v in pairs({
		{"pos", "x", -100, 100},
		{"pos", "y", -100, 100},
		{"pos", "z", -100, 100},
		{"angle", "p", -180, 180},
		{"angle", "y", -180, 180},
		{"angle", "r", -180, 180},
	}) do
		local slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(TOP)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(4)
		slider:SetText(v[1] .. "." .. v[2])
		slider:SetDark(true)
		slider:SetMinMax(v[3], v[4])
		slider:SetValue(t[v[1]][v[2]])
		
		function slider:OnValueChanged(val)
			t[v[1]][v[2]] = val
		end
	end
	
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,32*6)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()

	if !IsValid(wep) or !wep.CW20Weapon then
		panel:AddControl("Label", {Text = "Not a CW2 swep, move along."})
		return
	end
	
	self:_addForegripOverrideToggleSection(panel, wep)
	
	if not wep.ForegripOverride then return end
	
	self:_addWipeReloadAllSection(panel, wep)
	self:_addNewParentSection(panel, wep)
	self:_addSelectParentSection(panel, wep)
	
	if not wep.ForegripParent then return end
	
	self:_addRemoveParentSection(panel, wep)
	-- self:_addWipeReloadCurPosSection(panel, wep)
	self:_addSelectBoneSection(panel, wep)
	
	if not self._curBoneName then return end
	
	self:_addWipeReloadCurBoneSection(panel, wep)
	self:_addSlidersSection(panel, wep)
	
	-- panel:AddControl("Label", {Text = "export cur button"}) // filter out (0, 0, 0)
	panel:AddControl("Button", {Text = "Export current"})
	
	-- panel:AddControl("Label", {Text = "export all button"}) // filter out (0, 0, 0)
	panel:AddControl("Button", {Text = "Export all"})
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
