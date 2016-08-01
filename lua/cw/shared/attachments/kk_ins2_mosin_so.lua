local att = {}
att.name = "kk_ins2_mosin_so"
att.displayNameShort = "SawnOff"
att.displayName = "CQC Variant"
att.isBG = true
att.KK_INS2_playIdle = true
att.WeaponLength = -18

att.statModifiers = {
	AimSpreadMult = 0.1,
	DrawSpeedMult = 0.05,
	VelocitySensitivityMult = 0.2,
	OverallMouseSensMult = 0.1,
	DamageMult = 0.1,
	RecoilMult = 0.2,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

function att:attachFunc()
	if CLIENT then
		self.AttachmentModelsVM.cw_menu_muzzle._bone = 52
		
		self.CW_VM:SetModel("models/weapons/v_cw_kk_ins2_mosin_so.mdl")
		self.WMEnt:SetModel("models/weapons/w_cw_kk_ins2_mosin_so.mdl")
	end
	
	self.WorldModel = "models/weapons/w_cw_kk_ins2_mosin_so.mdl"
end

function att:detachFunc()
	if CLIENT then
		self.AttachmentModelsVM.cw_menu_muzzle._bone = 57
		
		self.CW_VM:SetModel("models/weapons/v_mosin.mdl")
		self.WMEnt:SetModel("models/weapons/w_mosin.mdl")
	end
	
	self.WorldModel = "models/weapons/w_mosin.mdl"
end

if CLIENT then
	CustomizableWeaponry:createStatText(att)
end

CustomizableWeaponry:registerAttachment(att)
