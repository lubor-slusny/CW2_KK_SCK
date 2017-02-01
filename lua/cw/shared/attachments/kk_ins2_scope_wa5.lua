local att = {}
att.name = "kk_ins2_scope_wa5"
att.displayNameShort = "W.A5 7x"
att.displayName = "Winchester A5 7x Scope"
att.aimPos = {"KKINS2ScopeWA5Pos", "KKINS2ScopeWA5Ang"}
att.FOVModifier = 0
att.AimViewModelFOV = 20
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
	OverallMouseSensMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides 7x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
		[3] = {t = "Can be disorienting at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}

	local path = "models/weapons/optics/enfield_crosshair"
	
	att.zoomTextures = {
		{tex = surface.GetTextureID(path), offset = {0, 1}},
	}
	
	att._rtFov = 7
	att._rtReticle = surface.GetTextureID(path)
	att._reticleMat = Material(path)
	
	att.zoomDesired = 7
	
	function att:drawRenderTarget()		
		local scopeEnt = self.AttachmentModelsVM[att.name].ent
		if self:isAiming() then 
			scopeEnt:SetSequence(2)
		else
			scopeEnt:SetSequence(1)
		end
		
		CustomizableWeaponry_KK.ins2.rtSight:renderTarget(self, att)
	end
	
	function att:elementRender()
		CustomizableWeaponry_KK.ins2.rtSight:stencil(self, att)
	end
end

function att:attachFunc()
	self.OverrideAimMouseSens = 0.1
	self.SimpleTelescopicsFOV = 70
	self.AimViewModelFOV = 50
	self.BlurOnAim = true
	self.ZoomTextures = att.zoomTextures
end

function att:detachFunc()
	self.OverrideAimMouseSens = nil
	self.SimpleTelescopicsFOV = nil
	self.AimViewModelFOV = self.AimViewModelFOV_Orig
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)