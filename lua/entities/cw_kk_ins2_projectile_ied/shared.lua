ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Planted IED"
ENT.Author = "Spy"
ENT.Information = "Planted IED"
ENT.Spawnable = false
ENT.AdminSpawnable = false 

-- ENT.BlastDamage = 100
-- ENT.BlastRadius = 434

ENT.BlastDamage = 380
ENT.BlastRadius = 600 // 1200

ENT.KKIN2RCEprojetile = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Detonator")
end

CustomizableWeaponry:addRegularSound("CW_KK_INS2_IED_ENT_BOUNCE", {"weapons/ied/ied_bounce_01.wav", "weapons/ied/ied_bounce_02.wav", "weapons/ied/ied_bounce_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE", {"weapons/ied/ied_detonate_01.wav", "weapons/ied/ied_detonate_02.wav", "weapons/ied/ied_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_D1", {"weapons/ied/ied_detonate_dist_01.wav", "weapons/ied/ied_detonate_dist_02.wav", "weapons/ied/ied_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_D2", {"weapons/ied/ied_detonate_far_dist_01.wav", "weapons/ied/ied_detonate_far_dist_02.wav", "weapons/ied/ied_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_WATER", {"weapons/ied/water/ied_water_detonate_01.wav", "weapons/ied/water/ied_water_detonate_02.wav", "weapons/ied/water/ied_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_WATER_D1", {"weapons/ied/water/ied_water_detonate_dist_01.wav", "weapons/ied/water/ied_water_detonate_dist_02.wav", "weapons/ied/water/ied_water_detonate_dist_03.wav"})

ENT.explosionSound0 = "CW_KK_INS2_IED_ENT_DETONATE"
ENT.explosionSound1 = "CW_KK_INS2_IED_ENT_DETONATE_D1"
ENT.explosionSound2 = "CW_KK_INS2_IED_ENT_DETONATE_D2"
ENT.explosionSoundW0 = "CW_KK_INS2_IED_ENT_DETONATE_WATER"
ENT.explosionSoundW1 = "CW_KK_INS2_IED_ENT_DETONATE_WATER_D1"

ENT.explosionParticles = {
	-- "ins_c4_explosion", // too much generic_nearglow
	
	"generic_crater_smoke_big",
	"ins_c4_explosion_shockwave",
	"ins_grenade_explosion_smoke",
	"ins_c4_explosion_smoke_d",
	"ins_c4_explosion_debris",
	"ins_c4_explosion_smoke_c",
	"ins_c4_explosion_spikes",
	"ins_c4_explosion_flames_b",
	"ins_c4_explosion_spikes_d",
	"ins_c4_explosion_smoke_thin",
	"ins_c4_explosion_debris",
	"ins_c4_flash",
	-- "generic_nearglow",
	"ins_c4_explosion_smoke_thin_b",
	"ins_c4_explosion_smoke_ground_c",
	"ins_c4_explosion_flames",
	"ins_c4_inner_explosion",
	"ins_c4_explosion_sparks_b",
	"ins_c4_explosion_sparks",	
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
