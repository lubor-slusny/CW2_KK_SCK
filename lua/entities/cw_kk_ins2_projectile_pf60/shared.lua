ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Rocket Propelled Grenade"
ENT.Author = "L337N008"
ENT.Information = "A 40MM grenade modified to be launched from RPG7 and AT4"
ENT.Spawnable = false
ENT.AdminSpawnable = false 

ENT.BlastDamage = 200
ENT.BlastRadius = 400

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/w_panzerfaust_projectile.mdl") 
		self:PhysicsInitBox(Vector(0,-2,-2), Vector(40,2,2))
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE) // HL2 racket
		
		local phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end

		self:GetPhysicsObject():SetBuoyancyRatio(0)

		spd = physenv.GetPerformanceSettings()
		spd.MaxVelocity = 5000

		physenv.SetPerformanceSettings(spd)
	else
		self.Emitter = ParticleEmitter(self:GetPos())
		self.LunchTime = CurTime()
	end
end
