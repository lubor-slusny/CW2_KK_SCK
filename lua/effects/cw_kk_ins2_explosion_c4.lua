AddCSLuaFile()

local td = {}
local down = Vector(0, 0, -50)
local ang0 = Angle(-90, 0, 0)

local ent, pos, ang, tr

function EFFECT:Init(fx)
	ent = fx:GetEntity()
	
	pos = ent:GetPos()
	
	-- td.start = pos
	-- td.endpos = pos + down
	-- td.filter = ent
	
	-- tr = util.TraceLine(td)
	
	-- if tr.Hit then
		-- ang = tr.HitNormal:Angle()
		-- ang:RotateAroundAxis()
	-- else
		ang = ang0
	-- end
	
	if ent:WaterLevel() == 0 then
		for _,p in pairs(ent.explosionParticles) do
			ParticleEffect(p, pos, ang, ent)
		end
		
		sound.Play(ent.explosionSound0, pos, 180)
	else
		for _,p in pairs(ent.explosionParticlesWater) do
			ParticleEffect(p, pos, ang, ent)
		end
		
		sound.Play(ent.explosionSoundW0, pos, 180)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
