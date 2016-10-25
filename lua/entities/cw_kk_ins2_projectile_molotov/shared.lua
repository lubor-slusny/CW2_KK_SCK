ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Thrown incendiary grenade"
ENT.Author = "Spy"
ENT.Information = "Thrown incendiary grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.fuseParticles = "molotov_trail"
PrecacheParticleSystem(ENT.fuseParticles)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "BreakOnImpact")
end
