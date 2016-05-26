CustomizableWeaponry:addFireSound("CW_KK_INS2_MK18_FIRE", "weapons/mk18/mk18_fp.wav", 1, 105, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_MK18_FIRE_SUPPRESSED", "weapons/mk18/mk18_suppressed_fp.wav", 1, 75, CHAN_STATIC)

CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_BOLTBACK", "weapons/mk18/handling/mk18_boltback.wav")
CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_BOLTRELEASE", "weapons/mk18/handling/mk18_boltrelease.wav")
CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_EMPTY", "weapons/mk18/handling/mk18_empty.wav")
CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_FIRESELECT", "weapons/mk18/handling/mk18_fireselect.wav")
CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_HIT", "weapons/mk18/handling/mk18_hit.wav")
CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_MAGIN", "weapons/mk18/handling/mk18_magin.wav")
CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_MAGOUT", "weapons/mk18/handling/mk18_magout.wav")
CustomizableWeaponry:addReloadSound("CW_KK_INS2_MK18_MAGRELEASE", "weapons/mk18/handling/mk18_magrelease.wav")

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_MK18_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_MK18_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER" },
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MK18_EMPTY"},
	},

	base_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_MK18_FIRESELECT"},
	},

	base_reload = {
		{time = 16/30, sound = "CW_KK_INS2_MK18_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_MK18_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_MK18_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_MK18_HIT"},
	},

	base_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_MK18_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_MK18_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_MK18_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_MK18_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_MK18_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MK18_EMPTY"},
	},

	iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_MK18_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_MK18_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_MK18_BOLTRELEASE"},
	},

	foregrip_draw_b = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster_b = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER" },
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MK18_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_MK18_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 16/30, sound = "CW_KK_INS2_MK18_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_MK18_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_MK18_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_MK18_HIT"},
	},

	foregrip_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_MK18_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_MK18_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_MK18_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_MK18_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_MK18_BOLTRELEASE"},
	},

	foregrip_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MK18_EMPTY"},
	},

	foregrip_iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_MK18_FIRESELECT"},
	},
}
