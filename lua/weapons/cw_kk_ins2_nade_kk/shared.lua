if not CustomizableWeaponry then return end
if not CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()
AddCSLuaFile("sh_soundscript.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Stielhandflare"
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/cw_kk_ins2_nade_kk")
	
	SWEP.AttachmentModelsVM = {
		["nade"] = {model = "models/props_junk/flare.mdl", pos = Vector(0, 0, -2.2346), angle = Angle(0, -55, 180), size = Vector(0.4, 0.4, 0.4), bone = "Weapon", active = true},
		["cap"] = {model = "models/weapons/w_flare_projectile.mdl", pos = Vector(0.2212, 0.0722, -0.3167), angle = Angle(90, 0, 0), size = Vector(6, 2, 2), bone = "grenade_cap", active = true},
	}
	
	SWEP.AttachmentModelsWM = {}
	
	SWEP.HUD_3D2DOffset = Vector(-1, 3, 0)
	SWEP.HUD_3D2DOffsetMenu = Vector(-8, 6, 0)
	SWEP.CustomizationMenuScale = 0.006
end

SWEP.CanRestOnObjects = false
SWEP.projectileClass = "kk_flare"

SWEP.Animations = {
	pullpin = "pullbackhigh",
	throw = "throw",
	
	pull_cook = "pullbackhighbake",
	throw_cook = "bakethrow",
	
	pull_short = "pullbacklow",
	throw_short = "lowthrow",
	
	base_idle = "idle",
	base_pickup = "draw",
	base_draw = "draw",
	base_holster = "holster",
	base_sprint = "sprint",
	base_safe = "down",
	base_crawl = "crawl",
}

SWEP.SpeedDec = 5

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base_nade"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_nebelhandgranate.mdl"
SWEP.WorldModel		= "models/props_junk/flare.mdl"

SWEP.WMPos = Vector(3.891, 2.295, -1.765)
SWEP.WMAng = Angle(-28.962, 155.365, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted(SWEP)
SWEP.AdminOnly		= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "25MM Flare"

SWEP.canCook = false

SWEP.HolsterTime = 0.6

SWEP.fuseTime = 0

SWEP.timeToThrow = 1.2
SWEP.spawnTime = 0.95
SWEP.swapTime = 1.4
SWEP.maxVelDelay = 1.5

SWEP.spoonTime = 44/35.2
SWEP.timeToThrowCook = 1.5
SWEP.maxVelDelayCook = 1.8

SWEP.timeToThrowShort = 1.2
SWEP.spawnTimeShort = 0.65
SWEP.swapTimeShort = 1.3
SWEP.maxVelDelayShort = 1.5

if CLIENT then
	local nodraw = "models/weapons/attachments/cw_kk_ins2_shared/nodraw"
	
	function SWEP:IndividualInitialize()
		local vm = self.CW_VM
		
		vm:SetSubMaterial(0, nodraw)
		vm:SetSubMaterial(1, nodraw)
	end
end
