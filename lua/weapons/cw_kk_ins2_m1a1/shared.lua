AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "KK_INS2_762x33"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_standard_m1a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_m1a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_mag_m1a1_15"] = {model = "models/weapons/upgrades/a_magazine_m1a1_15.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/a_magazine_m1a1_30.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
		
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimpoint_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/w_standard_m1a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_m1a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_mag_m1a1_15"] = {model = "models/weapons/upgrades/w_magazine_m1a1_15.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/w_magazine_m1a1_30.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_ins_foregrip.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.3578, -3, -0.1792)
	SWEP.KKINS2CSTMBarskaAng = Vector(-0.5, 0, 0)

	SWEP.IronsightPos = Vector(-2.3654, -2, 0.9924)
	SWEP.IronsightAng = Vector(0, 0.03, 0)

	SWEP.KKINS2AimpointPos = Vector(-2.3836, -3, -0.3407)
	SWEP.KKINS2AimpointAng = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.3664, -3, -0.181)
	SWEP.KKINS2MagnifierAng = Vector(-1.12, 0, 0)

	SWEP.CustomizationMenuScale = 0.017
end

SWEP.Attachments = {
	{header = "Sight", offset = {500, -500},  atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint"}},
	{header = "Barrel", offset = {-200, -500},  atts = {"md_saker"}},
	{header = "Under", offset = {-500, 0},  atts = {"kk_ins2_vertgrip"}},
	{header = "Extras", offset = {125, 100}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "MagZ", offset = {-50, 500}, atts = {"kk_ins2_mag_m1a1_30"}},
	{header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready", // coz drawanimfunc doesnt play always
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_mm = "base_reload_ext",
	base_reload_empty = "base_reloadempty",
	base_reload_empty_mm = "base_reloadempty_ext",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_fire = "foregrip_fire",
	foregrip_fire_aim = "foregrip_iron_fire",
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_mm = "foregrip_reload_ext",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_reload_empty_mm = "foregrip_reloadempty_ext",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 10/30, sound = "CW_KK_INS2_M1A1_BOLTBACK"},
		{time = 23/30, sound = "CW_KK_INS2_M1A1_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M1A1_EMPTY"},
	},

	base_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 67/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
	},

	base_reload_ext = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 67/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
	},

	base_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 65/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
		{time = 101/30, sound = "CW_KK_INS2_M1A1_BOLTBACK"},
		{time = 115/30, sound = "CW_KK_INS2_M1A1_BOLTRELEASE"},
	},

	base_reloadempty_ext = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 65/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
		{time = 101/30, sound = "CW_KK_INS2_M1A1_BOLTBACK"},
		{time = 115/30, sound = "CW_KK_INS2_M1A1_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M1A1_EMPTY"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 10/30, sound = "CW_KK_INS2_M1A1_BOLTBACK"},
		{time = 23/30, sound = "CW_KK_INS2_M1A1_BOLTRELEASE"},
	},

	foregrip_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M1A1_EMPTY"},
	},

	foregrip_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 67/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
	},

	foregrip_reload_ext = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 67/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
	},

	foregrip_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 65/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
		{time = 101/30, sound = "CW_KK_INS2_M1A1_BOLTBACK"},
		{time = 115/30, sound = "CW_KK_INS2_M1A1_BOLTRELEASE"},
	},

	foregrip_reloadempty_ext = {
		{time = 16/30, sound = "CW_KK_INS2_M1A1_MAGRELEASE"},
		{time = 24/30, sound = "CW_KK_INS2_M1A1_MAGOUT"},
		{time = 65/30, sound = "CW_KK_INS2_M1A1_MAGIN"},
		{time = 101/30, sound = "CW_KK_INS2_M1A1_BOLTBACK"},
		{time = 115/30, sound = "CW_KK_INS2_M1A1_BOLTRELEASE"},
	},

	foregrip_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M1A1_EMPTY"},
	},
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_m1a1.mdl"
SWEP.WorldModel		= "models/weapons/w_m1a1.mdl"

SWEP.WMPos = Vector(4.986, 0.921, -1.038)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".30 Carbine"

SWEP.FireDelay = 60/900
SWEP.FireSound = "CW_KK_INS2_M1A1_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M1A1_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 42

SWEP.FirstDeployTime = 1.5
SWEP.DeployTime = 0.5

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.ReloadSpeed = 1
SWEP.base_ReloadTime = 2.25
SWEP.base_ReloadTime_Empty = 2.25
SWEP.base_ReloadHalt = 3.05
SWEP.base_ReloadHalt_Empty = 4.55

SWEP.SnapToIdlePostReload = false

if CLIENT then 
	function SWEP:updateOtherParts()
		local active = self.ActiveAttachments
	
		self.AttachmentModelsVM.kk_ins2_mag_m1a1_15.active = !active.kk_ins2_mag_m1a1_30
	end
end
