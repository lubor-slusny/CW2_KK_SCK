
local TOOL = {}

TOOL.Name = "bonemods"
TOOL.PrintName = "Bonemod Editor"

local label, backgroundPanel

function TOOL:_addSectionForegripOverrideToggle(panel, wep)
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

function TOOL:_addSectionWipeReloadAll(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(LEFT)
		butt:SetSize(150,20)
		butt:SetText("Wipe all bonemods")
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(RIGHT)
		butt:SetSize(150,20)
		butt:SetText("Reload all bonemods")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionNewParent(panel, wep)
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
			wep.ForegripOverridePos = wep.ForegripOverridePos or {}
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

function TOOL:_addSectionSelectParent(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP.ForegripParent")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		
		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		
		box:SetValue(wep.ForegripParent or "")
		
		for k,_ in pairs(wep.ForegripOverridePos or {}) do
			box:AddChoice(k)
		end
		
		function box:OnSelect(i, name)
			wep.ForegripParent = name
			TOOL._curBones[wep].print = nil
			TOOL._curBones[wep].name = nil
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionRemoveParent(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Remove current parent")
		
		function butt:DoClick()
			if wep.ForegripParent then
				wep.ForegripOverridePos[wep.ForegripParent] = nil
				wep.ForegripParent = nil
			end
			
			TOOL._curBones[wep].print = nil
			TOOL._curBones[wep].name = nil
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionFilterBones(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetText("List modified bones only")
		cbox:SetDark(true)
		cbox:SetValue(self._filterBones or false)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		function cbox:OnChange(val)
			TOOL._filterBones = val
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionSelectBone(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Current bone:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		
		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		
		box:SetValue(self._curBones[wep].print or "")
		
		if self._filterBones then
			for k,_ in pairs(wep.ForegripOverridePos[wep.ForegripParent]) do
				local i = wep.CW_VM:LookupBone(k)
				box:AddChoice(string.format("[%03d] %s", i, k), k)
			end
		else
			for i = 0, (wep.CW_VM:GetBoneCount() - 1) do
				local data = wep.CW_VM:GetBoneName(i)
				box:AddChoice(string.format("[%03d] %s", i, data), data)
			end
		end
		
		function box:OnSelect(i, printName, boneName)
			TOOL._curBones[wep].print = printName
			TOOL._curBones[wep].name = boneName
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionWipeReloadCurPos(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(LEFT)
		butt:SetSize(150,20)
		butt:SetText("Wipe all bones")
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(RIGHT)
		butt:SetSize(150,20)
		butt:SetText("Reload all bones")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionWipeReloadCurBone(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(LEFT)
		butt:SetSize(150,20)
		butt:SetText("Wipe sliders")
		
		function butt:DoClick()
			for _,slider in pairs(TOOL._boneSliders) do
				slider:SetValue(0)
			end
		end
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(RIGHT)
		butt:SetSize(150,20)
		butt:SetText("Reload sliders")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionBoneSliders(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
	
	self._boneSliders = {}
	
	local t
	wep.ForegripOverridePos = wep.ForegripOverridePos or {}
	t = wep.ForegripOverridePos
	
	t[wep.ForegripParent] = t[wep.ForegripParent] or {}
	t = t[wep.ForegripParent]
	
	t[self._curBones[wep].name] = t[self._curBones[wep].name] or {pos = Vector(), angle = Angle()}
	t = t[self._curBones[wep].name]
	
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
		slider:SetText(v[1] .. "." .. v[2])
		slider:SetDark(true)
		slider:SetMinMax(v[3], v[4])
		slider:SetDecimals(4)
		slider:SetValue(t[v[1]][v[2]])
		
		self:LoadSliderZoom(slider)
		
		function slider:OnValueChanged(val)
			t[v[1]][v[2]] = val
			TOOL:SaveSliderZoom(self)
		end
		
		self._boneSliders[v[1] .. "." .. v[2]] = slider
	end
	
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,32*6)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionExportCur(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Export current")
		
		function butt:DoClick()
		
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionExportAll(panel, wep)
	backgroundPanel = vgui.Create("DPanel", panel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Export all")
		
		function butt:DoClick()
		
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
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
	
	self._curBones[wep] = self._curBones[wep] or {}
	
	self:_addSectionForegripOverrideToggle(panel, wep)
	
	if not wep.ForegripOverride then return end
	
	-- self:_addSectionWipeReloadAll(panel, wep)
	self:_addSectionNewParent(panel, wep)
	self:_addSectionSelectParent(panel, wep)
	
	if wep.ForegripParent then
		self:_addSectionRemoveParent(panel, wep)
		-- self:_addSectionWipeReloadCurPos(panel, wep)
		self:_addSectionSelectBone(panel, wep)
		self:_addSectionFilterBones(panel, wep)
		
		if self._curBones[wep].name then 
			self:_addSectionWipeReloadCurBone(panel, wep)
			self:_addSectionBoneSliders(panel, wep)
		end
		
		self:_addSectionExportCur(panel, wep)
	end
	
	self:_addSectionExportAll(panel, wep)
end

function TOOL:SetPanel(panel)
	self._curBones = self._curBones or {}
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
