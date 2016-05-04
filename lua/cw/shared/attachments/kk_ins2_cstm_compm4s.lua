local att = {}
att.name = "kk_ins2_cstm_compm4s"
att.displayName = "Aimpoint CompM4S"
att.displayNameShort = "CompM4S"
att.aimPos = {"KKINS2CSTMCompM4SPos", "KKINS2CSTMCompM4SAng"}
att.FOVModifier = 20
att.isSight = true
-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.07}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
		[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
	
	att.reticle = "models/weapons/optics/aimpoint_reticule_holo"
	att._reticleSize = 8
	
	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight(self, att)
	end
	
end

CustomizableWeaponry:registerAttachment(att)