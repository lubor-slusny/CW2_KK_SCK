if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M9A1 Bazooka"
	
	SWEP.SelectFont = "CW_SelectIcons2"
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.RearEffectw = true
	SWEP.NoShells = true
	
	SWEP.AttachmentModelsVM = {
		["rack-it"] = {model = "models/weapons/upgrades/a_warhead_bazooka_1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
	}
	
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-0.8269, -5, 1.5462)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-1.7264, 0, -0.281)
	SWEP.IronsightAng = Vector(7.5622, -0.9048, 13.5897)

	SWEP.SprintAnimSpeed = 1
	SWEP.ViewModelMovementScale_sprint = 0.6
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.CustomizationMenuScale = 0.01
	SWEP.HUD_MagText = "TUBE: "
end

SWEP.Chamberable = false
SWEP.WeaponLength = 44

SWEP.Attachments = {
}

SWEP.Animations = {
	draw = "base_ready",
	base_insert = "base_reload",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "rpg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"single"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.AimViewModelFOV = 30
SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_bazooka.mdl"
SWEP.WorldModel		= "models/weapons/w_bazooka.mdl"

SWEP.DrawCustomWM = true
SWEP.WMPos = Vector(6.035, 2, -2.366)
SWEP.WMAng = Vector(-8, 0, -180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "M6A1 Rocket"

SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_WW2_BAZOOKA_FIRE"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 1
SWEP.Damage = 100

SWEP.FirstDeployTime = 6.87
SWEP.DeployTime = 0.83

SWEP.ReloadTime = 4.4
SWEP.ReloadTime_Empty = 4.4
SWEP.ReloadHalt = 6.4
SWEP.ReloadHalt_Empty = 6.4
