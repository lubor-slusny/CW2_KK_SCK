ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Activated frag grenade"
ENT.Author = "Spy"
ENT.Information = "Activated frag grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "grenadeModel")
end

CustomizableWeaponry:addRegularSound("CW_KK_INS2_FRAG_ENT_BOUNCE", {"weapons/m67/m67_bounce_01.wav", "weapons/m67/m67_bounce_02.wav", "weapons/m67/m67_bounce_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE", {"weapons/m67/m67_detonate_01.wav", "weapons/m67/m67_detonate_02.wav", "weapons/m67/m67_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_D1", {"weapons/m67/m67_detonate_dist_01.wav", "weapons/m67/m67_detonate_dist_02.wav", "weapons/m67/m67_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_D2", {"weapons/m67/m67_detonate_far_dist_01.wav", "weapons/m67/m67_detonate_far_dist_02.wav", "weapons/m67/m67_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_WATER", {"weapons/m67/water/m67_water_detonate_01.wav", "weapons/m67/water/m67_water_detonate_02.wav", "weapons/m67/water/m67_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_WATER_D1", {"weapons/m67/water/m67_water_detonate_dist_01.wav", "weapons/m67/water/m67_water_detonate_dist_02.wav", "weapons/m67/water/m67_water_detonate_dist_03.wav"})

ENT.explosionSound0 = "CW_KK_INS2_FRAG_ENT_DETONATE"
ENT.explosionSound1 = "CW_KK_INS2_FRAG_ENT_DETONATE_D1"
ENT.explosionSound2 = "CW_KK_INS2_FRAG_ENT_DETONATE_D2"
ENT.explosionSoundW0 = "CW_KK_INS2_FRAG_ENT_DETONATE_WATER"
ENT.explosionSoundW1 = "CW_KK_INS2_FRAG_ENT_DETONATE_WATER_D1"

ENT.explosionParticles = {
	-- "ins_grenade_explosion", // consists of all below
	
	"generic_crater_smoke",
	"ins_grenade_explosion_shockwave",
	"ins_grenade_explosion_spikes_b",
	"ins_grenade_explosion_spikes",
	"ins_grenade_explosion_smoke",
	"ins_grenade_explosion_smoke_thick",
	"ins_grenade_explosion_smoke_thick_b",
	"ins_grenade_explosion_spikes_b",
	"ins_grenade_inner_explosion",
	"ins_grenade_explosion_flames_b",
	"ins_grenade_explosion_smoke_ground_c",
	"ins_grenade_explosion_sparks",
	"ins_grenade_inner_explosion_debris",
	"ins_grenade_explosion_flames",
	"ins_grenade_flash",
	-- "generic_nearglow", // looks orange in GM
}

ENT.explosionParticlesWater = {
	"ins_water_explosion"
}

for _,p in pairs(ENT.explosionParticles) do
	PrecacheParticleSystem(p)
end

for _,p in pairs(ENT.explosionParticlesWater) do
	PrecacheParticleSystem(p)
end
