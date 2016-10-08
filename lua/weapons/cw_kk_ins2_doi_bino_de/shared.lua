if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Binoculars DE"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(0, 0, 0)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.01
	SWEP.ReloadViewBobEnabled = false
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.AimOverlay = surface.GetTextureID("models/weapons/optics/binocs_overlay_german")
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
SWEP.NormalHoldType = "slam"
SWEP.RunHoldType = "slam"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base_bino"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_binoculars_german.mdl"
SWEP.WorldModel		= "models/weapons/w_binoculars_german.mdl"

SWEP.WMPos = Vector(3.48, 5.131, -0.802)
SWEP.WMAng = Vector(57.638, 177.912, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2de
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.FireSound = "CW_KK_INS2_DOI_BINO_DE_ATTACK"
SWEP.ResponseSound = "CW_KK_INS2_DOI_BINO_DE_SPAWN"