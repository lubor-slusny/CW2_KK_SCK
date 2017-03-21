AddCSLuaFile()

CW_KK_SCK = CW_KK_SCK or {}

CW_KK_SCK.ELEMENT_BROWSER = CW_KK_SCK.ELEMENT_BROWSER or {}

local TOOL = CW_KK_SCK.ELEMENT_BROWSER

TOOL.utilityTabName = "CW_KK_SCK_ELEMENT_BROWSER"
TOOL.printName = "Element Browser 2.0"

function TOOL:IsValid() return true end

TOOL.buttFunc = {}

function TOOL.buttFunc:updatePanel()
	TOOL:updatePanel()
end

TOOL.elementTables = {
	["AttachmentModelsVM"] = {adjustable = true},
	["AttachmentModelsWM"] = {adjustable = false}, // just so sightadjustment doesnt showup for WElements
}

TOOL.openTabs = TOOL.openTabs or {}
TOOL.addingNewElement = TOOL.addingNewElement or {}

function TOOL:reInitializeElement(data)
	local WEAPON = self.WEAPON
	
	SafeRemoveEntity(data.ent)
	SafeRemoveEntity(data.stencilEnt)
	data.stencilEnt = nil
	
	data.ent = WEAPON:createManagedCModel(data.model, RENDERGROUP_BOTH)
	data.ent:SetNoDraw(true)
	
	data.active = data.active or false
	data.nodraw = data.nodraw or false
	
	data.matrix = Matrix()
	
	-- data.pos.y = -data.pos.y
	-- data.matrix:Translate(data.pos)
	-- data.matrix:Rotate(data.angle)
		
	if data.size then
		data.matrix:Scale(data.size)
	end
	
	data.ent:EnableMatrix("RenderMultiply", data.matrix)
	
	if data.bodygroups then
		for main, sec in pairs(data.bodygroups) do
			data.ent:SetBodygroup(main, sec)
		end
	end
	
	if data.skin then
		data.ent:SetSkin(data.skin)
	end
	
	data.ent:SetupBones()

	if data.merge then
		data.ent:SetParent(WEAPON.CW_VM)
		data.ent:AddEffects(EF_BONEMERGE)
	end
	
	if data.attachment then
		data._attachment = WEAPON.CW_VM:LookupAttachment(data.attachment)
	end
	
	if data.bone then
		data._bone = WEAPON.CW_VM:LookupBone(data.bone)
	end
	
	for i,mat in pairs(data.ent:GetMaterials()) do
		if CustomizableWeaponry_KK.ins2.nodrawMat[mat] then
			data.ent:SetSubMaterial(i - 1, CustomizableWeaponry_KK.ins2.nodrawMatPath)
		end
	end
	
	if data.material then 
		data.ent:SetMaterial(data.material)
	end
end

TOOL.noBackground = Color(0,0,0,0)
TOOL.darkBackground = Color(0,0,0,50)
TOOL.headerBackground = Color(0,160,255,100)

function TOOL:getParentEnt(str)
	local WEAPON = self.WEAPON
	
	if str == "AttachmentModelsVM" then
		return WEAPON.CW_VM
	end
	
	if str == "AttachmentModelsWM" then
		return IsValid(WEAPON.WMEnt) and WEAPON.WMEnt or WEAPON
	end
end

local stored = {}

function TOOL:initSliderStorage(id)
	if not stored[id] then
		stored[id] = CreateClientConVar("_kk_sck_elements_slsens_" .. id, 1, true, false)
	end
end

function TOOL:storeSliderZoom(slider)
	local id = slider._kk_sck_id
	
	self:initSliderStorage(id)
	
	RunConsoleCommand("_kk_sck_elements_slsens_" .. id, slider.Wang:GetZoom())
end

function TOOL:loadSliderZoom(slider)
	local id = slider._kk_sck_id
	
	self:initSliderStorage(id)
	
	slider.Wang:SetZoom(stored[id]:GetFloat())
end

local function cloneAngle(ang)
	return Angle(ang.p, ang.y, ang.r)
end

local UNIFORMSCALELOCK = false

function TOOL:backupAdjustmentTable(wep, t, key, curData)
	local origData = weapons.GetStored(wep:GetClass())[t][key]
	local orig = origData and origData.adjustment
	
	if orig == curData.adjustment then
		curData.adjustment = {}
		for k,v in pairs(orig) do
			curData.adjustment[k] = v
		end
	end
end

TOOL.knownElementDataKeys = {
	["active"] = true,
	["model"] = true,
	["models"] = true,
	["bone"] = true,
	["_bone"] = true,
	["pos"] = true,
	["angle"] = true,
	["size"] = true,
	["animated"] = true,
	["skin"] = true,
	["bodygroups"] = true,
	["adjustment"] = true,
	
	["attachment"] = true, // INS2 alternative to "bone"
	["_attachment"] = true, // INS2 alternative to "_bone"
	["merge"] = true, // INS2 bone merge
	["material"] = true, // INS2 material override - same as in SCK/CW1
	["nodraw"] = true, // deprecated part of INS2 stencil sights
	["retSizeMult"] = true,	// INS2 stencil sight reticle size multiplier (since all sights come in 3+ sizes)
	["hideVM"] = true, // hides CW_VM
	["rLight"] = true, // recomputes lighting of velement
	
	["ignoreKKBGO"] = true, // BGO3 crashes my game if combined with CSGO stat attachment proxies
}

TOOL.noExportElementDataKeys = {
	["ent"] = true,
	["rel"] = true,
	["matrix"] = true,
	["origPos"] = true,
	["origAng"] = true,
	
	["stencilEnt"] = true, // INS2 stencil sight ent
	
	-- ["_kksck_curIndex"] = true, // index of element.models sub-table
	-- ["_kksck_expanded"] = true, // element being shown in editor
}

