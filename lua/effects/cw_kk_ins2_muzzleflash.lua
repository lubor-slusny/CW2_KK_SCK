AddCSLuaFile()

-- local makeShell = CustomizableWeaponry.shells.make
local makeShell = CustomizableWeaponry_KK.ins2.makeShell

function EFFECT:Init(fx)
	local ent = fx:GetEntity()
	
	if not IsValid(ent) then
		self:Remove()
		return
	end
	
	if not IsValid(ent.Owner) then
		self:Remove()
		return
	end
	
	if not ent.Owner:ShouldDrawLocalPlayer() and ent.Owner == LocalPlayer() then -- don't create the effect if we're in first person
		self:Remove()
		return
	end
	
	local particleEffect = ent:getFireParticles()
	local attachModel = ent:getMuzzleModel()
	
	if not IsValid(attachModel) then
		self:Remove()
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
		local att = attachModel:GetAttachment(2)
		
		if att then
			ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, attachModel, 2)
			ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, attachModel, 2)
			
			local dlight = DynamicLight(self:EntIndex())
			
			dlight.r = 255 
			dlight.g = 218
			dlight.b = 74
			dlight.Brightness = 4
			dlight.Pos = att.Pos
			dlight.Size = 128
			dlight.Decay = 128
			dlight.DieTime = CurTime() + FrameTime()
		end
	end
	
	if ent.NoShells then
		self:Remove() 
		return 
	end
	
	if shellAtt and ent.Shell then
		if ent.ShellDelay then
			timer.Simple(ent.ShellDelay, function()
				if IsValid(ent) then
					shellAtt = attachModel:GetAttachment(ent.WorldShellEjectionAttachmentID)
					local ejectVelocity = shellAtt.Ang:Forward() * (ent.ShellEjectVelocity or 200)
					
					local ang = shellAtt.Ang
					local tweak = ent._shellTable.rw
					if tweak then
						ang:RotateAroundAxis(ang:Right(), tweak.Right)
						ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
						ang:RotateAroundAxis(ang:Up(), tweak.Up)
					end
					
					makeShell(ent, shellAtt.Pos, ang, ejectVelocity, 0.5, 10)
					
					if ent.Shell2 then
						ent._shellTable = ent._shellTable2
						
						local ang = shellAtt.Ang
						local tweak = ent._shellTable.rw
						if tweak then
							ang:RotateAroundAxis(ang:Right(), tweak.Right)
							ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
							ang:RotateAroundAxis(ang:Up(), tweak.Up)
						end
						
						makeShell(ent, shellAtt.Pos, ang, ejectVelocity, 0.5, 10)
						ent._shellTable = ent._shellTable1
					end
				end
			end)
		else
			local ejectVelocity = shellAtt.Ang:Forward() * (ent.ShellEjectVelocity or 200)
			
			local ang = shellAtt.Ang
			local tweak = ent._shellTable.rw
			if tweak then
				ang:RotateAroundAxis(ang:Right(), tweak.Right)
				ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
				ang:RotateAroundAxis(ang:Up(), tweak.Up)
			end
			
			makeShell(ent, shellAtt.Pos, ang, ejectVelocity, 0.5, 10)
			
			if ent.Shell2 then
				if ent:GetClass() == "cw_kk_ins2_ww2_garand" and ent:Clip1() > 0 then return end
				
				ent._shellTable = ent._shellTable2
				
				local ang = shellAtt.Ang
				local tweak = ent._shellTable.rw
				if tweak then
					ang:RotateAroundAxis(ang:Right(), tweak.Right)
					ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
					ang:RotateAroundAxis(ang:Up(), tweak.Up)
				end
				
				makeShell(ent, shellAtt.Pos, ang, ejectVelocity + VectorRand() * 10, 0.5, 10)
				ent._shellTable = ent._shellTable1
			end
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
