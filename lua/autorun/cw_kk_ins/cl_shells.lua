
if CLIENT then
	local cvarSSF = GetConVar("cw_kk_ins2_shell_sound") or {GetInt = function() return 3 end}
	local cvarSLT = GetConVar("cw_kk_ins2_shell_time") or {GetFloat = function() return 10 end}

	local angleVel = Vector(0, 0, 0)
	local up = Vector(0, 0, -100)
	local shellMins, shellMaxs = Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5)
	local fallbackShell = CustomizableWeaponry.shells:getShell("mainshell")
	
	local CurTime = CurTime
	local soundPlay = sound.Play
	
	local function shellPlaySound(shell)
		if shell._ssp then return end
		shell._ssp = true
		
		soundPlay(shell._ss, shell:GetPos())
	end
	
	local function shellThink(shell)
		if shell._ttl < CurTime() then
			SafeRemoveEntity(shell)
		end
	end
	
	CustomizableWeaponry_KK.ins2.deployedShells = CustomizableWeaponry_KK.ins2.deployedShells or {}
	
	function CustomizableWeaponry_KK.ins2.makeShell(pos, ang, velocity, t, scale)
		velocity = velocity or up
		velocity.x = velocity.x + math.Rand(-5, 5)
		velocity.y = velocity.y + math.Rand(-5, 5)
		velocity.z = velocity.z + math.Rand(-5, 5)
		
		t = t or fallbackShell
		
		local ent = ClientsideModel(t.m, RENDERGROUP_BOTH) 
		ent:SetPos(pos)
		ent:PhysicsInitBox(t.bbmin or shellMins, t.bbmax or shellMaxs)
		ent:SetAngles(ang)
		ent:SetModelScale((scale or 1), 0)
		ent:SetMoveType(MOVETYPE_VPHYSICS) 
		ent:SetSolid(SOLID_VPHYSICS) 
		ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		
		local phys = ent:GetPhysicsObject()
	
		if cvarSSF:GetInt() == 1 then // no function lol
			phys:SetMaterial("grenade")
		else
			phys:SetMaterial("gmod_silent")
		end
		
		phys:SetMass(10)
		phys:SetVelocity(velocity)
		
		angleVel.x = math.random(-500, 500)
		angleVel.y = math.random(-500, 500)
		angleVel.z = math.random(-500, 500)
		
		phys:AddAngleVelocity(ang:Right() * 100 + angleVel)

		if cvarSSF:GetInt() == 2 then // function creation spam
			timer.Simple(0.5, function()
				if t.s and IsValid(ent) then
					soundPlay(t.s, ent:GetPos())
				end
			end)
		end
		
		if cvarSSF:GetInt() == 3 then // recycled function
			ent._ss = t.s
			ent._ssp = false
			ent:AddCallback("PhysicsCollide", shellPlaySound)
		end
	
		if cvarSSF:GetInt() == 4 then // fail
			phys:SetMaterial(t.s)
		end
	
		-- SafeRemoveEntityDelayed(ent, cvarSLT:GetFloat() or removeTime or 10) // function creation spam
		
		ent._ttl = CurTime() + (cvarSLT:GetFloat()) // terrible mess
		hook.Add("Think", ent, shellThink)
		
		table.insert(CustomizableWeaponry_KK.ins2.deployedShells, ent)
		
		return ent
	end
end