function TOOL:updatePanel()
	local PANEL = self.PANEL
	
	if not PANEL then return end
	
	PANEL:ClearControls()
	-- PANEL:AddHeader()

	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:SetTooltip("Loads changes made outside of this tool.")
	butt:DockMargin(0, 0, 0, 8)	
	butt:SetText("Refresh")
	butt.DoClick = self.buttFunc.updatePanel
	
	PANEL:AddItem(butt)
	
	local WEAPON = self.WEAPON
	
	local openTab = IsValid(WEAPON) and self.openTabs[WEAPON] or {}
	local addingNewElement = IsValid(WEAPON) and self.addingNewElement[WEAPON]
	
	if IsValid(WEAPON) and WEAPON.CW20Weapon then
		for t,tProps in pairs(self.elementTables) do
			WEAPON[t] = WEAPON[t] or {}
			
			if addingNewElement then
				if addingNewElement == t then
				
					local newElementHeaderPanel = vgui.Create("DPanel", PANEL)

						local label
						label = vgui.Create("DLabel", newElementHeaderPanel)
						label:SetText("Create new")
						label:SetDark(true)
						label:Dock(LEFT)
						label:DockMargin(8,0,0,0)
						label:SizeToContents()
						
						local butt
						butt = vgui.Create("DButton", newElementHeaderPanel)
						butt:SetText("Cancel")
						butt:Dock(RIGHT)
						butt:DockMargin(0,4,8,4)
						
						function butt:DoClick()
							TOOL.addingNewElement[WEAPON] = nil
							TOOL:updatePanel()
						end
						
					newElementHeaderPanel:SizeToContents()
					newElementHeaderPanel:SetBackgroundColor(self.headerBackground)
					PANEL:AddItem(newElementHeaderPanel)
					
					local entryKey, entryModel
					
					local newElementKeyPanel = vgui.Create("DPanel", PANEL)
						
						local label
						label = vgui.Create("DLabel", newElementKeyPanel)
						label:SetText("Element table key:")
						label:SetDark(true)
						label:Dock(LEFT)
						label:DockMargin(8,0,0,0)
						label:SizeToContents()
						
						local entry
						entry = vgui.Create("DTextEntry", newElementKeyPanel)
						entry:Dock(FILL)
						entry:DockMargin(8,0,8,0)
						
						entry:SetValue("kk_was_here_lol")
						
						entryKey = entry
						
					newElementKeyPanel:SizeToContents()
					PANEL:AddItem(newElementKeyPanel)
					
					local newElementModelPanel = vgui.Create("DPanel", PANEL)
						
						local label
						label = vgui.Create("DLabel", newElementModelPanel)
						label:SetText("Model:")
						label:SetDark(true)
						label:Dock(LEFT)
						label:DockMargin(8,0,0,0)
						label:SizeToContents()
						
						local entry
						entry = vgui.Create("DTextEntry", newElementModelPanel)
						entry:Dock(FILL)
						entry:DockMargin(8,0,8,0)
						
						entry:SetValue("models/maxofs2d/cube_tool.mdl")
						
						entryModel = entry
						
					newElementModelPanel:SizeToContents()
					PANEL:AddItem(newElementModelPanel)
					
					local function validateInput(t)
						local key = entryKey:GetValue()
						
						if not key then
							entryKey:SetValue("__nope")
							return
						end
						
						if key == "" then
							entryKey:SetValue("__too_short")
							return
						end
						
						if WEAPON[t][key] then
							entryKey:SetValue("__already_taken_" .. math.Round(CurTime()))
							return
						end
						
						return key
					end
					
					local function initializeElementTable()
						local new = {}
						
						local model = entryModel:GetValue() or "models/maxofs2d/cube_tool.mdl"
						
						if not file.Exists(model, "GAME") then
							model = "models/maxofs2d/cube_tool.mdl"
						end
						
						new.model = model
						new.pos = Vector()
						new.angle = Angle()
						
						if model == "models/maxofs2d/cube_tool.mdl" then
							new.size = Vector(0.075, 0.075, 0.075)
							new.bodygroups = {1}
						else
							new.size = Vector(1, 1, 1)
						end
						
						if WEAPON.KKINS2Wep then
							new.merge = true
						end
						
						new.active = true
						
						TOOL:reInitializeElement(new)
						
						if not WEAPON.KKINS2Wep then
							local ent = TOOL:getParentEnt(t)
							
							new.bone = ent:GetBoneName(0)
							new._bone = 0
						end
						
						return new
					end
					
					for t,_ in pairs(self.elementTables) do
						
						local newElementFinalizePanel = vgui.Create("DPanel", PANEL)
						
							local butt
							butt = vgui.Create("DButton", newElementFinalizePanel)
							butt:SetText("Add to " .. t)
							butt:Dock(FILL)							
							butt:DockMargin(8,0,8,0)
							
							function butt:DoClick()
								local key = validateInput(t)
								
								if not key then
									return
								end
								
								WEAPON[t][key] = initializeElementTable()
								
								TOOL.openTabs[WEAPON] = {
									t = t,
									key = key
								}
								
								TOOL.addingNewElement[WEAPON] = nil
								TOOL:updatePanel()
							end
							
						newElementFinalizePanel:SizeToContents()
						PANEL:AddItem(newElementFinalizePanel)
						
					end
					
					local newElementFinalizePanel = vgui.Create("DPanel", PANEL)
					
						local butt
						butt = vgui.Create("DButton", newElementFinalizePanel)
						butt:SetText("Add to all")
						butt:Dock(FILL)							
						butt:DockMargin(8,0,8,0)
						
						function butt:DoClick()
							for t,_ in pairs(TOOL.elementTables) do
								local key = validateInput(t)
								
								if not key then
									return
								end
								
								WEAPON[t][key] = initializeElementTable()
							end
							
							TOOL.openTabs[WEAPON] = {
								t = t,
								key = key
							}
							
							TOOL.addingNewElement[WEAPON] = nil
							TOOL:updatePanel()
						end
						
					newElementFinalizePanel:SizeToContents()
					PANEL:AddItem(newElementFinalizePanel)
					
				end
				
				continue
			end
		
			if openTab.key == nil or openTab.t == t or (WEAPON[t][openTab.key] != nil) then					
				local elementTableHeaderPanel = vgui.Create("DPanel", PANEL)
				
					local label
					label = vgui.Create("DLabel", elementTableHeaderPanel)
					label:SetText("SWEP." .. t .. ":")
					label:SetDark(true)
					label:Dock(LEFT)
					label:DockMargin(8,0,0,0)
					label:SizeToContents()
					
					local butt
					butt = vgui.Create("DButton", elementTableHeaderPanel)
					butt:SetText("Add")
					butt:SetTooltip("Add new item to " .. t .. ".")
					butt:Dock(RIGHT)
					butt:DockMargin(0,4,8,4)
					
					function butt:DoClick()
						TOOL.addingNewElement[WEAPON] = t
						TOOL:updatePanel()
					end
					
				elementTableHeaderPanel:SizeToContents()
				elementTableHeaderPanel:SetBackgroundColor(self.headerBackground)
				PANEL:AddItem(elementTableHeaderPanel)
			end
			
			local sortMeh = {}
			for k,v in pairs(WEAPON[t]) do
				sortMeh[(v.active and "a_" or "b_") .. tostring(k)] = k
			end
			
			for key,data in SortedPairs(sortMeh) do
				key = sortMeh[key]
				data = WEAPON[t][key]
				
				if (t == openTab.t and key == openTab.key) or (openTab.key == nil) or (key == openTab.key) then
					local elementNamePanel = vgui.Create("DPanel", PANEL)
						local icon
						icon = vgui.Create("DImage", elementNamePanel)
						icon:SetPos(0,2)
						icon:SetSize(20,20)
						icon:SetMouseInputEnabled(true)
						
						if data.active then
							icon:SetImage("icon16/bullet_green.png")
						else
							icon:SetImage("icon16/bullet_red.png")
						end
						
						function icon:Think()
							if self:IsHovered() then
								if input.IsMouseDown(MOUSE_RIGHT) then
									SetClipboardText(key)
								end
							end
						end
						
						local label
						label = vgui.Create("DLabel", elementNamePanel)
						label:SetText(key)
						label:SetDark(true)
						label:Dock(FILL)
						label:SizeToContents()
						label:SetMouseInputEnabled(true)
						
						local arrowLabel
						arrowLabel = vgui.Create("DLabel", elementNamePanel)
						arrowLabel:SetDark(true)
						arrowLabel:Dock(RIGHT)
						arrowLabel:SetMouseInputEnabled(true)
						
						function arrowLabel:updateText()
							if t == openTab.t and key == openTab.key then
								self:SetText("<=")
							else
								self:SetText("=>")
							end
							self:SizeToContents()
						end
						
						arrowLabel:updateText()
						
						local function updateTitle()
							TOOL.openTabs[WEAPON] = TOOL.openTabs[WEAPON] or {}
							
							if t == openTab.t and key == openTab.key then
								TOOL.openTabs[WEAPON].key = nil
							else
								TOOL.openTabs[WEAPON].key = key
								TOOL.openTabs[WEAPON].t = t
							end
							
							arrowLabel:updateText()
							TOOL:updatePanel()
						end
					
						icon.DoClick = updateTitle
						label.DoClick = updateTitle
						arrowLabel.DoClick = updateTitle
						
					elementNamePanel:DockPadding(20,0,8,0)
					elementNamePanel:SizeToContents()
					PANEL:AddItem(elementNamePanel)
					
					elementNamePanel:SetMouseInputEnabled(true)
					elementNamePanel.DoClick = updateTitle
				end
				
				local curData
				
				if t == openTab.t and key == openTab.key then
					local elementSettingPanelHeight = 0
					
					local elementSettingPanel = vgui.Create("DPanel", PANEL)

						local settActivePanel = vgui.Create("DPanel", elementSettingPanel)

							local cbox
							cbox = vgui.Create("DCheckBoxLabel", settActivePanel)
							cbox:SetText("Active")
							cbox:SetTooltip("does stuff.")
							cbox:SetDark(true)
							cbox:Dock(FILL)
							cbox:DockMargin(8,0,0,0)
							
							cbox:SetValue(data.active)
							function cbox:OnChange(val)
								data.active = val
								TOOL:updatePanel()
							end
					
						settActivePanel:Dock(TOP)
						settActivePanel:SetSize(200,16)
						settActivePanel:SetPaintBackground(false)
						settActivePanel:SizeToContents()
						
						if data.models then
							local pickSubElementPanel = vgui.Create("DPanel", elementSettingPanel)
						
								local box = vgui.Create("DComboBox", pickSubElementPanel)
								box:Dock(FILL)
								box:SetValue(data.models[openTab.subID or 1].model)
								
								for k,v in pairs(data.models) do
									box:AddChoice(v.model)
								end
								
								function box:OnSelect(i, name)
									openTab.subID = i
									TOOL:updatePanel()
								end
								
							pickSubElementPanel:Dock(TOP)
							pickSubElementPanel:DockMargin(0,8,0,0)
							pickSubElementPanel:SetPaintBackground(false)
							pickSubElementPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 32
							curData = data.models[openTab.subID or 1]
						else
							curData = data
						end
				
						local settModelPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local label
							label = vgui.Create("DLabel", settModelPanel)
							label:SetText("Model:")
							label:SetDark(true)
							label:Dock(LEFT)
							label:DockMargin(8,0,0,0)
							label:SizeToContents()
							
							local entry
							entry = vgui.Create("DTextEntry", settModelPanel)
							entry:Dock(FILL)
							entry:DockMargin(8,0,8,0)
							
							entry:SetValue(curData.ent:GetModel() or "")
							
							function entry:OnChange()
								local f = self:GetValue()
								
								if file.Exists(f, "GAME") then
									curData.model = f
									curData.ent:SetModel(f)
									TOOL:updatePanel()
								end
							end
							
						settModelPanel:Dock(TOP)
						settModelPanel:DockMargin(0,8,0,0)
						settModelPanel:SetPaintBackground(false)
						settModelPanel:SizeToContents()
						
						local settMergePanel = vgui.Create("DPanel", elementSettingPanel)
						
							local funcList = vgui.Create("DListView", settMergePanel)
							funcList:SetMultiSelect(false)
							funcList:AddColumn("Point of attachment function:")
							funcList:AddLine("[CW20] Bone on parent entity")
							
							if WEAPON.KKINS2Wep then
								local ent = TOOL:getParentEnt(t)
								
								if table.Count(ent:GetAttachments()) > 0 then
									funcList:AddLine("[KKIN2] QC Attachment on parent entity")
								else
									funcList:AddLine("[DISABLED] No QC Attachments found")
								end
								
								funcList:AddLine("[KKIN2] Bone-Merge to parent entity")
							end
							
							funcList:Dock(FILL)
							function funcList:SortByColumn() end
							
							if curData.merge then
								funcList._lastRow = 3
								funcList:SelectItem(funcList:GetLine(3))
							elseif curData._attachment then
								funcList._lastRow = 2
								funcList:SelectItem(funcList:GetLine(2))
							else
								funcList._lastRow = 1
								funcList:SelectItem(funcList:GetLine(1))
							end
							
							function funcList:OnRowSelected(val)
								if val == self._lastRow then
									return
								end
								
								self._lastRow = val
								
								local ent = TOOL:getParentEnt(t)
								
								if val == 1 then
									curData.merge = false
									curData.attachment = nil
									curData._attachment = nil
									curData.bone = ent:GetBoneName(0) // fallback so drawAttachFunc doesnt freakout
									curData._bone = nil
								elseif val == 2 then
									local att = ent:GetAttachments()[1]
									
									if att then
										curData.merge = false
										curData.attachment = att.name // lets hope there is at least one compiled to parent model
										curData._attachment = nil 
										curData.bone = nil
										curData._bone = nil
									end
								elseif val == 3 then
									curData.merge = true // E.Z.
									curData.attachment = nil
									curData._attachment = nil
									curData.bone = nil
									curData._bone = nil
								end
								
								TOOL:reInitializeElement(curData)
								TOOL:updatePanel()
							end
							
						settMergePanel:Dock(TOP)
						settMergePanel:SetSize(200,68)
						settMergePanel:DockMargin(0,12,0,0)
						settMergePanel:SetPaintBackground(false)
						settMergePanel:SizeToContents()
						
						if funcList:GetSelectedLine() == 1 then
							
							local settBonePanel = vgui.Create("DPanel", elementSettingPanel)
						
								local box = vgui.Create("DComboBox", settBonePanel)
								box:Dock(FILL)
								box:SetValue(curData.bone or "-select bone-")
								
								local ent = TOOL:getParentEnt(t)
								
								for i = 0, (ent:GetBoneCount() - 1) do
									local data = ent:GetBoneName(i)
									box:AddChoice(string.format("%s [%d]", data, i), data)
								end
								
								function box:OnSelect(_, _, name) 
									curData.bone = name
									TOOL:reInitializeElement(curData)
									TOOL:updatePanel()
								end
								
							settBonePanel:Dock(TOP)
							settBonePanel:DockMargin(0,8,0,0)
							settBonePanel:SetPaintBackground(false)
							settBonePanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 32
						end
						
						if funcList:GetSelectedLine() == 2 then
							
							local settAttPanel = vgui.Create("DPanel", elementSettingPanel)
						
								local ent = TOOL:getParentEnt(t)
								local entAttachments = ent:GetAttachments()
								
								local box = vgui.Create("DComboBox", settAttPanel)
								box:Dock(FILL)
								box:SetValue(curData.attachment or "-select attachment-")
								
								for i = 1, (table.Count(entAttachments)) do
									local data = entAttachments[i].name
									box:AddChoice(string.format("%s [%d]", data, i), data)
								end
								
								function box:OnSelect(_, _, name) 
									curData.attachment = name
									TOOL:reInitializeElement(curData)
									TOOL:updatePanel()
								end
								
							settAttPanel:Dock(TOP)
							settAttPanel:DockMargin(0,8,0,0)
							settAttPanel:SetPaintBackground(false)
							settAttPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 32
						end
						
						local settPosXPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settPosXPanel)
							slider:Dock(FILL)
							slider:DockMargin(8,0,8,0)
							slider:SetDecimals(4)
							slider:SetMinMax(-100, 100)
							slider:SetValue(curData.pos.x)
							slider:SetText("pos.x")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								curData.pos = Vector(curData.pos) // garbage gen, but doesnt mess up stored weapon classes
								curData.pos.x = val
								
								TOOL:storeSliderZoom(self)
							end

							slider._kk_sck_id = "settPosX"
							self:loadSliderZoom(slider)
							
						settPosXPanel:Dock(TOP)
						settPosXPanel:DockMargin(0,8,0,0)
						settPosXPanel:SetBackgroundColor(TOOL.darkBackground)
						settPosXPanel:SizeToContents()
						
						local settPosYPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settPosYPanel)
							slider:Dock(FILL)
							slider:DockMargin(8,0,8,0)
							slider:SetDecimals(4)
							slider:SetMinMax(-100, 100)
							slider:SetValue(curData.pos.y)
							slider:SetText("pos.y")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								curData.pos = Vector(curData.pos)
								curData.pos.y = val
								
								TOOL:storeSliderZoom(self)
							end

							slider._kk_sck_id = "settPosY"
							self:loadSliderZoom(slider)
							
						settPosYPanel:Dock(TOP)
						settPosYPanel:SetBackgroundColor(TOOL.darkBackground)
						settPosYPanel:SizeToContents()
						
						local settPosZPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settPosZPanel)
							slider:Dock(FILL)
							slider:DockMargin(8,0,8,0)
							slider:SetDecimals(4)
							slider:SetMinMax(-100, 100)
							slider:SetValue(curData.pos.z)
							slider:SetText("pos.z")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								curData.pos = Vector(curData.pos)
								curData.pos.z = val
							
								TOOL:storeSliderZoom(self)
							end

							slider._kk_sck_id = "settPosZ"
							self:loadSliderZoom(slider)
							
						settPosZPanel:Dock(TOP)
						settPosZPanel:SetBackgroundColor(TOOL.darkBackground)
						settPosZPanel:SizeToContents()
						
						local settAngPPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settAngPPanel)
							slider:Dock(FILL)
							slider:DockMargin(8,0,8,0)
							slider:SetDecimals(4)
							slider:SetMinMax(-180, 180)
							slider:SetValue(curData.angle.p)
							slider:SetText("angle.p")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								curData.angle = cloneAngle(curData.angle)
								curData.angle.p = val
							
								TOOL:storeSliderZoom(self)
							end

							slider._kk_sck_id = "settAngP"
							self:loadSliderZoom(slider)
							
						settAngPPanel:Dock(TOP)
						settAngPPanel:DockMargin(0,8,0,0)
						settAngPPanel:SetBackgroundColor(TOOL.darkBackground)
						settAngPPanel:SizeToContents()
						
						local settAngYPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settAngYPanel)
							slider:Dock(FILL)
							slider:DockMargin(8,0,8,0)
							slider:SetDecimals(4)
							slider:SetMinMax(-180, 180)
							slider:SetValue(curData.angle.y)
							slider:SetText("angle.y")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								curData.angle = cloneAngle(curData.angle)
								curData.angle.y = val
							
								TOOL:storeSliderZoom(self)
							end

							slider._kk_sck_id = "settAngY"
							self:loadSliderZoom(slider)
							
						settAngYPanel:Dock(TOP)
						settAngYPanel:SetBackgroundColor(TOOL.darkBackground)
						settAngYPanel:SizeToContents()
						
						local settAngRPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settAngRPanel)
							slider:Dock(FILL)
							slider:DockMargin(8,0,8,0)
							slider:SetDecimals(4)
							slider:SetMinMax(-180, 180)
							slider:SetValue(curData.angle.r)
							slider:SetText("angle.r")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								curData.angle = cloneAngle(curData.angle)
								curData.angle.r = val
							
								TOOL:storeSliderZoom(self)
							end

							slider._kk_sck_id = "settAngR"
							self:loadSliderZoom(slider)
							
						settAngRPanel:Dock(TOP)
						settAngRPanel:SetBackgroundColor(TOOL.darkBackground)
						settAngRPanel:SizeToContents()
						
						local settSizeXYZPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local sliderXYZ
							sliderXYZ = vgui.Create("DNumSlider", settSizeXYZPanel)
							sliderXYZ:Dock(FILL)
							sliderXYZ:DockMargin(8,0,8,0)
							sliderXYZ:SetDecimals(4)
							sliderXYZ:SetMinMax(0.01, 10)
							sliderXYZ:SetValue(curData.size.x)
							sliderXYZ:SetText("size.xyz")
							sliderXYZ:SetDark(true)

						settSizeXYZPanel:Dock(TOP)
						settSizeXYZPanel:DockMargin(0,8,0,0)
						settSizeXYZPanel:SetBackgroundColor(TOOL.darkBackground)
						settSizeXYZPanel:SizeToContents()
						
						local settSizeXPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local sliderX
							sliderX = vgui.Create("DNumSlider", settSizeXPanel)
							sliderX:Dock(FILL)
							sliderX:DockMargin(8,0,8,0)
							sliderX:SetDecimals(4)
							sliderX:SetMinMax(0.01, 10)
							sliderX:SetValue(curData.size.x)
							sliderX:SetText("size.x")
							sliderX:SetDark(true)
							function sliderX:OnValueChanged(val)
								if UNIFORMSCALELOCK then return end
								
								curData.size = Vector(curData.size)
								curData.size.x = val
								TOOL:reInitializeElement(curData)
							
								TOOL:storeSliderZoom(self)
							end

							sliderX._kk_sck_id = "settSizeX"
							self:loadSliderZoom(sliderX)
							
						settSizeXPanel:Dock(TOP)
						settSizeXPanel:DockMargin(0,8,0,0)
						settSizeXPanel:SetBackgroundColor(TOOL.darkBackground)
						settSizeXPanel:SizeToContents()
						
						local settSizeYPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local sliderY
							sliderY = vgui.Create("DNumSlider", settSizeYPanel)
							sliderY:Dock(FILL)
							sliderY:DockMargin(8,0,8,0)
							sliderY:SetDecimals(4)
							sliderY:SetMinMax(0.01, 10)
							sliderY:SetValue(curData.size.y)
							sliderY:SetText("size.y")
							sliderY:SetDark(true)
							function sliderY:OnValueChanged(val)
								if UNIFORMSCALELOCK then return end
								
								curData.size = Vector(curData.size)
								curData.size.y = val
								TOOL:reInitializeElement(curData)
							
								TOOL:storeSliderZoom(self)
							end

							sliderY._kk_sck_id = "settSizeY"
							self:loadSliderZoom(sliderY)
							
						settSizeYPanel:Dock(TOP)
						settSizeYPanel:SetBackgroundColor(TOOL.darkBackground)
						settSizeYPanel:SizeToContents()
						
						local settSizeZPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local sliderZ
							sliderZ = vgui.Create("DNumSlider", settSizeZPanel)
							sliderZ:Dock(FILL)
							sliderZ:DockMargin(8,0,8,0)
							sliderZ:SetDecimals(4)
							sliderZ:SetMinMax(0.01, 10)
							sliderZ:SetValue(curData.size.z)
							sliderZ:SetText("size.z")
							sliderZ:SetDark(true)
							function sliderZ:OnValueChanged(val)
								if UNIFORMSCALELOCK then return end
								
								curData.size = Vector(curData.size)
								curData.size.z = val
								TOOL:reInitializeElement(curData)
							
								TOOL:storeSliderZoom(self)
							end

							sliderZ._kk_sck_id = "settSizeZ"
							self:loadSliderZoom(sliderZ)
							
						settSizeZPanel:Dock(TOP)
						settSizeZPanel:SetBackgroundColor(TOOL.darkBackground)
						settSizeZPanel:SizeToContents()
						
						function sliderXYZ:OnValueChanged(val)
							UNIFORMSCALELOCK = true
								sliderX:SetValue(val)
								sliderY:SetValue(val)
								sliderZ:SetValue(val)
							UNIFORMSCALELOCK = false
							
							curData.size = Vector(val,val,val)
							TOOL:reInitializeElement(curData)
							
							TOOL:storeSliderZoom(self)
						end

						sliderXYZ._kk_sck_id = "settSizeXYZ"
						self:loadSliderZoom(sliderXYZ)
						
						if tProps.adjustable then
							local settAdjustmentLabelPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local label
								label = vgui.Create("DLabel", settAdjustmentLabelPanel)
								label:SetText("Sight Adjustment:")
								label:SetDark(true)
								label:Dock(LEFT)
								label:DockMargin(8,0,0,0)
								label:SizeToContents()
								
								local butt
								butt = vgui.Create("DButton", settAdjustmentLabelPanel)
								butt:SetTooltip("Adds sight adjustment subtable.")
								butt:Dock(RIGHT)
								butt:DockMargin(0,4,8,4)
								
								if data.adjustment then
									butt:SetText("Remove")
									function butt:DoClick()
										data.adjustment = nil
										TOOL:updatePanel()
									end
								else
									butt:SetText("Add")
									function butt:DoClick()
										data.adjustment = {
											min = 0, 
											max = 0, 
											axis = "x", 
											inverse = false,
											inverseOffsetCalc = false,
										}
										TOOL:updatePanel()
									end
								end
								
							settAdjustmentLabelPanel:Dock(TOP)
							settAdjustmentLabelPanel:DockMargin(0,8,0,0)
							settAdjustmentLabelPanel:SetBackgroundColor(TOOL.darkBackground)
							settAdjustmentLabelPanel:SizeToContents()
							
							if data.adjustment then
								local settAdjustmentAxisPanel = vgui.Create("DPanel", elementSettingPanel)
							
									local label
									label = vgui.Create("DLabel", settAdjustmentAxisPanel)
									label:SetText("Axis: ")
									label:SetDark(true)
									label:Dock(LEFT)
									label:DockMargin(8,0,0,0)
									label:SizeToContents()
									
									local ax = {x = 1, y = 2, z = 3}
									local xa = {"x", "y", "z"}
									
									local unselect = {"X", "Y", "Z"}
									local selected = {"[X]", "[Y]", "[Z]"}
									
									local buttRow = vgui.Create("DListView", settAdjustmentAxisPanel)
									buttRow:AddColumn("")
									buttRow:AddColumn("")
									buttRow:AddColumn("")
									buttRow:SetHeaderHeight(20)
									
									buttRow:Dock(FILL)
									buttRow:DockMargin(16,2,8,2)
									buttRow:SizeToContents()
									buttRow:SetBackgroundColor(Color(0,0,0,255))
									buttRow:SetPaintBackground(false)
									buttRow:FixColumnsLayout()
									
									function buttRow:SortByColumn(i)
										TOOL:backupAdjustmentTable(WEAPON, t, key, data)
										
										data.adjustment.axis = xa[i]
										
										// PrintTable(self:GetTable())
										// PrintTable(self.Columns[i]:GetTable())
										
										for k,v in pairs(self.Columns) do
											if k == i then 
												v:SetName(selected[k])
											else
												v:SetName(unselect[k])
											end
										end
									end
									
									function buttRow:OnRequestResize(val) end
									
									buttRow:SortByColumn(ax[data.adjustment.axis])
									
								settAdjustmentAxisPanel:Dock(TOP)
								settAdjustmentAxisPanel:SetBackgroundColor(TOOL.darkBackground)
								settAdjustmentAxisPanel:SizeToContents()
								
								local settAdjustmentMinPanel = vgui.Create("DPanel", elementSettingPanel)
								
									local slider
									slider = vgui.Create("DNumSlider", settAdjustmentMinPanel)
									slider:Dock(FILL)
									slider:DockMargin(8,0,8,0)
									slider:SetDecimals(4)
									slider:SetMinMax(-100, 100)
									slider:SetValue(data.adjustment.min)
									slider:SetText("Min:")
									slider:SetDark(true)
									function slider:OnValueChanged(val)
										TOOL:backupAdjustmentTable(WEAPON, t, key, data)
										
										data.adjustment.min = val
										
										TOOL:storeSliderZoom(self)
									end

									slider._kk_sck_id = "settAdjustmentMin"
									self:loadSliderZoom(slider)
									
								settAdjustmentMinPanel:Dock(TOP)
								settAdjustmentMinPanel:SetBackgroundColor(TOOL.darkBackground)
								settAdjustmentMinPanel:SizeToContents()
								
								local settAdjustmentMaxPanel = vgui.Create("DPanel", elementSettingPanel)
								
									local slider
									slider = vgui.Create("DNumSlider", settAdjustmentMaxPanel)
									slider:Dock(FILL)
									slider:DockMargin(8,0,8,0)
									slider:SetDecimals(4)
									slider:SetMinMax(-100, 100)
									slider:SetValue(data.adjustment.max)
									slider:SetText("Max:")
									slider:SetDark(true)
									function slider:OnValueChanged(val)
										TOOL:backupAdjustmentTable(WEAPON, t, key, data)
										
										data.adjustment.max = val
									
										TOOL:storeSliderZoom(self)
									end

									slider._kk_sck_id = "settAdjustmentMax"
									self:loadSliderZoom(slider)
									
								settAdjustmentMaxPanel:Dock(TOP)
								settAdjustmentMaxPanel:SetBackgroundColor(TOOL.darkBackground)
								settAdjustmentMaxPanel:SizeToContents()
								
								local settAdjustmentInvPanel = vgui.Create("DPanel", elementSettingPanel)
								
									// inverse
									// inverseOffsetCalc
									// index
								
									local settAdjustmentInvCtrlPanel = vgui.Create("DPanel", settAdjustmentInvPanel)
										
										local cbox
										cbox = vgui.Create("DCheckBoxLabel", settAdjustmentInvCtrlPanel)
										cbox:SetText("Invert input")
										cbox:SetDark(true)
										cbox:SizeToContents()	
										
										cbox:SetValue(data.adjustment.inverse)
										
										function cbox:OnChange(val)
											TOOL:backupAdjustmentTable(WEAPON, t, key, data)
										
											data.adjustment.inverse = val
										end
										
									settAdjustmentInvCtrlPanel:Dock(LEFT)
									settAdjustmentInvCtrlPanel:DockMargin(8,4,0,0)
									settAdjustmentInvCtrlPanel:SetSize(120,24)
									settAdjustmentInvCtrlPanel:SetPaintBackground(false)
									settAdjustmentInvCtrlPanel:SizeToContents()
									
									local settAdjustmentInvPrtPanel = vgui.Create("DPanel", settAdjustmentInvPanel)
										
										local cbox
										cbox = vgui.Create("DCheckBoxLabel", settAdjustmentInvPrtPanel)
										cbox:SetText("Invert calculation")
										cbox:SetDark(true)
										cbox:SizeToContents()	
										
										cbox:SetValue(data.adjustment.inverseOffsetCalc)
										
										function cbox:OnChange(val)
											TOOL:backupAdjustmentTable(WEAPON, t, key, data)
											
											data.adjustment.inverseOffsetCalc = val
										end
										
									settAdjustmentInvPrtPanel:Dock(RIGHT)
									settAdjustmentInvPrtPanel:DockMargin(0,4,8,0)
									settAdjustmentInvPrtPanel:SetSize(120,24)
									settAdjustmentInvPrtPanel:SetPaintBackground(false)
									settAdjustmentInvPrtPanel:SizeToContents()
									
								settAdjustmentInvPanel:Dock(TOP)
								settAdjustmentInvPanel:SetBackgroundColor(TOOL.darkBackground)
								settAdjustmentInvPanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 32 + 96
							else
								elementSettingPanelHeight = elementSettingPanelHeight + 32
							end
						end
						
						if curData.ent:SkinCount() > 1 then 
							local settSkinPanel = vgui.Create("DPanel", elementSettingPanel)
								
							local slider
							slider = vgui.Create("DNumSlider", settSkinPanel)
							slider:Dock(FILL)
							slider:DockMargin(8,0,8,0)
							slider:SetDecimals(0)
							slider:SetMinMax(0, curData.ent:SkinCount() - 1)
							slider:SetValue(curData.ent:GetSkin())
							slider:SetText("Skin")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								curData.skin = val
								curData.ent:SetSkin(val)
							end

							settSkinPanel:Dock(TOP)
							settSkinPanel:DockMargin(0,8,0,0)
							settSkinPanel:SetBackgroundColor(TOOL.darkBackground)
							settSkinPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 32
						end
						
						local bgSettings = false
						
						for i = 0, curData.ent:GetNumBodyGroups() - 1 do
							bgSettings = bgSettings or (curData.ent:GetBodygroupCount(i) - 1 > 0)
						end
						
						if bgSettings then 
							local settBodygroupLabelPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local label
								label = vgui.Create("DLabel", settBodygroupLabelPanel)
								label:SetText("Bodygroups:")
								label:SetDark(true)
								label:Dock(FILL)
								label:DockMargin(8,0,0,0)
								label:SizeToContents()
								label:SetMouseInputEnabled(true)
								
							settBodygroupLabelPanel:Dock(TOP)
							settBodygroupLabelPanel:DockMargin(0,8,0,0)
							settBodygroupLabelPanel:SetBackgroundColor(TOOL.darkBackground)
							settBodygroupLabelPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 34
						
							for i = 0, curData.ent:GetNumBodyGroups() - 1 do
								local bgCount = curData.ent:GetBodygroupCount(i) - 1
								if bgCount > 0 then
									
									local settBodygroupPanel = vgui.Create("DPanel", elementSettingPanel)
										
										local slider
										slider = vgui.Create("DNumSlider", settBodygroupPanel)
										slider:Dock(FILL)
										slider:DockMargin(8,0,8,0)
										slider:SetDecimals(0)
										slider:SetMinMax(0, bgCount)
										slider:SetValue(curData.ent:GetBodygroup(i))
										slider:SetText(i .. "# " .. curData.ent:GetBodygroupName(i))
										slider:SetDark(true)
										function slider:OnValueChanged(val)
											local t = curData.bodygroups
											curData.bodygroups = {}
											if t then
												for k,v in pairs(t) do
													curData.bodygroups[k] = v
												end
											end
											curData.bodygroups[i] = val
											curData.ent:SetBodygroup(i, val)
										end

									settBodygroupPanel:Dock(TOP)
									settBodygroupPanel:SetBackgroundColor(TOOL.darkBackground)
									settBodygroupPanel:SizeToContents()
									
									elementSettingPanelHeight = elementSettingPanelHeight + 24
								end
							end
						end
						
						if WEAPON.KKINS2Wep then
							local settMaterialPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local label
								label = vgui.Create("DLabel", settMaterialPanel)
								label:SetText("Material Override:")
								label:SetDark(true)
								label:Dock(LEFT)
								label:DockMargin(8,0,0,0)
								label:SizeToContents()
								
								local entry
								entry = vgui.Create("DTextEntry", settMaterialPanel)
								entry:Dock(FILL)
								entry:DockMargin(8,0,8,0)
								
								entry:SetValue(curData.material or "")
								
								function entry:OnChange()
									local f = self:GetValue()
									
									curData.material = f
									curData.ent:SetMaterial(f)
								end
								
							settMaterialPanel:Dock(TOP)
							settMaterialPanel:DockMargin(0,8,0,0)
							settMaterialPanel:SetPaintBackground(false)
							settMaterialPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 34
							
							local settParentPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local label
								label = vgui.Create("DLabel", settParentPanel)
								label:SetText("Parent Override:")
								label:SetDark(true)
								label:Dock(LEFT)
								label:DockMargin(8,0,0,0)
								label:SizeToContents()
								
								local entry
								entry = vgui.Create("DTextEntry", settParentPanel)
								entry:Dock(FILL)
								entry:DockMargin(8,0,8,0)
								
								entry:SetValue(curData.rel or "")
								
								function entry:OnChange()
									local f = self:GetValue()
									
									curData.rel = f
								end
								
							settParentPanel:Dock(TOP)
							settParentPanel:DockMargin(0,8,0,0)
							settParentPanel:SetPaintBackground(false)
							settParentPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 34
							
							local settNoDrawPanel = vgui.Create("DPanel", elementSettingPanel)
							
								local cbox, label
								cbox = vgui.Create("DCheckBoxLabel", settNoDrawPanel)
								cbox:SetText("No Draw (Pos/Ang updates only)")
								cbox:SetTooltip("cube tool")
								cbox:SetDark(true)
								cbox:Dock(FILL)
								
								cbox:SetValue(curData.nodraw)
								function cbox:OnChange(val)
									curData.nodraw = val
								end
						
							settNoDrawPanel:SetSize(200,16)
							settNoDrawPanel:Dock(TOP)
							settNoDrawPanel:DockMargin(8,8,0,0)
							settNoDrawPanel:SetPaintBackground(false)
							settNoDrawPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 24
							
							local settHideVMPanel = vgui.Create("DPanel", elementSettingPanel)
							
								local cbox, label
								cbox = vgui.Create("DCheckBoxLabel", settHideVMPanel)
								cbox:SetText("Hide CW_VM when active")
								cbox:SetTooltip("for weapon variants")
								cbox:SetDark(true)
								cbox:Dock(FILL)
								
								cbox:SetValue(curData.hideVM)
								function cbox:OnChange(val)
									curData.hideVM = val
								end
						
							settHideVMPanel:SetSize(200,16)
							settHideVMPanel:Dock(TOP)
							settHideVMPanel:DockMargin(8,8,0,0)
							settHideVMPanel:SetPaintBackground(false)
							settHideVMPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 24
							
							local settRecomputePanel = vgui.Create("DPanel", elementSettingPanel)
							
								local cbox, label
								cbox = vgui.Create("DCheckBoxLabel", settRecomputePanel)
								cbox:SetText("Recompute lighting")
								cbox:SetTooltip("for scopes")
								cbox:SetDark(true)
								cbox:Dock(FILL)
								
								cbox:SetValue(curData.rLight)
								function cbox:OnChange(val)
									curData.rLight = val
								end
						
							settRecomputePanel:SetSize(200,16)
							settRecomputePanel:Dock(TOP)
							settRecomputePanel:DockMargin(8,8,0,0)
							settRecomputePanel:SetPaintBackground(false)
							settRecomputePanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 24
						end
						
						local settAnimatedPanel = vgui.Create("DPanel", elementSettingPanel)
						
							local cbox, label
							cbox = vgui.Create("DCheckBoxLabel", settAnimatedPanel)
							cbox:SetText("Animated")
							cbox:SetTooltip("CW2 md_m203")
							cbox:SetDark(true)
							cbox:Dock(FILL)
							-- cbox:DockMargin(8,0,0,0)
							
							cbox:SetValue(curData.animated)
							function cbox:OnChange(val)
								curData.animated = val
							end
					
						settAnimatedPanel:SetSize(200,16)
						settAnimatedPanel:Dock(TOP)
						settAnimatedPanel:DockMargin(8,8,0,0)
						settAnimatedPanel:SetPaintBackground(false)
						settAnimatedPanel:SizeToContents()
						
						local unknownSettings = {}
						
						for k,v in pairs(curData) do
							if not TOOL.knownElementDataKeys[k] and not TOOL.noExportElementDataKeys[k] then
								unknownSettings[k] = v
							end
						end
						
						if table.Count(unknownSettings) > 0 then 
							local settUnknownLabelPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local label
								label = vgui.Create("DLabel", settUnknownLabelPanel)
								label:SetText("Uknown settings:")
								label:SetDark(true)
								label:Dock(FILL)
								label:DockMargin(8,0,0,0)
								label:SizeToContents()
								label:SetMouseInputEnabled(true)
								
							settUnknownLabelPanel:Dock(TOP)
							settUnknownLabelPanel:DockMargin(0,8,0,0)
							settUnknownLabelPanel:SetBackgroundColor(TOOL.darkBackground)
							settUnknownLabelPanel:SizeToContents()
							
							elementSettingPanelHeight = elementSettingPanelHeight + 34
							
							for k,v in pairs(unknownSettings) do
							
								local settUnknownPanel = vgui.Create("DPanel", elementSettingPanel)
								
									local label
									label = vgui.Create("DLabel", settUnknownPanel)
									label:SetText("[\"" .. k .. "\"] = " .. tostring(v))
									label:SetDark(true)
									label:Dock(FILL)
									label:DockMargin(8,0,0,0)
									label:SizeToContents()
									label:SetMouseInputEnabled(true)
									
								settUnknownPanel:Dock(TOP)
								settUnknownPanel:SetBackgroundColor(TOOL.darkBackground)
								settUnknownPanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 24
								
							end
						end
						
						local buttExportPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local butt
							butt = vgui.Create("DButton", buttExportPanel)
							butt:SetTooltip("Copies current element table to your clipboard.")
							butt:Dock(FILL)
							butt:SetText("Export (copy to clipboard)")
							function butt:DoClick()
								
								if data.models then
									local snds = {
										"http://cdn.frustra.org/sounds/sound_tf2/vo/scout_no02.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/pyro_no01.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/soldier_no03.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/demoman_no01.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/heavy_no02.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/medic_no02.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/engineer_no01.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/sniper_no01.mp3",
										"http://cdn.frustra.org/sounds/sound_tf2/vo/spy_no02.mp3",
									}
								
									sound.PlayURL(table.Random(snds), "", function(station)
										if IsValid(station) then
											station:Play()
										else
											print("INVALID INTERNET CONNECTION OMGF!")
										end
									end)
									
									SetClipboardText("No! element.models not yet supported!")
									return
								end
								
								local out, outputFormat, posFormated, angFormated, sizeFormated, attachFuncID, attachFuncVal, attachFuncCaps, rest
								
								outputFormat = "[\"%s\"] = {model = \"%s\"%s, pos = %s, angle = %s, size = %s, %s = %s%s},"
								
								local function s(x) return tostring(math.Round(x, 4)) end
								
								posFormated = string.format(
									"Vector(%s, %s, %s)", 
									s(data.pos.x), 
									s(data.pos.y), 
									s(data.pos.z)
								)
								
								angFormated = string.format(
									"Angle(%s, %s, %s)", 
									s(data.angle.p),
									s(data.angle.y),
									s(data.angle.r)
								)
								
								sizeFormated = string.format(
									"Vector(%s, %s, %s)",
									s(data.size.x),
									s(data.size.y), 
									s(data.size.z)
								)
								
								if data.merge then
									attachFuncID = "merge"
									attachFuncCaps = ""
								elseif data.attachment then
									attachFuncID = "attachment"
									attachFuncCaps = "\""
								else
									attachFuncID = "bone"
									attachFuncCaps = "\""
								end										
								
								attachFuncVal = attachFuncCaps .. tostring(data[attachFuncID]) .. attachFuncCaps
								
								rest = ""
								
								// adjustment
								if data.adjustment then
									rest = rest .. string.format(
										", adjustment = {axis = \"%s\", min = %s, max = %s, inverse = %s, inverseOffsetCalc = %s}",
										tostring(data.adjustment.axis),
										tostring(data.adjustment.min),
										tostring(data.adjustment.max),
										tostring(data.adjustment.inverse),
										tostring(data.adjustment.inverseOffsetCalc)
									)
								end
								
								// material
								if data.material then
									rest = rest .. ", material = \"" .. data.material .. "\""
								end
								
								// bodygroups
								local bgsFormated = ", bodygroups = {"
								local bgs
								
								for k = 0, data.ent:GetNumBodyGroups() - 1 do
									local v = data.ent:GetBodygroup(k)
									if v != 0 then
										bgs = true
										bgsFormated = bgsFormated .. "[" .. k .. "] = " .. v .. ","
									end
								end
								
								if bgs then
									rest = rest .. bgsFormated .. "}"
								end
								
								// skin
								local skin = data.ent:GetSkin()
								if skin != 0 then
									rest = rest .. ", skin = " .. skin
								end
								
								// nodraw
								if data.nodraw then
									rest = rest .. ", nodraw = true"
								end
								
								// animated
								if data.animated then
									rest = rest .. ", animated = true"
								end
								
								// hideVM
								if data.hideVM then
									rest = rest .. ", hideVM = true"
								end
								
								// active by default
								local origData = weapons.GetStored(WEAPON:GetClass())[t] and weapons.GetStored(WEAPON:GetClass())[t][key]
								local activeByDef
								
								if origData then
									activeByDef = origData.active
								else
									activeByDef = data.active
								end
								
								if activeByDef then
									rest = rest .. ", active = true"
								end
								
								// pootit together
								out = string.format(
									outputFormat,
									key,
									data.model,
									data.rLight and ", rLight = true" or "", // rLight
									posFormated,
									angFormated,
									sizeFormated,
									attachFuncID,
									attachFuncVal,
									rest
								)
								
								// out
								SetClipboardText(out)
							end
	
						buttExportPanel:Dock(TOP)
						buttExportPanel:DockMargin(0,8,0,0)
						buttExportPanel:SetPaintBackground(false)
						buttExportPanel:SizeToContents()
						
						local buttRestorePanel = vgui.Create("DPanel", elementSettingPanel)
						
							local origData = weapons.GetStored(WEAPON:GetClass())[t]
							local origData = origData and origData[key]
							
							local butt
							butt = vgui.Create("DButton", buttRestorePanel)
							butt:Dock(FILL)
							
							if origData then
								butt:SetText("Restore from weapon.lua")
								butt:SetTooltip("Wipes your changes from this element.")
							
								function butt:DoClick()
									
									data.adjustment = origData.adjustment
									
									if origData.models then
										origData = origData.models[openTab.subID or 1]
									end
									
									curData.model = origData.model
									curData.pos = origData.pos
									curData.angle = origData.angle
									curData.size = origData.size
									curData.merge = origData.merge
									curData.bone = origData.bone
									curData.attachment = origData.attachment
									curData.skin = origData.skin
									curData.bodygroups = origData.bodygroups
									curData.material = origData.material
									
									TOOL:reInitializeElement(curData)
									TOOL:updatePanel()
								end
							else
								butt:SetText("Original data not found")
								butt:SetTooltip("Element data not found in wep.lua. Nothing to restore.")
								
								butt:SetEnabled(false)
							end
		
						buttRestorePanel:Dock(TOP)
						buttRestorePanel:DockMargin(0,8,0,0)
						buttRestorePanel:SetPaintBackground(false)
						buttRestorePanel:SizeToContents()
						
					elementSettingPanel:SetSize(0, 504 + elementSettingPanelHeight)
					elementSettingPanel:DockPadding(8,8,8,8)
					elementSettingPanel:DockMargin(0,0,0,0)
					elementSettingPanel:SizeToContents()
					-- elementSettingPanel:SetPaintBackground(false)
					PANEL:AddItem(elementSettingPanel)
					
				end // end if t == openTab.t and key == openTab.key then
				
			end // end for key,data in SortedPairs(sortMeh) do
			
		end // end for t,tProps in pairs(self.elementTables) do
		
	end // end if IsValid(WEAPON) and WEAPON.CW20Weapon then
	
	if IsValid(WEAPON) and WEAPON.CW20Weapon then
		if not openTab.key and not addingNewElement then
			PANEL:AddControl("Label", {Text = "Active elementRender function count: " .. table.Count(WEAPON.elementRender)})
		end
	end
	
	if not CustomizableWeaponry then return end
	
	if not openTab.key and not addingNewElement then
		local i = 0

		for _,ent in pairs(CustomizableWeaponry.cmodels.curModels) do 
			if ent.wepParent == WEAPON then
				i = i + 1
			end
		end

		PANEL:AddControl("Label", {Text = "Current weapon cl model count: " .. i})
		PANEL:AddControl("Label", {Text = "Current total cl model count: " .. #CustomizableWeaponry.cmodels.curModels})
	end
end

function TOOL:think()
	self.WEAPON = LocalPlayer():GetActiveWeapon()
	
	local curSetup
	
	if IsValid(self.WEAPON) then 
		curSetup = self.WEAPON:GetClass() .. "|" 
		
		if self.WEAPON.ActiveAttachments then
			for k,v in pairs(self.WEAPON.ActiveAttachments) do
				if v then 
					curSetup = curSetup .. k .. "|"
				end
			end
		end
	end
	
	if curSetup != self._think_lastSetup then
		self:updatePanel()
	end
	
	self._think_lastSetup = curSetup
end

function TOOL:PopulateToolMenu()
	local instance = self
	
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", TOOL.utilityTabName, TOOL.printName, "", "", function(panel)
		instance.PANEL = panel
		instance:updatePanel()
		
		hook.Add("Think", instance, instance.think)
	end)
end

hook.Add("PopulateToolMenu", TOOL, TOOL.PopulateToolMenu)

function TOOL:PostReloadToolsMenu()
	hook.Remove("Think", self)
end

hook.Add("PostReloadToolsMenu", TOOL, TOOL.PostReloadToolsMenu)

-- RunConsoleCommand("spawnmenu_reload")
