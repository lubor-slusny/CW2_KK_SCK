AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ExplodeRadius = 384
ENT.ExplodeDamage = 100

ENT.Model = "models/weapons/w_molotov.mdl"

local phys, ef

function ENT:Initialize()
	self:SetModel(self.Model) 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self:GetPhysicsObject():SetBuoyancyRatio(0)
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end 

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	self:Detonate()
end

function ENT:Fuse(t)
	//muhehe
end

function ENT:Detonate()
	if self.wentBoomAlready then
		return 
	end
	
	self.wentBoomAlready = true
	
	self:StopParticles()
	
	if self:WaterLevel() == 0 then
		local fx = ents.Create("cw_kk_ins2_particles")
		fx:processProjectile(self)
		fx:Spawn()
		
		SafeRemoveEntity(self)
	else
		SafeRemoveEntityDelayed(self, 60)
	end
end

function ENT:Think()
	if self:WaterLevel() != 0 then
		self:Detonate()
	end
end
