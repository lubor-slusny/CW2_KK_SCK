
local TOOL = {}

TOOL.Name = "bonemods"
TOOL.PrintName = "Bonemod Editor (v0.3)"

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()

	if !IsValid(wep) or !wep.CW20Weapon then
		panel:AddControl("Label", {Text = "Not a CW2 swep, move along."})
		return
	end
	
	-- panel:AddControl("Label", {Text = "SWEP.ForegripOverride tickbox"})
	panel:AddControl("CheckBox", {Label = "SWEP.ForegripOverride", Command = ""})
	
	// if not SWEP.ForegripOverride return end
	
	panel:AddControl("Label", {Text = "[wipe all][reload all] buttons"})
	
	-- panel:AddControl("Label", {Text = "SWEP.ForegripOverridePos.new text entry"})
	panel:AddControl("TextBox", {Label = "new parent", Command = "", WaitForEnter = "1"})
	
	panel:AddControl("Label", {Text = "SWEP.ForegripParent selector"})
	
	panel:AddControl("Label", {Text = "[wipe key][reload key] buttons"})
	
	panel:AddControl("Label", {Text = "bone name selector"}) // list all VM bones, setup vectors from SWEP
	
	panel:AddControl("Label", {Text = "[wipe][reload] buttons"})
	
	-- panel:AddControl("Label", {Text = "6sliders"}) // pos xyz, ang pyr
	panel:AddControl("Slider", {
		Label = "pos.x",
		Type = "Float",
		Min = "-100",
		Max = "100",
		Command = ""
	})
	
	panel:AddControl("Slider", {
		Label = "pos.y",
		Type = "Float",
		Min = "-100",
		Max = "100",
		Command = ""
	})
	
	panel:AddControl("Slider", {
		Label = "pos.z",
		Type = "Float",
		Min = "-100",
		Max = "100",
		Command = ""
	})
	
	panel:AddControl("Slider", {
		Label = "ang.p",
		Type = "Float",
		Min = "-180",
		Max = "180",
		Command = ""
	})
	
	panel:AddControl("Slider", {
		Label = "ang.y",
		Type = "Float",
		Min = "-180",
		Max = "180",
		Command = ""
	})
	
	panel:AddControl("Slider", {
		Label = "ang.r",
		Type = "Float",
		Min = "-180",
		Max = "180",
		Command = ""
	})
	
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
