AddCSLuaFile()

local PANEL, WEAPON

local elementTables = {
	"AttachmentModelsVM",
	"AttachmentModelsWM",
	"WElements",
}

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
		v:SetSkin(data.skin)
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

local transBackground = Color(0,0,0,0)

local function cloneAngle(ang)
	return Angle(ang.p, ang.y, ang.r)
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
	
	if !IsValid(WEAPON) then return end
	if not WEAPON.CW20Weapon then return end
	
	for _,t in pairs(elementTables) do
		if WEAPON[t] then
			PANEL:AddControl("Label", {Text = "SWEP." .. t .. ":"})
			
			for key,data in pairs(WEAPON[t]) do
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
					
					local function updateTitle()
						data._kksck_expanded = !data._kksck_expanded
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
				
				if data._kksck_expanded then
					local elementSettingPanel = vgui.Create("DPanel", PANEL)

						local settActivePanel = vgui.Create("DPanel", elementSettingPanel)

							local cbox
							cbox = vgui.Create("DCheckBoxLabel", settActivePanel)
							cbox:SetText("Active")
							cbox:SetTooltip("does stuff.")
							cbox:SetDark(true)
							cbox:Dock(FILL)
							
							cbox:SetValue(data.active)
							function cbox:OnChange(val)
								data.active = val
								updatePanel()
							end
					
						settActivePanel:Dock(TOP)
						settActivePanel:SetSize(200,16)
						settActivePanel:SetBackgroundColor(transBackground)
						settActivePanel:SizeToContents()
						
						local settModelPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local label
							label = vgui.Create("DLabel", settModelPanel)
							label:SetText("Model:")
							label:SetDark(true)
							label:Dock(LEFT)
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
						settModelPanel:SetBackgroundColor(transBackground)
						settModelPanel:SizeToContents()
						
						local settPosXPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settPosXPanel)
							slider:Dock(TOP)
							slider:SetDecimals(4)
							slider:SetMinMax(-100, 100)
							slider:SetValue(data.pos.x)
							slider:SetText("Pos.x")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								data.pos = Vector(data.pos) // garbage gen, but doesnt mess up stored weapon classes
								data.pos.x = val
							end

						settPosXPanel:Dock(TOP)
						settPosXPanel:DockMargin(0,4,0,0)
						settPosXPanel:SetBackgroundColor(transBackground)
						settPosXPanel:SizeToContents()
						
						local settPosYPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settPosYPanel)
							slider:Dock(TOP)
							slider:SetDecimals(4)
							slider:SetMinMax(-100, 100)
							slider:SetValue(data.pos.y)
							slider:SetText("Pos.y")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								data.pos = Vector(data.pos)
								data.pos.y = val
							end

						settPosYPanel:Dock(TOP)
						settPosYPanel:DockMargin(0,8,0,0)
						settPosYPanel:SetBackgroundColor(transBackground)
						settPosYPanel:SizeToContents()
						
						local settPosZPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settPosZPanel)
							slider:Dock(TOP)
							slider:SetDecimals(4)
							slider:SetMinMax(-100, 100)
							slider:SetValue(data.pos.z)
							slider:SetText("Pos.z")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								data.pos = Vector(data.pos)
								data.pos.z = val
							end

						settPosZPanel:Dock(TOP)
						settPosZPanel:DockMargin(0,8,0,0)
						settPosZPanel:SetBackgroundColor(transBackground)
						settPosZPanel:SizeToContents()
						
						local settAngPPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settAngPPanel)
							slider:Dock(TOP)
							slider:SetDecimals(4)
							slider:SetMinMax(-180, 180)
							slider:SetValue(data.angle.p)
							slider:SetText("Ang.p")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								data.angle = cloneAngle(data.angle)
								data.angle.p = val
							end

						settAngPPanel:Dock(TOP)
						settAngPPanel:DockMargin(0,8,0,0)
						settAngPPanel:SetBackgroundColor(transBackground)
						settAngPPanel:SizeToContents()
						
						local settAngYPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settAngYPanel)
							slider:Dock(TOP)
							slider:SetDecimals(4)
							slider:SetMinMax(-180, 180)
							slider:SetValue(data.angle.y)
							slider:SetText("Ang.y")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								data.angle = cloneAngle(data.angle)
								data.angle.y = val
							end

						settAngYPanel:Dock(TOP)
						settAngYPanel:DockMargin(0,8,0,0)
						settAngYPanel:SetBackgroundColor(transBackground)
						settAngYPanel:SizeToContents()
						
						local settAngRPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settAngRPanel)
							slider:Dock(TOP)
							slider:SetDecimals(4)
							slider:SetMinMax(-180, 180)
							slider:SetValue(data.angle.r)
							slider:SetText("Ang.r")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								data.angle = cloneAngle(data.angle)
								data.angle.r = val
							end

						settAngRPanel:Dock(TOP)
						settAngRPanel:DockMargin(0,8,0,0)
						settAngRPanel:SetBackgroundColor(transBackground)
						settAngRPanel:SizeToContents()
						
						local settSizeXPanel = vgui.Create("DPanel", elementSettingPanel)
							
							local slider
							slider = vgui.Create("DNumSlider", settSizeXPanel)
							slider:Dock(TOP)
							slider:SetDecimals(4)
							slider:SetMinMax(0.01, 10)
							slider:SetValue(data.size.x)
							slider:SetText("Size.xyz")
							slider:SetDark(true)
							function slider:OnValueChanged(val)
								data.size = Vector(data.size)
								data.size.x = val
								data.size.y = val
								data.size.z = val
								reInitializeElement(data)
							end

						settSizeXPanel:Dock(TOP)
						settSizeXPanel:DockMargin(0,8,0,0)
						settSizeXPanel:SetBackgroundColor(transBackground)
						settSizeXPanel:SizeToContents()
						
						local butt
						butt = vgui.Create("DButton", elementSettingPanel)
						butt:SetTooltip("Wipes your changes from this element.")
						butt:Dock(BOTTOM)
						butt:SetText("Restore from weapon.lua")
						function butt:DoClick()
							local origData = weapons.GetStored(WEAPON:GetClass())[t][key]
							
							data.model = origData.model
							data.pos = origData.pos
							data.angle = origData.angle
							data.size = origData.size
							
							reInitializeElement(data)
							updatePanel()
						end
	
					elementSettingPanel:SetSize(0,400)
					elementSettingPanel:DockPadding(8,8,8,8)
					elementSettingPanel:DockMargin(0,0,0,0)
					elementSettingPanel:SizeToContents()
					PANEL:AddItem(elementSettingPanel)			
				end
			end
		end
	end
	
	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:SetTooltip("Collapses all elements.")
	butt:DockMargin(0, 0, 0, 8)	
	butt:SetText("Collapse All")
	function butt:DoClick()
		collapseAll()
		updatePanel()
	end
	PANEL:AddItem(butt)
end

local _LAST_WEP

function KK_SCK_VELEMENTS_Think()
	WEAPON = LocalPlayer():GetActiveWeapon()
	
	if WEAPON != _LAST_WEP then 
		updatePanel()
	end
	
	_LAST_WEP = WEAPON
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
