AddCSLuaFile()

local CVMT = {
	SLIDERS = {},
	LABELS = {},
}

local function buildPanel(panel)
	panel:ClearControls()

	CVMT.LABELS.cvmtHeader = panel:AddControl("Label", {Text = "Spy`s CVMT:"})
	CVMT.LABELS.cvmtHeader:DockMargin(0, 0, 0, 0)

	panel:AddControl("CheckBox", {Label = "Enable HUD elements", Command = "cvmt_enabled"}):DockMargin(8, 0, 8, 8)
	panel:AddControl("CheckBox", {Label = "Show anim list", Command = "cvmt_animlist"}):DockMargin(8, 0, 8, 8)
	
	CVMT.SLIDERS["cvmt_cycle"] = vgui.Create("DNumSlider", panel)
	CVMT.SLIDERS["cvmt_cycle"]:DockMargin(8, 0, 8, 8)
	CVMT.SLIDERS["cvmt_cycle"]:SetDecimals(4)
	CVMT.SLIDERS["cvmt_cycle"]:SetMinMax(0, 1)
	CVMT.SLIDERS["cvmt_cycle"]:SetValue(1)
	CVMT.SLIDERS["cvmt_cycle"]:SetText("Set cycle")
	CVMT.SLIDERS["cvmt_cycle"]:SetDark(true)
	panel:AddItem(CVMT.SLIDERS["cvmt_cycle"])

	CVMT.SLIDERS["cvmt_pbr"] = vgui.Create("DNumSlider", panel)
	CVMT.SLIDERS["cvmt_pbr"]:DockMargin(8, 0, 8, 8)
	CVMT.SLIDERS["cvmt_pbr"]:SetDecimals(4)
	CVMT.SLIDERS["cvmt_pbr"]:SetMinMax(-5, 5)
	CVMT.SLIDERS["cvmt_pbr"]:SetValue(1)
	CVMT.SLIDERS["cvmt_pbr"]:SetText("Set playback rate")
	CVMT.SLIDERS["cvmt_pbr"]:SetDark(true)
	panel:AddItem(CVMT.SLIDERS["cvmt_pbr"])

	CVMT.SLIDERS["cvmt_cycle"].OnValueChanged = function(slider, val)
		CVMT.SLIDERS["cvmt_pbr"]:SetValue(0)
		RunConsoleCommand("cvmt_setcycle", val)
		RunConsoleCommand("cvmt_setplaybackrate", 0)
	end
			
	CVMT.SLIDERS["cvmt_pbr"].OnValueChanged = function(slider, val)
		RunConsoleCommand("cvmt_setplaybackrate", val)
	end
	
	local left = vgui.Create("DLabel", panel)
	left:SetText("Play anim:")
	left:SetDark(true)
	left:DockMargin(8, 0, 8, 8)
	local right = vgui.Create("DTextEntry", panel)
	right:SetConVar("cvmt_playanim_freeze")
	right:Dock(TOP)
	panel:AddItem(left, right)
	
	local left = vgui.Create("DLabel", panel)
	left:SetText("Play anim:")
	left:SetDark(true)
	left:DockMargin(8, 0, 8, 8)
	local right = vgui.Create("DTextEntry", panel)
	right:SetConVar("cvmt_playanim_freeze")
	right:Dock(TOP)
	panel:AddItem(left, right)
	
	CVMT.LABELS.cvmtHeader2 = panel:AddControl("Label", {Text = "Complete list of CVMT ConCommands:"})
	CVMT.LABELS.cvmtHeader2:DockMargin(8, 16, 8, 8)
	
	CVMT.LABELS.cvmtFuncList = panel:AddControl("Label", {Text = "cvmt_freeze\ncvmt_setcycle\ncvmt_seek\ncvmt_setplaybackrate\ncvmt_playanim\ncvmt_playanim_freeze\n"})
	CVMT.LABELS.cvmtFuncList:DockMargin(16, 0, 8, 8)
end

hook.Add("PopulateToolMenu", "KK_SCK_CVMT", function()
	if GetConVarNumber("cw_kk_dev_menu") != 0 then
		spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_CVMT", "CVMT Panel", "", "", buildPanel)
	end
end)

// DELETE BELOW // debug code
RunConsoleCommand("spawnmenu_reload")
