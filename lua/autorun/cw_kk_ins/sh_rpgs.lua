
function CustomizableWeaponry_KK.ins2:fireRPG(IFTP, legit)
	if IFTP then
		if SERVER then
			local pos = self.Owner:GetShootPos()
			local eyeAng = self.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			-- local offset = /*forward * 30 +*/ eyeAng:Right() * 4 - eyeAng:Up() * 3
			local offset = /*forward * 30 +*/ eyeAng:Right() * 4 - eyeAng:Up() * 6
			
			local nade = ents.Create("cw_kk_ins2_projectile_rpg")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(self.Owner)
			
			if not legit then
				nade.safetyBypass = true
				-- nade.doAClusterFuck = true
			end
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				-- phys:SetVelocity(forward * 4527.55) // 115 m/s coz wiki
				phys:SetVelocity(forward * 3395.6625)
				-- phys:SetVelocity(forward * 2263.775)
			end
		end
	end
end

function CustomizableWeaponry_KK.ins2:fireAT4(IFTP)
	if IFTP then
		if SERVER then
			local pos = self.Owner:GetShootPos()
			local eyeAng = self.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = eyeAng:Right() * 4 - eyeAng:Up() * 6
			
			local nade = ents.Create("cw_kk_ins2_projectile_at4")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(self.Owner)
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(forward * 3395.6625)
			end
		end
	end
end

function CustomizableWeaponry_KK.ins2:fireM6A1(IFTP, legit)
	if IFTP then
		if SERVER then
			local pos = self.Owner:GetShootPos()
			local eyeAng = self.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = eyeAng:Right() * 4 - eyeAng:Up() * 3
			
			local nade = ents.Create("cw_kk_ins2_projectile_m6a1")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(self.Owner)
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(forward * 4000)
			end
			
			ParticleEffect("cstm_smoke", self:GetPos(), Angle(0, 0, 0), self)
		end
	end
end

function CustomizableWeaponry_KK.ins2:firePF60(IFTP, legit)
	if IFTP then
		if SERVER then
			local pos = self.Owner:GetShootPos()
			local eyeAng = self.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = eyeAng:Right() * 1 + eyeAng:Up() * -3
			
			local nade = ents.Create("cw_kk_ins2_projectile_pf60")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(self.Owner)
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(forward * 4000)
			end
		end
	end
end

function CustomizableWeaponry_KK.ins2:fireHL2EP2(IFTP)
	if IFTP then 
		local pos = self.Owner:GetShootPos()
		local eyeAng = self.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		local offset = forward * 30 + eyeAng:Right() * 4 - eyeAng:Up() * 3
		
		local nade = ents.Create("weapon_striderbuster")
		nade:SetPos(pos + offset)
		nade:SetAngles(eyeAng)
		nade:Spawn()
		nade:Activate()
		nade:SetOwner(self.Owner)
		local phys = nade:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:SetVelocity(forward * 2500)
		end
		
		-- nade:SetKeyValue("Dud Bomb", "false")
		-- nade:Fire("string", "param", 0)
		-- nade:Fire("OnPhysCannon")
		-- nade:AddGameFlag(FVPHYSICS_WAS_THROWN)
		-- nade:Fire("Wake")
		-- nade:Fire("EnablePuntSound")
		-- nade:SetKeyValue("ExplodeIn", "0")
		-- nade:Fire("PUNTED_BY_CANNON")
		-- nade:Fire("physgun_pickup")
		-- nade:Fire("physgun_punt")
		-- hook.Run("GravGunPunt", self.Owner, nade)
		-- nade:Fire("ignite")
		-- nade:Fire("activate")
		-- nade:Fire("arm")
		-- nade:Fire("punt")
		-- nade:Fire("launch")
		-- nade:Fire("ExplodeIn", "2", 2)
		-- nade:SetKeyValue("explodein", "2")
		-- nade:Fire("explodein", "2")
		
		-- nade:Fire("Launch")
		-- nade:Fire("Launch", self.Owner)
		-- nade:SetKeyValue("m_bLaunched", "true")
		-- nade:Launch(self.Owner)
		-- nade.m_bLaunched = true
		-- nade:launch(self.Owner)
		-- nade:Fire("ExplodeIn", "2", 0)
	end
end

function CustomizableWeaponry_KK.ins2:fireHL2EP1(IFTP)
	if IFTP then 
		local pos = self.Owner:GetShootPos()
		local eyeAng = self.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		
		local nade = ents.Create("prop_combine_ball")
		nade:SetPos(pos)
		
		nade:Spawn()
		nade:Activate()
		
		nade:SetSolid(SOLID_VPHYSICS)
		nade:SetOwner(self.Owner)
		
		local phys = nade:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:SetVelocity(forward * 1000)
		end
	end
end
