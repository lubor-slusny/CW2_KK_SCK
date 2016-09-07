
CustomizableWeaponry_KK.ins2.rpgs = CustomizableWeaponry_KK.ins2.rpgs or {}

function CustomizableWeaponry_KK.ins2.rpgs.fireRPG(wep, IFTP, legit)
	if IFTP then
		if SERVER then
			local pos = IsValid(wep.Owner) and wep.Owner:GetShootPos() or wep:GetPos()
			local eyeAng = IsValid(wep.Owner) and wep.Owner:EyeAngles() or wep:GetAngles()
			
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
			nade:SetOwner(wep.Owner)
			
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

function CustomizableWeaponry_KK.ins2.rpgs.fireAT4(wep, IFTP)
	if IFTP then
		if SERVER then
			local pos = wep.Owner:GetShootPos()
			local eyeAng = wep.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = eyeAng:Right() * 4 - eyeAng:Up() * 6
			
			local nade = ents.Create("cw_kk_ins2_projectile_at4")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(wep.Owner)
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(forward * 3395.6625)
			end
		end
	end
end

function CustomizableWeaponry_KK.ins2.rpgs.fireM6A1(wep, IFTP)
	if IFTP then
		if SERVER then
			local pos = wep.Owner:GetShootPos()
			local eyeAng = wep.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = eyeAng:Right() * 4 - eyeAng:Up() * 3
			
			local nade = ents.Create("cw_kk_ins2_projectile_m6a1")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(wep.Owner)
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(forward * 4000)
			end
		end
	end
end

function CustomizableWeaponry_KK.ins2.rpgs.firePF60(wep, IFTP)
	if IFTP then
		if SERVER then
			local pos = wep.Owner:GetShootPos()
			local eyeAng = wep.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = eyeAng:Right() * 1 + eyeAng:Up() * -3
			
			local nade = ents.Create("cw_kk_ins2_projectile_pf60")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(wep.Owner)
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(forward * 4000)
			end
		end
	end
end

function CustomizableWeaponry_KK.ins2.rpgs.fireHL2EP2(wep, IFTP)
	if IFTP then 
		local pos = wep.Owner:GetShootPos()
		local eyeAng = wep.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		local offset = forward * 30 + eyeAng:Right() * 4 - eyeAng:Up() * 3
		
		local nade = ents.Create("weapon_striderbuster")
		nade:SetPos(pos + offset)
		nade:SetAngles(eyeAng)
		nade:Spawn()
		nade:Activate()
		nade:SetOwner(wep.Owner)
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
		-- hook.Run("GravGunPunt", wep.Owner, nade)
		-- nade:Fire("ignite")
		-- nade:Fire("activate")
		-- nade:Fire("arm")
		-- nade:Fire("punt")
		-- nade:Fire("launch")
		-- nade:Fire("ExplodeIn", "2", 2)
		-- nade:SetKeyValue("explodein", "2")
		-- nade:Fire("explodein", "2")
		
		-- nade:Fire("Launch")
		-- nade:Fire("Launch", wep.Owner)
		-- nade:SetKeyValue("m_bLaunched", "true")
		-- nade:Launch(wep.Owner)
		-- nade.m_bLaunched = true
		-- nade:launch(wep.Owner)
		-- nade:Fire("ExplodeIn", "2", 0)
	end
end

function CustomizableWeaponry_KK.ins2.rpgs.fireHL2EP1(wep, IFTP)
	if !IsValid(wep._EP1Launcher) then
		wep._EP1Launcher = ents.Create("point_combine_ball_launcher")
	end

	if IFTP then 
		local pos = wep.Owner:GetShootPos()
		local eyeAng = wep.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		
		wep._EP1Launcher:SetOwner(wep.Owner)
		
		wep._EP1Launcher:SetPos(pos)
		wep._EP1Launcher:SetAngles(eyeAng)
		
		wep._EP1Launcher:SetKeyValue("launchconenoise", "0")
		wep._EP1Launcher:SetKeyValue("ballcount", "1000")
		wep._EP1Launcher:SetKeyValue("minspeed", "2000")
		wep._EP1Launcher:SetKeyValue("maxspeed", "2000")
		wep._EP1Launcher:SetKeyValue("ballradius", "10")
		wep._EP1Launcher:SetKeyValue("maxballbounces", "4")
		wep._EP1Launcher:SetKeyValue("balltype", "2")
		
		wep._EP1Launcher:Fire("Enable")
		wep._EP1Launcher:Fire("LaunchBall")
		wep._EP1Launcher:Fire("Disable")
		
		-- local nade = ents.Create("prop_combine_ball")
		-- nade:SetPos(pos)
		
		-- nade:Fire("setradius", "10")
		-- nade:Fire("SetOwnerEntity", wep.Owner)
		-- nade:Fire("SetOriginalOwner", wep.Owner)
		-- nade:Fire("SetAbsVelocity", forward * 10)
		-- nade:SetOwner(wep.Owner)
		
		-- nade:Spawn()
		
		-- nade:Fire("SetMass", 150)
		-- nade:Fire("StartLifetime", 4)
		
		-- nade:Activate()
		
		-- nade:Fire("SetAbsVelocity", forward * 10)
		
		-- local phys = nade:GetPhysicsObject()
		
		-- if IsValid(phys) then
			-- phys:SetVelocity(forward * 10)
		-- end
	end
end
