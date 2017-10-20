AddCSLuaFile()

local TOOL = {}

TOOL.Name = "chandsmdltest"
TOOL.PrintName = "C-Hands Model Test"
TOOL.Version = "1.1"

TOOL.gmodRigs = {
	"models/weapons/c_arms_chell.mdl",
	"models/weapons/c_arms_citizen.mdl",
	"models/weapons/c_arms_combine.mdl",
	"models/weapons/c_arms_cstrike.mdl",
	"models/weapons/c_arms_dod.mdl",
	"models/weapons/c_arms_hev.mdl",
	"models/weapons/c_arms_refugee.mdl",
}

TOOL.insRigs = {
	"models/weapons/v_hands_vip.mdl",
	"models/weapons/v_hands_ins_h.mdl",
	"models/weapons/v_hands_ins_m.mdl",
	"models/weapons/v_hands_ins_l.mdl",
	"models/weapons/v_hands_sec_h.mdl",
	"models/weapons/v_hands_sec_m.mdl",
	"models/weapons/v_hands_sec_l.mdl",
}

function TOOL:_apply()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	local ent = ply:GetHands()
	if !IsValid(ent) then return end

	ent:SetModel(TOOL.model)
end

local label, butt, box

function TOOL:_updatePanel(panel)
	local panel = self._panel

	if !IsValid(panel) then return end

	panel:ClearControls()

	self:AddHeaderSimpleLR(panel, "Current model:")

	label = panel:AddControl("Label", {Text = "kekekek:"})
	label:DockMargin(8, 0, 8, 0)
	label:SetMouseInputEnabled(true)
	label.DoClick = function(self) SetClipboardText(self:GetText()) end
	self._curMDLLabel = label

	self:AddHeaderSimpleLR(panel, "Custom model:")

	box = vgui.Create("DTextEntry", panel)
	box:Dock(TOP)
	box:DockMargin(8, 0, 8, 0)
	box.OnEnter = function(self)
		TOOL.model = self:GetValue()
		TOOL:_apply()
	end
	panel:AddItem(box)

	butt = vgui.Create("DButton", panel)
	butt:SetText("(Re-) Apply")
	butt:DockMargin(8, 0, 8, 0)
	butt.DoClick = function() TOOL:_apply() end
	panel:AddItem(butt)
	self._reApplyButt = butt

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

	self:AddHeaderSimpleLR(panel, "Some GM rigs:", "[LMB - SET]")

	for k,v in pairs(self.gmodRigs) do
		label = panel:AddControl("Label", {Text = v})
		label:DockMargin(8, 0, 8, 8)

		function label:DoClick()
			box:SetValue(v)
			box:OnEnter()
		end
	end

	self:AddHeaderSimpleLR(panel, "Some INS2 rigs:", "[LMB - SET]")

	for k,v in pairs(self.insRigs) do
		label = panel:AddControl("Label", {Text = v})
		label:DockMargin(8, 0, 8, 8)

		function label:DoClick()
			box:SetValue(v)
			box:OnEnter()
		end
	end
end

function TOOL:Think()
	local panel = self._panel

	if !IsValid(panel) then return end

	self._reApplyButt:SetEnabled(self.model != nil)

	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	local ent = ply:GetHands()
	if !IsValid(ent) then return end

	self._curMDLLabel:SetText(ent:GetModel())
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

function TOOL:OnWeaponChanged()
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
