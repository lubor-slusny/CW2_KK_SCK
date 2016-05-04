
if CLIENT then
	local cvarSSF = GetConVar("cw_kk_ins2_shell_sound")
	local cvarSLT = GetConVar("cw_kk_ins2_shell_time")

	local up = Vector(0, 0, -100)
	local shellMins, shellMaxs = Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5)

	local function playSound(self)
		if self._sndPld then return end
		sound.Play(self._shSnd, self:GetPos())	
		self._sndPld = true
	end
	
	local fallbackShell = CustomizableWeaponry.shells:getShell("mainshell")
	
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
		-- ent:SetCollisionGroup(COLLISION_GROUP_NONE)
		
		if cvarSSF:GetInt() == 3 then
			ent._shSnd = t.s
			ent:AddCallback("PhysicsCollide", playSound)
		end
		
		local phys = ent:GetPhysicsObject()
		
		if cvarSSF:GetInt() == 1 then
			phys:SetMaterial("grenade")
		else
			phys:SetMaterial("gmod_silent")
		end
		
		phys:SetMass(10)
		phys:SetVelocity(velocity)

		if cvarSSF:GetInt() == 2 then
			timer.Simple(soundTime or 0.5, function()
				if t.s and IsValid(ent) then
					sound.Play(t.s, ent:GetPos())
				end
			end)
		end
		
		table.insert(CustomizableWeaponry_KK.ins2.deployedShells, ent)
		
		SafeRemoveEntityDelayed(ent, cvarSLT:GetFloat() or removeTime or 10)
		
		return ent
	end
end