AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ExplodeRadius = 384
ENT.ExplodeDamage = 100
ENT.Model = "models/weapons/w_cw_fraggrenade_thrown.mdl"

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

function ENT:OnRemove()
	return false
end 

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	if not self:IsHeldPotato() then
		self.prepareNextPickup = true
	end
	
	vel = physobj:GetVelocity()
	len = vel:Length()
	
	if len > 500 then
		physobj:SetVelocity(vel * 0.6)
	end
	
	if len > 100 then
		CT = CurTime()
		
		if CT > self.NextImpact then
			self:EmitSound("CW_KK_INS2_FRAG_ENT_BOUNCE", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end
end

function ENT:Fuse(t)
	local p = self:GetOwner()
	self.fuser = IsValid(p) and p or self
	self.kaboomboom = CurTime() + (t or 3)
end

function ENT:Use(activator, caller)
	if not CustomizableWeaponry_KK.HOME then
		return false
	end
	
	if IsValid(activator) and activator:IsPlayer() then
		CustomizableWeaponry_KK.ins2.hotPotato:attemptPickUp(activator, self)
	end
end

function ENT:IsHeldPotato()
	return IsValid(self.heldBy) and self.heldBy.dt.Potato == self
end

function ENT:Think()
	if self.prepareNextPickup then
		self.prepareNextPickup = false
		
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetOwner()
	end
	
	if self.kaboomboom and CurTime() > self.kaboomboom then
		util.BlastDamage(self, self.fuser, self:GetPos(), self.ExplodeRadius, self.ExplodeDamage)
		
		ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetMagnitude(1)
		util.Effect("Explosion", ef)
		
		self:Remove()
	end
end
