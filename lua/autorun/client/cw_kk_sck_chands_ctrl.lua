AddCSLuaFile()

local MODEL

local function apply()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
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

local insRigs = {
	"models/weapons/v_hands_ins_h.mdl",
	"models/weapons/v_hands_ins_m.mdl",
	"models/weapons/v_hands_ins_l.mdl",
	"models/weapons/v_hands_sec_h.mdl",
	"models/weapons/v_hands_sec_m.mdl",
	"models/weapons/v_hands_sec_l.mdl",
	"models/weapons/v_hands_vip.mdl",
	"models/weapons/v_cw_kk_ins2_hands_css.mdl",
}

local function buildPanel(panel)
	panel:ClearControls()

	local curMDLLabel = panel:AddControl("Label", {Text = "kekekek:"})
	curMDLLabel:SetMouseInputEnabled(true)
	function curMDLLabel:DoClick() SetClipboardText(self.KKMDLNAEM) end
	curMDLLabel:DockMargin(8, 0, 8, 0)

	local left = vgui.Create("DLabel", panel)
	left:SetText("Custom Model:")
	left:SetDark(true)
	left:DockMargin(8, 0, 0, 0)
	
	local box = vgui.Create("DTextEntry", panel)
	box:Dock(TOP)
	box:DockMargin(0, 0, 8, 0)
	function box:OnEnter() MODEL = self:GetValue() apply() end
	panel:AddItem(left, box)
	
	local butt = vgui.Create("DButton", panel)
	butt:SetText("(Re-) Apply")
	butt:DockMargin(8, 0, 8, 0)
	butt.DoClick = apply
	panel:AddItem(butt)
	
	hook.Add("Think", "KK_SCK_CHCTRL", function()
		butt:SetEnabled(MODEL)
			
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local ent = ply:GetHands()
		if !IsValid(ent) then return end
		
		curMDLLabel:SetText("Current Model: " .. ent:GetModel())
		curMDLLabel.KKMDLNAEM = ent:GetModel()
	end)
	
	local butt = vgui.Create("DButton", panel)
	butt:SetText("Reset VM Idle (for SCK)")
	butt:DockMargin(8, 0, 8, 0)
	butt.DoClick = function()
		local seqId = "idle"
		local ent = LocalPlayer():GetViewModel()
		
		ent:SetPlaybackRate(1)
		ent:ResetSequence(seqId)
		ent:SetCycle(0)
	end
	panel:AddItem(butt)
	
	header2 = panel:AddControl("Label", {Text = "Some GM rigs:"})
	header2:DockMargin(8, 0, 8, 0)

	local knownRig
	
	for k,v in pairs(knownRigs) do
		knownRig = panel:AddControl("Label", {Text = v})
		knownRig:DockMargin(16, 0, 8, 8)
		
		function knownRig:DoClick()
			box:SetValue(v)
			box:OnEnter()
		end
	end
	
	header3 = panel:AddControl("Label", {Text = "Some INS2 rigs:"})
	header3:DockMargin(8, 0, 8, 0)

	for k,v in pairs(insRigs) do
		knownRig = panel:AddControl("Label", {Text = v})
		knownRig:DockMargin(16, 0, 8, 8)
		
		function knownRig:DoClick()
			box:SetValue(v)
			box:OnEnter()
		end
	end
	
end

hook.Add("PopulateToolMenu", "KK_SCK_CHCTRL", function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_CHCTRL", "C-Hands Model Test", "", "", buildPanel)
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_CHCTRL", function()
	hook.Remove("Think", "KK_SCK_CHCTRL")
end)

-- RunConsoleCommand("spawnmenu_reload")
