AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "GP25"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.Shell = "KK_INS2_545x39"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_gl_gp25"] = {model = "models/weapons/upgrades/a_gl_gp25.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["40mm_kk_1337"] = {model = "models/weapons/w_at4_projectile.mdl", bone = "GL_Round", pos = Vector(1.75,0,0), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85),
			active = function(self)
				local correctAmmo = CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM] and CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM].name == "40mm_kk_1337"
				local nadeVisible = self.AttachmentModelsVM.kk_ins2_gl_gp25.active and self.M203Chamber or (self.Sequence == self.Animations.gl_on_reload and self.CW_VM:GetCycle() > 0.2)
				return correctAmmo and nadeVisible
			end
		},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_6.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["handguardStandard"] = {model = "models/weapons/upgrades/w_standard_ak74.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_foregrip_wood_2.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["kk_ins2_gl_gp25_merge"] = {model = "models/weapons/upgrades/w_gp25.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_gl_gp25"] = {model = "models/weapons/upgrades/w_gp25.mdl", attachment = "gl", pos = Vector(-10.75,0.2,0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	-- SWEP.IronsightPos = Vector(-2.305, -4, 0.375)
	-- SWEP.IronsightAng = Vector(0.35, 0.03, 0)
	
	-- SWEP.KKINS2AimpointPos = Vector(-2.305, -2, -0.45)
	-- SWEP.KKINS2AimpointAng = Vector(0, -0.02, 0)
	
	-- SWEP.KKINS2MagnifierPos = Vector(-2.305, -2, -0.45)
	-- SWEP.KKINS2MagnifierAng = Vector(0.1, -0.02, 0)
	
	SWEP.IronsightPos = Vector(-2.305, -4, 0.375)
	SWEP.IronsightAng = Vector(0.35, 0.03, 0)
	
	SWEP.KKINS2CSTMSureShotPos = Vector(-2.305, -2, -0.25)
	SWEP.KKINS2CSTMSureShotAng = Vector(0, -0.02, 0)
	
	SWEP.KKINS2CSTMBarskaPos = Vector(-2.305, -2, -0.45)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, -0.02, 0)
	
	SWEP.KKINS2AimpointPos = Vector(-2.305, -2, -0.45)
	SWEP.KKINS2AimpointAng = Vector(0, -0.02, 0)
	
	SWEP.KKINS2MagnifierPos = Vector(-2.305, -2, -0.45)
	SWEP.KKINS2MagnifierAng = Vector(0.1, -0.02, 0)
	
	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.3057, -2, -0.4334)
	SWEP.KKINS2CSTMMicroT1Ang = Vector(0, 0, 0)

	
	-- SWEP.IronsightPos_def = Vector(-2.305, -4, 0.375)
	-- SWEP.IronsightAng_def = Vector(0.35, 0.03, 0)
	
	-- SWEP.KKINS2CSTMSureShotPos_def = Vector(-2.305, -2, -0.25)
	-- SWEP.KKINS2CSTMSureShotAng_def = Vector(0, -0.02, 0)
	
	-- SWEP.KKINS2CSTMBarskaPos_def = Vector(-2.305, -2, -0.45)
	-- SWEP.KKINS2CSTMBarskaAng_def = Vector(0, -0.02, 0)
	
	-- SWEP.KKINS2AimpointPos_def = Vector(-2.305, -2, -0.45)
	-- SWEP.KKINS2AimpointAng_def = Vector(0, -0.02, 0)
	
	-- SWEP.KKINS2MagnifierPos_def = Vector(-2.305, -2, -0.45)
	-- SWEP.KKINS2MagnifierAng_def = Vector(0.1, -0.02, 0)
	
	-- SWEP.IronsightPos_gl = Vector(-2.8231, -4, 0.5268)
	-- SWEP.IronsightAng_gl = Vector(-1.045, 0.056, 0)

	-- SWEP.KKINS2CSTMSureShotPos_gl = Vector(-2.8393, -2, -0.01)
	-- SWEP.KKINS2CSTMSureShotAng_gl = Vector(-1.4224, 0.0938, 0)

	-- SWEP.KKINS2CSTMBarskaPos_gl = Vector(-2.8393, -2, -0.2488)
	-- SWEP.KKINS2CSTMBarskaAng_gl = Vector(-1.4224, 0.0938, 0)

	-- SWEP.KKINS2AimpointPos_gl = Vector(-2.8393, -2, -0.2488)
	-- SWEP.KKINS2AimpointAng_gl = Vector(-1.4224, 0.0938, 0)

	-- SWEP.KKINS2MagnifierPos_gl = Vector(-2.8562, -2, -0.227)
	-- SWEP.KKINS2MagnifierAng_gl = Vector(-1.5, -0.02, 0)

	
	SWEP.M203Pos = Vector(-1.0384, -4, 0.8356)
	SWEP.M203Ang = Vector(1.0405, -0.0059, 0)

	SWEP.CustomizationMenuScale = 0.016
