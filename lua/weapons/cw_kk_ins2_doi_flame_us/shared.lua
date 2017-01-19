if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if not CustomizableWeaponry_KK.HOME then return end

SWEP.magType = "NONE"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Flame US"
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_flamethrower_american")
	
	SWEP.Shell = "KK_INS2_45apc"

	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}

	SWEP.IronsightPos = Vector(-2.2377, -2, 1.0456)
	SWEP.IronsightAng = Vector(0.1611, 0.0052, 0)

end

SWEP.MuzzleEffect = "flamethrower_blue"
PrecacheParticleSystem(SWEP.MuzzleEffect)

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
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
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

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/kk_doi/v_flame_mk2.mdl"
SWEP.WorldModel		= "models/weapons/w_m2.mdl"

SWEP.WMPos = Vector(11, 0.395, -2.5)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2us
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted3(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted3(SWEP)

SWEP.Primary.ClipSize		= 400
SWEP.Primary.DefaultClip	= 400
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 60/700
SWEP.FireSound = "CW_KK_INS2_DOI_FLAME_GB_FIRE_START"
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

SWEP.ReloadTimes = {
	base_ready = {1.9, 1.9},
}

if CLIENT then
	function SWEP:postPrimaryAttack()
		self.stopParticlesTime = CurTime() + 0.1
	end
	
	function SWEP:IndividualThink_INS2()
		if self.stopParticlesTime and CurTime() > self.stopParticlesTime then
			self.CW_VM:StopParticles()
			self.WMEnt:StopParticles()
			self:StopParticles()
		end
	end
end
