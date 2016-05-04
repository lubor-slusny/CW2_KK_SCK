AddCSLuaFile()

function EFFECT:Init(fx)
	local ent = fx:GetEntity()
	
	if not IsValid(ent) then
		return
	end
	
	if not IsValid(ent.Owner) then
		return
	end
	
	if not ent.Owner:ShouldDrawLocalPlayer() and ent.Owner == LocalPlayer() then -- don't create the effect if we're in first person
		return
	end
	
	local particleEffect = ent:getFireParticles()
	local attachModel = ent:getMuzzleModel()
	
	if not IsValid(attachModel) then
		return
	end
	
	local muzzleAtt = attachModel:GetAttachment(ent.WorldMuzzleAttachmentID)
	local shellAtt = attachModel:GetAttachment(ent.WorldShellEjectionAttachmentID)
	
	ParticleEffectAttach(particleEffect, PATTACH_POINT_FOLLOW, attachModel, ent.WorldMuzzleAttachmentID)

	if not ent.dt.Suppressed then
		local dlight = DynamicLight(self:EntIndex())
		
		dlight.r = 255 
		dlight.g = 218
		dlight.b = 74
		dlight.Brightness = 4
		dlight.Pos = muzzleAtt.Pos
		dlight.Size = 96
		dlight.Decay = 128
		dlight.DieTime = CurTime() + FrameTime()
	end
	
	if ent.RearEffectw then	// RPGs
		ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, attachModel, 2)
		ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, attachModel, 2)

		local dlight = DynamicLight(self:EntIndex())
		
		dlight.r = 255 
		dlight.g = 218
		dlight.b = 74
		dlight.Brightness = 4
		dlight.Pos = attachModel:GetAttachment(2).Pos
		dlight.Size = 128
		dlight.Decay = 128
		dlight.DieTime = CurTime() + FrameTime()
	end
	
	if ent.NoShells then return end
	
	if shellAtt and ent.Shell then
		if ent.ShellDelay then
			timer.Simple(ent.ShellDelay, function()
				if IsValid(ent) then
					shellAtt = attachModel:GetAttachment(ent.WorldShellEjectionAttachmentID)
					local ejectVelocity = shellAtt.Ang:Forward() * (ent.ShellEjectVelocity or 200)
					shellAtt.Ang:RotateAroundAxis(shellAtt.Ang:Right(), 90)
					CustomizableWeaponry.shells.make(ent, shellAtt.Pos, shellAtt.Ang, ejectVelocity, 0.5, 10)
					
					if ent.Shell2 then
						ent._shellTable = CustomizableWeaponry.shells:getShell(ent.Shell2)
						CustomizableWeaponry.shells.make(ent, shellAtt.Pos, ang, ejectVelocity, 0.5, 10)
						ent._shellTable = CustomizableWeaponry.shells:getShell(ent.Shell)
					end
				end
			end)
		else
			local ejectVelocity = shellAtt.Ang:Forward() * (ent.ShellEjectVelocity or 200)
			
			local ang = shellAtt.Ang
			local tweak = CustomizableWeaponry.shells.cache[ent.Shell].angleTweakWorld
			if tweak then
				ang:RotateAroundAxis(ang:Right(), tweak.Right)
				ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
				ang:RotateAroundAxis(ang:Up(), tweak.Up)
			end
			
			CustomizableWeaponry.shells.make(ent, shellAtt.Pos, ang, ejectVelocity, 0.5, 10)
			
			if ent.Shell2 then
				ent._shellTable = CustomizableWeaponry.shells:getShell(ent.Shell2)
				CustomizableWeaponry.shells.make(ent, shellAtt.Pos, ang, ejectVelocity + VectorRand() * 10, 0.5, 10)
				ent._shellTable = CustomizableWeaponry.shells:getShell(ent.Shell)
			end
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
