if not CustomizableWeaponry_KK.HOME then return end

local TOOL = {}

TOOL.Name = "altpos"
TOOL.PrintName = "AltPos Builder"
TOOL.Version = "0.9"

function TOOL:_addSectionWipeReload(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local listView = vgui.Create("DListView", backgroundPanel)
		listView:SetHeaderHeight(20)
		listView:AddColumn("Wipe")
		listView:AddColumn("Reload")
		
		listView:Dock(FILL)
		listView:SizeToContents()
		listView:SetPaintBackground(false)
		listView:FixColumnsLayout()
		listView.OnRequestResize = function() end
		
		function listView:SortByColumn(i)
			TOOL:ThrowNewNotImplemented()
			
			// wipe
			if (i == 1) then
				return
			end
			
			// reload
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
end

function TOOL:_addSectionSliders(panel, wep)
	for _,s in pairs({
		{"Pos", "x", -50, 50},
		{"Pos", "y", -50, 50},
		{"Pos", "z", -50, 50},
		{"Ang", "p", -90, 90},
		{"Ang", "y", -180, 180},
		{"Ang", "r", -180, 180},
	}) do 
		local slider = vgui.Create("DNumSlider", panel)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(4)
		slider:SetMinMax(s[3], s[4])
		slider:SetValue(0)
		slider:SetText(s[1] .. "." .. s[2])
		slider:SetDark(true)
		
		self:LoadSliderZoom(slider)
		
		function slider:OnValueChanged(val)
			TOOL:SaveSliderZoom(self)
		end

		panel:AddItem(slider)
	end
end

function TOOL:_addSectionPreviewExport(panel, wep)
	local backgroundPanel = vgui.Create("DPanel", panel)
	panel:AddItem(backgroundPanel)
		
		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(0,2,0,2)
		label:SizeToContents()
		label:SetText(
			"SWEP.AlternativePos = " .. 
			self:VectorToString(wep.AlternativePos)
		)
		
		local label
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetDark(true)
		label:Dock(TOP)
		label:DockMargin(0,0,0,2)
		label:SizeToContents()

		label:SetText(
			"SWEP.AlternativeAng = " .. 
			self:VectorToString(wep.AlternativeAng)
		)
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:DockPadding(8,0,8,0)
	-- backgroundPanel:SetSize(200,34)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
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
	
	local cbox = panel:AddControl("CheckBox", {Label = "Custom weapon origins? (shortcut)", Command = "cw_alternative_vm_pos"})
	cbox:DockMargin(8,0,8,0)
	
	self:_addSectionWipeReload(panel, wep)
	self:_addSectionSliders(panel, wep)
	self:_addSectionPreviewExport(panel, wep)
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
