local att = {}
att.name = "kk_ins2_aimpoint"
att.displayName = "Aimpoint"
att.displayNameShort = "Aimpoint"
att.aimPos = {"KKINS2AimpointPos", "KKINS2AimpointAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 35
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
	OverallMouseSensMult = -0.07
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
		[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
	
	att.reticle = "models/weapons/optics/aimpoint_reticule_holo"
	att._reticleSize = 7
	
	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight(self, att)
	end
	
	function att:attachFunc()
	end
	
	function att:detachFunc()
	end
end

CustomizableWeaponry:registerAttachment(att)