
if CLIENT then
	CustomizableWeaponry_KK.ins2.shells = CustomizableWeaponry_KK.ins2.shells or {}
	CustomizableWeaponry_KK.ins2.shells._deployed = CustomizableWeaponry_KK.ins2.shells._deployed or {}
	
	local cvarSSF = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_shell_sound"] or {GetInt = function() return 3 end}
	local cvarSLT = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_shell_time"] or {GetFloat = function() return 10 end}
	
	local CurTime = CurTime
	local soundPlay = sound.Play
	
	local function shellPlaySound(shell)
		if shell._ssp then return end
		
		shell._ssp = true
		
		soundPlay(shell._ss, shell:GetPos())
	end
	
	local function shellThink(shell)
		if shell._ttl > CurTime() then return end
		
		SafeRemoveEntity(shell)
	end

	local angleVel = Vector()
	
	function CustomizableWeaponry_KK.ins2.shells:make(pos, ang, velocity, t, scale)
		pos = pos or EyePos()
		ang = ang or EyeAngles()
		velocity = velocity or Vector()
		t = t or CustomizableWeaponry.shells:getShell("mainshell")
		scale = scale or 1
		
		t.bbmin = t.bbmin or Vector(-0.5, -0.15, -0.5)
		t.bbmax = t.bbmax or Vector(0.5, 0.15, 0.5)
		
		velocity.x = velocity.x + math.Rand(-5, 5)
		velocity.y = velocity.y + math.Rand(-5, 5)
		velocity.z = velocity.z + math.Rand(-5, 5)
		
		local ent = ClientsideModel(t.m, RENDERGROUP_BOTH) 
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:SetModelScale(scale, 0)
		ent:PhysicsInitBox(t.bbmin * scale, t.bbmax * scale)
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
	
		-- SafeRemoveEntityDelayed(ent, cvarSLT:GetFloat() or 10) // another timer.Simple + function creation
		
		ent._ttl = CurTime() + (cvarSLT:GetFloat()) // terrible mess
		hook.Add("Think", ent, shellThink)
		
		table.insert(self._deployed, ent)
		
		return ent
	end
	
	function CustomizableWeaponry_KK.ins2.shells:cleanUp()
		for _,v in pairs(self._deployed) do
			SafeRemoveEntity(v)
		end
	end
	
	function CustomizableWeaponry_KK.ins2.shells:getDeployedCount()
		local i = 1
	
		for _ = 1, #self._deployed do
			if !IsValid(self._deployed[i]) then
				table.remove(self._deployed, i)
			else
				i = i + 1
			end
		end
		
		return #self._deployed
	end
end
