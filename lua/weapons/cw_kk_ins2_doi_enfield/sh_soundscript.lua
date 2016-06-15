
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 21/30, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 26/30, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 40/30, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 45/30, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 64/30, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
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

	base_fire_end = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 20 ""},
		{time = 13/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 14/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 22/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		// { event AE_WPN_COCK 24 ""},
		{time = 26/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_ENFIELD_EMPTY"},
	},

	base_melee = {
		{time = 1/30, sound = "CW_KK_INS2_WW2_MELEE"},
	},

	base_reload_clip = {
		{time = 19/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		// { event AE_WPN_RELOAD_OFFSCREEN 42 ""},
		{time = 27/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 64/31, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 85/31, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		// { event 46 90 ""},
		{time = 113/31, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 138/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 146/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 162/31, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	base_reload_empty_clip = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		// { event AE_WPN_RELOAD_OFFSCREEN 42 ""},
		{time = 19/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 64/31, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 85/31, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		// { event 46 90 ""},
		{time = 113/31, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 153/31, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 171/31, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		// { event 46 176 ""},
		{time = 198/31, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 223/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 231/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 250/31, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	base_reload_full_clip = {
		-- { event AE_WPN_RELOAD_OFFSCREEN 42 ""},
		{time = 19/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 64/31, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 85/31, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		-- { event 46 90 ""},
		{time = 113/31, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 153/31, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 171/31, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		-- { event 46 176 ""},
		{time = 198/31, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 223/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 231/31, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 250/31, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	base_reload_start = {
		{time = 19/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
	},

	base_reload_start_empty = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 19/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
	},

	base_reload_insert = {
		{time = 14/37.2, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN"},
		-- { event 46 22 ""},
	},

	base_reload_end = {
		{time = 14/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 21/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
	},

	iron_fire_end = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 18 ""},
		{time = 13/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 16/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 24/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		-- { event AE_WPN_COCK 26 ""},
		{time = 27/33.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_ENFIELD_EMPTY"},
	},

	base_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_melee_empty = {
		{time = 1, sound = "CW_KK_INS2_WW2_MELEE"},
	},

	glsetup_in = {
		{time = 19/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 66/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN"},
		{time = 99/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 106/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 134/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 166/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad1"},
		{time = 178/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad2"},
		{time = 210/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 212/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_SHOULDER"},
	},

	glsetup_in_empty = {
		{time = 19/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		// { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 66/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN"},
		{time = 99/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 106/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 134/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 166/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad1"},
		{time = 178/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad2"},
		{time = 210/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 212/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_SHOULDER"},
	},

	glsetup_out = {
		{time = 36/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_GLREMOVE"},
		{time = 112/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 119/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 130/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 139/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 155/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	glsetup_out_empty = {
		{time = 18/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 26/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 38/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 45/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 63/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	glsetup_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	glsetup_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_ENFIELD_EMPTY"},
	},

	glsetup_reload = {
		{time = 19/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 66/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN"},
		{time = 99/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 106/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 134/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 166/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad1"},
		{time = 178/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad2"},
		{time = 210/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 212/32.5, sound = "CW_KK_INS2_DOI_ENFIELD_SHOULDER"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
	},

	glsetup_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_ENFIELD_EMPTY"},
	},

	glsetup_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_crawl_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},
}
