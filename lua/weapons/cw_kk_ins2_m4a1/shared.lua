AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M4A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.Shell = "KK_INS2_556x45"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_carryhandle_m4.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["bg_foldsight"] = {model = "models/weapons/attachments/v_cw_kk_ins2_flipsight.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["cover_dn_ln"] = {model = "models/weapons/upgrades/a_standard_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["cover_dn_sh_ft"] = {model = "models/weapons/upgrades/a_standard4_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["cover_rt_ln"] = {model = "models/weapons/upgrades/a_standard3_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["cover_rt_sh_bk"] = {model = "models/weapons/upgrades/a_standard5_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["cover_lt_ln"] = {model = "models/weapons/upgrades/a_standard2_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["cover_lt_sh_ft"] = {model = "models/weapons/upgrades/a_standard6_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
		["kk_ins2_gl_m203"] = {model = "models/weapons/upgrades/a_gl_m203.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_rail.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_rail.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_xl.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech_xl.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska_xl.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["ins_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["ins_scope_m40"] = {model = "models/weapons/upgrades/a_optic_m40_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["ins_scope_mosin"] = {model = "models/weapons/upgrades/a_optic_mosin_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["ins_scope_po"] = {model = "models/weapons/upgrades/a_optic_po4x24_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/w_flipup3.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		-- ["bottomRailCover"] = {model = "models/weapons/upgrades/a_standard_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_foregrip_sec1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["kk_ins2_gl_m203_merge"] = {model = "models/weapons/upgrades/w_m203.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_gl_m203"] = {model = "models/weapons/upgrades/w_m203.mdl", attachment = "gl", pos = Vector(-12,1.1,0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos_def = Vector(-2.4942, -2, 0.6828)
	SWEP.IronsightAng_def = Vector(-0.3628, 0.0389, 0)

	SWEP.KKINS2AimpointPos_def = Vector(-2.495, -2, 0.5751)
	SWEP.KKINS2AimpointAng_def = Vector(0, 0, 0)

	SWEP.KKINS2KobraPos_def = Vector(-2.4939, -2, 0.3292)
	SWEP.KKINS2KobraAng_def = Vector(0, 0, 0)

	SWEP.KKINS2EoTechPos_def = Vector(-2.4945, -2, 0.5707)
	SWEP.KKINS2EoTechAng_def = Vector(0, 0, 0)

	SWEP.KKINS2CSTMBarskaPos_def = Vector(-2.4969, -2, 0.5799)
	SWEP.KKINS2CSTMBarskaAng_def = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos_def = Vector(-2.4897, -2, 0.5722)
	SWEP.KKINS2MagnifierAng_def = Vector(0, 0, 0)

	
	SWEP.KKINS2AimpointPos_gl = Vector(-3.3724, -2, 0.9624)
	SWEP.KKINS2AimpointAng_gl = Vector(-2.4281, -0.9777, 0)

	SWEP.KKINS2KobraPos_gl = Vector(-3.3832, -2, 0.5669)
	SWEP.KKINS2KobraAng_gl = Vector(-1.5081, -0.9912, -0.1912)

	SWEP.KKINS2MagnifierPos_gl = Vector(-3.3017, -2, 0.7538)
	SWEP.KKINS2MagnifierAng_gl = Vector(0, 0, 0)

	SWEP.IronsightPos_gl = Vector(-3.3838, -2, 1.0264)
	SWEP.IronsightAng_gl = Vector(-2.5672, -0.9928, 0)

	SWEP.KKINS2CSTMBarskaPos_gl = Vector(-3.364, -2, 0.9875)
	SWEP.KKINS2CSTMBarskaAng_gl = Vector(-2.5051, -0.953, 0)

	SWEP.KKINS2EoTechPos_gl = Vector(-3.3782, -2, 0.9978)
	SWEP.KKINS2EoTechAng_gl = Vector(-2.5473, -0.9677, 0)


	SWEP.M203Pos = Vector(-0.5168, -2, 1.149)
	SWEP.M203Ang = Vector(0.593, -0.0025, 0)

	
	SWEP.KKINS2AimpointPos = SWEP.KKINS2AimpointPos_def
	SWEP.KKINS2AimpointAng = SWEP.KKINS2AimpointAng_def

	SWEP.KKINS2KobraPos = SWEP.KKINS2KobraPos_def
	SWEP.KKINS2KobraAng = SWEP.KKINS2KobraAng_def

	SWEP.KKINS2MagnifierPos = SWEP.KKINS2MagnifierPos_def
	SWEP.KKINS2MagnifierAng = SWEP.KKINS2MagnifierAng_def

	SWEP.IronsightPos = SWEP.IronsightPos_def
	SWEP.IronsightAng = SWEP.IronsightAng_def

	SWEP.KKINS2CSTMBarskaPos = SWEP.KKINS2CSTMBarskaPos_def
	SWEP.KKINS2CSTMBarskaAng = SWEP.KKINS2CSTMBarskaAng_def

	SWEP.KKINS2EoTechPos = SWEP.KKINS2EoTechPos_def
	SWEP.KKINS2EoTechAng = SWEP.KKINS2EoTechAng_def
	
	SWEP.FoldSightPos = Vector(-2.4966, -2, 0.9963)
	SWEP.FoldSightAng = Vector(-1.1876, 0, 0)
end

SWEP.SightBGs = {main = 0, foldsight = 0}

SWEP.Attachments = {
	{header = "Sight", offset = {500, -500},  atts = {"bg_foldsight", "kk_ins2_kobra", "kk_ins2_cstm_barska", "kk_ins2_eotech", "kk_ins2_aimpoint"}},
	{header = "Barrel", offset = {-200, -500},  atts = {"md_saker", "kk_ins2_hoovy"}},
	{header = "Under", offset = {-500, 0},  atts = {"kk_ins2_vertgrip", "kk_ins2_gl_m203"}},
	{header = "Extras", offset = {150, 200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready", // coz drawanimfunc doesnt play always
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire","iron_fire_a","iron_fire_b","iron_fire_c","iron_fire_d","iron_fire_e","iron_fire_f"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_fire = "foregrip_fire",
	foregrip_fire_aim = {"foregrip_iron_fire","foregrip_iron_fire_a","foregrip_iron_fire_b","foregrip_iron_fire_c","foregrip_iron_fire_d","foregrip_iron_fire_e","foregrip_iron_fire_f"},
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_firemode = "foregrip_fireselect",
	foregrip_firemode_aim = "foregrip_iron_fireselect",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
	
	gl_off_pickup = "gl_ready",
	gl_off_draw = "gl_draw",
	gl_off_fire = "gl_fire",
	gl_off_fire_aim = {"gl_iron_fire","gl_iron_fire_a","gl_iron_fire_b","gl_iron_fire_c","gl_iron_fire_d","gl_iron_fire_e","gl_iron_fire_f"},
	gl_off_fire_empty = "gl_dryfire",
	gl_off_fire_empty_aim = "gl_iron_dryfire",
	gl_off_reload = "gl_reload",
	gl_off_reload_empty = "gl_reloadempty",
	gl_off_idle = "gl_draw",
	gl_off_holster = "gl_holster",
	gl_off_firemode = "gl_fireselect",
	gl_off_firemode_aim = "gl_fireselect",
	gl_off_sprint = "gl_sprint",
	gl_off_safe = "gl_down",
	gl_off_safe_aim = "gl_iron_down",
	
	gl_on_draw = "glsetup_draw",
	gl_on_fire = "glsetup_fire",
	gl_on_fire_aim = "glsetup_iron_fire",
	gl_on_fire_empty = "glsetup_dryfire",
	gl_on_fire_empty_aim = "glsetup_iron_dryfire",
	gl_on_reload = "glsetup_reload",
	gl_on_idle = "glsetup_draw",
	gl_on_holster = "glsetup_holster",
	gl_on_sprint = "glsetup_sprint",
	gl_on_safe = "glsetup_down",
	gl_on_safe_aim = "glsetup_iron_down",
	
	gl_turn_on = "glsetup_in",
	gl_turn_off = "glsetup_out",
}

SWEP.Sounds = {
	base_ready = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	-- base_crawl = {
		-- {time = 0/30, sound = "CW_KK_INS2_LeftCrawl"},
		-- {time = 22/30, sound = "CW_KK_INS2_RightCrawl"},
	-- },

	base_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	base_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	base_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M4A1_HIT"},
	},

	base_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M4A1_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	foregrip_draw_b = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster_b = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	-- foregrip_crawl = {
		-- {time = 0/30, sound = "CW_KK_INS2_LeftCrawl"},
		-- {time = 22/30, sound = "CW_KK_INS2_RightCrawl"},
	-- },

	foregrip_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	foregrip_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	foregrip_iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M4A1_HIT"},
	},

	foregrip_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M4A1_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	gl_ready = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	gl_draw = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	gl_holster = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	-- gl_crawl = {
		-- {time = 0/30, sound = "CW_KK_INS2_LeftCrawl"},
		-- {time = 22/30, sound = "CW_KK_INS2_RightCrawl"},
	-- },

	gl_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	gl_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	gl_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M4A1_HIT"},
	},

	gl_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M4A1_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M4A1_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M4A1_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M4A1_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_M4A1_BOLTRELEASE"},
	},

	gl_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M4A1_EMPTY"},
	},

	gl_iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M4A1_FIRESELECT"},
	},

	glsetup_in = {
		{time = 0, sound = "CW_KK_INS2_M203_SELECT"},
	},

	glsetup_out = {
		{time = 0, sound = "CW_KK_INS2_M203_DESELECT"},
	},

	glsetup_ready = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_draw = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	-- glsetup_crawl = {
		-- {time = 0/30, sound = "CW_KK_INS2_LeftCrawl"},
		-- {time = 22/30, sound = "CW_KK_INS2_RightCrawl"},
	-- },

	glsetup_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M203_EMPTY"},
	},

	glsetup_reload = {
		{time = 0/30, sound = "CW_KK_INS2_GL_BEGINRELOAD"},
		{time = 16/30, sound = "CW_KK_INS2_M203_OPENBARREL"},
		{time = 40/30, sound = "CW_KK_INS2_M203_INSERTGRENADE"},
		-- {time = 44/30, sound = "CW_KK_INS2_m203_GrenadeDrop"},
		{time = 73/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	glsetup_iron_fire = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_M203_EMPTY"},
	},
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_m4a1.mdl"
SWEP.WorldModel		= "models/weapons/w_m4a1.mdl"

SWEP.WMPos = Vector(5.219, 0.554, -0.893)
SWEP.WMAng = Vector(-10, -1, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.066666666666667
SWEP.FireSound = "CW_KK_INS2_M4A1_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M4A1_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 28

SWEP.FirstDeployTime = 2.2
SWEP.DeployTime = 0.71

SWEP.base_ReloadTime = 2.9
SWEP.base_ReloadTime_Empty = 2.9
SWEP.base_ReloadHalt = 3.7
SWEP.base_ReloadHalt_Empty = 4.3

SWEP.gl_on_ReloadTime = 2.6
SWEP.gl_on_ReloadHalt = 3.17

if CLIENT then
	function SWEP:updateOtherParts()
		-- self.AttachmentModelsVM.cover_dn.active = self:getActiveAttachmentInCategory(3) == nil
		-- self.AttachmentModelsVM.cover_rt.active = !self.ActiveAttachments.kk_ins2_gl_m203
		
		self.AttachmentModelsVM.cover_dn_ln.active = self:getActiveAttachmentInCategory(3) == nil
		self.AttachmentModelsVM.cover_dn_sh_ft.active = self.ActiveAttachments.kk_ins2_vertgrip
		self.AttachmentModelsVM.cover_rt_ln.active = self:getActiveAttachmentInCategory(4) == nil
		self.AttachmentModelsVM.cover_rt_sh_bk.active = !self.AttachmentModelsVM.cover_rt_ln.active
		self.AttachmentModelsVM.cover_lt_sh_ft.active = self.ActiveAttachments.kk_ins2_gl_m203
		self.AttachmentModelsVM.cover_lt_ln.active = !self.AttachmentModelsVM.cover_lt_sh_ft.active

		local hasInstalledScope = self:getActiveAttachmentInCategory(1) != nil
		local isBipod = self.dt.INS2GLActive //self.dt.BipodDeployed
		
		-- //bipod aimpos switch // yea, bipod, ofc
		-- if self.ActiveAttachments.kk_ins2_magnifier then
			-- local name = "KKINS2Magnifier"
			-- if isBipod then
				-- self[name .. "Pos"] = self[name .. "Pos_gl"]
				-- self[name .. "Ang"] = self[name .. "Ang_gl"]
			-- else
				-- self[name .. "Pos"] = self[name .. "Pos_def"]
				-- self[name .. "Ang"] = self[name .. "Ang_def"]
			-- end
			-- self.AimPos = self[name .. "Pos"]
			-- self.AimAng = self[name .. "Ang"]
		-- elseif hasInstalledScope then
			-- local sight = CustomizableWeaponry.sights[self:getActiveAttachmentInCategory(1)]
			-- if isBipod then
				-- self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_gl"]
				-- self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_gl"]
			-- else
				-- self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_def"]
				-- self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_def"]
			-- end
			-- self.AimPos = self[sight.aimPos[1]]
			-- self.AimAng = self[sight.aimPos[2]]
		-- else
			-- if isBipod then
				-- self.IronsightPos = self.IronsightPos_gl
				-- self.IronsightAng = self.IronsightAng_gl
			-- else
				-- self.IronsightPos = self.IronsightPos_def
				-- self.IronsightAng = self.IronsightAng_def
			-- end
			-- self.AimPos = self.IronsightPos
			-- self.AimAng = self.IronsightAng
		-- end
		
		if isBipod then
			self.AimPos = self.M203Pos
			self.AimAng = self.M203Ang
		else
			if self.ActiveAttachments.kk_ins2_magnifier then
				local name = "KKINS2Magnifier"
				self.AimPos = self[name .. "Pos"]
				self.AimAng = self[name .. "Ang"]
			elseif hasInstalledScope then
				local sight = CustomizableWeaponry.sights[self:getActiveAttachmentInCategory(1)]
				self.AimPos = self[sight.aimPos[1]]
				self.AimAng = self[sight.aimPos[2]]
			else
				self.AimPos = self.IronsightPos
				self.AimAng = self.IronsightAng
			end
		end
		
		local vm = self.CW_VM
		local cycle = vm:GetCycle()
		
		if (self.Sequence == self.Animations.gl_turn_on or self.Sequence == self.Animations.gl_on_draw) and cycle > 0.9 then
			self:playAnim("gl_on_fire",1,1) 
		end
		
	end
end