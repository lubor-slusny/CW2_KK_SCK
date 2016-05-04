if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MG-42"
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	
	SWEP.Shell = "KK_INS2_762x54"
	SWEP.MuzzleEffect = "muzzleflash_6"

	SWEP.AttachmentModelsVM = {		
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		-- ["kk_counter"] = {model = "models/weapons/stattrack.mdl", bone = "Weapon", pos = Vector(0.026, -7.802, 3.993), angle = Angle(0, 0, 72), size = Vector(0.699, 0.699, 0.699)},
		["kk_counter"] = {model = "models/weapons/stattrack.mdl", bone = "Weapon", pos = Vector(0.026, -7.77, 4.057), angle = Angle(0, 0, 50), size = Vector(0.699, 0.699, 0.699)},
		["kk_textbox"] = {model = "models/weapons/uid.mdl", bone = "LidCont", pos = Vector(0.441, -5.015, -0.156), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.CustomizePos = Vector(4.488, -1.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.IronsightPos = Vector(-2.3517, -2, 1.2473)
	SWEP.IronsightAng = Vector(0.0334, 0, 0)

	SWEP.KKINS_implicitBipod = true
	SWEP.CustomizationMenuScale = 0.015
end

SWEP.Chamberable = false
SWEP.BipodInstalled = true

SWEP.Attachments = {
	["+reload"] = {header = "Ammo", offset = {200, 600}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready", // coz drawanimfunc doesnt play always
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire_1","base_fire_2"},
	base_fire_aim = {"iron_fire_1","iron_fire_2"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",				// tacticool
	base_reload_empty = "base_reload_empty",	// empty, dryfired
	base_reload_empty_charged = "base_reload",				// empty, charged
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	bipod_in = "deployed_in",
	bipod_fire = {"deployed_fire_1","deployed_fire_2"},
	bipod_fire_aim = {"deployed_iron_fire_1","deployed_iron_fire_2"},
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload_half",
	bipod_reload_empty = "deployed_reload_empty",
	bipod_reload_empty_charged = "deployed_reload",
	bipod_out = "deployed_out",
}

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 23/30, sound = "CW_KK_INS2_M249_BOLTBACK"},
		{time = 30/30, sound = "CW_KK_INS2_M249_BOLTRELEASE"},
		{time = 56/30, sound = "CW_KK_INS2_M249_SHOULDER"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 15/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 38/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M249_EMPTY"},
	},

	base_reload = {
		{time = 2/31.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 34/31.5, sound = "CW_KK_INS2_M249_COVEROPEN"},
		{time = 69/31.5, sound = "CW_KK_INS2_M249_MAGOUTFULL"},
		{time = 90/31.5, sound = "CW_KK_INS2_M249_FETCHMAG"},
		{time = 129/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 147/31.5, sound = "CW_KK_INS2_M249_MAGHIT"},
		{time = 154/31.5, sound = "CW_KK_INS2_M249_MAGIN"},
		{time = 177/31.5, sound = "CW_KK_INS2_M249_BULLETJINGLE"},
		{time = 184/31.5, sound = "CW_KK_INS2_M249_BELTALIGN"},
		{time = 208/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 226/31.5, sound = "CW_KK_INS2_M249_COVERCLOSE"},
		{time = 263/31.5, sound = "CW_KK_INS2_M249_SHOULDER"},
		// reload at 186/31.5
	},

	base_reload_empty = {
		{time = 2/31.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 32/31.5, sound = "CW_KK_INS2_M249_BOLTBACK"},
		{time = 42/31.5, sound = "CW_KK_INS2_M249_BOLTRELEASE"},
		{time = 77/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 89/31.5, sound = "CW_KK_INS2_M249_COVEROPEN"},
		{time = 111/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 134/31.5, sound = "CW_KK_INS2_M249_MAGOUT"},
		{time = 151/31.5, sound = "CW_KK_INS2_M249_FETCHMAG"},
		{time = 195/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 216/31.5, sound = "CW_KK_INS2_M249_MAGHIT"},
		{time = 223/31.5, sound = "CW_KK_INS2_M249_MAGIN"},
		{time = 238/31.5, sound = "CW_KK_INS2_M249_BULLETJINGLE"},
		{time = 249/31.5, sound = "CW_KK_INS2_M249_BELTALIGN"},
		{time = 273/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 290/31.5, sound = "CW_KK_INS2_M249_COVERCLOSE"},
		{time = 324/31.5, sound = "CW_KK_INS2_M249_SHOULDER"},
		// reload at 150/31.5
	},

	base_reload_half = {
		{time = 2/31.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 13/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 26/31.5, sound = "CW_KK_INS2_M249_COVEROPEN"},
		{time = 63/31.5, sound = "CW_KK_INS2_M249_THROWAWAYREMAINING"},
		{time = 91/31.5, sound = "CW_KK_INS2_M249_MAGOUT"},
		{time = 108/31.5, sound = "CW_KK_INS2_M249_FETCHMAG"},
		{time = 150/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 177/31.5, sound = "CW_KK_INS2_M249_MAGHIT"},
		{time = 185/31.5, sound = "CW_KK_INS2_M249_MAGIN"},
		{time = 201/31.5, sound = "CW_KK_INS2_M249_BULLETJINGLE"},
		{time = 211/31.5, sound = "CW_KK_INS2_M249_BELTALIGN"},
		{time = 233/31.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 252/31.5, sound = "CW_KK_INS2_M249_COVERCLOSE"},
		{time = 289/31.5, sound = "CW_KK_INS2_M249_SHOULDER"},
		// reload at 186/31.5
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M249_EMPTY"},
	},

	deployed_in = {
		{time = 17/38, sound = "CW_KK_INS2_M249_BIPODDEPLOY"},
	},

	deployed_out = {
		{time = 26/38, sound = "CW_KK_INS2_M249_BIPODRETRACT"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M249_EMPTY"},
	},

	deployed_reload = {
		{time = 2/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 34/32.5, sound = "CW_KK_INS2_M249_COVEROPEN"},
		{time = 69/32.5, sound = "CW_KK_INS2_M249_MAGOUTFULL"},
		{time = 90/32.5, sound = "CW_KK_INS2_M249_FETCHMAG"},
		{time = 129/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 147/32.5, sound = "CW_KK_INS2_M249_MAGHIT"},
		{time = 154/32.5, sound = "CW_KK_INS2_M249_MAGIN"},
		{time = 177/32.5, sound = "CW_KK_INS2_M249_BULLETJINGLE"},
		{time = 184/32.5, sound = "CW_KK_INS2_M249_BELTALIGN"},
		{time = 208/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 226/32.5, sound = "CW_KK_INS2_M249_COVERCLOSE"},
		{time = 263/32.5, sound = "CW_KK_INS2_M249_SHOULDER"},
		// reload at 186/32.5
	},

	deployed_reload_half = {
		{time = 2/32.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 13/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 26/32.5, sound = "CW_KK_INS2_M249_COVEROPEN"},
		{time = 63/32.5, sound = "CW_KK_INS2_M249_THROWAWAYREMAINING"},
		{time = 91/32.5, sound = "CW_KK_INS2_M249_MAGOUT"},
		{time = 108/32.5, sound = "CW_KK_INS2_M249_FETCHMAG"},
		{time = 150/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 177/32.5, sound = "CW_KK_INS2_M249_MAGHIT"},
		{time = 185/32.5, sound = "CW_KK_INS2_M249_MAGIN"},
		{time = 201/32.5, sound = "CW_KK_INS2_M249_BULLETJINGLE"},
		{time = 211/32.5, sound = "CW_KK_INS2_M249_BELTALIGN"},
		{time = 233/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 252/32.5, sound = "CW_KK_INS2_M249_COVERCLOSE"},
		{time = 289/32.5, sound = "CW_KK_INS2_M249_SHOULDER"},
		// reload at 186/32.5
	},

	deployed_reload_empty = {
		{time = 2/32.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 32/32.5, sound = "CW_KK_INS2_M249_BOLTBACK"},
		{time = 42/32.5, sound = "CW_KK_INS2_M249_BOLTRELEASE"},
		{time = 77/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 91/32.5, sound = "CW_KK_INS2_M249_COVEROPEN"},
		{time = 111/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 129/32.5, sound = "CW_KK_INS2_M249_MAGOUT"},
		{time = 151/32.5, sound = "CW_KK_INS2_M249_FETCHMAG"},
		{time = 195/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT2"},
		{time = 201/32.5, sound = "CW_KK_INS2_M249_MAGHIT"},
		{time = 217/32.5, sound = "CW_KK_INS2_M249_MAGIN"},
		{time = 234/32.5, sound = "CW_KK_INS2_M249_BULLETJINGLE"},
		{time = 249/32.5, sound = "CW_KK_INS2_M249_BELTALIGN"},
		{time = 273/32.5, sound = "CW_KK_INS2_M249_ARMMOVEMENT1"},
		{time = 283/32.5, sound = "CW_KK_INS2_M249_COVERCLOSE"},
		{time = 324/32.5, sound = "CW_KK_INS2_M249_SHOULDER"},
		// reload at 150/32.5
	},

	deployed_iron_idle = {
		{time = 0, sound = "Universal.IronIdle"},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M249_EMPTY"},
	},
}
	
SWEP.ReloadTimes = {					
	-- base_reload = {186/31.5, 9.5},		//qc
	-- base_reload_half = {186/31.5, 9.84},
	-- base_reload_empty = {150/31.5, 11},
	
	base_reload = {7.3, 9.5},			// CVMT
	base_reload_half = {8, 9.84},
	base_reload_empty = {9.35, 11},
	
	-- deployed_reload = {186/32.5, 8.77},
	-- deployed_reload_half = {186/32.5, 9.5},
	-- deployed_reload_empty = {150/32.5, 10.52},
	
	deployed_reload = {7.1, 8.77},
	deployed_reload_half = {7.9, 9.5},
	deployed_reload_empty = {8.85, 10.52},
}
	
SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_mg42.mdl"
SWEP.WorldModel		= "models/weapons/w_mg42.mdl"

SWEP.WMPos = Vector(5.184, 0.935, -1.03)
SWEP.WMAng = Vector(-10, -1, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 18
SWEP.Primary.DefaultClip	= 18
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.92x57MM"

SWEP.FireDelay = 60/1200
SWEP.FireSound = "CW_KK_INS2_WW2_MG42_FIRE"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 28

SWEP.FirstDeployTime = 3.13
SWEP.DeployTime = 0.83

SWEP.base_ReloadTime = 9.84
SWEP.base_ReloadHalt = 9.84
SWEP.base_ReloadTime_Empty = 9.05
SWEP.base_ReloadHalt_Empty = 9.05
SWEP.base_ReloadTime_EmptyFired = 10.52
SWEP.base_ReloadHalt_EmptyFired = 10.52

SWEP.bipod_ReloadTime = 9.5
SWEP.bipod_ReloadHalt = 9.5
SWEP.bipod_ReloadTime_Empty = 8.7
SWEP.bipod_ReloadHalt_Empty = 8.7
SWEP.bipod_ReloadTime_EmptyFired = 10.52
SWEP.bipod_ReloadHalt_EmptyFired = 10.52

if CLIENT then
	function SWEP:updateOtherParts()
		local vm = self.CW_VM
		local cycle = vm:GetCycle()
		
		local clip = self:Clip1()
		local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo) + clip
		
		if self.Sequence:find("reload") and cycle > 0.4 then
			self:setBodygroup(1,math.Clamp(ammo,0,18))
		else
			self:setBodygroup(1,math.Clamp(clip,0,18))
		end
		
		if self.dt.BipodDeployed then
			self:SetSequence(1)
		else
			self:SetSequence(0)
		end
	end
end
