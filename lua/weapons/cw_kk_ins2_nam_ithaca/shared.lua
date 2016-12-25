if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Ithaca"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_nam_ithaca37")
	
	SWEP.NoShells = true
	SWEP.Shell = "KK_INS2_12guage"
	-- SWEP.ShellDelay = 13/30
	
	SWEP.ShellViewAngleAlign = {Forward = 90, Right = 0, Up = 0}
	
	SWEP.AttachmentModelsVM = {
		["std_mag"] = {model = "models/weapons/upgrades/a_ithaca_standard.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["ext_mag"] = {model = "models/weapons/upgrades/a_ithaca_mag.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_ithaca_namonet.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_sling"] = {model = "models/weapons/upgrades/a_ithaca_sling.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		-- ["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_kar98k_bayonet.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.0257, -2.5, 0.962)
	SWEP.IronsightAng = Vector(0.3882, 0, 0)

	SWEP.CustomizationMenuScale = 0.015
end

SWEP.MuzzleEffect = "muzzleflash_ithica_1p"
SWEP.MuzzleEffectWorld = "muzzleflash_ithica_3p"

SWEP.Attachments = {
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_slugrounds", "am_flechetterounds"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire_1", "base_fire_2", "base_firelast"},
	base_fire_aim = {"iron_fire_1", "iron_fire_2", "iron_fire_last"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_bolt = {"base_fire_cock_1", "base_fire_cock_2"},
	base_bolt_aim = {"iron_fire_cock_1", "iron_fire_cock_2"},
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start_empty",
	base_insert = {"base_reload_insert", "base_reload_insert2"},
	base_reload_end = "base_reload_end",
	base_reload_end_empty = "base_reload_end_empty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_sprint_knife = "base_sprint_bayonet",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",
	base_stab = "base_melee",
}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 B2K"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_nam_ithaca37.mdl"
SWEP.WorldModel		= "models/weapons/w_nam_ithaca37.mdl"

SWEP.WMPos = Vector(5, 0.5, -1.8)
SWEP.WMAng = Vector(-15, 3, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted2(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted2(SWEP)

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_KK_INS2_TOZ_FIRE"
SWEP.Recoil = 2

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.4
SWEP.MaxSpreadInc = 0.02
SWEP.ClumpSpread = 0.02
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.85
SWEP.Shots = 12
SWEP.Damage = 11

SWEP.FirstDeployTime = 1.8
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.7

SWEP.Chamberable = true
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = SWEP.FireDelay + 0.2
SWEP.GlobalDelayOnShoot = SWEP.FireDelay

SWEP.WeaponLength = 18

SWEP.MuzzleVelocity = 381

SWEP.ReloadTimes = {
	base_fire_cock_1 = {7/35, 0.4},
	base_fire_cock_2 = {7/35, 0.4},
	iron_fire_cock_1 = {7/35, 0.4},
	iron_fire_cock_2 = {7/35, 0.4},
	
	base_reload_start = {0.65, 0.65},
	base_reload_start_empty = {1.3, 2.2, KK_INS2_SHOTGUN_LOAD_FIRST},
	base_reload_insert = {0.45, 0.93},
	base_reload_insert2 = {0.45, 0.93},
	base_reload_end = {0.6, 0.6},
	base_reload_end_empty = {0.6, 0.6},
}
