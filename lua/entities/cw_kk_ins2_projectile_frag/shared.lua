ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Activated frag grenade"
ENT.Author = "Spy"
ENT.Information = "Activated frag grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

CustomizableWeaponry:addRegularSound("CW_KK_INS2_FRAG_ENT_BOUNCE", {"weapons/m67/m67_bounce_01.wav", "weapons/m67/m67_bounce_02.wav", "weapons/m67/m67_bounce_03.wav"})
CustomizableWeaponry:addRegularSound("CW_KK_INS2_FRAG_ENT_DETONATE", {"weapons/m67/m67_detonate_01.wav", "weapons/m67/m67_detonate_02.wav", "weapons/m67/m67_detonate_03.wav"})

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "grenadeModel")
end
