AddCSLuaFile()

local CURMODELLABEL, BOX, BUTT
local MODEL

local function apply()
	local ent = LocalPlayer()
	if !IsValid(ent) then return end
	
	local ent = ply:GetHands()
	if !IsValid(ent) then return end
	
	ent:SetModel(MODEL)
end

local knownRigs = {
	"models/weapons/c_arms_chell.mdl",
	"models/weapons/c_arms_citizen.mdl",
	"models/weapons/c_arms_combine.mdl",
	"models/weapons/c_arms_cstrike.mdl",
	"models/weapons/c_arms_dod.mdl",
	"models/weapons/c_arms_hev.mdl",
	"models/weapons/c_arms_refugee.mdl",
}

local function buildPanel(panel)
	panel:ClearControls()

	CURMODELLABEL = panel:AddControl("Label", {Text = "kekekek:"})
	CURMODELLABEL:DockMargin(8, 0, 8, 0)

	local left = vgui.Create("DLabel", panel)
	left:SetText("Custom Model:")
	left:SetDark(true)
	left:DockMargin(8, 0, 0, 0)
	
	BOX = vgui.Create("DTextEntry", panel)
	BOX:Dock(TOP)
	BOX:DockMargin(0, 0, 8, 0)
	function BOX:OnEnter() MODEL = self:GetValue() apply() end
	panel:AddItem(left, BOX)
	
	BUTT = vgui.Create("DButton", panel)
	BUTT:SetText("(Re-) Apply")
	BUTT:DockMargin(8, 0, 8, 0)
	BUTT.DoClick = apply
	panel:AddItem(BUTT)
	
	header2 = panel:AddControl("Label", {Text = "Some rigs:"})
	header2:DockMargin(8, 0, 8, 0)

	local knownRig
	
	for k,v in pairs(knownRigs) do
		knownRig = panel:AddControl("Label", {Text = v})
		knownRig:DockMargin(16, 0, 8, 8)
		
		function knownRig:DoClick()
			BOX:SetValue(v)
			BOX:OnEnter()
		end
	end
		
	hook.Add("Think", "KK_SCK_CHCTRL", function()
		BUTT:SetEnabled(MODEL)
			
		local ent = LocalPlayer()
		if !IsValid(ent) then return end
		
		local ent = ply:GetHands()
		if !IsValid(ent) then return end
		
		CURMODELLABEL:SetText("Current Model: " .. ent:GetModel())
	end)
end

hook.Add("PopulateToolMenu", "KK_SCK_CHCTRL", function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_CHCTRL", "C-Hands Controller", "", "", buildPanel)
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_CHCTRL", function()
	hook.Remove("Think", "KK_SCK_CHCTRL")
end)

-- RunConsoleCommand("spawnmenu_reload")
