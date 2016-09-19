AddCSLuaFile()

local PANEL, WEAPON

local elementTables = {
	["AttachmentModelsVM"] = {adjustable = true},
	["AttachmentModelsWM"] = {adjustable = false}, // just so sightadjustment panels dont showup for WElements
}

local function getParentEnt(str)
	if str == "AttachmentModelsVM" then
		return WEAPON.CW_VM
	end
	
	if str == "AttachmentModelsWM" then
		return IsValid(WEAPON.WMEnt) and WEAPON.WMEnt or WEAPON
	end
end

local knownElementDataKeys = {
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
	
	["ignoreKKBGO"] = true, // BGO3 crashes my game if combined with CSGO stat attachment proxies
}

local noExportElementDataKeys = {
	["ent"] = true,
	["rel"] = true,
	["matrix"] = true,
	["origPos"] = true,
	["origAng"] = true,
	
	["stencilEnt"] = true, // INS2 stencil sight ent
	
	["_kksck_curIndex"] = true, // index of element.models sub-table
	["_kksck_expanded"] = true, // element being shown in editor
}

local function collapseAll()
	for t,tProps in pairs(elementTables) do
		if WEAPON[t] then
			for key,data in pairs(WEAPON[t]) do
				data._kksck_expanded = false
			end
		end
	end
end

local function reInitializeElement(data)
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
			data.ent:SetSubMaterial(i - 1, "models/weapons/attachments/cw_kk_ins2_shared/nodraw")
		end
	end
	
	if data.material then 
		data.ent:SetMaterial(data.material)
	end
end

local noBackground = Color(0,0,0,0)
local darkBackground = Color(0,0,0,50)

local function cloneAngle(ang)
	return Angle(ang.p, ang.y, ang.r)
end

local UNIFORMSCALELOCK = false

local function backupAdjustmentTable(wep, t, key, curData)
	local orig = weapons.GetStored(wep:GetClass())[t][key].adjustment
	
	if orig == curData.adjustment then
		curData.adjustment = {}
		for k,v in pairs(orig) do
			curData.adjustment[k] = v
		end
	end
end

local stored = {}

local function initSliderStorage(id)
	if not stored[id] then
		stored[id] = CreateClientConVar("_kk_sck_elements_slsens_" .. id, 1, true, false)
	end
end

local function storeSliderZoom(slider)
	local id = slider._kk_sck_id
	
	initSliderStorage(id)
	
	RunConsoleCommand("_kk_sck_elements_slsens_" .. id, slider.Wang:GetZoom())
end

local function loadSliderZoom(slider)
	local id = slider._kk_sck_id
	
	initSliderStorage(id)
	
	slider.Wang:SetZoom(stored[id]:GetFloat())
end

