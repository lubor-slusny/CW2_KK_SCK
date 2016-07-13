AddCSLuaFile()

local makeShell = CustomizableWeaponry_KK.ins2.makeShell
local vm, att, pos, ang, velocity, align, shellEnt

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
	
	local muzzleAtt = attachModel:GetAttachment(ent.MuzzleWorldAttachmentID)
	local shellAtt = attachModel:GetAttachment(ent.ShellWorldAttachmentID)
	
	ParticleEffectAttach(particleEffect, PATTACH_POINT_FOLLOW, attachModel, ent.MuzzleWorldAttachmentID)

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
		return
	end
	
	if shellAtt and ent.Shell then
		if ent.ShellDelay then
			timer.Simple(ent.ShellDelay, function()
				if IsValid(ent) then
					shellAtt = attachModel:GetAttachment(ent.ShellWorldAttachmentID)
					local ejectVelocity = shellAtt.Ang:Forward() * (ent.ShellEjectVelocity or 200)
					
					local ang = shellAtt.Ang
					local tweak = ent.ShellWorldAngleAlign
					if tweak then
						ang:RotateAroundAxis(ang:Right(), tweak.Right)
						ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
						ang:RotateAroundAxis(ang:Up(), tweak.Up)
					end
					
					makeShell(shellAtt.Pos, ang, ejectVelocity, ent._shellTable1, ent.ShellScale)
				end
			end)
		else
			local ejectVelocity = shellAtt.Ang:Forward() * (ent.ShellEjectVelocity or 200)
			
			local ang = shellAtt.Ang
			local tweak = ent.ShellWorldAngleAlign
			if tweak then
				ang:RotateAroundAxis(ang:Right(), tweak.Right)
				ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
				ang:RotateAroundAxis(ang:Up(), tweak.Up)
			end
			
			makeShell(shellAtt.Pos, ang, ejectVelocity, ent._shellTable1, ent.ShellScale)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
