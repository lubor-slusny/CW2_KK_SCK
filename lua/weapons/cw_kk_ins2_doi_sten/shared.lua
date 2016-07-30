if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "smgMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Sten"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "x"
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.Shell = "KK_INS2_9x19"
	SWEP.ShellDelay = 0.1
	
	SWEP.ShellViewAngleAlign = {Forward = 0, Right = 0, Up = 180}
	SWEP.ShellWorldAngleAlign = {Forward = 0, Right = 0, Up = 180}
	
	SWEP.AttachmentModelsVM = {
		-- ["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_sten_foregrip.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_sten_foregrip.mdl", bone = "Weapon", pos = Vector(2.4687, -2.8842, -11.6320), angle = Angle(90, -90, 0), size = Vector(1, 1, 1)},
	}
	
	SWEP.AttachmentModelsWM = {
		-- ["kk_ins2_vertgrip"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.3491, 0, 1.7527)
	SWEP.IronsightAng = Vector(-0.4149, 0, 0)

	SWEP.CustomizationMenuScale = 0.013
end

SWEP.Attachments = {
	{header = "Under", offset = {-500, 0}, atts = {"kk_ins2_vertgrip"}},
	["+reload"] = {header = "Ammo", offset = {0, 400}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_draw",
	
	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire = {"base_fire_1","base_fire_2"},
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3"},
	base_fire_last = "base_firelast",
	base_fire_last_aim = "iron_firelast",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_safe_empty = "base_down_empty",
	base_safe_empty_aim = "iron_down_empty",
	
	foregrip_pickup = "foregrip_draw",
	foregrip_draw = "foregrip_draw",
	foregrip_draw_empty = "foregrip_draw_empty",
	foregrip_fire = {"foregrip_fire_1","foregrip_fire_2"},
	foregrip_fire_aim = {"foregrip_iron_fire_1","foregrip_iron_fire_2","foregrip_iron_fire_3"},
	foregrip_fire_last = "foregrip_firelast",
	foregrip_fire_last_aim = "foregrip_iron_firelast",
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	-- foregrip_idle = "foregrip_holster",
	-- foregrip_idle_empty = "foregrip_holster_empty",
	foregrip_idle = "foregrip_iron_idle",
	foregrip_idle_empty = "foregrip_iron_idle_empty",
	foregrip_holster = "foregrip_holster",
	foregrip_holster_empty = "foregrip_holster_empty",
	-- foregrip_holster = "foregrip_iron_idle",
	-- foregrip_holster_empty = "foregrip_iron_idle_empty",
	foregrip_sprint = "foregrip_sprint",
	foregrip_sprint_empty = "foregrip_sprint_empty",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
	foregrip_safe_empty = "foregrip_down_empty",
	foregrip_safe_empty_aim = "foregrip_iron_down_empty",
}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_sten.mdl"
SWEP.WorldModel		= "models/weapons/w_sten.mdl"

SWEP.WMPos = Vector(10, 6, -2)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.models.ww2gb
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.models.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 32
SWEP.Primary.DefaultClip	= 32
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 60/550 
SWEP.FireSound = "CW_KK_INS2_STERLING_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_STERLING_FIRE_SUPPRESSED"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 25

SWEP.FirstDeployTime = 2.67
SWEP.DeployTime = 0.8

SWEP.ReloadTime = 2.43
SWEP.ReloadTime_Empty = 3.27
SWEP.ReloadHalt = 3.1
SWEP.ReloadHalt_Empty = 4.45

SWEP.WeaponLength = 16

SWEP.Chamberable = false
SWEP.KK_INS2_EmptyIdle = true

SWEP.MuzzleVelocity = 365
