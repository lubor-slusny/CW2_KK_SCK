AddCSLuaFile()

if SERVER then
	function CustomizableWeaponry.grenadeTypes:createGrenadeEntity(name)
		local pos = self.Owner:GetShootPos()
		local eyeAng = self.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		local offset = forward * 30 + eyeAng:Right() * 4 - eyeAng:Up() * 3
		
		local nade = ents.Create(name)
		nade:SetPos(pos + offset)
		nade:SetAngles(eyeAng)
		
		-- if self.CW_KK_40MM_MDL then
			-- nade.model = self.CW_KK_40MM_MDL // w8 for CW2 update
		-- end
		
		nade:Spawn()
		nade:Activate()
		nade:SetOwner(self.Owner)
		
		if self.CW_KK_40MM_MDL then
			nade:SetModel(self.CW_KK_40MM_MDL)
		end
		
		local phys = nade:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:SetVelocity(forward * 2996)
		end
	end
end
