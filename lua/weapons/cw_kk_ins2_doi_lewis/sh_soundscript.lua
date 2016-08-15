
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
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

	-- base_fire_1 = {
		-- { event AE_MUZZLEFLASH 0 ""},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- base_fire_2 = {
		-- { event AE_MUZZLEFLASH 0 ""},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- base_fire_last = {
		-- { event AE_MUZZLEFLASH 0 ""},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_LEWIS_EMPTY"},
	},

	base_reload = {
		{time = 26/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGRELEASE"},
		{time = 40/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGOUTFULL"},
		{time = 53/31.5, sound = "CW_KK_INS2_DOI_LEWIS_FETCHMAG"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 83 ""},
		{time = 134/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGFIDDLE"},
		{time = 140/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGIN"},
		{time = 169/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGHIT"},
		{time = 198/31.5, sound = "CW_KK_INS2_DOI_LEWIS_RATTLE"},
		{time = 208/31.5, sound = "CW_KK_INS2_DOI_LEWIS_SHOULDERWEAPON"},
		-- { event 46 170 ""},
	},

	base_reloadempty = {
		{time = 26/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGRELEASE"},
		{time = 40/31.5, sound = "lewis_Magout"},
		{time = 53/31.5, sound = "CW_KK_INS2_DOI_LEWIS_FETCHMAG"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 83 ""},
		{time = 119/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGFIDDLE"},
		{time = 127/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGIN"},
		{time = 157/31.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGHIT"},
		-- { event 46 158 ""},
		{time = 197/31.5, sound = "CW_KK_INS2_DOI_LEWIS_BOLTBACK"},
		{time = 225/31.5, sound = "CW_KK_INS2_DOI_LEWIS_RATTLE"},
		{time = 239/31.5, sound = "CW_KK_INS2_DOI_LEWIS_SHOULDERWEAPON"},
	},

	-- iron_fire_1 = {
		-- { event AE_MUZZLEFLASH 0 ""},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- iron_fire_2 = {
		-- { event AE_MUZZLEFLASH 0 ""},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- iron_fire_last = {
		-- { event AE_MUZZLEFLASH 0 ""},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_LEWIS_EMPTY"},
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

	deployed_in = {
		{time = 19/32.5, sound = "CW_KK_INS2_DOI_LEWIS_DEPLOYGROUNDHIT"},
		{time = 40/32.5, sound = "CW_KK_INS2_DOI_LEWIS_RATTLE"},
		{time = 50/32.5, sound = "CW_KK_INS2_DOI_LEWIS_SHOULDERWEAPON"},
	},

	deployed_out = {
		{time = 20/33, sound = "CW_KK_INS2_DOI_LEWIS_RATTLE"},
		{time = 39/33, sound = "CW_KK_INS2_DOI_LEWIS_SHOULDERWEAPON"},
	},

	-- deployed_fire_1 = {
		-- { event AE_MUZZLEFLASH 0 "M249 MUZZLE"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- deployed_fire_2 = {
		-- { event AE_MUZZLEFLASH 0 "M249 MUZZLE"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- deployed_fire_last = {
		-- { event AE_MUZZLEFLASH 0 "M249 MUZZLE"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_LEWIS_EMPTY"},
	},

	deployed_reload = {
		{time = 26/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGRELEASE"},
		{time = 40/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGOUTFULL"},
		{time = 53/32.5, sound = "CW_KK_INS2_DOI_LEWIS_FETCHMAG"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 83 ""},
		{time = 134/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGFIDDLE"},
		{time = 140/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGIN"},
		{time = 169/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGHIT"},
		{time = 198/32.5, sound = "CW_KK_INS2_DOI_LEWIS_RATTLE"},
		{time = 208/32.5, sound = "CW_KK_INS2_DOI_LEWIS_SHOULDERWEAPON"},
		-- { event 46 170 ""},
	},

	deployed_reload_empty = {
		{time = 26/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGRELEASE"},
		{time = 40/32.5, sound = "lewis_Magout"},
		{time = 53/32.5, sound = "CW_KK_INS2_DOI_LEWIS_FETCHMAG"},
		-- { event AE_WPN_RELOAD_OFFSCREEN 83 ""},
		{time = 119/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGFIDDLE"},
		{time = 127/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGIN"},
		{time = 157/32.5, sound = "CW_KK_INS2_DOI_LEWIS_MAGHIT"},
		-- { event 46 158 ""},
		{time = 197/32.5, sound = "CW_KK_INS2_DOI_LEWIS_BOLTBACK"},
		{time = 225/32.5, sound = "CW_KK_INS2_DOI_LEWIS_RATTLE"},
		{time = 239/32.5, sound = "CW_KK_INS2_DOI_LEWIS_SHOULDERWEAPON"},
	},

	-- deployed_iron_fire_1 = {
		-- { event AE_MUZZLEFLASH 0 "M249 MUZZLE"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- deployed_iron_fire_2 = {
		-- { event AE_MUZZLEFLASH 0 "M249 MUZZLE"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	-- deployed_iron_fire_last = {
		-- { event AE_MUZZLEFLASH 0 "M249 MUZZLE"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
		-- fps 35
	-- },

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_LEWIS_EMPTY"},
	},
}
