ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Planted C4"
ENT.Author = "Spy"
ENT.Information = "Planted C4"
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
