AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Think()
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end 

local vel, len

function ENT:PhysicsCollide(data, physobj)
	self:selfDestruct()
end

function ENT:selfDestruct()
	if self.ded then 
		return
	end
	
	self.ded = true
	
	local smokeScreen = ents.Create("cw_smokescreen_impact")
	smokeScreen:SetPos(self:GetPos())
	smokeScreen:Spawn()
	
	local fx = ents.Create("cw_kk_ins2_particles")
	fx:processProjectile(self)
	fx:Spawn()
	
	SafeRemoveEntityDelayed(self, 30)
end