end

SWEP.Attachments = {
	{header = "Under", offset = {-500, 0}, atts = {"kk_ins2_gl_gp25"}},
}

SWEP.Animations = {
	draw = "glsetup_draw", // coz drawanimfunc doesnt play always
	
	base_pickup = "gl_draw",
	base_draw = "gl_draw",
	base_fire = "gl_fire",
	base_fire_aim = {"gl_iron_fire","gl_iron_fire_a","gl_iron_fire_b","gl_iron_fire_c","gl_iron_fire_d","gl_iron_fire_e","gl_iron_fire_f"},
	base_fire_empty = "gl_dryfire",
	base_fire_empty_aim = "gl_iron_dryfire",
	base_reload = "gl_reload",
	base_reload_empty = "gl_reloadempty",
	base_idle = "gl_draw",
	base_holster = "gl_holster",
	base_firemode = "gl_fireselect",
	base_firemode_aim = "gl_iron_fireselect",
	base_sprint = "gl_sprint",
	base_safe = "gl_down",
	base_safe_aim = "gl_iron_down",

	gl_off_pickup = "gl_draw",
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
	gl_off_firemode_aim = "gl_iron_fireselect",
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

SWEP.ReloadTimes = {
	base_reload = {2.2, 3.15},
	base_reloadempty = {2.2, 4.35},
	foregrip_reload = {2.2, 3.15},
	foregrip_reloadempty = {2.2, 4.35},
	gl_reload = {2.2, 3.15},
	gl_reloadempty = {2.2, 4.35},
	glsetup_reload = {1.75, 2.67}
}

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	base_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	base_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_AK74_RATTLE"},
	},

	base_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_AK74_RATTLE"},
		{time = 96/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 102/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	foregrip_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
	},

	foregrip_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
		{time = 98/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	foergrip_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	foregrip_iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	gl_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 12/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
		{time = 27/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 39/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	gl_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	gl_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	gl_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	gl_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	gl_reload = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
	},

	gl_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_AK74_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_AK74_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_AK74_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_AK74_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_AK74_RATTLE"},
		{time = 98/30, sound = "CW_KK_INS2_AK74_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_AK74_BOLTRELEASE"},
	},

	gl_iron_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_AK74_EMPTY"},
	},

	gl_iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_AK74_FIRESELECT"},
	},

	glsetup_in = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_SELECT"},
	},

	glsetup_out = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_DESELECT"},
	},

	glsetup_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_dryfire = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_EMPTY"},
	},

	glsetup_iron_dryfire = {
		{time = 0/31, sound = "CW_KK_INS2_GP30_EMPTY"},
	},

	glsetup_reload = {
		{time = 0, sound = "CW_KK_INS2_GL_BEGINRELOAD"},
		{time = 40/30, sound = "CW_KK_INS2_GP30_INSERTGRENADE"},
		{time = 54/30, sound = "CW_KK_INS2_GP30_INSERTGRENADECLICK"},
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
SWEP.ViewModel		= "models/weapons/v_ak74.mdl"
SWEP.WorldModel		= "models/weapons/w_ak74.mdl"

SWEP.WMPos = Vector(5.666, 0.66, -1.055)
SWEP.WMAng = Angle(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "40MM"

SWEP.FireDelay = 0.092307692307692
SWEP.FireSound = "CW_KK_INS2_AK74_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_AK74_FIRE_SUPPRESSED"
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
		
	end
end