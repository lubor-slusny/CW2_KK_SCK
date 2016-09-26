
local function shell(wep)
	wep:shellEvent() 
end

local function bulletsToClip(wep)	
	-- wep._bulletsToClip = true
	wep._loadingNewBelt = false
end

// joke or realism?

local function blankLoaded(wep)
	wep._blankWW2Loaded = true
end

local function removeBlank(wep)
	wep._blankWW2Loaded = false
end

local function dryFireInterruptedGL(wep)
	if wep._blankWW2Loaded then
		removeBlank(wep)
		wep:CreateMuzzle()
		wep:EmitSound(wep.FireSound)
	else
		wep:EmitSound("CW_KK_INS2_DOI_ENFIELD_EMPTY")
	end
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 21/33, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 26/33, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 40/33, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 45/33, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 64/33, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
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
		{time = 13/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 14/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 20/38, sound = "", callback = shell},
		{time = 22/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		// { event AE_WPN_COCK 24 ""},
		{time = 26/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_ENFIELD_EMPTY"},
	},

	base_melee = {
		{time = 1/30, sound = "CW_KK_INS2_DOI_MELEE"},
	},

	base_reload_clip = {
		{time = 19/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		// { event AE_WPN_RELOAD_OFFSCREEN 42 ""},
		{time = 27/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 42/36, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve},
		{time = 64/36, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 85/36, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		// { event 46 90 ""},
		{time = 90/36, sound = "", callback = bulletsToClip},
		{time = 113/36, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 138/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 146/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 162/36, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	base_reload_empty_clip = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		// { event AE_WPN_RELOAD_OFFSCREEN 42 ""},
		{time = 19/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 29/36, sound = "", callback = shell},
		{time = 42/36, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve},
		{time = 64/36, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 85/36, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		// { event 46 90 ""},
		{time = 113/36, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 153/36, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 171/36, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		// { event 46 176 ""},
		{time = 176/36, sound = "", callback = bulletsToClip},
		{time = 198/36, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 223/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 231/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 250/36, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	base_reload_full_clip = {
		-- { event AE_WPN_RELOAD_OFFSCREEN 42 ""},
		{time = 19/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 29/36, sound = "", callback = shell},
		{time = 42/36, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve},
		{time = 64/36, sound = "CW_KK_INS2_DOI_ENFIELD_MAGIN"},
		{time = 85/36, sound = "CW_KK_INS2_DOI_ENFIELD_ROUNDSIN"},
		-- { event 46 90 ""},
		{time = 90/36, sound = "", callback = bulletsToClip},
		{time = 113/36, sound = "CW_KK_INS2_DOI_ENFIELD_CLIPREMOVE"},
		{time = 138/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 146/36, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 162/36, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	base_reload_start = {
		{time = 19/38.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/38.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
	},

	base_reload_start_empty = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 19/38.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/38.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 29/38.5, sound = "", callback = shell},
	},

	base_reload_insert = {
		{time = 14/40.2, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN"},
		{time = 22/40.2, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToClip},
		-- { event 46 22 ""},
	},

	base_reload_end = {
		{time = 14/38.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 21/38.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
	},

	iron_fire_end = {
		-- { event AE_CL_CREATE_PARTICLE_BRASS 18 ""},
		{time = 13/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 16/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 18/38, sound = "", callback = shell},
		{time = 24/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		-- { event AE_WPN_COCK 26 ""},
		{time = 27/38, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
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
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_melee_empty = {
		{time = 1/30, sound = "CW_KK_INS2_DOI_MELEE"},
	},

	glsetup_in = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 66/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN", callback = blankLoaded},
		{time = 99/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 106/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 134/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 166/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad1"},
		{time = 178/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad2", callback = removeBlank},
		{time = 210/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 212/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_SHOULDER"},
	},

	glsetup_in_empty = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 29/35.5, sound = "", callback = shell},
		// { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 66/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN", callback = blankLoaded},
		{time = 99/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 106/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 134/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 166/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad1"},
		{time = 178/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad2", callback = removeBlank},
		{time = 210/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 212/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_SHOULDER"},
	},

	glsetup_out = {
		{time = 36/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_GLREMOVE"},
		{time = 112/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 119/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 130/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 139/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 155/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	glsetup_out_empty = {
		{time = 18/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 26/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 29/35.5, sound = "", callback = shell},
		{time = 38/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 45/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
		{time = 63/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
	},

	glsetup_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	glsetup_dryfire = {
		{time = 0, sound = "", callback = dryFireInterruptedGL},
	},

	glsetup_reload = {
		{time = 19/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTRELEASE"},
		{time = 27/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTBACK"},
		{time = 29/35.5, sound = "", callback = shell},
		{time = 66/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BULLETIN", callback = blankLoaded},
		{time = 99/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTFORWARD"},
		{time = 106/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_BOLTLATCH"},
		{time = 134/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 166/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad1"},
		{time = 178/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_GlLoad2", callback = removeBlank},
		{time = 210/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_RATTLE"},
		{time = 212/35.5, sound = "CW_KK_INS2_DOI_ENFIELD_SHOULDER"},
		-- { event AE_CL_CREATE_PARTICLE_BRASS 29 ""},
	},

	glsetup_iron_dryfire = {
		{time = 0, sound = "", callback = dryFireInterruptedGL},
	},

	glsetup_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_crawl_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},
}
