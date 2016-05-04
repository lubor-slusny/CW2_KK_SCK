local att = {}
att.name = "kk_ins2_cstm_scar_skin"
att.displayName = "Tan SCARH Finish"
att.displayNameShort = "Tan"
att.isBG = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	RecoilMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Ever played Payday 2?.", c = CustomizableWeaponry.textColors.NEUTRAL},
		[2] = {t = "Retextures alter stats.", c = CustomizableWeaponry.textColors.VNEGATIVE},
	}
	
	function att:attachFunc()
		self.CW_VM:SetModel("models/weapons/v_cw_kk_ins2_cstm_scar_tan.mdl")
		self.WMEnt:SetModel("models/weapons/w_cw_kk_ins2_cstm_scar_tan.mdl")
		self.DrawCustomWM = true
	end

	function att:detachFunc()
		self.CW_VM:SetModel("models/weapons/v_cw_kk_ins2_cstm_scar.mdl")
		self.WMEnt:SetModel("models/weapons/w_cw_kk_ins2_cstm_scar.mdl")
		self.DrawCustomWM = false
	end	
end

CustomizableWeaponry:registerAttachment(att)