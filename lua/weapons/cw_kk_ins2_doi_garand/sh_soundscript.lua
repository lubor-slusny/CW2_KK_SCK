
local function shell(wep)
	wep:shellEvent()
end

local function clip(wep) 
	wep:shellEvent2() 
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 24/30, sound = "CW_KK_INS2_DOI_GARAND_BOLTRELEASE"},
		{time = 41/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire_1 = {
		{time = 0.09, sound = "", callback = shell},
	},

	base_fire_2 = {
		{time = 0.09, sound = "", callback = shell},
	},

	base_fire_last = {
		{time = 0, sound = "CW_KK_INS2_DOI_GARAND_PING"},
		{time = 0.06, sound = "", callback = shell},
		{time = 0.45, sound = "", callback = clip},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_GARAND_EMPTY"},
	},

	base_melee = {
		{time = 1/30, sound = "CW_KK_INS2_DOI_MELEE"},
	},

	base_reloadfull = {
		{time = 18/30, sound = "CW_KK_INS2_DOI_GARAND_MAGRELEASE"},
		{time = 32/30, sound = "CW_KK_INS2_DOI_GARAND_BOLTBACK"},
		{time = 35/30, sound = "CW_KK_INS2_DOI_GARAND_MAGOUT"},
		{time = 50/30, sound = "CW_KK_INS2_DOI_GARAND_FETCHMAG"},
		{time = 80/30, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 100/30, sound = "CW_KK_INS2_DOI_GARAND_MAGIN"},
		{time = 111/30, sound = "CW_KK_INS2_DOI_GARAND_MAGHIT"},
		{time = 113/30, sound = "CW_KK_INS2_DOI_GARAND_RATTLE"},
		{time = 118/30, sound = "CW_KK_INS2_DOI_GARAND_BOLTRELEASE"},
	},

	base_reloadempty = {
		{time = 1/30, sound = "CW_KK_INS2_DOI_GARAND_FETCHMAG"},
		{time = 28/30, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 45/30, sound = "CW_KK_INS2_DOI_GARAND_MAGIN"},
		{time = 57/30, sound = "CW_KK_INS2_DOI_GARAND_MAGHIT"},
		{time = 64/30, sound = "CW_KK_INS2_DOI_GARAND_BOLTRELEASE"},
		{time = 79/30, sound = "CW_KK_INS2_DOI_GARAND_RATTLE"},
	},

	iron_fire_1 = {
		{time = 0.09, sound = "", callback = shell},
	},

	iron_fire_2 = {
		{time = 0.09, sound = "", callback = shell},
	},

	iron_fire_3 = {
		{time = 0.09, sound = "", callback = shell},
	},

	iron_fire_last = {
		{time = 0, sound = "CW_KK_INS2_DOI_GARAND_PING"},
		{time = 0.06, sound = "", callback = shell},
		{time = 0.45, sound = "", callback = clip},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_GARAND_EMPTY"},
	},

	base_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_melee_empty = {
		{time = 1/30, sound = "CW_KK_INS2_DOI_MELEE"},
	},
}
