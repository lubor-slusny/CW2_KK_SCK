local att = {}
att.name = "kk_ins2_cstm_scar_skin"
att.displayName = "Tan $CAR-H Finish"
att.displayNameShort = "Tan"
att.isBG = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	RecoilMult = -0.2
}

att.activeVM = "models/weapons/v_cw_kk_ins2_cstm_scar_tan.mdl"
att.activeWM = "models/weapons/w_cw_kk_ins2_cstm_scar_tan.mdl"
att.origVM = "models/weapons/v_cw_kk_ins2_cstm_scar.mdl"
att.origWM = "models/weapons/w_cw_kk_ins2_cstm_scar.mdl"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Ever played Payday 2?.", c = CustomizableWeaponry.textColors.NEUTRAL},
		[2] = {t = "Retextures alter stats.", c = CustomizableWeaponry.textColors.VNEGATIVE},
	}
end

function att:attachFunc()
	if CLIENT then
		self.CW_VM:SetModel(att.activeVM)
	end
	
	self.WorldModel = att.activeWM
end

function att:detachFunc()
	if CLIENT then
		self.CW_VM:SetModel(att.origVM)
	end
	
	self.WorldModel = att.origWM
end

CustomizableWeaponry:registerAttachment(att)