local function updatePanel()
	if not PANEL then return end
	
	PANEL:ClearControls()

	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:SetTooltip("Loads changes made outside of this tool.")
	butt:DockMargin(0, 0, 0, 8)	
	butt:SetText("Refresh")
	butt.DoClick = updatePanel
	PANEL:AddItem(butt)
	
	if IsValid(WEAPON) and WEAPON.CW20Weapon then
		for t,tProps in pairs(elementTables) do
			if WEAPON[t] then
				if not WEAPON._kksck_tabOpen then
					PANEL:AddControl("Label", {Text = "SWEP." .. t .. ":"})
				end
				
				for key,data in SortedPairs(WEAPON[t]) do
				
					if data._kksck_expanded or !WEAPON._kksck_tabOpen then
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
								if data._kksck_expanded then
									self:SetText("<=")
								else
									self:SetText("=>")
								end
								self:SizeToContents()
							end
							
							arrowLabel:updateText()
							
							local function updateTitle() // changed 2many times
								local state = !data._kksck_expanded
								collapseAll()
								
								data._kksck_expanded = state
								WEAPON._kksck_tabOpen = state
								
								arrowLabel:updateText()
								updatePanel()
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
					
					if data._kksck_expanded then
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
									updatePanel()
								end
						
							settActivePanel:Dock(TOP)
							settActivePanel:SetSize(200,16)
							settActivePanel:SetPaintBackground(false)
							settActivePanel:SizeToContents()
							
							if data.models then
								local pickSubElementPanel = vgui.Create("DPanel", elementSettingPanel)
							
									local box = vgui.Create("DComboBox", pickSubElementPanel)
									box:Dock(FILL)
									box:SetValue(data.models[data._kksck_curIndex or 1].model)
									
									for k,v in pairs(data.models) do
										box:AddChoice(v.model)
									end
									
									function box:OnSelect(i, name)
										data._kksck_curIndex = i
										updatePanel()
									end
									
								pickSubElementPanel:Dock(TOP)
								pickSubElementPanel:DockMargin(0,8,0,0)
								pickSubElementPanel:SetPaintBackground(false)
								pickSubElementPanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 32
								curData = data.models[data._kksck_curIndex or 1]
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
										updatePanel()
									end
								end
								
							settModelPanel:Dock(TOP)
							settModelPanel:DockMargin(0,8,0,0)
							settModelPanel:SetPaintBackground(false)
							settModelPanel:SizeToContents()
							
							local settMergePanel = vgui.Create("DPanel", elementSettingPanel)
							
								local funcList = vgui.Create("DListView", settMergePanel)
								funcList:SetMultiSelect(false)
								funcList:AddColumn("Attach Point Function")
								funcList:AddLine("[CW20] Bone on parent entity")
								
								if WEAPON.KKINS2Wep then
									funcList:AddLine("[KKIN2] QC Attachment on parent entity")
									funcList:AddLine("[KKIN2] Bone-Merge to parent entity")
								end
								
								funcList:Dock(FILL)
								function funcList:SortByColumn() end
								
								if curData.merge then
									funcList:SelectItem(funcList:GetLine(3))
								elseif curData._attachment then
									funcList:SelectItem(funcList:GetLine(2))
								else
									funcList:SelectItem(funcList:GetLine(1))
								end
								
								function funcList:OnRowSelected(val)
									if val == 1 then
										curData.merge = false
										curData.attachment = nil
										curData._attachment = nil
										curData.bone = nil
										curData._bone = 0 // fallback so drawAttachFunc doesnt freakout
									elseif val == 2 then
										curData.merge = false
										curData.attachment = nil
										curData._attachment = 1 // lets pray there is at least one compiled to parent model
										curData.bone = nil
										curData._bone = nil
									elseif val == 3 then
										curData.merge = true // E.Z.
										curData.attachment = nil
										curData._attachment = nil
										curData.bone = nil
										curData._bone = nil
									end
									
									reInitializeElement(curData)
									updatePanel()
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
									
									local ent = getParentEnt(t)
									
									for i = 0, ent:GetBoneCount() do
										box:AddChoice(ent:GetBoneName(i))
									end
									
									function box:OnSelect(i, name) 
										curData.bone = name
										reInitializeElement(curData)
										updatePanel()
									end
									
								settBonePanel:Dock(TOP)
								settBonePanel:DockMargin(0,8,0,0)
								settBonePanel:SetPaintBackground(false)
								settBonePanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 32
							end
							
							if funcList:GetSelectedLine() == 2 then
								
								local settAttPanel = vgui.Create("DPanel", elementSettingPanel)
							
									local box = vgui.Create("DComboBox", settAttPanel)
									box:Dock(FILL)
									box:SetValue(curData.attachment or "-select attachment-")
									
									local ent = getParentEnt(t)
									
									for k,v in pairs(ent:GetAttachments()) do
										box:AddChoice(v.name)
									end
									
									function box:OnSelect(i, name) 
										curData.attachment = name
										reInitializeElement(curData)
										updatePanel()
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
									
									storeSliderZoom(self)
								end

								slider._kk_sck_id = "settPosX"
								loadSliderZoom(slider)
								
							settPosXPanel:Dock(TOP)
							settPosXPanel:DockMargin(0,8,0,0)
							settPosXPanel:SetBackgroundColor(darkBackground)
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
									
									storeSliderZoom(self)
								end

								slider._kk_sck_id = "settPosY"
								loadSliderZoom(slider)
								
							settPosYPanel:Dock(TOP)
							settPosYPanel:SetBackgroundColor(darkBackground)
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
								
									storeSliderZoom(self)
								end

								slider._kk_sck_id = "settPosZ"
								loadSliderZoom(slider)
								
							settPosZPanel:Dock(TOP)
							settPosZPanel:SetBackgroundColor(darkBackground)
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
								
									storeSliderZoom(self)
								end

								slider._kk_sck_id = "settAngP"
								loadSliderZoom(slider)
								
							settAngPPanel:Dock(TOP)
							settAngPPanel:DockMargin(0,8,0,0)
							settAngPPanel:SetBackgroundColor(darkBackground)
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
								
									storeSliderZoom(self)
								end

								slider._kk_sck_id = "settAngY"
								loadSliderZoom(slider)
								
							settAngYPanel:Dock(TOP)
							settAngYPanel:SetBackgroundColor(darkBackground)
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
								
									storeSliderZoom(self)
								end

								slider._kk_sck_id = "settAngR"
								loadSliderZoom(slider)
								
							settAngRPanel:Dock(TOP)
							settAngRPanel:SetBackgroundColor(darkBackground)
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
							settSizeXYZPanel:SetBackgroundColor(darkBackground)
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
									reInitializeElement(curData)
								
									storeSliderZoom(self)
								end

								sliderX._kk_sck_id = "settSizeX"
								loadSliderZoom(sliderX)
								
							settSizeXPanel:Dock(TOP)
							settSizeXPanel:DockMargin(0,8,0,0)
							settSizeXPanel:SetBackgroundColor(darkBackground)
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
									reInitializeElement(curData)
								
									storeSliderZoom(self)
								end

								sliderY._kk_sck_id = "settSizeY"
								loadSliderZoom(sliderY)
								
							settSizeYPanel:Dock(TOP)
							settSizeYPanel:SetBackgroundColor(darkBackground)
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
									reInitializeElement(curData)
								
									storeSliderZoom(self)
								end

								sliderZ._kk_sck_id = "settSizeZ"
								loadSliderZoom(sliderZ)
								
							settSizeZPanel:Dock(TOP)
							settSizeZPanel:SetBackgroundColor(darkBackground)
							settSizeZPanel:SizeToContents()
							
							function sliderXYZ:OnValueChanged(val)
								UNIFORMSCALELOCK = true
									sliderX:SetValue(val)
									sliderY:SetValue(val)
									sliderZ:SetValue(val)
								UNIFORMSCALELOCK = false
								
								curData.size = Vector(val,val,val)
								reInitializeElement(curData)
								
								storeSliderZoom(self)
							end

							sliderXYZ._kk_sck_id = "settSizeXYZ"
							loadSliderZoom(sliderXYZ)
							
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
								settSkinPanel:SetBackgroundColor(darkBackground)
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
								settBodygroupLabelPanel:SetBackgroundColor(darkBackground)
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
										settBodygroupPanel:SetBackgroundColor(darkBackground)
										settBodygroupPanel:SizeToContents()
										
										elementSettingPanelHeight = elementSettingPanelHeight + 24
									end
								end
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
							end
							
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
											updatePanel()
										end
									else
										butt:SetText("Add")
										function butt:DoClick()
											data.adjustment = {
												min = 0, 
												max = 0, 
												axis = "x", 
												inverseOffsetCalc = false
											}
											updatePanel()
										end
									end
									
								settAdjustmentLabelPanel:Dock(TOP)
								settAdjustmentLabelPanel:DockMargin(0,8,0,0)
								settAdjustmentLabelPanel:SetBackgroundColor(darkBackground)
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
											backupAdjustmentTable(WEAPON, t, key, data)
											
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
									settAdjustmentAxisPanel:SetBackgroundColor(darkBackground)
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
											backupAdjustmentTable(WEAPON, t, key, data)
											
											data.adjustment.min = val
											
											storeSliderZoom(self)
										end

										slider._kk_sck_id = "settAdjustmentMin"
										loadSliderZoom(slider)
										
									settAdjustmentMinPanel:Dock(TOP)
									settAdjustmentMinPanel:SetBackgroundColor(darkBackground)
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
											backupAdjustmentTable(WEAPON, t, key, data)
											
											data.adjustment.max = val
										
											storeSliderZoom(self)
										end

										slider._kk_sck_id = "settAdjustmentMax"
										loadSliderZoom(slider)
										
									settAdjustmentMaxPanel:Dock(TOP)
									settAdjustmentMaxPanel:SetBackgroundColor(darkBackground)
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
												backupAdjustmentTable(WEAPON, t, key, data)
											
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
												backupAdjustmentTable(WEAPON, t, key, data)
												
												data.adjustment.inverseOffsetCalc = val
											end
											
										settAdjustmentInvPrtPanel:Dock(RIGHT)
										settAdjustmentInvPrtPanel:DockMargin(0,4,8,0)
										settAdjustmentInvPrtPanel:SetSize(120,24)
										settAdjustmentInvPrtPanel:SetPaintBackground(false)
										settAdjustmentInvPrtPanel:SizeToContents()
										
									settAdjustmentInvPanel:Dock(TOP)
									settAdjustmentInvPanel:SetBackgroundColor(darkBackground)
									settAdjustmentInvPanel:SizeToContents()
									
									elementSettingPanelHeight = elementSettingPanelHeight + 32 + 96
								else
									elementSettingPanelHeight = elementSettingPanelHeight + 32
								end
							end
							
							local unknownSettings = {}
							
							for k,v in pairs(curData) do
								if not knownElementDataKeys[k] and not noExportElementDataKeys[k] then
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
								settUnknownLabelPanel:SetBackgroundColor(darkBackground)
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
									settUnknownPanel:SetBackgroundColor(darkBackground)
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
									
									local out, format, posFormated, angFormated, sizeFormated, attachFuncID, attachFuncVal, attachFuncCaps
									
									format = "[\"%s\"] = {model = \"%s\", pos = %s, angle = %s, size = %s, %s = %s},"
									posFormated = string.format("Vector(%0.5f, %0.5f, %0.5f)", data.pos.x, data.pos.y, data.pos.z)
									angFormated = string.format("Angle(%0.5f, %0.5f, %0.5f)", data.angle.p, data.angle.y, data.angle.r)
									sizeFormated = string.format("Vector(%0.5f, %0.5f, %0.5f)", data.size.x, data.size.y, data.size.z)
									
									if data.merge then
										attachFuncID = "merge"
										attachFuncCaps = ""
									elseif curData.attachment then
										attachFuncID = "attachment"
										attachFuncCaps = "\""
									else
										attachFuncID = "bone"
										attachFuncCaps = "\""
									end										
									
									attachFuncVal = attachFuncCaps .. tostring(data[attachFuncID]) .. attachFuncCaps
									
									out = string.format(
										format,
										key,
										data.model,
										posFormated,
										angFormated,
										sizeFormated,
										attachFuncID,
										attachFuncVal
									)
									
									SetClipboardText(out)
								end
		
							buttExportPanel:Dock(TOP)
							buttExportPanel:DockMargin(0,8,0,0)
							buttExportPanel:SetPaintBackground(false)
							buttExportPanel:SizeToContents()
							
							local buttRestorePanel = vgui.Create("DPanel", elementSettingPanel)
									
								local butt
								butt = vgui.Create("DButton", buttRestorePanel)
								butt:SetTooltip("Wipes your changes from this element.")
								butt:Dock(FILL)
								butt:SetText("Restore from weapon.lua")
								function butt:DoClick()
									local origData = weapons.GetStored(WEAPON:GetClass())[t][key]
									
									data.adjustment = origData.adjustment
									
									if origData.models then
										origData = origData.models[data._kksck_curIndex or 1]
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
									
									reInitializeElement(curData)
									updatePanel()
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
					end
				end		
			end
		end
	end

	if not (IsValid(WEAPON) and WEAPON._kksck_tabOpen) then
		if IsValid(WEAPON) and WEAPON.CW20Weapon then
			PANEL:AddControl("Label", {Text = "Active elementRender function count: " .. table.Count(WEAPON.elementRender)})
		end

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

local _LAST_SETUP

local function think()
	WEAPON = LocalPlayer():GetActiveWeapon()
	
	local curSetup
	
	if IsValid(WEAPON) then 
		curSetup = WEAPON:GetClass() .. "|" 
		
		if WEAPON.ActiveAttachments then
			for k,v in pairs(WEAPON.ActiveAttachments) do
				if v then 
					curSetup = curSetup .. k .. "|"
				end
			end
		end
	end
	
	if curSetup != _LAST_SETUP then
		
		updatePanel()
	end
	
	_LAST_SETUP = curSetup
end

hook.Add("PopulateToolMenu", "KK_SCK_VELEMENTS", function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_VELEMENTS", "VElement Browser", "", "", function(panel)
		PANEL = panel
		updatePanel()
		
		hook.Add("Think", "KK_SCK_VELEMENTS_Think", think)
	end)
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_VELEMENTS_Remove", function()
	hook.Remove("Think", "KK_SCK_VELEMENTS_Think")
end)

RunConsoleCommand("spawnmenu_reload")
