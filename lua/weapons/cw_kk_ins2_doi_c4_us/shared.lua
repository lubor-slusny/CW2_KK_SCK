if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "C4 US"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "O"
	
	SWEP.AttachmentModelsVM = {
		["pcf"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(0.00000, 0.00000, 0.00000), angle = Angle(0.00000, -90.00000, 0.00000), size = Vector(0.01000, 0.01000, 0.01000), attachment = "prime", bodygroups = {1}, active = true},
	}
	
	SWEP.AttachmentModelsWM = {}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.grenadeEnt = "cw_grenade_thrown"

SWEP.Animations = {
	plant = "base_plant",
	
	pullpin = "base_pullback",
	throw = "base_throw",
	
	pull_cook = "secondary_pullback",
	throw_cook = "secondary_throw",
	
	base_pickup = "base_draw",
	base_idle = "base_idle",
	base_draw = "base_draw",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 5

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "slam"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base_nade"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_compb_allied.mdl"
SWEP.WorldModel		= "models/weapons/w_compb_allied.mdl"

SWEP.WMPos = Vector(5.5, 3.295, -1.765)
SWEP.WMAng = Angle(-28.962, 165.365, 70)

SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Frag Grenades"

SWEP.fuseTime = 10

SWEP.timeToThrow = 1.1
SWEP.swapTime = 0.9

SWEP.spoonTime = 29/30
SWEP.timeToThrowCook = 1.1
SWEP.swapTimeCook = 0.9

SWEP.mustCook = true
SWEP.canPlant = true

SWEP.PlantAng = Vector(0, 0, 180)
