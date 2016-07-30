if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Lewis"
	
	SWEP.IconLetter = "w"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "KK_INS2_762x54"
	SWEP.ShellDelay = 0.1
	
	SWEP.ShellViewAngleAlign = {Forward = 0, Right = 0, Up = -22}
	SWEP.ShellWorldAngleAlign = {Forward = 0, Right = 0, Up = 0}
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-3.3295, -2, 2.1344)
	SWEP.IronsightAng = Vector(-0.0648, 0.0265, 0)

	SWEP.CustomizationMenuScale = 0.02
end

SWEP.Attachments = {
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	["+reload"] = {header = "Ammo", offset = {500, 300}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "base_draw_empty",
	base_fire = {"base_fire_1", "base_fire_2"},
	base_fire_aim = {"iron_fire_1","iron_fire_2"},
	base_fire_last = "base_fire_last",
	base_fire_last_aim = "iron_fire_last",
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
	
	bipod_in = "deployed_in",
	bipod_in_empty = "deployed_in",
	bipod_fire = {"deployed_fire_1", "deployed_fire_2"},
	bipod_fire_aim = {"deployed_iron_fire_1", "deployed_iron_fire_2"},
	bipod_fire_last = "deployed_fire_last",
	bipod_fire_last_aim = "deployed_fire_last",
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_empty = "deployed_reload_empty",
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_empty = "deployed_fireselect_empty",
	bipod_firemode_aim = "deployed_iron_fireselect",
	bipod_firemode_empty_aim = "deployed_iron_fireselect_empty",
	bipod_out = "deployed_out",
	bipod_out_empty = "deployed_out",
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
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

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_lewis.mdl"
SWEP.WorldModel		= "models/weapons/w_m1919.mdl"

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.models.ww2gb
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.models.ww2de

SWEP.WMPos = Vector(5, 1, -2)
SWEP.WMAng = Vector(-6, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 47
SWEP.Primary.DefaultClip	= 47
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".303 British"

SWEP.FireDelay = 60/600
SWEP.FireSound = "CW_KK_INS2_DOI_LEWIS_FIRE"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 60

SWEP.FirstDeployTime = 3.07
SWEP.DeployTime = 1.4

SWEP.Chamberable = false
SWEP.BipodInstalled = true
SWEP.KK_INS2_EmptyIdle = true

SWEP.ReloadTime = 5.2
SWEP.ReloadHalt = 7.14
SWEP.ReloadTime_Empty = 5.2
SWEP.ReloadHalt_Empty = 8.13

SWEP.WeaponLength = 28

SWEP.MuzzleVelocity = 740

if CLIENT then
	function SWEP:updateOtherParts()
		self:setBodygroup(1, math.Clamp(self:Clip1(), 0, 26))
	
	end
end