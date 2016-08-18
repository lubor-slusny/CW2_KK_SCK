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
	
	SWEP.AttachmentModelsVM = {}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.grenadeEnt = "cw_kk_ins2_projectile_molotov"

SWEP.Animations = {
	draw = "base_draw",
	
	pullpin = "pullback_high",
	throw = "throw",
	
	base_idle = "base_idle",
	base_draw = "base_draw",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
}

SWEP.SpeedDec = 5

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_nade_base"
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

SWEP.Effect_Lighter = "fire_verysmall_01"
SWEP.Effect_Rag = "fire_verysmall_01"

PrecacheParticleSystem(SWEP.Effect_Lighter)
PrecacheParticleSystem(SWEP.Effect_Rag)

if CLIENT then
	function SWEP:DrawFX()
		local vm = self.CW_VM
		local cyc = vm:GetCycle()
		local seq = self.Sequence
		
		if seq == "pullback_high" then
			if cyc < 1 then
				ParticleEffectAttach(self.Effect_Lighter, PATTACH_POINT_FOLLOW, vm, 1)
			end

			if cyc > 0.34 then
				ParticleEffectAttach(self.Effect_Rag, PATTACH_POINT_FOLLOW, vm, 2)
			end
		else
			vm:StopParticles()
		end	
	end
	
	function SWEP:RenderTargetFunc()
		local vm = self.CW_VM
		
		if not self.elementRender.molotov_fx then
			function self.elementRender:molotov_fx()
				self:DrawFX()
			end
		end
	end
	
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

SWEP.timeToThrow = 1.6

SWEP.canCook = false // this one detonates on impact
