AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
	
hook.Add("Initialize", "cw_kk_ins_flashlight", function()
	util.AddNetworkString("cw_kk_ins_flashlight_use")
	util.AddNetworkString("cw_kk_ins_flashlight_init")
end)
	
function ENT:Initialize()
	self.EPT = ents.Create("env_projectedtexture")

	self.EPT:SetLocalPos(Vector(0, 0, 0))
	self.EPT:SetLocalAngles(Angle(0, 0, 0))
	
	self.EPT:SetKeyValue("enableshadows", "1")
	self.EPT:SetKeyValue("texture", "")
	self.EPT:SetKeyValue("farz", 2048)
	self.EPT:SetKeyValue("nearz", 0.01)
	self.EPT:SetKeyValue("lightfov", "60")
	self.EPT:SetKeyValue("AlwaysUpdateOn", 1)
	
	-- self.EPT:SetParent(self.parentWep.Owner:GetViewModel())
	-- self.EPT:Fire("SetParentAttachment", "Laser") 
	
	self.EPT:SetKeyValue("lightcolor", Format("%i %i %i %i", 0, 0, 0, 0))
	
	self.EPT:Spawn()
end

net.Receive("cw_kk_ins_flashlight_use", function()
	local ent = net.ReadEntity()
	if IsValid(ent) and IsValid(ent.EPT) then
		local pos, ang, colId = net.ReadVector(), net.ReadAngle(), net.ReadInt(3)
	
		ent.EPT:SetPos(pos or Vector(0, 0, 0))
		ent.EPT:SetAngles(ang or Angle(0, 0, 0))
		
		ent.col = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][colId].color
		ent.ttl = CurTime() + 0.1
	end
end)

function ENT:Think()
	if self.ttl and self.ttl > CurTime() then
		self.EPT:SetKeyValue("lightcolor", Format("%i %i %i %i", self.col.r, self.col.g, self.col.b, 255))
	else
		self.EPT:SetKeyValue("lightcolor", Format("%i %i %i %i", 0, 0, 0, 0))
	end
	
	if !IsValid(self.parentWep) then
		self:Remove()
	end
end

function ENT:OnRemove()
	SafeRemoveEntity(self.EPT)
end
