AddCSLuaFile()

local makeShell = CustomizableWeaponry_KK.ins2.makeShell

local wep, ent, att, particleEffect

function EFFECT:Init(fx)
	wep = fx:GetEntity()
	
	if not IsValid(wep) then
		return
	end
	
	if not IsValid(wep.Owner) then
		return
	end
	
	if not wep.Owner:ShouldDrawLocalPlayer() and wep.Owner == LocalPlayer() then
		return
	end
	
	ent = wep:getMuzzleModel()
	
	if not IsValid(ent) then
		return
	end
	
	particleEffect = wep:getFireParticles()
	att = ent:GetAttachment(wep.WorldMuzzleAttachmentID)
	
	if particleEffect and att then
		ParticleEffectAttach(particleEffect, PATTACH_POINT_FOLLOW, ent, wep.WorldMuzzleAttachmentID)
		
		if not wep.dt.Suppressed then
			local dlight = DynamicLight(self:EntIndex())
			
			dlight.r = 255 
			dlight.g = 218
			dlight.b = 74
			dlight.Brightness = 4
			dlight.Pos = att.Pos
			dlight.Size = 96
			dlight.Decay = 128
			dlight.DieTime = CurTime() + FrameTime()
		end
	end

	if wep.RearEffectw then	// RPGs
		att = ent:GetAttachment(2)
		
		if att then
			ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, ent, 2)
			ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, ent, 2)
			
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
	
	if wep.NoShells or wep._shellTable1 == nil then 
		return
	end
	
	att = ent:GetAttachment(wep.ShellWorldAttachmentID)
	
	if att then
		local ang, velocity, align
	
		if wep.ShellDelay then
			timer.Simple(wep.ShellDelay, function()
				if IsValid(wep) then
					att = ent:GetAttachment(wep.ShellWorldAttachmentID)
					
					ang = att.Ang
					
					if IsValid(wep.Owner) then
						velocity = wep.Owner:GetVelocity() + ang:Forward() * (wep.ShellEjectVelocity or 200)
					else
						velocity = wep:GetVelocity() + ang:Forward() * (wep.ShellEjectVelocity or 200)
					end
					
					align = wep.ShellWorldAngleAlign
					ang:RotateAroundAxis(ang:Right(), align.Right)
					ang:RotateAroundAxis(ang:Forward(), align.Forward)
					ang:RotateAroundAxis(ang:Up(), align.Up)
					
					makeShell(
						att.Pos,
						ang, 
						velocity, 
						wep._shellTable1, 
						wep.ShellScale
					)
				end
			end)
		else
			att = ent:GetAttachment(wep.ShellWorldAttachmentID)
			
			ang = att.Ang
			
			// I guess wep will always have owner during FX init
			velocity = wep.Owner:GetVelocity() + ang:Forward() * (wep.ShellEjectVelocity or 200)
			
			align = wep.ShellWorldAngleAlign
			ang:RotateAroundAxis(ang:Right(), align.Right)
			ang:RotateAroundAxis(ang:Forward(), align.Forward)
			ang:RotateAroundAxis(ang:Up(), align.Up)
			
			makeShell(
				att.Pos,
				ang, 
				velocity, 
				wep._shellTable1, 
				wep.ShellScale
			)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
