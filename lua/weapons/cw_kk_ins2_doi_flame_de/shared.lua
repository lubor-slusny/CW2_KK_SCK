if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "NONE"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Flame DE"
	
	SWEP.IconLetter = "q"
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.Shell = "KK_INS2_45apc"

	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}

	SWEP.IronsightPos = Vector(-2.2377, -2, 1.0456)
	SWEP.IronsightAng = Vector(0.1611, 0.0052, 0)

end

SWEP.WeaponLength = 16

SWEP.Attachments = {
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

-- if CustomizableWeaponry_KK.HOME then
	-- table.insert(SWEP.Attachments, {header = "Lasers", offset = {125, 0}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}})
-- end

SWEP.Chamberable = false
SWEP.KK_INS2_EmptyIdle = false

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_ready",
	base_reload_empty = "base_ready",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_flame_werfer41.mdl"
SWEP.WorldModel		= "models/weapons/w_lufboy.mdl"

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2us

SWEP.WMPos = Vector(11, 0.395, -2.5)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 400
SWEP.Primary.DefaultClip	= 400
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 60/700
SWEP.FireSound = "CW_KK_INS2_WW2_THOMPSON_FIRE"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.7
SWEP.MaxSpreadInc = 0.035
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 33

SWEP.FirstDeployTime = 1.9
SWEP.DeployTime = 0.71

SWEP.ReloadTime = 0.8
SWEP.ReloadHalt = 0.9
SWEP.ReloadTime_Empty = 0.8
SWEP.ReloadHalt_Empty = 0.9

if CLIENT then 
	function SWEP:updateOtherParts()
	end
end
