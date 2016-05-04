if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1903A4 Springfield"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"

	SWEP.Shell = "KK_INS2_762x54"
	SWEP.ShellDelay = 0.14 + 0.4
	
	SWEP.BackupSights = {}
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_mosin.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_zf4"] = {model = "models/weapons/upgrades/a_optic_zf4.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_mosin.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_zf4"] = {model = "models/weapons/upgrades/w_scope_mosin.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.ForegripOverridePos = {
		["LeftHandFix"] = {
			["L Clavicle"] = {scale = Vector(1, 1, 1), pos = Vector(-100,0,0), angle = Angle(0, 0, 0)}
		},
	}
	
	SWEP.IronsightPos = Vector(-2.813, -2, 1.45)
	SWEP.IronsightAng = Vector(-0.03, 0.03, 0)
	
	SWEP.KKINS2ScopeZF4Pos = Vector(-2.8087, -14, 0.3478)
	SWEP.KKINS2ScopeZF4Ang = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.025
end

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = 2
SWEP.GlobalDelayOnShoot = 2

SWEP.WeaponLength = 38

SWEP.Attachments = {
	-- {header = "Sight", offset = {500, -500}, atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_cstm_acog", "kk_ins2_po4", "kk_ins2_scope_mosin", "kk_ins2_scope_m40"}},
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_scope_zf4"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	-- {header = "Under", offset = {-500, 0}, atts = {"kk_ins2_bipod"}},
	-- {header = "Lasers", offset = {125, 200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	-- {header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	reload_start = "",
	insert = "",
	reload_end = "",
	idle = "",	
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire_start",
	base_fire_aim = "iron_fire_start",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_bolt = "base_fire_end",
	base_bolt_aim = "iron_fire_end",
	base_reload_start = "reload_start",
	base_reload_start_empty = "reload_start",
	base_insert = "reload_insert",
	base_reload_end = "reload_end",
	base_reload_end_empty = "reload_end",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_melee = "base_melee",
	
	bipod_in = "deployed_in",
	bipod_fire = "deployed_fire_start",
	bipod_fire_aim = "iron_fire_deployed_start",
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "iron_dryfire_deployed",
	bipod_bolt = "deployed_fire_end",
	bipod_bolt_aim = "iron_fire_deployed_end",
	bipod_reload_start = "deployed_reload_start",
	bipod_reload_start_empty = "deployed_reload_start",
	bipod_insert = "deployed_reload_insert",
	bipod_reload_end = "deployed_reload_end",
	bipod_reload_end_empty = "deployed_reload_end",
	bipod_out = "deployed_out",
}
	
SWEP.Sounds = {
	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 19/25, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 24/25, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 33/25, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 38/25, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
		{time = 56/25, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire_end = {
		// shell @ 15 ""},
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 13/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 24/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 28/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},

	reload_start = {
		// shell @ 15 "MOSIN EJECT"},
		{time = 4/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
	},

	reload_insert = {
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BULLETIN"},
		// reloaded @ 14 ""},
	},

	reload_end = {
		{time = 7/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	iron_fire_end = {
		// shell @ 17 ""},
		{time = 11/28.5, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 15/28.5, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 25/28.5, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		// pumpedrdy @ 27 ""},
		{time = 29/28.5, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
		{time = 45/28.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},

	deployed_in = {
		{time = 12/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART"},
		{time = 16/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND"},
	},

	deployed_out = {
		{time = 6/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT"},
	},

	deployed_fire_end = {
		// shell @ 15 ""},
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 13/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 24/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 28/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},

	deployed_reload_start = {
		// shell @ 15 ""},
		{time = 4/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
	},

	deployed_reload_insert = {
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BULLETIN"},
		// reloaded @ 12 ""},
	},

	deployed_reload_end = {
		{time = 7/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	iron_fire_deployed_end = {
		// shell @ 15 ""},
		{time = 8/34, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 13/34, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 24/34, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 28/34, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	iron_dryfire_deployed = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_springfield.mdl"
SWEP.WorldModel		= "models/weapons/w_springfield.mdl"

SWEP.WMPos = Vector(6.136, 0.786, -1.713)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x54MMR"

SWEP.FireDelay = 1.75
SWEP.FireSound = "CW_KK_INS2_MOSIN_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_MOSIN_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 42

SWEP.FirstDeployTime = 2.9
SWEP.DeployTime = 0.73

SWEP.RecoilToSpread = 0.8 

SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15

SWEP.ReloadStartTime = 0.865
SWEP.ReloadStartTimeEmpty = 0.865
SWEP.InsertShellTime = 0.8
SWEP.ReloadFinishWait = 1.05
SWEP.ReloadFinishWaitEmpty = 1.05

SWEP.SnapToIdlePostReload = false

function SWEP:fireAnimFunc()
	local clip = self:Clip1()
	local mag = ""
	
	if clip == 0 then
		mag = "_empty"
	end
	
	local prefix = self:getForegripMode()
	local suffix = ""
	
	if self:isAiming() then
		suffix = "_aim"
	end
	
	if clip > 0 then
		CustomizableWeaponry.actionSequence.new(self, 0.14, nil, function() 
			local prefix = self:getForegripMode()
			local suffix = ""
			
			if self:isAiming() then
				suffix = "_aim"
			end
			
			self:sendWeaponAnim(prefix .. "bolt" .. suffix,1,0)
		end)
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. mag .. suffix,1,0)
	
end //*/
	