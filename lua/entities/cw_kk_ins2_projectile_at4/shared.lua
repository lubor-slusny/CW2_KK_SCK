ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "AT4 Projectile"
ENT.Author = "L337N008"
ENT.Information = "A 40MM grenade modified to be launched from AT4"
ENT.Spawnable = false
ENT.AdminSpawnable = false 

ENT.Editable = true

-- ENT.BlastDamage = 200
-- ENT.BlastRadius = 400

ENT.BlastDamage = 230
ENT.BlastRadius = 500 // 1000 is 2much

ENT.SpeedStarter = 4527.55
ENT.SpeedThruster = 11574.78
ENT.SpeedMax = 11574.78

ENT.safetyBypass = false

-- ENT.DontDestroy = true

function ENT:Initialize()
	if SERVER then
		self:SetModel(self.Model or "models/weapons/w_missile.mdl")
		self:PhysicsInitBox(Vector(-10, -1.5, -1.5), Vector(12, 1.5, 1.5))
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
		
		local phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:SetMass(10)
			phys:Wake()
		end

		self:GetPhysicsObject():SetBuoyancyRatio(0)

		self.dt.State = self.States.initialized

		spd = physenv.GetPerformanceSettings()
		spd.MaxVelocity = 11574.78

		physenv.SetPerformanceSettings(spd)
	else
		self.Emitter = ParticleEmitter(self:GetPos())
	end
	
	local CT = CurTime()
	
	self.ArmTime = CT
	self.selfDestructTime = CT + 5.1
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
end

ENT.States = {
	initialized = 1,
	armed = 2,
	misfired = 3
}

CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE", {"weapons/at4/at4rpg_detonate_01.wav", "weapons/at4/at4rpg_detonate_02.wav", "weapons/at4/at4rpg_detonate_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_D1", {"weapons/at4/at4rpg_detonate_dist_01.wav", "weapons/at4/at4rpg_detonate_dist_02.wav", "weapons/at4/at4rpg_detonate_dist_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_D2", {"weapons/at4/at4rpg_detonate_far_dist_01.wav", "weapons/at4/at4rpg_detonate_far_dist_02.wav", "weapons/at4/at4rpg_detonate_far_dist_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_WATER", {"weapons/at4/water/at4rpg_water_detonate_01.wav", "weapons/at4/water/at4rpg_water_detonate_02.wav", "weapons/at4/water/at4rpg_water_detonate_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_WATER_D1", {"weapons/at4/water/at4rpg_water_detonate_dist_01.wav", "weapons/at4/water/at4rpg_water_detonate_dist_02.wav", "weapons/at4/water/at4rpg_water_detonate_dist_03.wav"}, 1, 100, CHAN_STATIC)

ENT.explosionSound0 = "CW_KK_INS2_RPG_ENT_DETONATE"
ENT.explosionSound1 = "CW_KK_INS2_RPG_ENT_DETONATE_D1"
ENT.explosionSound2 = "CW_KK_INS2_RPG_ENT_DETONATE_D2"
ENT.explosionSoundW0 = "CW_KK_INS2_RPG_ENT_DETONATE_WATER"
ENT.explosionSoundW1 = "CW_KK_INS2_RPG_ENT_DETONATE_WATER_D1"

ENT.explosionParticles = {
	-- "ins_rpg_explosion", // too much nearglow
	
	"ins_grenade_explosion_shockwave",
	"ins_rpg_explosion_smoke_c",
	"generic_crater_smoke",
	"ins_rpg_explosion_debris",
	"ins_rpg_explosion_smoke",
	"ins_rpg_inner_explosion",
	"ins_rpg_explosion_spikes",
	"ins_rpg_explosion_smoke_b",
	"ins_rpg_explosion_sparks",
	"ins_rpg_explosion_debris",
	"ins_grenade_explosion_smoke_ground_c",
	"ins_grenade_inner_explosion_debris",
	"ins_rpg_flash",
	"ins_rpg_flash_b",
	-- "generic_nearglow",
	"ins_rpg_explosion_flames",
	"ins_rpg_glow",
	"ins_c4_explosion_sparks_burst",
}

ENT.explosionParticlesWater = {
	"ins_Water_explosion"
}

for _,p in pairs(ENT.explosionParticles) do
	PrecacheParticleSystem(p)
end

for _,p in pairs(ENT.explosionParticlesWater) do
	PrecacheParticleSystem(p)
end
