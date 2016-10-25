AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:processProjectile(ent)
	self._sourceEnt = ent
end

function ENT:Initialize()
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local ent = self._sourceEnt
	
	self:SetPos(ent:GetPos())
	self:SetAngles(ent:GetAngles())
	
	local class = ent:GetClass()
	local tweak = self._dbStr2int[class]
	self:SetProjectileClass(tweak)
	
	if self.db[class].followProjectile then
		self:SetMoveType(MOVETYPE_NONE)
		self:SetParent(self._sourceEnt)
	end
	
	SafeRemoveEntityDelayed(self, 30)
end

function ENT:Think()
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	self:StopParticles()
	return false
end
