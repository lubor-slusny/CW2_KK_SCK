local att = {}
att.name = "kk_ins2_ww2_nade_jackit"
att.displayNameShort = "Jacket"
att.displayName = "Frag Jacket"

att.statModifiers = {
	VelocitySensitivityMult = -0.3,
	OverallMouseSensMult = -0.15,
	RecoilMult = -0.2,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Causes grenade to create more shrapnels upon detonation.", c = CustomizableWeaponry.textColors.VPOSITIVE}
	}
	
	att.SelectIconOverride = surface.GetTextureID("vgui/inventory/weapon_splintering")
end

CustomizableWeaponry:registerAttachment(att)
