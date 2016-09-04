
local function shell(wep) 
	wep:shellEvent() 
end

local function link(wep)
	wep:shellEvent2() 
end

SWEP.Sounds = {
	base_ready = {
		{time = 29/34.2, sound = "CW_KK_INS2_DOI_MG34_BOLTBACK"},
		{time = 38/34.2, sound = "CW_KK_INS2_DOI_MG34_BOLTRELEASE"},
		{time = 61/34.2, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 78/34.2, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 15, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 38/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	base_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_EMPTY"},
	},

	base_fireselect = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_FIRESELECT"},
	},

	base_reload = {
		{time = 30/34.5, sound = "CW_KK_INS2_DOI_MG34_COVEROPEN"},
		{time = 78/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUT"},
		{time = 83/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUTRATTLE"},
		{time = 115/34.5, sound = "CW_KK_INS2_DOI_MG34_FETCHMAG"},
		{time = 130/34.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 158/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGIN"},
		{time = 168/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGHIT"},
		{time = 198/34.5, sound = "CW_KK_INS2_DOI_MG34_BELTALIGN"},
		{time = 234/34.5, sound = "CW_KK_INS2_DOI_MG34_COVERCLOSE"},
		{time = 267/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 285/34.5, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 130 ""},
		-- { event 46 170 ""},
	},

	base_reload_half = {
		{time = 30/34.5, sound = "CW_KK_INS2_DOI_MG34_COVEROPEN"},
		{time = 78/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUT"},
		{time = 83/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUTRATTLE"},
		{time = 115/34.5, sound = "CW_KK_INS2_DOI_MG34_FETCHMAG"},
		{time = 130/34.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 158/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGIN"},
		{time = 168/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGHIT"},
		{time = 198/34.5, sound = "CW_KK_INS2_DOI_MG34_BELTALIGN"},
		{time = 234/34.5, sound = "CW_KK_INS2_DOI_MG34_COVERCLOSE"},
		{time = 267/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 285/34.5, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 130 ""},
		-- { event 46 170 ""},
	},

	base_reload_empty = {
		{time = 30/34.5, sound = "CW_KK_INS2_DOI_MG34_COVEROPEN"},
		{time = 68/34.5, sound = "CW_KK_INS2_DOI_MG34_BOLTBACK"},
		{time = 76/34.5, sound = "CW_KK_INS2_DOI_MG34_BOLTRELEASE"},
		{time = 98/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 132/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUT"},
		{time = 136/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUTRATTLE"},
		{time = 150/34.5, sound = "CW_KK_INS2_DOI_MG34_FETCHMAG"},
		{time = 160/34.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 213/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGIN"},
		{time = 222/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGHIT"},
		{time = 252/34.5, sound = "CW_KK_INS2_DOI_MG34_BELTALIGN"},
		{time = 288/34.5, sound = "CW_KK_INS2_DOI_MG34_COVERCLOSE"},
		{time = 323/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 338/34.5, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 150 ""},
		-- { event 46 224 ""},
	},

	iron_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	iron_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_EMPTY"},
	},

	iron_fireselect = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_FIRESELECT"},
	},

	deployed_in = {
		{time = 19/32.5, sound = "CW_KK_INS2_DOI_MG34_DEPLOYGROUNDHIT"},
		{time = 46/32.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 65/32.5, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
	},

	deployed_out = {
		{time = 25/33, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 39/33, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
	},

	deployed_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_EMPTY"},
	},

	deployed_fireselect = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_FIRESELECT"},
	},

	deployed_reload = {
		{time = 30/34.5, sound = "CW_KK_INS2_DOI_MG34_COVEROPEN"},
		{time = 78/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUT"},
		{time = 83/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUTRATTLE"},
		{time = 115/34.5, sound = "CW_KK_INS2_DOI_MG34_FETCHMAG"},
		{time = 130/34.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 158/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGIN"},
		{time = 168/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGHIT"},
		{time = 198/34.5, sound = "CW_KK_INS2_DOI_MG34_BELTALIGN"},
		{time = 234/34.5, sound = "CW_KK_INS2_DOI_MG34_COVERCLOSE"},
		{time = 260/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 276/34.5, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 130 ""},
		-- { event 46 170 ""},
	},

	deployed_reload_half = {
		{time = 30/34.5, sound = "CW_KK_INS2_DOI_MG34_COVEROPEN"},
		{time = 78/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUT"},
		{time = 83/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUTRATTLE"},
		{time = 115/34.5, sound = "CW_KK_INS2_DOI_MG34_FETCHMAG"},
		{time = 130/34.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 158/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGIN"},
		{time = 168/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGHIT"},
		{time = 198/34.5, sound = "CW_KK_INS2_DOI_MG34_BELTALIGN"},
		{time = 234/34.5, sound = "CW_KK_INS2_DOI_MG34_COVERCLOSE"},
		{time = 260/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 276/34.5, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 130 ""},
		-- { event 46 170 ""},
	},

	deployed_reload_empty = {
		{time = 30/34.5, sound = "CW_KK_INS2_DOI_MG34_COVEROPEN"},
		{time = 68/34.5, sound = "CW_KK_INS2_DOI_MG34_BOLTBACK"},
		{time = 76/34.5, sound = "CW_KK_INS2_DOI_MG34_BOLTRELEASE"},
		{time = 98/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 132/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUT"},
		{time = 136/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGOUTRATTLE"},
		{time = 150/34.5, sound = "CW_KK_INS2_DOI_MG34_FETCHMAG"},
		{time = 160/34.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 213/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGIN"},
		{time = 222/34.5, sound = "CW_KK_INS2_DOI_MG34_MAGHIT"},
		{time = 252/34.5, sound = "CW_KK_INS2_DOI_MG34_BELTALIGN"},
		{time = 288/34.5, sound = "CW_KK_INS2_DOI_MG34_COVERCLOSE"},
		{time = 316/34.5, sound = "CW_KK_INS2_DOI_MG34_RATTLE"},
		{time = 330/34.5, sound = "CW_KK_INS2_DOI_MG34_SHOULDERWEAPON"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 150 ""},
		-- { event 46 224 ""},
	},

	deployed_iron_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_iron_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_EMPTY"},
	},

	deployed_iron_fireselect = {
		{time = 0, sound = "CW_KK_INS2_DOI_MG34_FIRESELECT"},
	},
}
