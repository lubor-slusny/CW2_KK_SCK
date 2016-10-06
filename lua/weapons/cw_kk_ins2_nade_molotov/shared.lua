if not CustomizableWeaponry then return end
if not CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "[2D] Molotov`s Drink"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "O"
	
	SWEP.AttachmentModelsVM = {
		["fx_light"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.01), attachment = "lighter", active = true, nodraw = true},
		["fx_rag"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(-0.67614, 0.05519, -0.63427), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.01), attachment = "rag", active = true, nodraw = true},
	}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.grenadeEnt = "cw_kk_ins2_projectile_molotov"

SWEP.Animations = {
	pullpin = "pullback_high",
	throw = "throw",
	
	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_crawl = "base_crawl",
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
SWEP.ViewModel		= "models/weapons/v_molotov.mdl"
SWEP.WorldModel		= "models/weapons/w_molotov.mdl"

SWEP.WMPos = Vector(3.891, 2.295, -1.765)
SWEP.WMAng = Angle(-28.962, 155.365, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Incediary"

SWEP.timeToThrow = 1.5
SWEP.maxVelDelay = 2

SWEP.canCook = false // this one detonates on impact

if CLIENT then
	local m
	local muz = {}
	
	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
			muz.Pos = m:GetTranslation()
			muz.Ang = m:GetAngles()
			return muz
		end
		
		return self.CW_VM:GetAttachment(2)
	end
end
