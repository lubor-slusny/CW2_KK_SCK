ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Rocket Propelled Grenade"
ENT.Author = "L337N008"
ENT.Information = "A 40MM grenade modified to be launched from RPG7 and AT4"
ENT.Spawnable = false
ENT.AdminSpawnable = false 

ENT.Editable = true

ENT.BlastDamage = 200
ENT.BlastRadius = 400

ENT.SpeedStarter = 4527.55
ENT.SpeedThruster = 11574.78
ENT.SpeedMax = 11574.78

ENT.safetyBypass = false
ENT.doAClusterFuck = false

-- ENT.DontDestroy = true

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/w_missile.mdl") 
		self:PhysicsInitBox(Vector(0,-2,-2), Vector(40,2,2))
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE) // HL2 racket
		
		-- self:PhysicsInit(SOLID_VPHYSICS)
		-- self:SetMoveType(MOVETYPE_VPHYSICS)
		-- self:SetSolid(SOLID_VPHYSICS)
		-- self:SetCollisionGroup(COLLISION_GROUP_NONE)
		
		local phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
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
	
	self.ArmTime = CT + 0.1
	self.SelfDestructTime = CT + 5.1
end

function ENT:SetupDataTables()
	-- self:DTVar("Int", 0, "State")
	self:NetworkVar("Int", 0, "State", {
		KeyName = "state", 
		Edit = {
			type = "Int", 
			min = 1, 
			max = 3, 
			order = 1
		} 
	})
end

ENT.States = {
	initialized = 1,
	armed = 2,
	misfired = 3
}