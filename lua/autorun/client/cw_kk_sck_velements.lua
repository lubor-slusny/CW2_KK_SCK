AddCSLuaFile()

local PANEL, WEAPON

local elementTables = {
	"AttachmentModelsVM",
	"AttachmentModelsWM",
}

local function getParentEnt(str)
	if str == "AttachmentModelsVM" then
		return WEAPON.CW_VM
	end
	
	if str == "AttachmentModelsWM" then
		return WEAPON.WMEnt
	end
end

local knownElementDataKeys = {
	"model",
	"pos",
	"angle",
	"size",
	"merge",
	
	"stuff",
	"stuff",
	"stuff",
}

local function collapseAll()
	for _,t in pairs(elementTables) do
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
		for _,t in pairs(elementTables) do
			if WEAPON[t] then
				if not WEAPON._kksck_tabOpen then
					PANEL:AddControl("Label", {Text = "SWEP." .. t .. ":"})
				end
				
				for key,data in pairs(WEAPON[t]) do
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
							settActivePanel:SetBackgroundColor(noBackground)
							settActivePanel:SizeToContents()
							
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
								
								entry:SetValue(data.ent:GetModel())
								
								function entry:OnChange()
									local f = self:GetValue()
									
									if file.Exists(f, "GAME") then
										data.ent:SetModel(f)
									end
								end
								
							settModelPanel:Dock(TOP)
							settModelPanel:DockMargin(0,8,0,0)
							settModelPanel:SetBackgroundColor(noBackground)
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
								
								if data.merge then
									funcList:SelectItem(funcList:GetLine(3))
								elseif data._attachment then
									funcList:SelectItem(funcList:GetLine(2))
								else
									funcList:SelectItem(funcList:GetLine(1))
								end
								
								function funcList:OnRowSelected(val)
									if val == 1 then
										data.merge = false
										data.attachment = nil
										data._attachment = nil
										data.bone = nil
										data._bone = 0 // fallback so drawAttachFunc doesnt freakout
									elseif val == 2 then
										data.merge = false
										data.attachment = nil
										data._attachment = 1 // lets pray there is at least one compiled to parent model
										data.bone = nil
										data._bone = nil
									elseif val == 3 then
										data.merge = true // E.Z.
										data.attachment = nil
										data._attachment = nil
										data.bone = nil
										data._bone = nil
									end
									
									reInitializeElement(data)
									updatePanel()
								end
								
							settMergePanel:Dock(TOP)
							settMergePanel:SetSize(200,68)
							settMergePanel:DockMargin(0,12,0,0)
							settMergePanel:SetBackgroundColor(noBackground)
							settMergePanel:SizeToContents()
							
							if funcList:GetSelectedLine() == 1 then
								
								local settBonePanel = vgui.Create("DPanel", elementSettingPanel)
							
									local box = vgui.Create("DComboBox", settBonePanel)
									box:Dock(FILL)
									box:SetValue(data.bone or "-select bone-")
									
									local ent = getParentEnt(t)
									
									for i = 0, ent:GetBoneCount() do
										box:AddChoice(ent:GetBoneName(i))
									end
									
									function box:OnSelect(i, name) 
										data.bone = name
										reInitializeElement(data)
										updatePanel()
									end
									
								settBonePanel:Dock(TOP)
								settBonePanel:DockMargin(0,8,0,0)
								settBonePanel:SetBackgroundColor(noBackground)
								settBonePanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 32
							end
							
							if funcList:GetSelectedLine() == 2 then
								
								local settAttPanel = vgui.Create("DPanel", elementSettingPanel)
							
									local box = vgui.Create("DComboBox", settAttPanel)
									box:Dock(FILL)
									box:SetValue(data.attachment or "-select attachment-")
									
									local ent = getParentEnt(t)
									
									for k,v in pairs(ent:GetAttachments()) do
										box:AddChoice(v.name)
									end
									
									function box:OnSelect(i, name) 
										data.attachment = name
										reInitializeElement(data)
										updatePanel()
									end
									
								settAttPanel:Dock(TOP)
								settAttPanel:DockMargin(0,8,0,0)
								settAttPanel:SetBackgroundColor(noBackground)
								settAttPanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 32
							end
							
							local settPosXPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local slider
								slider = vgui.Create("DNumSlider", settPosXPanel)
								slider:Dock(FILL)
								slider:DockMargin(8,0,0,0)
								slider:SetDecimals(4)
								slider:SetMinMax(-100, 100)
								slider:SetValue(data.pos.x)
								slider:SetText("pos.x")
								slider:SetDark(true)
								function slider:OnValueChanged(val)
									data.pos = Vector(data.pos) // garbage gen, but doesnt mess up stored weapon classes
									data.pos.x = val
								end

							settPosXPanel:Dock(TOP)
							settPosXPanel:DockMargin(0,8,0,0)
							settPosXPanel:SetBackgroundColor(darkBackground)
							settPosXPanel:SizeToContents()
							
							local settPosYPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local slider
								slider = vgui.Create("DNumSlider", settPosYPanel)
								slider:Dock(FILL)
								slider:DockMargin(8,0,0,0)
								slider:SetDecimals(4)
								slider:SetMinMax(-100, 100)
								slider:SetValue(data.pos.y)
								slider:SetText("pos.y")
								slider:SetDark(true)
								function slider:OnValueChanged(val)
									data.pos = Vector(data.pos)
									data.pos.y = val
								end

							settPosYPanel:Dock(TOP)
							settPosYPanel:SetBackgroundColor(darkBackground)
							settPosYPanel:SizeToContents()
							
							local settPosZPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local slider
								slider = vgui.Create("DNumSlider", settPosZPanel)
								slider:Dock(FILL)
								slider:DockMargin(8,0,0,0)
								slider:SetDecimals(4)
								slider:SetMinMax(-100, 100)
								slider:SetValue(data.pos.z)
								slider:SetText("pos.z")
								slider:SetDark(true)
								function slider:OnValueChanged(val)
									data.pos = Vector(data.pos)
									data.pos.z = val
								end

							settPosZPanel:Dock(TOP)
							settPosZPanel:SetBackgroundColor(darkBackground)
							settPosZPanel:SizeToContents()
							
							local settAngPPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local slider
								slider = vgui.Create("DNumSlider", settAngPPanel)
								slider:Dock(FILL)
								slider:DockMargin(8,0,0,0)
								slider:SetDecimals(4)
								slider:SetMinMax(-180, 180)
								slider:SetValue(data.angle.p)
								slider:SetText("angle.p")
								slider:SetDark(true)
								function slider:OnValueChanged(val)
									data.angle = cloneAngle(data.angle)
									data.angle.p = val
								end

							settAngPPanel:Dock(TOP)
							settAngPPanel:DockMargin(0,8,0,0)
							settAngPPanel:SetBackgroundColor(darkBackground)
							settAngPPanel:SizeToContents()
							
							local settAngYPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local slider
								slider = vgui.Create("DNumSlider", settAngYPanel)
								slider:Dock(FILL)
								slider:DockMargin(8,0,0,0)
								slider:SetDecimals(4)
								slider:SetMinMax(-180, 180)
								slider:SetValue(data.angle.y)
								slider:SetText("angle.y")
								slider:SetDark(true)
								function slider:OnValueChanged(val)
									data.angle = cloneAngle(data.angle)
									data.angle.y = val
								end

							settAngYPanel:Dock(TOP)
							settAngYPanel:SetBackgroundColor(darkBackground)
							settAngYPanel:SizeToContents()
							
							local settAngRPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local slider
								slider = vgui.Create("DNumSlider", settAngRPanel)
								slider:Dock(FILL)
								slider:DockMargin(8,0,0,0)
								slider:SetDecimals(4)
								slider:SetMinMax(-180, 180)
								slider:SetValue(data.angle.r)
								slider:SetText("angle.r")
								slider:SetDark(true)
								function slider:OnValueChanged(val)
									data.angle = cloneAngle(data.angle)
									data.angle.r = val
								end

							settAngRPanel:Dock(TOP)
							settAngRPanel:SetBackgroundColor(darkBackground)
							settAngRPanel:SizeToContents()
							
							local settSizeXYZPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local sliderXYZ
								sliderXYZ = vgui.Create("DNumSlider", settSizeXYZPanel)
								sliderXYZ:Dock(FILL)
								sliderXYZ:DockMargin(8,0,0,0)
								sliderXYZ:SetDecimals(4)
								sliderXYZ:SetMinMax(0.01, 10)
								sliderXYZ:SetValue(data.size.x)
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
								sliderX:DockMargin(8,0,0,0)
								sliderX:SetDecimals(4)
								sliderX:SetMinMax(0.01, 10)
								sliderX:SetValue(data.size.x)
								sliderX:SetText("size.x")
								sliderX:SetDark(true)
								function sliderX:OnValueChanged(val)
									if UNIFORMSCALELOCK then return end
									
									data.size = Vector(data.size)
									data.size.x = val
									reInitializeElement(data)
								end

							settSizeXPanel:Dock(TOP)
							settSizeXPanel:DockMargin(0,8,0,0)
							settSizeXPanel:SetBackgroundColor(darkBackground)
							settSizeXPanel:SizeToContents()
							
							local settSizeYPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local sliderY
								sliderY = vgui.Create("DNumSlider", settSizeYPanel)
								sliderY:Dock(FILL)
								sliderY:DockMargin(8,0,0,0)
								sliderY:SetDecimals(4)
								sliderY:SetMinMax(0.01, 10)
								sliderY:SetValue(data.size.y)
								sliderY:SetText("size.y")
								sliderY:SetDark(true)
								function sliderY:OnValueChanged(val)
									if UNIFORMSCALELOCK then return end
									
									data.size = Vector(data.size)
									data.size.y = val
									reInitializeElement(data)
								end

							settSizeYPanel:Dock(TOP)
							settSizeYPanel:SetBackgroundColor(darkBackground)
							settSizeYPanel:SizeToContents()
							
							local settSizeZPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local sliderZ
								sliderZ = vgui.Create("DNumSlider", settSizeZPanel)
								sliderZ:Dock(FILL)
								sliderZ:DockMargin(8,0,0,0)
								sliderZ:SetDecimals(4)
								sliderZ:SetMinMax(0.01, 10)
								sliderZ:SetValue(data.size.z)
								sliderZ:SetText("size.z")
								sliderZ:SetDark(true)
								function sliderZ:OnValueChanged(val)
									if UNIFORMSCALELOCK then return end
									
									data.size = Vector(data.size)
									data.size.z = val
									reInitializeElement(data)
								end

							settSizeZPanel:Dock(TOP)
							settSizeZPanel:SetBackgroundColor(darkBackground)
							settSizeZPanel:SizeToContents()
							
							function sliderXYZ:OnValueChanged(val)
								UNIFORMSCALELOCK = true
									sliderX:SetValue(val)
									sliderY:SetValue(val)
									sliderZ:SetValue(val)
								UNIFORMSCALELOCK = false
								
								data.size = Vector(val,val,val)
								reInitializeElement(data)							
							end
							
							if data.ent:SkinCount() > 1 then 
								local settSkinPanel = vgui.Create("DPanel", elementSettingPanel)
									
								local slider
								slider = vgui.Create("DNumSlider", settSkinPanel)
								slider:Dock(FILL)
								slider:DockMargin(8,0,0,0)
								slider:SetDecimals(0)
								slider:SetMinMax(0, data.ent:SkinCount() - 1)
								slider:SetValue(data.ent:GetSkin())
								slider:SetText("Skin")
								slider:SetDark(true)
								function slider:OnValueChanged(val)
									data.skin = val
									data.ent:SetSkin(val)
								end

								settSkinPanel:Dock(TOP)
								settSkinPanel:DockMargin(0,8,0,0)
								settSkinPanel:SetBackgroundColor(darkBackground)
								settSkinPanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 32
							end
							
							local bgSettings = false
							
							for i = 0, data.ent:GetNumBodyGroups() - 1 do
								bgSettings = bgSettings or (data.ent:GetBodygroupCount(i) - 1 > 0)
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
							
								for i = 0, data.ent:GetNumBodyGroups() - 1 do
									local bgCount = data.ent:GetBodygroupCount(i) - 1
									if bgCount > 0 then
										
										local settBodygroupPanel = vgui.Create("DPanel", elementSettingPanel)
											
											local slider
											slider = vgui.Create("DNumSlider", settBodygroupPanel)
											slider:Dock(FILL)
											slider:DockMargin(8,0,0,0)
											slider:SetDecimals(0)
											slider:SetMinMax(0, bgCount)
											slider:SetValue(data.ent:GetBodygroup(i))
											slider:SetText(i .. "# " .. data.ent:GetBodygroupName(i))
											slider:SetDark(true)
											function slider:OnValueChanged(val)
												local t = data.bodygroups
												data.bodygroups = {}
												if t then
													for k,v in pairs(t) do
														data.bodygroups[k] = v
													end
												end
												data.bodygroups[i] = val
												data.ent:SetBodygroup(i, val)
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
								
								cbox:SetValue(data.animated)
								function cbox:OnChange(val)
									data.animated = val
								end
						
							settAnimatedPanel:SetSize(200,16)
							settAnimatedPanel:Dock(TOP)
							settAnimatedPanel:DockMargin(8,8,0,0)
							settAnimatedPanel:SetBackgroundColor(noBackground)
							settAnimatedPanel:SizeToContents()
							
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
								local settAdjustmentTopPanel = vgui.Create("DPanel", elementSettingPanel)
									
									local settAdjustmentTopMinPanel = vgui.Create("DPanel", settAdjustmentTopPanel)
									
										local label
										label = vgui.Create("DLabel", settAdjustmentTopMinPanel)
										label:SetText("Min:")
										label:SetDark(true)
										label:Dock(LEFT)
										label:DockMargin(8,0,2,0)
										label:SizeToContents()
										
										local wang
										wang = vgui.Create("DNumberWang", settAdjustmentTopMinPanel)
										wang:Dock(FILL)
										wang:DockMargin(2,2,0,2)
										wang:SetMinMax(-100,100)
										wang:SetDecimals(4)
										wang:SetValue(data.adjustment.min)
										
										function wang:OnValueChanged(val)
											data.adjustment.min = val
										end
									
									settAdjustmentTopMinPanel:Dock(LEFT)
									settAdjustmentTopMinPanel:SetSize(120,24)
									settAdjustmentTopMinPanel:SetBackgroundColor(Color(255,255,0,255))
									settAdjustmentTopMinPanel:SizeToContents()
									
									local settAdjustmentTopMaxPanel = vgui.Create("DPanel", settAdjustmentTopPanel)
											
										local label
										label = vgui.Create("DLabel", settAdjustmentTopMaxPanel)
										label:SetText("Max:")
										label:SetDark(true)
										label:Dock(LEFT)
										label:DockMargin(0,0,2,0)
										label:SizeToContents()
										
										local wang
										wang = vgui.Create("DNumberWang", settAdjustmentTopMaxPanel)
										wang:Dock(FILL)
										wang:DockMargin(2,2,8,2)
										wang:SetMinMax(-100,100)
										wang:SetDecimals(4)
										wang:SetValue(data.adjustment.max)
										
										function wang:OnValueChanged(val)
											data.adjustment.max = val
										end
									
									settAdjustmentTopMaxPanel:Dock(RIGHT)
									settAdjustmentTopMaxPanel:SetSize(120,24)
									settAdjustmentTopMaxPanel:SetBackgroundColor(Color(255,0,255,255))
									-- settAdjustmentTopMaxPanel:SetPaintBackground(false)
									settAdjustmentTopMaxPanel:SizeToContents()
									
								settAdjustmentTopPanel:Dock(TOP)
								settAdjustmentTopPanel:SetBackgroundColor(darkBackground)
								settAdjustmentTopPanel:SizeToContents()
								
								local settAdjustmentBottomPanel = vgui.Create("DPanel", elementSettingPanel)
								
									local settAdjustmentBottomAxisPanel = vgui.Create("DPanel", settAdjustmentBottomPanel)
									
										-- local label
										-- label = vgui.Create("DLabel", settAdjustmentBottomAxisPanel)
										-- label:SetText("Axis:")
										-- label:SetDark(true)
										-- label:Dock(LEFT)
										-- label:DockMargin(8,0,2,0)
										-- label:SizeToContents()
										
										-- local box = vgui.Create("DComboBox", settAdjustmentBottomAxisPanel)
										-- box:Dock(FILL)
										-- box:DockMargin(2,2,0,2)
										-- box:SetValue(data.adjustment.axis)
										-- box:AddChoice("x")
										-- box:AddChoice("y")
										-- box:AddChoice("z")
										
										-- function box:OnSelect(i, name) 
											-- data.adjustment.axis = name
										-- end
									
										local ax = {x = 1, y = 2, z = 3}
										local xa = {"x", "y", "z"}
										
										local slider
										slider = vgui.Create("DNumSlider", settAdjustmentBottomAxisPanel)
										slider:Dock(FILL)
										slider:DockMargin(8,0,0,0)
										slider:SetDecimals(0)
										slider:SetMinMax(1,3)
										slider:SetValue(ax[data.adjustment.axis] or 1)
										slider:SetText("Axis: " .. (data.adjustment.axis or "x"))
										slider:SetDark(true)
										function slider:OnValueChanged(val)
											val = xa[math.Round(math.Clamp(val, 1, 3))]
											
											self:SetText("Axis: " .. val)
											data.adjustment.axis = val
										end
										
									settAdjustmentBottomAxisPanel:Dock(LEFT)
									settAdjustmentBottomAxisPanel:SetSize(120,24)
									settAdjustmentBottomAxisPanel:SetBackgroundColor(Color(255,0,0,255))
									settAdjustmentBottomAxisPanel:SizeToContents()
									
									local settAdjustmentBottomInvPanel = vgui.Create("DPanel", settAdjustmentBottomPanel)
									
										local cbox
										cbox = vgui.Create("DCheckBox", settAdjustmentBottomInvPanel)
										cbox:SetDark(true)
										-- cbox:Dock(LEFT)
										cbox:SetPos(0,3)
										cbox:SetSize(19,19)
										-- cbox:DockMargin(8,0,0,0)
										
										cbox:SetValue(data.adjustment.inverseOffsetCalc)
										function cbox:OnChange(val)
											data.adjustment.inverseOffsetCalc = val
										end
										
										local label
										label = vgui.Create("DLabel", settAdjustmentBottomInvPanel)
										label:SetText("Inverse calculation")
										label:SetDark(true)
										label:SetPos(23,5)
										label:DockMargin(8,0,2,0)
										label:SizeToContents()
										
									settAdjustmentBottomInvPanel:Dock(RIGHT)
									settAdjustmentBottomInvPanel:SetSize(120,24)
									settAdjustmentBottomInvPanel:SetBackgroundColor(Color(0,255,0,255))
									settAdjustmentBottomInvPanel:SizeToContents()
									
								settAdjustmentBottomPanel:Dock(TOP)
								settAdjustmentBottomPanel:SetBackgroundColor(darkBackground)
								settAdjustmentBottomPanel:SizeToContents()
								
								elementSettingPanelHeight = elementSettingPanelHeight + 48
							end
							
							local buttExportPanel = vgui.Create("DPanel", elementSettingPanel)
								
								local butt
								butt = vgui.Create("DButton", buttExportPanel)
								butt:SetTooltip("Copies current element table to your clipboard.")
								butt:Dock(FILL)
								butt:SetText("Export (copy to clipboard)")
								function butt:DoClick()
									
								end
		
							buttExportPanel:Dock(TOP)
							buttExportPanel:DockMargin(0,8,0,0)
							buttExportPanel:SetBackgroundColor(noBackground)
							buttExportPanel:SizeToContents()
							
							local buttRestorePanel = vgui.Create("DPanel", elementSettingPanel)
									
								local butt
								butt = vgui.Create("DButton", buttRestorePanel)
								butt:SetTooltip("Wipes your changes from this element.")
								butt:Dock(FILL)
								butt:SetText("Restore from weapon.lua")
								function butt:DoClick()
									local origData = weapons.GetStored(WEAPON:GetClass())[t][key]
									
									data.pos = origData.pos
									data.angle = origData.angle
									data.size = origData.size
									data.merge = origData.merge
									data.bone = origData.bone
									data.attachment = origData.attachment
									data.skin = origData.skin
									data.bodygroups = origData.bodygroups
									
									reInitializeElement(data)
									updatePanel()
								end
			
							buttRestorePanel:Dock(TOP)
							buttRestorePanel:DockMargin(0,8,0,0)
							buttRestorePanel:SetBackgroundColor(noBackground)
							buttRestorePanel:SizeToContents()
							
						elementSettingPanel:SetSize(0, 536 + elementSettingPanelHeight)
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

function KK_SCK_VELEMENTS_Think()
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
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_VELEMENTS", "VElements", "", "", function(panel)
		PANEL = panel
		updatePanel()
		
		hook.Add("Think", "KK_SCK_VELEMENTS_Think", KK_SCK_VELEMENTS_Think)
	end)
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_VELEMENTS_Remove", function()
	hook.Remove("Think", "KK_SCK_VELEMENTS_Think")
end)

RunConsoleCommand("spawnmenu_reload")
