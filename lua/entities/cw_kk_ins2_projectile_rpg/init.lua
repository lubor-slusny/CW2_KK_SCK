AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Think()
	self:SetBodygroup(0,1)
		
	if self.dt.State == self.States.misfired then
		return 
	end
	
	local CT = CurTime()
	
	if CT > self.selfDestructTime then
		if self.safetyBypass and self.missfiredArmTime then return end
		self:selfDestruct()
	elseif CT > self.ArmTime then
		self.dt.State = self.States.armed
		
		self:SearchNDestroy()
		
		if self.doAClusterFuck and CT > self.ArmTime + 0.3 then
			for i = 1,math.random(5,7) do
				self:clusterFuckRackit()
			end
			
			for i = 1,math.random(10,15) do
				self:clusterFuckHENade()
			end
			
			self.doAClusterFuck = false
		end
	
		local phys = self:GetPhysicsObject()
				
		if IsValid(phys) then
			
			if not self.ArmDir or self.safetyBypass then 
				self.ArmDir = phys:GetVelocity()
			end
		
			phys:SetVelocity((self.ArmDir:GetNormalized() * 5787.39) + VectorRand() * 10)
			
			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Forward(), 10)
			self:SetAngles(ang)

		end
		
	end
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end 

local vel, len

function ENT:Touch(ent)
	if !IsValid(ent) then return end
	if !ent:IsPlayer() and !ent:IsNPC() then return end
	
	if self.dt.State != self.States.misfired and CurTime() > self.ArmTime then
		self:selfDestruct()
	end
end

function ENT:PhysicsCollide(data, physobj)
	if self.dt.State == self.States.misfired then
		vel = physobj:GetVelocity()
		len = vel:Length()
		
		if len > 500 then
			physobj:SetVelocity(vel * 0.6)
		end
	
		return
	end
	
	if self.doAClusterFuck then
		self:clusterFuckRackit()
	end
	
	if CurTime() > self.ArmTime then
		-- if math.random(5) != 2 then
		if self.safetyBypass and self.missfiredArmTime and (CurTime() < self.missfiredArmTime) then
			return
		end
		
		self:selfDestruct()
	else
		self:EmitSound("physics/metal/metal_grenade_impact_hard" .. math.random(1, 3) .. ".wav", 80, 100)
		if self.safetyBypass then
			self.missfiredArmTime = self.ArmTime + 0.75
		else
			self.dt.State = self.States.misfired
		end
		
		vel = physobj:GetVelocity()
		len = vel:Length()
		
		if len > 500 then
			physobj:SetVelocity(vel * 0.6)
		end
	end
end

function ENT:selfDestruct()
	if self.HadEnough then return end
	
	self.HadEnough = true
	
	if self.DontDestroy then return end
	
	-- util.BlastDamage(self, self.Owner, self:GetPos(), self.BlastRadius, self.BlastDamage)
	
	-- local ef = EffectData()
	-- ef:SetOrigin(self:GetPos())
	-- ef:SetMagnitude(1)
	
	-- util.Effect("Explosion", ef)
	
	local expl = ents.Create("env_explosion")
	expl.CW_KK_INS2_inflictor = self
	expl:SetPos(self:GetPos())
	expl:SetOwner(self.Owner or ents.GetByIndex(1))
	expl:Spawn()
	expl:SetKeyValue("iMagnitude", tostring(self.BlastDamage))
	expl:SetKeyValue("iRadiusOverride", tostring(self.BlastRadius))
	expl:Fire("Explode",0,0)
	
	self:Remove()
end

local choppas = {
	npc_helicopter = true,
	npc_combinedropship = true,
	npc_combinegunship = true,
}

function ENT:SearchNDestroy()
	local hit 
	
	for k,v in pairs(ents.GetAll()) do
		if IsValid(v) and v.IsNPC and v:IsNPC() then
			if choppas[v:GetClass()] then
				if v:GetPos():Distance(self:GetPos()) < 400 then
					v:Fire("selfDestruct")
					hit = true
				end
			end
		end
	end
	
	if hit then 
		self:selfDestruct()
	end
end

function ENT:OnTakeDamage(dmg)
	self:selfDestruct()
end
	