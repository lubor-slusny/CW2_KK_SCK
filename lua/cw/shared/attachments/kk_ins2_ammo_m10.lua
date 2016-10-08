local att = {}
att.name = "kk_ins2_ammo_m10"
att.displayName = "M10A1 Smoke Rockets"
att.displayNameShort = "Smoke"
att.KK_INS2_playIdle = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Swaps HEAT rockets for white phosphorus smoke rockets.", c = CustomizableWeaponry.textColors.NETURAL}
	}
end

function att:attachFunc()
	self._KK_INS2_customPickupSuffix = "_mm"
	self._KK_INS2_customReloadSuffix = "_mm"
	self.Primary.Ammo = "M10A1 Rocket"
	self:unloadWeapon()
	
	self.FireBullet = function(wep)
		local IFTP = IsFirstTimePredicted()
		
		CustomizableWeaponry_KK.ins2.rpgs.fireM10(wep, IFTP, true)
	end
end

function att:detachFunc()
	self._KK_INS2_customPickupSuffix = ""
	self._KK_INS2_customReloadSuffix = ""
	self.Primary.Ammo = "M6A1 Rocket"
	self:unloadWeapon()
	
	self.FireBullet = function(wep)
		local IFTP = IsFirstTimePredicted()
		
		CustomizableWeaponry_KK.ins2.rpgs.fireM6A1(wep, IFTP, true)
	end
end

CustomizableWeaponry:registerAttachment(att)