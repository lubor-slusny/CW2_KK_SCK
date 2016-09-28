if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Panzerfaust"
	
	SWEP.SelectFont = "CW_SelectIcons2"
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	-- SWEP.RearEffectw = true
	SWEP.NoShells = true
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-2.6525, -2, 0.2846) // 60M
	SWEP.IronsightAng = Vector(1.2093, 0, 7)

	SWEP.SprintAnimSpeed = 1
	SWEP.ViewModelMovementScale_sprint = 0.6
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.CustomizationMenuScale = 0.01
	SWEP.HUD_MagText = "TUBE: "
	SWEP.MuzzleAttachmentName = "glmuzzle"
end

SWEP.Chamberable = false
SWEP.WeaponLength = 35

SWEP.Attachments = {
}

SWEP.KK_INS2_EmptyIdle = true

SWEP.Animations = {
	at4_reload_start = "base_holster_empty",
	at4_reload_end = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "base_draw_empty",
	base_fire = "base_fire",
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_idle = "base_idle",
	base_idle_empty = "base_idle_empty",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_safe_empty = "base_down_empty",
	base_safe_empty_aim = "iron_down_empty",
	base_crawl = "base_crawl",
	base_crawl_empty = "base_crawl_empty",
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "rpg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"single"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_panzerfaust.mdl"
SWEP.WorldModel		= "models/weapons/w_panzerfaust.mdl"

SWEP.DrawCustomWM = true
SWEP.WMPos = Vector(6.035, 0.5, -3)
SWEP.WMAng = Vector(-8, 0, -180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2de
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Panzerfaust"

SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_DOI_PANZERFAUST_FIRE"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 1
SWEP.Damage = 100

SWEP.FirstDeployTime = 3.4
SWEP.DeployTime = 1
SWEP.HolsterTime = 0.8

// terrible hax FTW

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadHalt = 4.5

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Int", 1, "Shots")
	self:NetworkVar("Float", 0, "HolsterDelay")
	self:NetworkVar("Float", 1, "AT4ReloadEnd")
	self:NetworkVar("Bool", 0, "Suppressed")
	self:NetworkVar("Bool", 1, "Safe")
	self:NetworkVar("Bool", 2, "BipodDeployed")
	self:NetworkVar("Angle", 0, "ViewOffset")
end

function SWEP:getAnimTimes()
	return self.ReloadTime, self.ReloadHalt
end

function SWEP:reloadAnimFunc(lm)
	self.dt.AT4ReloadEnd = CurTime() + self.ReloadHalt / self.ReloadSpeed
	
	self:sendWeaponAnim("at4_reload_start", self.ReloadSpeed, 0)

	CustomizableWeaponry.actionSequence.new(self, 1.2 / self.ReloadSpeed, nil, function() 
		if not self.ReloadDelay then return end
		
		self:sendWeaponAnim("at4_reload_end", self.ReloadSpeed, 0)
	end)
	
	return self:getAnimTimes()
end //*/

function SWEP:getReloadProgress()
	local CT = CurTime()
	
	if self.dt.AT4ReloadEnd < CT then return end
	
	if CLIENT then
		self.reticleInactivity = self.dt.AT4ReloadEnd
	end
	
	return math.Round((CT - self.dt.AT4ReloadEnd + self.ReloadHalt / self.ReloadSpeed) * 100 / self.ReloadHalt)
end

SWEP.reticleInactivityCallbacksRaw = {
	at4_reload_start = 0.1
}

local cyc, suffix

function SWEP:fireAnimFunc()
	cyc = 0.3
	suffix = ""

	if self:Clip1() == 0 then
		suffix = "_empty"
		cyc = 0
	end

	if self:isAiming() then
		suffix = suffix .. "_aim"
	end

	self:sendWeaponAnim("base_fire" .. suffix, 1, cyc)
end
