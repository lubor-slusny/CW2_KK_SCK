local att = {}
att.name = "kk_ins2_eotech"
att.displayName = "EoTech 552"
att.displayNameShort = "EoTech"
att.aimPos = {"KKINS2EoTechPos", "KKINS2EoTechAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 40
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
	OverallMouseSensMult = -0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
	
	att.reticle = "models/weapons/optics/eotech_reticule_holo"
	att._reticleSize = 16
	
	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight(self, att)
	end
	
end

CustomizableWeaponry:registerAttachment(att)