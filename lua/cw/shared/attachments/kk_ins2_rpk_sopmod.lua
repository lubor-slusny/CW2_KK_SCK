local att = {}
att.name = "kk_ins2_rpk_sopmod"
att.displayName = "Tacticool RPK Mod"
att.displayNameShort = "SOPMOD"
att.isBG = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	AimSpreadMult = 1,
	DrawSpeedMult = 0.05,
	VelocitySensitivityMult = -0.3,
	OverallMouseSensMult = -0.1,
	DamageMult = 0.1,
	RecoilMult = -0.2,
	FireDelayMult = -0.071
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

function att:attachFunc()
	if CLIENT then
		self.CW_VM:SetModel("models/weapons/v_cw_kk_ins2_rpk_tac.mdl")
		self.WMEnt:SetModel("models/weapons/w_cw_kk_ins2_rpk_tac.mdl")
	end
	
	self.WorldModel = "models/weapons/w_cw_kk_ins2_rpk_tac.mdl"
end

function att:detachFunc()
	if CLIENT then
		self.CW_VM:SetModel("models/weapons/v_rpk.mdl")
		self.WMEnt:SetModel("models/weapons/w_rpk.mdl")
	end
	
	self.WorldModel = "models/weapons/w_rpk.mdl"
end

CustomizableWeaponry:registerAttachment(att)
