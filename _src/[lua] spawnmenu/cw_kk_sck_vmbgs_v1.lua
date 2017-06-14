CreateClientConVar( "kk_scke_bg_01", "0", false, false )
CreateClientConVar( "kk_scke_bg_02", "0", false, false )
CreateClientConVar( "kk_scke_bg_03", "0", false, false )
CreateClientConVar( "kk_scke_bg_04", "0", false, false )
CreateClientConVar( "kk_scke_bg_05", "0", false, false )
CreateClientConVar( "kk_scke_bg_06", "0", false, false )
CreateClientConVar( "kk_scke_bg_07", "0", false, false )
CreateClientConVar( "kk_scke_bg_08", "0", false, false )
CreateClientConVar( "kk_scke_bg_09", "0", false, false )
CreateClientConVar( "kk_scke_bg_10", "0", false, false )
CreateClientConVar( "kk_scke_skin", "0", false, false )

CreateClientConVar( "kk_scke_sq_id", "reload", false, false )
CreateClientConVar( "kk_scke_sq_rate", "0", false, false )
CreateClientConVar( "kk_scke_sq_cycle", "0", false, false )

local function setSQId(...)
	local vm = LocalPlayer():GetViewModel()
	
	vm:ResetSequence(vm:LookupSequence(GetConVarString("kk_scke_sq_id")))
	vm:SetPlaybackRate(GetConVarNumber("kk_scke_sq_rate"))
	vm:SetCycle(GetConVarNumber("kk_scke_sq_cycle"))
end

local function setBGs()
	local vm = LocalPlayer():GetViewModel()
	
	vm:SetSkin(GetConVarNumber("kk_scke_skin"))
	vm:SetBodygroup(1,GetConVarNumber("kk_scke_bg_01"))
	vm:SetBodygroup(2,GetConVarNumber("kk_scke_bg_02"))
	vm:SetBodygroup(3,GetConVarNumber("kk_scke_bg_03"))
	vm:SetBodygroup(4,GetConVarNumber("kk_scke_bg_04"))
	vm:SetBodygroup(5,GetConVarNumber("kk_scke_bg_05"))
	vm:SetBodygroup(6,GetConVarNumber("kk_scke_bg_06"))
	vm:SetBodygroup(7,GetConVarNumber("kk_scke_bg_07"))
	vm:SetBodygroup(8,GetConVarNumber("kk_scke_bg_08"))
	vm:SetBodygroup(9,GetConVarNumber("kk_scke_bg_09"))
	vm:SetBodygroup(10,GetConVarNumber("kk_scke_bg_10"))
end

local function createSlider(Panel, Name, Convar)
	slider = vgui.Create("DNumSlider", Panel)
	slider:SetDecimals(0)
	slider:SetMin(0)
	slider:SetMax(10)
	slider:SetConVar(Convar)
	slider:SetValue(GetConVarNumber(Convar))
	slider:SetText(Name)
	slider:SetDark(true)
	slider.OnValueChanged = setBGs
	Panel:AddItem(slider)
end

local function SCKVMBG( Panel )
	Panel:ClearControls()
	
	Panel:AddControl("Label", {Text = "LocalPlayer():GetViewModel()"})
	
	Panel:AddControl("Label", {Text = "Skins"})
	createSlider(Panel, "skin (x):", "kk_scke_skin")
	
	Panel:AddControl("Label", {Text = "Bodygroups"})
	createSlider(Panel, "bg (1,x):", "kk_scke_bg_01")
	createSlider(Panel, "bg (2,x):", "kk_scke_bg_02")
	createSlider(Panel, "bg (3,x):", "kk_scke_bg_03")
	createSlider(Panel, "bg (4,x):", "kk_scke_bg_04")
	createSlider(Panel, "bg (5,x):", "kk_scke_bg_05")
	createSlider(Panel, "bg (6,x):", "kk_scke_bg_06")
	createSlider(Panel, "bg (7,x):", "kk_scke_bg_07")
	createSlider(Panel, "bg (8,x):", "kk_scke_bg_08")
	createSlider(Panel, "bg (9,x):", "kk_scke_bg_09")
	createSlider(Panel, "bg (10,x):", "kk_scke_bg_10")
	
	-- Panel:AddControl("Button", {Label = "Apply Bodygroup Settings", Command = "kk_scke_bg_apply"})
	
	Panel:AddControl("Label", {Text = "Animations"})
	
	-- slider = vgui.Create("DNumSlider", Panel)
	-- slider:SetDecimals(0)
	-- slider:SetMin(0)
	-- slider:SetMax(20)
	-- slider:SetConVar("kk_scke_sq_id")
	-- slider:SetValue(GetConVarNumber("kk_scke_sq_id"))
	-- slider:SetText("sequence id")
	-- Panel:AddItem(slider)
	
	Panel:AddControl( "TextBox",	{ Label = "sequence id", Command = "kk_scke_sq_apply", WaitForEnter = "1" } )
	
	slider = vgui.Create("DNumSlider", Panel)
	slider:SetDecimals(3)
	slider:SetMin(0)
	slider:SetMax(1)
	slider:SetConVar("kk_scke_sq_cycle")
	slider:SetValue(GetConVarNumber("kk_scke_sq_cycle"))
	slider:SetText("cycle")
	slider.OnValueChanged = setSQId
	Panel:AddItem(slider)
	
	Panel:AddControl("Button", {Label = "FUCKSHITFUCKFUCK", Command = "kk_scke_sq_apply"})
end

local function PopulateMyMenu_SCKVMBG()
	spawnmenu.AddToolMenuOption( 
		"Utilities", 
		"Knife Kitty", 
		"SCK VM Bodygroups", 
		"SCK VM Bodygroups", 
		"", 
		"", -- Resource File( Probably shouldn't use )
		SCKVMBG 
	)
end

hook.Add( "PopulateToolMenu", "PopulateMyMenu_SCKVMBG", PopulateMyMenu_SCKVMBG )

concommand.Add( "kk_scke_bg_apply", setBGs)
concommand.Add( "kk_scke_sq_apply", setSQId)
