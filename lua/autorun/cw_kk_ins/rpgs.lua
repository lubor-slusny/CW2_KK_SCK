
function CustomizableWeaponry_KK.ins2:fireRPG(IFTP, legit)
	if IFTP then
		if SERVER then
			local pos = self.Owner:GetShootPos()
			local eyeAng = self.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = /*forward * 30 +*/ eyeAng:Right() * 4 - eyeAng:Up() * 3
			
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
