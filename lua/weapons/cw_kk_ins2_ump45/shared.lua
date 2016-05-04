if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "smgMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK UMP .45"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "q"
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.Shell = "KK_INS2_45apc"
	
	SWEP.AttachmentModelsVM = {		
		["md_cobram2"] = {model = "models/weapons/upgrades/a_suppressor_sec2.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_rail.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_rail.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_cobram2"] = {model = "models/weapons/upgrades/w_sil_sec2.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.585, -2, 0.6)
	SWEP.IronsightAng = Vector(0.65, 0, 0)
	
	SWEP.KKINS2AimpointPos = Vector(-2.585, -2, 0.1)
	SWEP.KKINS2AimpointAng = Vector(-0.0789, 0.0136, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.585, -2, 0.1)
	SWEP.KKINS2CSTMBarskaAng = Vector(-0.2, 0.1, 0)
	
	SWEP.KKINS2MagnifierPos = Vector(-2.65, -2, 0.1)
	SWEP.KKINS2MagnifierAng = Vector(-0.3, -0.5, 0)
	
	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.6066, -2, 0.0645)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.013
end

SWEP.Attachments = {
	{header = "Sight", offset = {300, -700}, atts = {"kk_ins2_cstm_barska", "kk_ins2_cstm_eotechxps", "kk_ins2_aimpoint"}},
	{header = "Barrel", offset = {-300, -700}, atts = {"md_cobram2"}},
	{header = "Extras", offset = {-500, -200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	-- {header = "Barrel", offset = {0, 300}, atts = {"kk_ins2_ump45_skin"}},
	{header = "More Sight", offset = {800, -200}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {500, 300}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready", // coz drawanimfunc doesnt play always
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire","iron_fire_a","iron_fire_b","iron_fire_c","iron_fire_d","iron_fire_e","iron_fire_f"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "base_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "base_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_UMP45_BOLTLOCK"},
		{time = 13/30, sound = "CW_KK_INS2_UMP45_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_UMP45_EMPTY"},
	},

	base_fireselect = {
		{time = 6/30, sound = "CW_KK_INS2_UMP45_FIRESELECT"},
	},

	base_reload = {
		{time = 19/30, sound = "CW_KK_INS2_UMP45_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_UMP45_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_UMP45_MAGIN"},
	},

	base_reloadempty = {
		{time = 12/30, sound = "CW_KK_INS2_UMP45_BOLTBACK"},
		{time = 18/30, sound = "CW_KK_INS2_UMP45_BOLTLOCK"},
		{time = 40/30, sound = "CW_KK_INS2_UMP45_MAGRELEASE"},
		{time = 47/30, sound = "CW_KK_INS2_UMP45_MAGOUT"},
		{time = 93/30, sound = "CW_KK_INS2_UMP45_MAGIN"},
		{time = 112/30, sound = "CW_KK_INS2_UMP45_BOLTLOCK"},
		{time = 113/30, sound = "CW_KK_INS2_UMP45_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_UMP45_EMPTY"},
	},

	iron_fireselect = {
		{time = 6/30, sound = "CW_KK_INS2_UMP45_FIRESELECT"},
	},
}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_ump45.mdl"
SWEP.WorldModel		= "models/weapons/w_ump45.mdl"

SWEP.WMPos = Vector(3.88, 0.889, -1.215)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_UMP45_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_UMP45_FIRE_SUPPRESSED"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.7
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 23

SWEP.FirstDeployTime = 1.17
SWEP.DeployTime = 0.65

SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 3.15
SWEP.ReloadHalt_Empty = 4.45