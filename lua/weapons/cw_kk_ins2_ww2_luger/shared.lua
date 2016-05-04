if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "pistolMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Luger P08"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.Shell = "KK_INS2_9x19"
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-1.7612, 0, 0.9093)
	SWEP.IronsightAng = Vector(0.3285, 0.0045, 0)

	SWEP.CustomizationMenuScale = 0.01
	SWEP.ReloadViewBobEnabled = false
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.WeaponLength = 16

SWEP.Attachments = {
	["+reload"] = {header = "Ammo", offset = {500, 50}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.KK_INS2_emptyIdle = true

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire = {"base_fire","base_fire2","base_fire3"},
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3"},
	base_fire_last = "base_firelast",
	base_fire_last_aim = "iron_firelast",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_mm = "base_reload_extmag",
	base_reload_empty = "base_reloadempty",
	base_reload_empty_mm = "base_reloadempty_extmag",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "empty_holster",
	base_sprint = "base_sprint",
	base_sprint_empty = "empty_sprint",
	base_safe = "base_down",
	base_safe_empty = "empty_down",
	base_safe_aim = "iron_down",
	base_safe_empty_aim = "empty_iron_down",
}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
		{time = 4/30, sound = "CW_KK_INS2_MAKAROV_SAFETY"},
		{time = 9/30, sound = "CW_KK_INS2_MAKAROV_BOLTBACK"},
		{time = 19/30, sound = "CW_KK_INS2_MAKAROV_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0/30, sound = "CW_KK_INS2_MAKAROV_EMPTY"},
	},

	base_reload = {
		{time = 0/30, sound = "CW_KK_INS2_MAKAROV_MAGRELEASE"},
		{time = 7/30, sound = "CW_KK_INS2_MAKAROV_MAGOUT"},
		{time = 35/30, sound = "CW_KK_INS2_MAKAROV_MAGIN"},
		{time = 58/30, sound = "CW_KK_INS2_MAKAROV_MAGHIT"},
	},

	base_reload_extmag = {
		{time = 0/30, sound = "CW_KK_INS2_MAKAROV_MAGRELEASE"},
		{time = 7/30, sound = "CW_KK_INS2_MAKAROV_MAGOUT"},
		{time = 35/30, sound = "CW_KK_INS2_MAKAROV_MAGIN"},
		{time = 58/30, sound = "CW_KK_INS2_MAKAROV_MAGHIT"},
	},

	base_reloadempty = {
		{time = 0/30, sound = "CW_KK_INS2_MAKAROV_MAGRELEASE"},
		{time = 7/30, sound = "CW_KK_INS2_MAKAROV_MAGOUT"},
		{time = 35/30, sound = "CW_KK_INS2_MAKAROV_MAGIN"},
		{time = 58/30, sound = "CW_KK_INS2_MAKAROV_MAGHIT"},
		{time = 71/30, sound = "CW_KK_INS2_MAKAROV_BOLTRELEASE"},
	},

	base_reloadempty_extmag = {
		{time = 0/30, sound = "CW_KK_INS2_MAKAROV_MAGRELEASE"},
		{time = 7/30, sound = "CW_KK_INS2_MAKAROV_MAGOUT"},
		{time = 35/30, sound = "CW_KK_INS2_MAKAROV_MAGIN"},
		{time = 58/30, sound = "CW_KK_INS2_MAKAROV_MAGHIT"},
		{time = 71/30, sound = "CW_KK_INS2_MAKAROV_BOLTRELEASE"},
	},

	empty_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	empty_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MAKAROV_EMPTY"},
	},
}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_lugerp08.mdl"
SWEP.WorldModel		= "models/weapons/w_lugerp08.mdl"

SWEP.WMPos = Vector(4.5, 1, -3.5)
SWEP.WMAng = Vector(-8, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_WW2_LUGER_FIRE"
SWEP.Recoil = 0.77

SWEP.HipSpread = 0.034
SWEP.AimSpread = 0.012
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.22
SWEP.Shots = 1
SWEP.Damage = 19

SWEP.FirstDeployTime = 1.1
SWEP.DeployTime = 0.37

SWEP.ReloadTime = 2.05
SWEP.ReloadHalt = 2.57

SWEP.ReloadTime_Empty = 2.05
SWEP.ReloadHalt_Empty = 3.7
