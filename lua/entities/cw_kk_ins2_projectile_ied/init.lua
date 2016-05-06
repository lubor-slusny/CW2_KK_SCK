AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local phys, ef

function ENT:Initialize()
	self:SetModel("models/weapons/w_ied.mdl")
end

function ENT:InitPhys()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:SetMass(6)
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
		-- util.BlastDamage(
			-- self, 
			-- (self.Detonator and self.Detonator.Owner) or ents.GetByIndex(1), 
			-- self:GetPos(), 
			-- self.BlastRadius, 
			-- self.BlastDamage
		-- )
		
		-- ef = EffectData()
		-- ef:SetOrigin(self:GetPos())
		-- ef:SetMagnitude(1)
		
		-- util.Effect("Explosion", ef)
			
		local expl = ents.Create("env_explosion")
		expl.CW_KK_INS2_inflictor = IsValid(self.Detonator) and self.Detonator				//inflictor
		expl:SetOwner((self.Detonator and self.Detonator.Owner) or ents.GetByIndex(1))		//attacker
		expl:SetPos(self:GetPos())
		expl:Spawn()
		expl:SetKeyValue("iMagnitude", tostring(self.BlastDamage))
		expl:SetKeyValue("iRadiusOverride", tostring(self.BlastRadius))
		expl:Fire("Explode",0,0)
		
		self:Remove()
	end
end

function ENT:Use(activator, caller)
	if SERVER then
		local det = activator:GetWeapon("cw_kk_ins2_nade_ied")
		
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
