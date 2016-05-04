AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AKS74U"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.Shell = "KK_INS2_545x39"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_07.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["handguardStandard"] = {model = "models/weapons/upgrades/a_standard_aks74u.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		-- ["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_ak.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_aks.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_woodgrips_aks74u.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_7.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["handguardStandard"] = {model = "models/weapons/upgrades/w_standard_aks74u.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_foregrip_aks74u.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_gl_gp25"] = {model = "models/weapons/upgrades/w_gp25.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.3, -2, 0.13)
	SWEP.IronsightAng = Vector(0.55, 0.05, 0)
	
	SWEP.KKINS2AimpointPos = Vector(-2.305, -2, -0.45)	// acceptable
	SWEP.KKINS2AimpointAng = Vector(0, -0.02, 0)
	
	SWEP.KKINS2EoTechPos = Vector(-2.3088, -2, -0.4859)
	SWEP.KKINS2EoTechAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.3067, -2, -0.4756)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)

	SWEP.KKINS2KobraPos = Vector(-2.3041, -2, -0.3178)
	SWEP.KKINS2KobraAng = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.305, -1, -0.45)
	SWEP.KKINS2MagnifierAng = Vector(-0.6, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.0145
end

SWEP.Attachments = {
	{header = "Sight", offset = {400, -500},  atts = {"kk_ins2_kobra", "kk_ins2_cstm_barska", "kk_ins2_eotech", "kk_ins2_aimpoint"}},
	{header = "Barrel", offset = {-200, -500},  atts = {"md_saker"}},
	{header = "Under", offset = {-500, -100},  atts = {"kk_ins2_vertgrip"}},
	{header = "Extras", offset = {0, 100}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "More Sight", offset = {1000, -100}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {700, 300}, atts = {"am_magnum", "am_matchgrade"}}
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
	foregrip_fire_aim = {"foregrip_iron_fire", "foregrip_iron_fire_2"},
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire_b",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_firemode = "foregrip_fireselect",
	foregrip_firemode_aim = "foregrip_iron_fireselect",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
}

SWEP.ReloadTimes = {
	base_reload = {2.2, 3.15},
	base_reloadempty = {2.2, 4.35},
	foregrip_reload = {2.2, 3.15},
	foregrip_reloadempty = {2.2, 4.35}
}
		
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AKS74U_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AKS74U_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AKS74U_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_AKS74U_EMPTY"},
	},

	base_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AKS74U_FIRESELECT"},
	},

	base_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AKS74U_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AKS74U_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AKS74U_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AKS74U_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_AKS74U_RATTLE"},
	},

	base_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AKS74U_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AKS74U_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AKS74U_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AKS74U_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_AKS74U_RATTLE"},
		{time = 98/30, sound = "CW_KK_INS2_AKS74U_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_AKS74U_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_AKS74U_EMPTY"},
	},

	iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AKS74U_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AKS74U_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AKS74U_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AKS74U_BOLTRELEASE"},
	},

	foregrip_draw_b = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_AKS74U_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AKS74U_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AKS74U_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AKS74U_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AKS74U_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AKS74U_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AKS74U_RATTLE"},
	},

	foregrip_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AKS74U_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AKS74U_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AKS74U_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AKS74U_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AKS74U_RATTLE"},
		{time = 98/30, sound = "CW_KK_INS2_AKS74U_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_AKS74U_BOLTRELEASE"},
	},

	foregrip_iron_dryfire_b = {
		{time = 0, sound = "CW_KK_INS2_AKS74U_EMPTY"},
	},

	foregrip_iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AKS74U_FIRESELECT"},
	},
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
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
SWEP.ViewModel		= "models/weapons/v_aks74u.mdl"
SWEP.WorldModel		= "models/weapons/w_aks74u.mdl"

SWEP.WMPos =Vector(5.524, 0.66, -1.188)
SWEP.WMAng = Angle(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay = 60/700
SWEP.FireSound = "CW_KK_INS2_AKS74U_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_AKS74U_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 33

SWEP.FirstDeployTime = 2
SWEP.DeployTime = 0.6

if CLIENT then 
	function SWEP:updateOtherParts()
		if self.ActiveAttachments.kk_ins2_vertgrip then
			self.AttachmentModelsVM.handguardStandard.active = false
		else
			self.AttachmentModelsVM.handguardStandard.active = true
		end
	end
end