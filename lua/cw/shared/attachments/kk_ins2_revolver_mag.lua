local att = {}
att.name = "kk_ins2_revolver_mag"
att.displayName = "Speedy Loader"
att.displayNameShort = "Fast"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Speeds reload up. Incredibly.", c = CustomizableWeaponry.textColors.VPOSITIVE},
	}
end

function att:attachFunc()
	self:unloadWeapon()
	self.ShotgunReload = false
end

function att:detachFunc()
	self:unloadWeapon()
	self.ShotgunReload = true
end

CustomizableWeaponry:registerAttachment(att)