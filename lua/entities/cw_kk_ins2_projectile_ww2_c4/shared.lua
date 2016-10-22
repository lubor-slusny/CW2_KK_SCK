ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Activated frag grenade"
ENT.Author = "Spy"
ENT.Information = "Activated frag grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.fuseParticles = "weapon_compB_fuse"
PrecacheParticleSystem(ENT.fuseParticles)

CustomizableWeaponry:addRegularSound("CW_KK_INS2_DOI_C4_ENT_BOUNCE", {"weapons/compositonb/compositonb_bounce_01.wav", "weapons/compositonb/compositonb_bounce_02.wav", "weapons/compositonb/compositonb_bounce_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_ENT_DETONATE", {"weapons/compositonb/compositonb_detonate_01.wav", "weapons/compositonb/compositonb_detonate_02.wav", "weapons/compositonb/compositonb_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_ENT_DETONATE_D1", {"weapons/compositonb/compositonb_detonate_dist_01.wav", "weapons/compositonb/compositonb_detonate_dist_02.wav", "weapons/compositonb/compositonb_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_ENT_DETONATE_D2", {"weapons/compositonb/compositonb_detonate_far_dist_01.wav", "weapons/compositonb/compositonb_detonate_far_dist_02.wav", "weapons/compositonb/compositonb_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_ENT_DETONATE_WATER", {"weapons/compositonb/water/compositonb_water_detonate_01.wav", "weapons/compositonb/water/compositonb_water_detonate_02.wav", "weapons/compositonb/water/compositonb_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_ENT_DETONATE_WATER_D1", {"weapons/compositonb/water/compositonb_water_detonate_dist_01.wav", "weapons/compositonb/water/compositonb_water_detonate_dist_02.wav", "weapons/compositonb/water/compositonb_water_detonate_dist_03.wav"})

ENT.explosionSound0 = "CW_KK_INS2_DOI_C4_ENT_DETONATE"
ENT.explosionSound1 = "CW_KK_INS2_DOI_C4_ENT_DETONATE_D1"
ENT.explosionSound2 = "CW_KK_INS2_DOI_C4_ENT_DETONATE_D2"
ENT.explosionSoundW0 = "CW_KK_INS2_DOI_C4_ENT_DETONATE_WATER"
ENT.explosionSoundW1 = "CW_KK_INS2_DOI_C4_ENT_DETONATE_WATER_D1"

ENT.explosionParticles = {
	-- "ins_c4_explosion", // too much generic_nearglow
	
	-- "generic_crater_smoke_big",
	-- "ins_c4_explosion_shockwave",
	-- "ins_grenade_explosion_smoke",
	-- "ins_c4_explosion_smoke_d",
	-- "ins_c4_explosion_debris",
	-- "ins_c4_explosion_smoke_c",
	-- "ins_c4_explosion_spikes",
	-- "ins_c4_explosion_flames_b",
	-- "ins_c4_explosion_spikes_d",
	-- "ins_c4_explosion_smoke_thin",
	-- "ins_c4_explosion_debris",
	-- "ins_c4_flash",
	-- // "generic_nearglow",
	-- "ins_c4_explosion_smoke_thin_b",
	-- "ins_c4_explosion_smoke_ground_c",
	-- "ins_c4_explosion_flames",
	-- "ins_c4_inner_explosion",
	-- "ins_c4_explosion_sparks_b",
	-- "ins_c4_explosion_sparks",
	
	"doi_compB_explosion",
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
