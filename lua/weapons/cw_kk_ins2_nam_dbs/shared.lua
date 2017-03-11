if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "DBS"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_nam_izh43")
	
	SWEP.NoShells = true
	SWEP.Shell = "KK_INS2_12guage"
	
	SWEP.ShellViewAngleAlign = {Forward = 0, Right = 0, Up = 0}
	
	SWEP.AttachmentModelsVM = {}
	
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-1.7707, -2.5, 1.0321)
	SWEP.IronsightAng = Vector(0.6919, 0, 0)

	SWEP.CustomizationMenuScale = 0.015
end

SWEP.MuzzleEffect = "muzzleflash_ithica_1p"
SWEP.MuzzleEffectWorld = "muzzleflash_ithica_3p"

SWEP.Attachments = {
	-- {header = "Barrel", offset = {0, -200}, atts = {"kk_ins2_suppressor_shotgun"}},
	-- {header = "Under", offset = {0, 400}, atts = {"kk_ins2_vertgrip"}},
	-- {header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	["+reload"] = {header = "Ammo", offset = {1000, 400}, atts = {"am_slugrounds", "am_flechetterounds"}}
}

SWEP.Animations = {
	base_pickup = {"base_ready", "base_ready2"},
	base_draw = "base_draw",
	base_fire = {"base_fire", "base_firelast"},
	base_fire_aim = {"iron_fire", "iron_firelast"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 B2K"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_nam_doublebarrel.mdl"
SWEP.WorldModel		= "models/weapons/w_doublebarrel.mdl"

SWEP.WMPos = Vector(5, 0.5, -1.8)
SWEP.WMAng = Vector(-15, 3, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_M590_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_TOZ_FIRE_SUPPRESSED"
SWEP.Recoil = 4

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.4
SWEP.MaxSpreadInc = 0.02
SWEP.ClumpSpread = 0.02
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.85
SWEP.Shots = 12
SWEP.Damage = 15

SWEP.FirstDeployTime = 2.2
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.6

SWEP.Chamberable = false

SWEP.WeaponLength = 24

SWEP.MuzzleVelocity = 381

SWEP.ReloadTimes = {
	base_reload = {2.95, 4.3},
	base_reloadempty = {4.2, 5.9},
}
