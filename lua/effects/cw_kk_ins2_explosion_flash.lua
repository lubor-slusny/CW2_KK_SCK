AddCSLuaFile()

local ang0 = Angle(-90, 0, 0)

local ent, pos

function EFFECT:Init(fx)
	ent = fx:GetEntity()
	
	pos = ent:GetPos()
	
	if ent:WaterLevel() == 0 then
		for _,p in pairs(ent.explosionParticles) do
			ParticleEffect(p, pos, ang0, ent)
		end
		sound.Play(ent.explosionSound0, pos, 180)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
