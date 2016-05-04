AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:clusterFuckRackit()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	
	local nade = ents.Create("cw_kk_ins2_projectile_rpg")
	nade:SetPos(pos)
	nade:SetAngles(ang)
	nade:Spawn()
	nade:Activate()
	nade:SetOwner(self.Owner)
	nade.OnTakeDamage = nil
	
	nade.safetyBypass = true
	
	local phys = nade:GetPhysicsObject()
	
	if IsValid(phys) then
		phys:SetVelocity(self:GetVelocity() + VectorRand() * 300)
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
	end
end

function ENT:clusterFuckHENade()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	
	local nade = ents.Create("cw_grenade_thrown")
	nade:SetPos(pos - ang:Forward())
	nade:SetAngles(ang)
	nade:Spawn()
	nade:Activate()
	nade:Fuse(math.random(2,8))
	nade:SetOwner(self.Owner)
	-- nade.OnTakeDamage = nil
	
	local phys = nade:GetPhysicsObject()
	
	if IsValid(phys) then
		phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
	end
end

local shraps = {
	"cw_kk_ins2_projectile_rpg",
	"cw_grenade_thrown",
	"cw_grenade_thrown",
	"cw_grenade_thrown",
	"cw_grenade_thrown",
	"cw_grenade_thrown",
	"cw_grenade_thrown",
	"cw_grenade_thrown",
	"cw_flash_thrown",
	"cw_flash_thrown",
	"cw_smoke_thrown",
}

function ENT:clusterFuckNades()
	for i = 1,math.random(10,15) do
		local pos = self:GetPos()
		local ang = self:GetAngles()
		
		local nade = ents.Create(shraps[math.random(table.Count(shraps))])
		nade:SetPos(pos - ang:Forward())
		nade:SetAngles(ang)
		nade:Spawn()
		nade:Activate()
		if nade.Fuse then nade:Fuse(2 + math.random(20) / 10) end
		nade:SetOwner(self.Owner)
		-- nade.OnTakeDamage = nil
		
		local phys = nade:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		end
	end
end

function ENT:Think()
	self:SetBodygroup(0,1)
		
	if self.dt.State == self.States.misfired then 
		-- if math.random(1,10000) == 1337 then 
			-- self:SelfDestruct()
		-- end
		return 
	end
	
	local CT = CurTime()
	
	if CT > self.SelfDestructTime then
		if self.safetyBypass and self.missfiredArmTime then return end
		self:SelfDestruct()
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
		
			-- phys:SetVelocity(self.ArmDir:GetNormalized() * 11574.78) // 294m/s coz some web about how rpg works
			-- phys:SetVelocity(self.ArmDir:GetNormalized() * -0.1)
			-- phys:SetVelocity((self.ArmDir:GetNormalized() * 11574.78) + VectorRand() * 10)
			phys:SetVelocity((self.ArmDir:GetNormalized() * 5787.39) + VectorRand() * 10)
			-- self:SetLocalAngularVelocity(Angle(90,90,0))
			-- self:SetVelocity((self.ArmDir:GetNormalized() * 5787.39) + VectorRand() * 10)
			
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
	if self.dt.State != self.States.misfired and CurTime() > self.ArmTime then
		self:SelfDestruct()
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
		
		self:SelfDestruct()
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

function ENT:SelfDestruct()
	self.HadEnough = true
	
	if self.DontDestroy then return end
	
	util.BlastDamage(self, self.Owner, self:GetPos(), self.BlastRadius, self.BlastDamage)
	
	local ef = EffectData()
	ef:SetOrigin(self:GetPos())
	ef:SetMagnitude(1)
	
	util.Effect("Explosion", ef)
	
	if self.doAClusterFuck then 		
		self:clusterFuckNades()
	end
	
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
					v:Fire("SelfDestruct")
					hit = true
				end
			end
		end
	end
	
	if hit then 
		self:SelfDestruct()
	end
end

function ENT:OnTakeDamage(dmg)
	if self.HadEnough then return end
	
	self:SelfDestruct()
end
	