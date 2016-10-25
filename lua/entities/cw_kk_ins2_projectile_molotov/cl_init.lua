include("shared.lua")

function ENT:Initialize()
	if self:GetBreakOnImpact() then
		ParticleEffectAttach(self.fuseParticles, PATTACH_POINT_FOLLOW, self, 1)
	end
end

function ENT:Draw()
	self.Entity:DrawModel()
end