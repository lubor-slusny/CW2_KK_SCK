AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ExplodeRadius = 434
ENT.ExplodeDamage = 100

local phys, ef

function ENT:Initialize()
	self:SetModel("models/weapons/w_cw_kk_ins2_c4.mdl")
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
	constraint.RemoveConstraints(self, "Weld")
	return false
end 

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	vel = physobj:GetVelocity()
	len = vel:Length()
	
	if len > 500 then -- let it roll
		physobj:SetVelocity(vel * 0.6) -- cheap as fuck, but it works
	end
	
	if len > 100 then
		CT = CurTime()
		
		if CT > self.NextImpact then
			self:EmitSound("weapons/hegrenade/he_bounce-1.wav", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end
end

function ENT:Fuse(t)
	if self:IsValid() then
		util.BlastDamage(self, (self.Detonator and self.Detonator.Owner) or ents.GetByIndex(1), self:GetPos(), self.ExplodeRadius, self.ExplodeDamage)
		
		ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetMagnitude(1)
		
		util.Effect("Explosion", ef)
		
		self:Remove()
	end
end

function ENT:Use(activator, caller)
	if SERVER then
		local det = activator:GetWeapon("cw_kk_ins2_nade_c4")
		
		if det == self.Detonator then
			activator:GiveAmmo(1, det.Primary.Ammo)
			self:Remove()
		end
	end
end

local curParent

function ENT:Think()
	curParent = self:GetParent()
	
	if curParent != self._lastParent and !IsValid(curParent) then
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	
	self._lastParent = curParent
end
