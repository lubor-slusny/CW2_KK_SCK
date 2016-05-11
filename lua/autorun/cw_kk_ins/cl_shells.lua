
if CLIENT then
	local cvarSSF = GetConVar("cw_kk_ins2_shell_sound")
	local cvarSLT = GetConVar("cw_kk_ins2_shell_time")

	local up = Vector(0, 0, -100)
	local shellMins, shellMaxs = Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5)
	local fallbackShell = CustomizableWeaponry.shells:getShell("mainshell")
	
	local CurTime = CurTime
	local soundPlay = sound.Play
	
	local function shellPlaySound(self)
		if self._ssp then return end
		self._ssp = true
		
		soundPlay(self._ss, self:GetPos())
	end
	
	local function shellThink(self)
		if self._ttl < CurTime() then
			SafeRemoveEntity(self)
		end
	end
	
	CustomizableWeaponry_KK.ins2.deployedShells = CustomizableWeaponry_KK.ins2.deployedShells or {}
	
	function CustomizableWeaponry_KK.ins2:makeShell(pos, ang, velocity, soundTime, removeTime)
		velocity = velocity or up
		velocity.x = velocity.x + math.Rand(-5, 5)
		velocity.y = velocity.y + math.Rand(-5, 5)
		velocity.z = velocity.z + math.Rand(-5, 5)
		
		local t = self._shellTable or fallbackShell
		
		local ent = ClientsideModel(t.m, RENDERGROUP_BOTH) 
		ent:SetPos(pos)
		ent:PhysicsInitBox(t.bbmin or shellMins, t.bbmax or shellMaxs)
		ent:SetAngles(ang)
		ent:SetModelScale((self.ShellScale or 1), 0)
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
		phys:SetVelocity(self.Owner:GetVelocity() + velocity)
		
		if cvarSSF:GetInt() == 2 then // function creation spam
			timer.Simple(soundTime or 0.5, function()
				if t.s and IsValid(ent) then
					sound.Play(t.s, ent:GetPos())
				end
			end)
		end
		
		if cvarSSF:GetInt() == 3 then // recycled function
			ent._ss = t.s
			ent._ssp = false
			ent:AddCallback("PhysicsCollide", shellPlaySound)
		end
	
		if cvarSSF:GetInt() == 4 then // fail
			phys:SetMaterial(t.pm or "grenade")
		end
	
		-- SafeRemoveEntityDelayed(ent, cvarSLT:GetFloat() or removeTime or 10) // function creation spam
		
		ent._ttl = CurTime() + (cvarSLT:GetFloat() or removeTime or 10)
		hook.Add("Think", ent, shellThink)
		
		table.insert(CustomizableWeaponry_KK.ins2.deployedShells, ent)
		
		return ent // M1 garand
	end
end