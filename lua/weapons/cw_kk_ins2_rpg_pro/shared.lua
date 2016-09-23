if not CustomizableWeaponry then return end

AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Professional Russian"
	
	SWEP.IconLetter = "C"
	
	SWEP.AttachmentModelsVM = {
		["nade"] = {model = "models/weapons/w_at4_projectile.mdl", bone = "Weapon", pos = Vector(0.028, 0.087, 18.68), angle = Angle(-90, 90, 0), size = Vector(0.75, 0.75, 0.75), active = true},
		["fx_light"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.01), attachment = "lighter", active = true, nodraw = true},
		["fx_rag"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(-0.67614, 0.05519, -0.63427), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.01), attachment = "rag", active = true, nodraw = true},
	}
	
	SWEP.HUD_MagText = "0 > "
end

SWEP.CanRestOnObjects = false

SWEP.Animations = {
	throw = "throw",
	pullpin = "pullback_high",
	
	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_crawl = "base_crawl",
}

local function lighter(wep)
	if SERVER then return end
	
	local vm = wep.AttachmentModelsVM.fx_light.ent
	
	ParticleEffectAttach(wep.Effect_Lighter, PATTACH_POINT_FOLLOW, vm, 0)
	
	wep._lighterStop = wep.Sequence
end

local function lighterFin(wep)
	if SERVER then return end
	
	wep._lighterStop = nil
end

local function rag(wep)
	if SERVER then return end
	
	local vm = wep.AttachmentModelsVM.fx_rag.ent
	
	-- ParticleEffectAttach(wep.Effect_Rag, PATTACH_POINT_FOLLOW, vm, 1)
	
	wep._ragStop = wep.Sequence
end

SWEP.Sounds = {
	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_GRENADE_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_GRENADE_HOLSTER"},
	},

	base_crawl = {
		{time = 10/25, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/25, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	pullback_high = {
		{time = 1/20, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 5/20, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE", callback = lighter},
		{time = 8/20, sound = "CW_KK_INS2_MOLOTOV_IGNITE", callback = rag},
		{time = 17/20, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE", callback = lighterFin},
	},

	pullback_highbake = {
		{time = 1, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 5, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE", callback = lighter},
		{time = 8, sound = "CW_KK_INS2_MOLOTOV_IGNITE", callback = rag},
		{time = 17, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE", callback = lighterFin},
	},

	pullback_low = {
		{time = 1, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 5, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE", callback = lighter},
		{time = 8, sound = "CW_KK_INS2_MOLOTOV_IGNITE", callback = rag},
		{time = 17, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE", callback = lighterFin},
	},

	throw = {
		{time = 0, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		{time = 0.3, sound = "CW_KK_INS2_RPG_FIRE"},
	},

	throw_bake = {
		{time = 0, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		{time = 0.3, sound = "CW_KK_INS2_RPG_FIRE"},
	},

	throw_low = {
		{time = 0, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		{time = 0.3, sound = "CW_KK_INS2_RPG_FIRE"},
	}
}
	
SWEP.SpeedDec = 5

SWEP.Slot = 5
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
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_rpg_pro.mdl"
-- SWEP.WorldModel		= "models/weapons/w_at4_projectile.mdl"
SWEP.WorldModel		= "models/weapons/w_cw_kk_ins2_rpg7_projectile_pd2.mdl"

SWEP.WMPos = Vector(14.17, -0.193, -25.729)
SWEP.WMAng = Angle(113.916, 13.63, 0)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.AdminOnly			= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "PG-7VM Grenade"

SWEP.Effect_Lighter = "fire_verysmall_01"
SWEP.Effect_Rag = "embers_small_01"

PrecacheParticleSystem(SWEP.Effect_Lighter)
PrecacheParticleSystem(SWEP.Effect_Rag)

if CLIENT then
	function SWEP:updateOtherParts()
		if self.Sequence != self._ragStop then
			-- self.AttachmentModelsVM.fx_rag.ent:StopParticles()
			self._ragStop = nil
		else
			local pos = self.AttachmentModelsVM.fx_rag.ent:GetPos()
			local ed = EffectData()
			ed:SetOrigin(pos)
			ed:SetScale(0.01)
			util.Effect("MetalSpark", ed)
		end
		
		if self.Sequence != self._lighterStop or self.CW_VM:GetCycle() >= 1 then
			self.AttachmentModelsVM.fx_light.ent:StopParticles()
			self._lighterStop = nil
		end
	end
	
	function SWEP:IndividualInitialize()
		local boneIds = {}
		local vm = self.CW_VM
		
		for _,v in pairs({"Rag_God", "Weapon", "Liq_top", "Bone01", "Bone02", "Bone03", "Bone04", "Bone06", "Bone07"}) do 
			boneIds[v] = vm:LookupBone(v)
		end
		
		for _,v in pairs(boneIds) do 
			vm:ManipulateBoneScale(v, Vector(0.01,0.01,0.01))
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

SWEP.HolsterTime = 0.6
SWEP.timeToThrow = 1.5
SWEP.swapTime = 0.5

SWEP.canCook = false // this swep should b cook only lol

function SWEP:createProjectile()
	CustomizableWeaponry_KK.ins2.rpgs.fireRPG(self, IsFirstTimePredicted())
end
