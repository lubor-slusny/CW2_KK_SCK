
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 21/30, sound = "CW_KK_INS2_WW2_K98_BOLTRELEASE"},
		{time = 26/30, sound = "CW_KK_INS2_WW2_K98_BOLTBACK"},
		{time = 40/30, sound = "CW_KK_INS2_WW2_K98_BOLTFORWARD"},
		{time = 45/30, sound = "CW_KK_INS2_WW2_K98_BOLTLATCH"},
		{time = 64/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
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
		{time = 13/30, sound = "CW_KK_INS2_WW2_K98_BOLTRELEASE"},
		{time = 14/30, sound = "CW_KK_INS2_WW2_K98_BOLTBACK"},
		{time = 22/30, sound = "CW_KK_INS2_WW2_K98_BOLTFORWARD"},
		{time = 26/30, sound = "CW_KK_INS2_WW2_K98_BOLTLATCH"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_WW2_K98_EMPTY"},
	},

	base_melee = {
		{time = 1/30, sound = "CW_KK_INS2_WW2_MELEE"},
	},

	/*
	$Sequence "base_reload_empty_stripper" {
		"v_kar98k_anims\base_reload_empty_stripper.smd"
		activity "ACT_VM_RELOADEMPTY_CLIP" 1
		{ event AE_CL_CREATE_PARTICLE_BRASS 29 "" }
		{ event 5004 19 "Weapon_kar98.BoltRelease" }
		{ event 5004 27 "Weapon_kar98.Boltback" }
		{ event 46 40 "" }
		{ event 5004 37 "Weapon_kar98.MagFetch" }
		{ event 5004 64 "Weapon_kar98.MagIn" }
		{ event 5004 80 "Weapon_kar98.RoundsIn" }
		{ event 5004 111 "Weapon_kar98.BoltforwardStripperClip" }
		{ event 5004 112 "Weapon_kar98.StripperClipEject" }
		{ event 5004 119 "Weapon_kar98.BoltLatch" }
		fadein 0.2
		fadeout 0.2
		fps 33.4
	}
	*/
	
	base_reload_empty_stripper = {
		{time = 19/33.4, sound = "CW_KK_INS2_WW2_K98_BOLTRELEASE"},
		{time = 27/33.4, sound = "CW_KK_INS2_WW2_K98_BOLTBACK"},
		{time = 37/33.4, sound = "CW_KK_INS2_WW2_GARAND_FETCHMAG"},
		{time = 64/33.4, sound = "CW_KK_INS2_WW2_GARAND_MAGIN"},
		{time = 80/33.4, sound = "CW_KK_INS2_WW2_GARAND_MAGHIT"},
		{time = 111/33.4, sound = "CW_KK_INS2_WW2_K98_BOLTFORWARD"},
		{time = 112/33.4, sound = "CW_KK_INS2_SHELL_38"},
		{time = 119/33.4, sound = "CW_KK_INS2_WW2_K98_BOLTLATCH"},
	},

	base_reload_start = {
		{time = 19/33.5, sound = "CW_KK_INS2_WW2_K98_BOLTRELEASE"},
		{time = 27/33.5, sound = "CW_KK_INS2_WW2_K98_BOLTBACK"},
	},

	base_reload_start_empty = {
		{time = 19/33.5, sound = "CW_KK_INS2_WW2_K98_BOLTRELEASE"},
		{time = 27/33.5, sound = "CW_KK_INS2_WW2_K98_BOLTBACK"},
	},

	base_reload_insert = {
		{time = 14/37.2, sound = "CW_KK_INS2_WW2_K98_BULLETIN"},
	},

	base_reload_end = {
		{time = 14/33.5, sound = "CW_KK_INS2_WW2_K98_BOLTFORWARD"},
		{time = 21/33.5, sound = "CW_KK_INS2_WW2_K98_BOLTLATCH"},
	},

	iron_fire_end = {
		{time = 13/30.5, sound = "CW_KK_INS2_WW2_K98_BOLTRELEASE"},
		{time = 16/30.5, sound = "CW_KK_INS2_WW2_K98_BOLTBACK"},
		{time = 24/30.5, sound = "CW_KK_INS2_WW2_K98_BOLTFORWARD"},
		{time = 27/30.5, sound = "CW_KK_INS2_WW2_K98_BOLTLATCH"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_WW2_K98_EMPTY"},
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
		{time = 1/30, sound = "CW_KK_INS2_WW2_MELEE"},
	}
}
