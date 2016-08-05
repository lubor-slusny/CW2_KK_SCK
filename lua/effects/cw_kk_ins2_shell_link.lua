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
	
	att = ent:GetAttachment(wep.ShellWorldAttachmentID)
	
	if att then
		local ang, velocity, align
	
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

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
