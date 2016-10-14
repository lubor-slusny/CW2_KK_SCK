include("shared.lua")

function ENT:Initialize()
	self.Entity.Emitter = ParticleEmitter(self.Entity:GetPos())
	self.Entity.ParticleDelay = 0
end

function ENT:Draw()
	self.Entity:DrawModel()
	
	local a = self:GetAttachment(1)
	
	a.Ang:RotateAroundAxis(a.Ang:Right(), 180)
	
	ParticleEffect("muzzleflash_pistol", a.Pos, a.Ang, self)
end