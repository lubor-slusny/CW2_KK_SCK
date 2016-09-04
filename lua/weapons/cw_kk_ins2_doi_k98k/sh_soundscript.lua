
local function shell(wep)
	wep:shellEvent() 
end

SWEP.animCallbacksRAW = { // Aim LayZ to rewrite this
	base_fire_end = {
		{time = 20/30, sound = "", callback = shell},
	},

	base_reload_empty_clip = {
		{time = 29/33.4, sound = "", callback = shell},
	},

	base_reload_start_empty = {
		{time = 29/33.5, sound = "", callback = shell},
	},

	iron_fire_end = {
		{time = 18/30.5, sound = "", callback = shell},
	},

	gl_fire_end = {
		{time = 20/30, sound = "", callback = shell},
	},

	gl_reload_empty_stripper = {
		{time = 29/33.4, sound = "", callback = shell},
	},

	gl_reload_start_empty = {
		{time = 29/33.5, sound = "", callback = shell},
	},

	gl_iron_fire_end = {
		{time = 18/30.5, sound = "", callback = shell},
	},

	glsetup_in_empty = {
		{time = 29/32.5, sound = "", callback = shell},
	},

	glsetup_out_empty = {
		{time = 29/32.5, sound = "", callback = shell},
	},

	glsetup_reload = {
		{time = 29/32.5, sound = "", callback = shell},
	},
}

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 21/33, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 26/33, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 40/33, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 45/33, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
		{time = 64/33, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire_end = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 20 ""},
		{time = 13/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 14/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 20/35, sound = "", callback = shell},
		{time = 22/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		-- { event AE_WPN_COCK 24 ""},
		{time = 26/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_K98_EMPTY"},
	},

	base_melee = {
		{time = 1/30, sound = "CW_KK_INS2_DOI_MELEE"},
	},

	base_reload_empty_clip = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 19/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 29/35, sound = "", callback = shell},
		-- { event 46 88 ""},
		-- { event AE_WPN_RELOAD_OFFSCREEN 40 ""},
		{time = 37/35, sound = "CW_KK_INS2_DOI_K98_FETCHMAG"},
		{time = 40/35, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 64/35, sound = "CW_KK_INS2_DOI_K98_MAGIN"},
		{time = 80/35, sound = "CW_KK_INS2_DOI_K98_ROUNDSIN"},
		{time = 111/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARDSTRIPPERCLIP"},
		{time = 112/35, sound = "CW_KK_INS2_DOI_K98_STRIPPERCLIPEJECT"},
		{time = 119/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	base_reload_full_clip = {
		{time = 19/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		-- { event 46 88 ""},
		-- { event AE_WPN_RELOAD_OFFSCREEN 40 ""},
		{time = 37/35, sound = "CW_KK_INS2_DOI_K98_FETCHMAG"},
		{time = 40/35, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 64/35, sound = "CW_KK_INS2_DOI_K98_MAGIN"},
		{time = 80/35, sound = "CW_KK_INS2_DOI_K98_ROUNDSIN"},
		{time = 111/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARDSTRIPPERCLIP"},
		{time = 112/35, sound = "CW_KK_INS2_DOI_K98_STRIPPERCLIPEJECT"},
		{time = 119/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	base_reload_start = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
	},

	base_reload_start_empty = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 29/35.5, sound = "", callback = shell},
	},

	base_reload_insert = {
		{time = 14/37.2, sound = "CW_KK_INS2_DOI_K98_BULLETIN"},
		{time = 21/37.2, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToClip},
		-- { event 46 22 ""},
	},

	base_reload_end = {
		{time = 14/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 21/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	iron_fire_end = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 18 ""},
		{time = 13/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 16/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 18/35, sound = "", callback = shell},
		{time = 24/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		-- { event AE_WPN_COCK 26 ""},
		{time = 27/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_K98_EMPTY"},
	},

	gl_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 21/33, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 26/33, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 40/33, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 45/33, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
		{time = 64/33, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
	},

	gl_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	gl_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	gl_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	gl_fire_end = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 20 ""},
		{time = 13/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 14/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 20/35, sound = "", callback = shell},
		{time = 22/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		-- { event AE_WPN_COCK 24 ""},
		{time = 26/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	gl_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_K98_EMPTY"},
	},

	gl_reload_empty_stripper = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 19/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 29/35, sound = "", callback = shell},
		-- { event 46 88 ""},
		-- { event AE_WPN_RELOAD_OFFSCREEN 40 ""},
		{time = 37/35, sound = "CW_KK_INS2_DOI_K98_FETCHMAG"},
		{time = 40/35, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 64/35, sound = "CW_KK_INS2_DOI_K98_MAGIN"},
		{time = 80/35, sound = "CW_KK_INS2_DOI_K98_ROUNDSIN"},
		{time = 111/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARDSTRIPPERCLIP"},
		{time = 112/35, sound = "CW_KK_INS2_DOI_K98_STRIPPERCLIPEJECT"},
		{time = 119/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	gl_reload_full_clip = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 19/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		-- { event 46 88 ""},
		-- { event AE_WPN_RELOAD_OFFSCREEN 40 ""},
		{time = 37/35, sound = "CW_KK_INS2_DOI_K98_FETCHMAG"},
		{time = 40/35, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToReserve},
		{time = 64/35, sound = "CW_KK_INS2_DOI_K98_MAGIN"},
		{time = 80/35, sound = "CW_KK_INS2_DOI_K98_ROUNDSIN"},
		{time = 111/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARDSTRIPPERCLIP"},
		{time = 112/35, sound = "CW_KK_INS2_DOI_K98_STRIPPERCLIPEJECT"},
		{time = 119/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	gl_reload_start = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
	},

	gl_reload_start_empty = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 29/35.5, sound = "", callback = shell},
	},

	gl_reload_insert = {
		-- { event AE_WPN_RELOAD_OFFSCREEN 21 ""},
		{time = 14/37.2, sound = "CW_KK_INS2_DOI_K98_BULLETIN"},
		{time = 21/37.2, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletsToClip},
		-- { event 46 22 ""},
	},

	gl_reload_end = {
		{time = 14/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 21/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	gl_iron_fire_end = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 18 ""},
		{time = 13/35, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 16/35, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 18/35, sound = "", callback = shell},
		{time = 24/35, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		-- { event AE_WPN_COCK 26 ""},
		{time = 27/35, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
	},

	gl_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_K98_EMPTY"},
	},

	glsetup_in = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 66/35.5, sound = "CW_KK_INS2_DOI_K98_BULLETIN"},
		{time = 99/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 106/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
		{time = 134/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
		{time = 166/35.5, sound = "CW_KK_INS2_DOI_K98_GLLOAD1"},
		{time = 178/35.5, sound = "CW_KK_INS2_DOI_K98_GLLOAD2"},
		{time = 210/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
		{time = 212/35.5, sound = "CW_KK_INS2_DOI_K98_SHOULDER"},
	},

	glsetup_in_empty = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 29/35.5, sound = "", callback = shell},
		{time = 66/35.5, sound = "CW_KK_INS2_DOI_K98_BULLETIN"},
		{time = 99/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 106/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
		{time = 134/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
		{time = 166/35.5, sound = "CW_KK_INS2_DOI_K98_GLLOAD1"},
		{time = 178/35.5, sound = "CW_KK_INS2_DOI_K98_GLLOAD2"},
		{time = 210/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
		{time = 212/35.5, sound = "CW_KK_INS2_DOI_K98_SHOULDER"},
	},

	glsetup_out = {
		{time = 36/35.5, sound = "CW_KK_INS2_DOI_K98_GLREMOVE"},
		{time = 112/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 119/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 130/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 139/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
		{time = 155/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
	},

	glsetup_out_empty = {
		{time = 18/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 26/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 29/35.5, sound = "", callback = shell},
		{time = 38/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 45/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 63/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
	},

	glsetup_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	glsetup_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_DOI_K98_EMPTY"},
	},

	glsetup_reload = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTBACK"},
		{time = 29/35.5, sound = "", callback = shell},
		{time = 66/35.5, sound = "CW_KK_INS2_DOI_K98_BULLETIN"},
		{time = 99/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTFORWARD"},
		{time = 106/35.5, sound = "CW_KK_INS2_DOI_K98_BOLTLATCH"},
		{time = 134/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
		{time = 166/35.5, sound = "CW_KK_INS2_DOI_K98_GLLOAD1"},
		{time = 178/35.5, sound = "CW_KK_INS2_DOI_K98_GLLOAD2"},
		{time = 210/35.5, sound = "CW_KK_INS2_DOI_K98_RATTLE"},
		{time = 212/35.5, sound = "CW_KK_INS2_DOI_K98_SHOULDER"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		-- { event 46 182 ""},
	},

	glsetup_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_K98_EMPTY"},
	},

	base_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl_empty = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_melee_empty = {
		{time = 1/30, sound = "CW_KK_INS2_DOI_MELEE"},
	},

	gl_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	gl_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	gl_crawl_empty = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	glsetup_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_crawl_empty = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},
}
