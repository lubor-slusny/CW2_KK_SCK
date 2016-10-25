include("shared.lua")

function ENT:Initialize()
	local i = self:GetProjectileClass()
	local class = self._dbInt2str[i]
	
	ed = EffectData()
	ed:SetEntity(self)
	util.Effect(self.db[class].effectClass, ed)
end

function ENT:Think()
end 

function ENT:Draw()
end
