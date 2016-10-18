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
		["pcf"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(), angle = Angle(0, -90, 0), size = Vector(0.01, 0.01, 0.01), attachment = "tail", bodygroups = {[1] = 1,}, active = true, nodraw = true},
	}
	
	SWEP.AttachmentModelsWM = {}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.grenadeEnt = "cw_kk_ins2_projectile_ww2_c4"

SWEP.Animations = {	
	pullpin = "base_pullback",
	throw = "base_throw",
	
	pull_cook = "secondary_pullback",
	throw_cook = "secondary_throw",
	
	plant = "base_plant",
	
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

SWEP.spoonTime = 29/30
SWEP.timeToThrowCook = 0.8
SWEP.swapTimeCook = 0.9
SWEP.maxVelDelayCook = 1.5

SWEP.mustCook = true
SWEP.canPlant = true

SWEP.PlantPos = Vector(1.5, 0, 0)
SWEP.PlantAng = Angle()

if CLIENT then
	function SWEP:updateOtherParts()
		if self._pcfStop and self.Sequence != self._pcfStop then
			self.AttachmentModelsVM.pcf.ent:StopParticles()
			-- self.AttachmentModelsVM.pcf.ent:StopLoopingSound(self._soundStop)
			-- self.AttachmentModelsVM.pcf.ent:StopSound("CW_KK_INS2_DOI_C4_FUSELOOP")
			-- self.CW_VM:StopParticles()
			
			self._pcfStop = nil
			
			local sound = self.soundLoop
			
			if sound then
				timer.Simple(self.spawnTime, function()
					if sound then 
						sound:Stop()
					end
				end)
			end
		else
			-- local pos = self.AttachmentModelsVM.pcf.ent:GetPos()
			-- local ed = EffectData()
			-- ed:SetOrigin(pos)
			-- ed:SetScale(0.01)
			-- util.Effect("Sparks", ed)
		end
	end
end
