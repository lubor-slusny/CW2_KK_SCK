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
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-0.8269, -5, 1.5462)
	SWEP.IronsightAng = Vector(0, 0, 0)

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

SWEP.KK_INS2_emptyIdle = true

SWEP.Animations = {
	draw = "base_ready",
	base_insert = "base_reload",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire = "base_fire",
	base_fire_aim = "iron_fire",
	base_fire_last = "base_fire",
	base_fire_last_aim = "iron_fire",
	base_fire_empty = "empty_dryfire",
	base_fire_empty_aim = "empty_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reload",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "empty_holster",
	base_sprint = "base_sprint",
	base_sprint_empty = "empty_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_safe_empty = "empty_down",
	base_safe_empty_aim = "iron_down_empty",
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

SWEP.FirstDeployTime = 3.06
SWEP.DeployTime = 0.83

SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 4
SWEP.ReloadHalt_Empty = 4

-- SWEP.ShotgunReload = true
-- SWEP.ReloadStartTime = 0
-- SWEP.InsertShellTime = 3
-- SWEP.ReloadFinishWait = 1

function SWEP:fireAnimFunc()
	local clip = self:Clip1()
	local cyc = 0.3
	local rate = 1
	local prefix = "base_"
	local suffix = ""
	
	if clip == 1 then
		suffix = "_last"
	elseif clip == 0 then
		suffix = "_empty"
		cyc = 0
	end
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix,rate,cyc)
end //*/
