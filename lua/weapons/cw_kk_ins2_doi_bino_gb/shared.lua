if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Binoculars GB"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(0, 0, 0)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.01
	SWEP.ReloadViewBobEnabled = false
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.WeaponLength = 16

SWEP.Attachments = {}

SWEP.Animations = {
	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "base_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 10

SWEP.Slot = 5
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_binoculars_british.mdl"
SWEP.WorldModel		= "models/weapons/w_binoculars.mdl"

SWEP.WMPos = Vector(4.5, 1, -3.5)
SWEP.WMAng = Vector(-8, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2us
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_DOI_P08_FIRE"
SWEP.Recoil = 0.77

SWEP.HipSpread = 0.034
SWEP.AimSpread = 0.012
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.22
SWEP.Shots = 1
SWEP.Damage = 24

SWEP.FirstDeployTime = 1.27
SWEP.DeployTime = 0.45

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry.quickGrenade.canThrow(self) then
			CustomizableWeaponry_KK.ins2.quickGrenade.throw(self)
			return
		end
	end
	
end

function SWEP:Reload() end

function SWEP:updateReloadTimes() end
