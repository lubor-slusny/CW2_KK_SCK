local att = {}
att.name = "kk_ins2_suppressor_ins"
att.displayName = "Universal suppressor"
att.displayNameShort = "Silencer"
att.isSuppressor = true

att.statModifiers = {
	OverallMouseSensMult = -0.1,
	RecoilMult = -0.15,
	WeaponLength = 12,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE},
		{t = "Increases weapon length.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:resetSuppressorStatus()
end

CustomizableWeaponry:registerAttachment(att)