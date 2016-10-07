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
	self:EmitSound("CW_KK_INS2_DOI_M10_ENT_BOOM")
	
	local smokeScreen = ents.Create("cw_smokescreen_impact")
	smokeScreen:SetPos(self:GetPos())
	smokeScreen:Spawn()
	smokeScreen:CreateParticles()
	
	self:Remove()
end
