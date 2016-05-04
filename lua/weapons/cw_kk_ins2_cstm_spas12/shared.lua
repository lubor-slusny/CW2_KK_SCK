if not CustomizableWeaponry then return end

AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SPAS12"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m3"

	SWEP.Shell = "KK_INS2_12guage"
	SWEP.ShellDelay = 13/30
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail_perma"] = {model = "models/weapons/upgrades/a_modkit_spas12.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_12ga.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_ins2.mdl", pos = Vector(0,0,0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_ins_shotgun.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_ins_shotgun.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(90, 90, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.IronsightPos = Vector(-2.008, -2, 0.9628)
	SWEP.IronsightAng = Vector(-0.1372, 0.04, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.008, -2, -0.17)
	SWEP.KKINS2CSTMBarskaAng = Vector(-0.0009, -0.1104, 0)

	SWEP.KKINS2AimpointPos = Vector(-2.008, -2, -0.17)
	SWEP.KKINS2AimpointAng = Vector(0, -0.1181, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.008, -1, -0.17)
	SWEP.KKINS2MagnifierAng = Vector(-0.35, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.015
end

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = 0.8

SWEP.Attachments = {
	{header = "Sight", offset = {500, -450},  atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint"}},
	{header = "Barrel", offset = {-200, -450},  atts = {"md_saker"}},
	{header = "Under", offset = {-500, 0},  atts = {"kk_ins2_vertgrip"}},
	{header = "Extras", offset = {125, 200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_slugrounds", "am_flechetterounds"}}
}

SWEP.Animations = {
	draw = "base_ready",
	reload_start = "",
	insert = "",
	reload_end = "",
	idle = "",	
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire","base_fire_2"},
	base_fire_aim = {"iron_fire_1","iron_fire_2"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload_start = "base_reload_start",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end",
	base_reload_empty_end = "base_reload_end_empty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_fire = {"foregrip_fire_1","foregrip_fire_2"},
	foregrip_fire_aim = {"foregrip_iron_fire_1","foregrip_iron_fire_2"},
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_reload_start = "foregrip_reload_start",
	foregrip_insert = "foregrip_reload_insert",
	foregrip_reload_end = "foregrip_reload_end",
	foregrip_reload_empty_end = "foregrip_reload_end_empty",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
}
	
SWEP.Sounds = {
	base_draw = {
		{time = 0, sound = "INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "INS2_UNIVERSAL_HOLSTER"},
	},

	base_ready = {
		{time = 0, sound = "INS2_UNIVERSAL_DRAW"},
		{time = 26/30, sound = "INS2_TOZ_PUMPBACK"},
		{time = 36/30, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	base_crawl = {
		{time = 15/30, sound = "INS2_UNIVERSAL_kk_ins2_rightCrawl"},
		{time = 38/30, sound = "INS2_UNIVERSAL_LeftCrawl"},
	},

	base_fire = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 14 ""},
		{time = 13/30, sound = "INS2_TOZ_PUMPBACK"},
		{time = 18/30, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	base_fire_2 = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 14 ""},
		{time = 13/30, sound = "INS2_TOZ_PUMPBACK"},
		{time = 18/30, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	base_dryfire = {
		{time = 0, sound = "INS2_TOZ_EMPTY"},
	},

	base_reload_start = {
		{time = 5/30, sound = "INS2_UNIVERSAL_LeanIn"},
	},

	base_reload_start_empty = {
		{time = 5/30, sound = "INS2_UNIVERSAL_LeanIn"},
	},

	base_reload_insert = {
		{time = 5/36, sound = "INS2_TOZ_SHELLINSERT"},
	},

	base_reload_end = {
		{time = 5/35, sound = "INS2_UNIVERSAL_LeanIn"},
	},

	base_reload_end_empty = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 15 ""},
		{time = 14/35, sound = "INS2_TOZ_PUMPBACK"},
		{time = 24/35, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	-- iron_fire_1 = {
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		-- {time = 22/40, sound = "INS2_TOZ_PUMPBACK"},
		-- {time = 30/40, sound = "INS2_TOZ_PUMPFORWARD"},
	-- },

	-- iron_fire_2 = {
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		-- {time = 22/40, sound = "INS2_TOZ_PUMPBACK"},
		-- {time = 30/40, sound = "INS2_TOZ_PUMPFORWARD"},
	-- },

	iron_fire_1 = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		{time = 22/50, sound = "INS2_TOZ_PUMPBACK"},
		{time = 30/50, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	iron_fire_2 = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		{time = 22/50, sound = "INS2_TOZ_PUMPBACK"},
		{time = 30/50, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	iron_dryfire = {
		{time = 0, sound = "INS2_TOZ_EMPTY"},
	},

	foregrip_draw = {
		{time = 0, sound = "INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_ready = {
		{time = 0, sound = "INS2_UNIVERSAL_DRAW"},
		{time = 26/30, sound = "INS2_TOZ_PUMPBACK"},
		{time = 36/30, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	foregrip_crawl = {
		{time = 0, sound = "INS2_UNIVERSAL_LeftCrawl"},
		{time = 22/30, sound = "INS2_UNIVERSAL_kk_ins2_rightCrawl"},
	},

	foregrip_fire_1 = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 14 ""},
		{time = 13/30, sound = "INS2_TOZ_PUMPBACK"},
		{time = 18/30, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	foregrip_fire_2 = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 14 ""},
		{time = 13/30, sound = "INS2_TOZ_PUMPBACK"},
		{time = 18/30, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	foregrip_dryfire = {
		{time = 0, sound = "INS2_TOZ_EMPTY"},
	},

	foregrip_reload_start = {
		{time = 5/30, sound = "INS2_UNIVERSAL_LeanIn"},
	},

	foregrip_reload_start_empty = {
		{time = 5/30, sound = "INS2_UNIVERSAL_LeanIn"},
	},

	foregrip_reload_insert = {
		{time = 5/36, sound = "INS2_TOZ_SHELLINSERT"},
	},

	foregrip_reload_end = {
		{time = 5/35, sound = "INS2_UNIVERSAL_LeanIn"},
	},

	foregrip_reload_end_empty = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 15 ""},
		{time = 14/35, sound = "INS2_TOZ_PUMPBACK"},
		{time = 24/35, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	-- foregrip_iron_fire_1 = {
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		-- {time = 22/40, sound = "INS2_TOZ_PUMPBACK"},
		-- {time = 30/40, sound = "INS2_TOZ_PUMPFORWARD"},
	-- },

	-- foregrip_iron_fire_2 = {
		-- // { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		-- {time = 22/40, sound = "INS2_TOZ_PUMPBACK"},
		-- {time = 30/40, sound = "INS2_TOZ_PUMPFORWARD"},
	-- },

	foregrip_iron_fire_1 = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		{time = 22/50, sound = "INS2_TOZ_PUMPBACK"},
		{time = 30/50, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	foregrip_iron_fire_2 = {
		// { event AE_CL_CREATE_PARTICLE_BRASS 23 ""},
		{time = 22/50, sound = "INS2_TOZ_PUMPBACK"},
		{time = 30/50, sound = "INS2_TOZ_PUMPFORWARD"},
	},

	foregrip_iron_dryfire = {
		{time = 0, sound = "INS2_TOZ_EMPTY"},
	},
}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WS"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_cstm_spas12.mdl"
SWEP.WorldModel		= "models/weapons/w_toz.mdl"

SWEP.WMPos = Vector(5.314, 0.759, -2.971)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.wsContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.wsContentMounted()

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.8
SWEP.FireSound = "CW_KK_INS2_TOZ_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_TOZ_FIRE_SUPPRESSED"
SWEP.Recoil = 3

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.013
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 10

SWEP.FirstDeployTime = 2.1
SWEP.DeployTime = 0.71

SWEP.ReloadSpeed = 1

SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.72
SWEP.ReloadFinishWait = 1.51
