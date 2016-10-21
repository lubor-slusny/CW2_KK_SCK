ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Thrown smoke grenade"
ENT.Author = "Spy"
ENT.Information = "Thrown smoke grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

CustomizableWeaponry:addRegularSound("CW_KK_INS2_M84_ENT_BOUNCE", {"weapons/m84/m84_bounce_01.wav", "weapons/m84/m84_bounce_02.wav", "weapons/m84/m84_bounce_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_M84_ENT_DETONATE", "weapons/m84/m84_detonate.wav")
CustomizableWeaponry:addFireSound("CW_KK_INS2_M84_ENT_DETONATE_D1", "weapons/m84/m84_detonate_dist.wav")
CustomizableWeaponry:addFireSound("CW_KK_INS2_M84_ENT_DETONATE_D2", "weapons/m84/m84_detonate_far_dist.wav")

ENT.explosionSound0 = "CW_KK_INS2_M84_ENT_DETONATE"
ENT.explosionSound1 = "CW_KK_INS2_M84_ENT_DETONATE_D1"
ENT.explosionSound2 = "CW_KK_INS2_M84_ENT_DETONATE_D2"
ENT.explosionSoundW0 = ""
ENT.explosionSoundW1 = ""

ENT.explosionParticles = {
	-- "ins_flashbang_explosion", // too much nearglow
	
	"ins_flashbang_explosion_smoke",
	"ins_flashbang_explosion_sparks",
	"ins_flashbang_inner_explosion",
	"ins_flashbang_explosion_sparks_b",
	"ins_flashbang_flash",
}

for _,p in pairs(ENT.explosionParticles) do
	PrecacheParticleSystem(p)
end
