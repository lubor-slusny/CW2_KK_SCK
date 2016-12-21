
local function m203(wep)
	if SERVER then return end
	
	wep:shellEvent203()
end

SWEP.Sounds = {
	base_ready = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 24/30, sound = "CW_KK_INS2_M4A1_BOLTBACK"},
		{time = 38/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
		{time = 52/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 67/30, sound = "CW_KK_INS2_M4A1_HIT"},
		{time = 82/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_draw = {
		{time = 0/31, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0/32, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	-- base_fire = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	base_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	base_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	base_reload = {
		{time = 39/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 45/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 104/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 119/30, sound = "CW_KK_INS2_M4A1_HIT"},
		// { event 46 117 ""},
	},

	base_reloadempty = {
		{time = 40/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 45/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 104/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 119/30, sound = "CW_KK_INS2_M4A1_HIT"},
		// { event 46 144 ""},
		{time = 147/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	base_reloadempty2 = {
		{time = 40/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 45/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 104/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 119/30, sound = "CW_KK_INS2_M4A1_HIT"},
		// { event 46 144 ""},
		{time = 147/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	base_reloadempty3 = {
		{time = 40/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 45/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 104/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 119/30, sound = "CW_KK_INS2_M4A1_HIT"},
		// { event 46 144 ""},
		{time = 147/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	-- iron_fire = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- iron_fire_a = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- iron_fire_b = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- iron_fire_c = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- iron_fire_d = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- iron_fire_e = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- iron_fire_f = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	gl_ready = {
		{time = 0/32, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 24/32, sound = "CW_KK_INS2_M4A1_BOLTBACK"},
		{time = 38/32, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
		{time = 52/32, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 67/32, sound = "CW_KK_INS2_M4A1_HIT"},
		{time = 82/32, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 98/32, sound = "CW_KK_INS2_M203_OPENBARREL"},
		{time = 115/32, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	gl_draw = {
		{time = 0/31, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	gl_holster = {
		{time = 0/34, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	gl_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	-- gl_fire = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	gl_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	gl_fireselect = {
		{time = 13/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	gl_reload = {
		{time = 39/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 45/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 104/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 119/30, sound = "CW_KK_INS2_M4A1_HIT"},
		// { event 46 117 ""},
	},

	gl_reloadempty = {
		{time = 40/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 45/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 104/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 119/30, sound = "CW_KK_INS2_M4A1_HIT"},
		// { event 46 144 ""},
		{time = 147/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	-- gl_iron_fire = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- gl_iron_fire_a = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- gl_iron_fire_b = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- gl_iron_fire_c = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- gl_iron_fire_d = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- gl_iron_fire_e = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	-- gl_iron_fire_f = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	gl_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	gl_iron_fireselect = {
		{time = 13/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	glsetup_in = {
		{time = 0/30, sound = "CW_KK_INS2_M203_SELECT"},
		{time = 23/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT"},
	},

	glsetup_out = {
		{time = 0/30, sound = "CW_KK_INS2_M203_DESELECT"},
		{time = 17/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND"},
	},

	glsetup_ready = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_draw = {
		{time = 0/31, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0/31, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	-- glsetup_fire = {
		-- // { event AE_GL_MUZZLEFLASH 0 ""},
	-- },

	glsetup_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M203_EMPTY"},
	},

	glsetup_reload = {
		{time = 0/30, sound = "uni_GLBeginReload"},
		{time = 24/30, sound = "CW_KK_INS2_M203_OPENBARREL"},
		{time = 68/30, sound = "CW_KK_INS2_M203_INSERTGRENADE"},
		// { event AE_EMIT_SHELL_M203 34 ""},
		-- {time = 43/30, sound = "203_GrenadeDrop"},
		{time = 101/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
		// { event 46 99 ""},
	},

	-- glsetup_iron_fire = {
		-- // { event AE_GL_MUZZLEFLASH 0/32 ""},
	-- },

	glsetup_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M203_EMPTY"},
	},

	deployed_in = {
		{time = 14/30, sound = "CW_KK_INS2_M4A1_HIT"},
		{time = 27/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	deployed_out = {
		{time = 13/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	-- deployed_fire = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	deployed_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	deployed_fireselect = {
		{time = 12/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	deployed_reload_half = {
		{time = 20/30, sound = "CW_KK_INS2_M16A4_MAGHITRELEASE"},
		{time = 25/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 84/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 98/30, sound = "CW_KK_INS2_M16A4_HIT"},
		// { event 46 94 ""},
	},

	deployed_reload_empty = {
		{time = 23/30, sound = "CW_KK_INS2_M16A4_MAGHITRELEASE"},
		{time = 26/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 83/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 97/30, sound = "CW_KK_INS2_M16A4_HIT"},
		// { event 46 119 ""},
		{time = 124/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	deployed_reload_empty2 = {
		{time = 23/30, sound = "CW_KK_INS2_M16A4_MAGHITRELEASE"},
		{time = 26/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 83/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 97/30, sound = "CW_KK_INS2_M16A4_HIT"},
		// { event 46 119 ""},
		{time = 124/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	-- deployed_iron_fire = {
		-- // { event AE_MUZZLEFLASH 0 ""},
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 0 ""},
	-- },

	deployed_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	deployed_iron_fireselect = {
		{time = 12/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},
}
