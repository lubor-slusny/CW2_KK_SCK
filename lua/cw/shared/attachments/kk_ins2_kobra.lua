local att = {}
att.name = "kk_ins2_kobra"
att.displayName = "Kobra"
att.displayNameShort = "Kobra"
att.aimPos = {"KKINS2KobraPos", "KKINS2KobraAng"}
att.FOVModifier = 15
att.isSight = true
-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
	
	att.reticle = "models/weapons/optics/kobra_dot"
	att._reticleSize = 16
	
	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight(self, att)
	end
	
end

CustomizableWeaponry:registerAttachment(att)