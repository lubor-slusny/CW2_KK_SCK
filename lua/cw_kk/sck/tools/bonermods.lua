AddCSLuaFile()

local TOOL = {}

TOOL.Name = "bonemods"
TOOL.PrintName = "Bonemod Editor"
TOOL.Version = "0.9"

local a0, v0 = Angle(), Vector()

function TOOL:_addSectionForegripOverrideToggle(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
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
	
	return wep.ForegripOverride
end

function TOOL:_addSectionWipeReloadAll(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
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
end

function TOOL:_addSectionNewParent(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Add new parent:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,0,0)
		label:SizeToContents()
		
		local entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(8,0,0,0)
		
		function entry:OnEnter()
			local newParent = self:GetValue()
			
			if newParent == "" then return end
			
			wep.ForegripOverridePos = wep.ForegripOverridePos or {}
			wep.ForegripOverridePos[newParent] = {}
			wep.ForegripParent = newParent
			-- wep.ForegripParent = wep.ForegripParent or newParent
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionSelectParent(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("SWEP.ForegripParent")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		
		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		
		box:SetValue(wep.ForegripParent and string.format("[\"%s\"]", wep.ForegripParent) or "")
		
		for k,_ in pairs(wep.ForegripOverridePos or {}) do
			box:AddChoice(string.format("\"%s\"", k), k)
		end
		
		function box:OnSelect(i, name, data)
			wep.ForegripParent = data
			TOOL._activeWeps[wep].parents[wep.ForegripParent] = 
				TOOL._activeWeps[wep].parents[wep.ForegripParent] or {}
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionRemoveParent(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Remove current parent")
		
		function butt:DoClick()
			if wep.ForegripParent then
				TOOL._activeWeps[wep].parents[wep.ForegripParent] = nil
				wep.ForegripOverridePos[wep.ForegripParent] = nil
				wep.ForegripParent = table.GetKeys(wep.ForegripOverridePos)[1]
			end
			
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionFilterBones(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)

		local cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetText("List modified bones only")
		cbox:SetDark(true)
		cbox:SetValue(self._activeWeps[wep].parents[wep.ForegripParent].filterBones or false)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		function cbox:OnChange(val)
			TOOL._activeWeps[wep].parents[wep.ForegripParent].filterBones = val
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionSelectBone(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Current bone:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,8,0)
		label:SizeToContents()
		
		local box = vgui.Create("DComboBox", backgroundPanel)
		box:Dock(FILL)
		
		box:SetValue(self._activeWeps[wep].parents[wep.ForegripParent].curBonePrint or "")
		
		if self._activeWeps[wep].parents[wep.ForegripParent].filterBones then
			for k,t in pairs(wep.ForegripOverridePos[wep.ForegripParent]) do
				if (t.pos != v0) or (t.angle != a0) then
					local i = wep.CW_VM:LookupBone(k) or -1
					box:AddChoice(string.format("[%03d] %s", i, k), k)
				end
			end
		else
			for i = 0, (wep.CW_VM:GetBoneCount() - 1) do
				local data = wep.CW_VM:GetBoneName(i)
				box:AddChoice(string.format("[%03d] %s", i, data), data)
			end
		end
		
		function box:OnSelect(i, printName, boneName)
			TOOL._activeWeps[wep].parents[wep.ForegripParent].curBonePrint = printName
			TOOL._activeWeps[wep].parents[wep.ForegripParent].curBoneName = boneName
			TOOL:_updatePanel()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionWipeReloadCurPos(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
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
end

function TOOL:_addSectionWipeReloadCurBone(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
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
		
		function butt:DoClick()
			TOOL:ThrowNewNotImplemented()
		end
		
		butt:SetToolTip("TBD")
		butt:SetEnabled(false)
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionBoneSliders(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
	
	self._boneSliders = {}
	
	local t
	wep.ForegripOverridePos = wep.ForegripOverridePos or {}
	t = wep.ForegripOverridePos
	
	t[wep.ForegripParent] = t[wep.ForegripParent] or {}
	t = t[wep.ForegripParent]
	
	local k = self._activeWeps[wep].parents[wep.ForegripParent].curBoneName
	t[k] = t[k] and {pos = Vector(t[k].pos), angle = Angle(t[k].angle)} or
		{pos = Vector(), angle = Angle()}
	t = t[k]
	
	for _,s in pairs({
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
		slider:SetText(s[1] .. "." .. s[2])
		slider:SetDark(true)
		slider:SetMinMax(s[3], s[4])
		slider:SetDecimals(4)
		slider:SetValue(t[s[1]][s[2]])
		
		self:LoadSliderZoom(slider)
		
		function slider:OnValueChanged(val)
			t[s[1]][s[2]] = val
			TOOL:SaveSliderZoom(self)
		end
		
		self._boneSliders[s[1] .. "." .. s[2]] = slider
	end
	
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,32*6)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionExportCur(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Export current")
		
		function butt:DoClick()
			local ex = TOOL:_exportCurrent()
			SetClipboardText(ex)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionExportAll(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local butt = vgui.Create("DButton", backgroundPanel)
		butt:Dock(FILL)
		butt:SetText("Export all")
		
		function butt:DoClick()
			local ex = TOOL:_exportAll()
			SetClipboardText(ex)
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_exportOne(ForegripParent)
	ForegripParent = ForegripParent or "nil"

	local wep = self._wep
	local out = "\n		[\"" .. ForegripParent .. "\"] = {"
	local fin = "},\n"
	
	for k,v in pairs(wep.ForegripOverridePos[ForegripParent]) do
		if (v.angle != a0) or (v.pos != v0) then
			out = out .. string.format(
				"\n			[\"%s\"] = {pos = %s, angle = %s},",
				k,
				self:VectorToString(v.pos),
				self:AngleToString(v.angle)
			)
			
			fin = "\n		},\n"
		end
	end
	
	out = out .. fin
	
	return out
end

function TOOL:_exportCurrent()
	return self:_exportOne(self._wep.ForegripParent)
end

function TOOL:_exportAll()
	local wep = self._wep
	local out = "\n	SWEP.ForegripOverridePos = {"
	local fin = "\n		//empty\n	}\n"
	
	for k,_ in pairs(wep.ForegripOverridePos) do
		out = out .. self:_exportOne(k)
		fin = "	}\n"
	end
	
	out = out .. fin
	
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
	
	self._activeWeps = self._activeWeps or {}
	self._activeWeps[wep] = self._activeWeps[wep] or {}
	self._activeWeps[wep].parents = self._activeWeps[wep].parents or {}
	
	self:_addSectionForegripOverrideToggle(panel, wep)
	
	if not wep.ForegripOverride then return end
	
	-- self:_addSectionWipeReloadAll(panel, wep)
	self:_addSectionNewParent(panel, wep)
	self:_addSectionSelectParent(panel, wep)
	
	if wep.ForegripParent then
		self._activeWeps[wep].parents[wep.ForegripParent] = 	
			self._activeWeps[wep].parents[wep.ForegripParent] or {}
		
		self:_addSectionRemoveParent(panel, wep)
		-- self:_addSectionWipeReloadCurPos(panel, wep)
		self:_addSectionSelectBone(panel, wep)
		self:_addSectionFilterBones(panel, wep)
		
		if self._activeWeps[wep].parents[wep.ForegripParent].curBoneName then 
			self:_addSectionWipeReloadCurBone(panel, wep)
			self:_addSectionBoneSliders(panel, wep)
		end
		
		self:_addSectionExportCur(panel, wep)
	end
	
	self:_addSectionExportAll(panel, wep)
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
