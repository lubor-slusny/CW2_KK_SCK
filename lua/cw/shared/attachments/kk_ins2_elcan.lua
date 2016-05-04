local att = {}
att.name = "kk_ins2_elcan"
att.displayNameShort = "Elcan"
att.displayName = "ELCAN C79"
att.aimPos = {"KKINS2ElcanPos", "KKINS2ElcanAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 30
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
	OverallMouseSensMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides 3x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
		[3] = {t = "Can be disorienting at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}

	local path = "models/weapons/optics/elcan_reticule"
	
	att.zoomTextures = {
		{tex = surface.GetTextureID(path), offset = {0, 1}},
	}
	
	att._rtFov = 15
	att._rtReticle = surface.GetTextureID(path)
	att._reticleMat = Material(path)
	
	function att:drawRenderTarget()
		local scopeEnt = self.AttachmentModelsVM[att.name].ent
		if self:isAiming() then 
			scopeEnt:SetSequence(1)
		else
			scopeEnt:SetSequence(0)
		end
		
		CustomizableWeaponry_KK.ins2.renderTargetSight(self, att)
	end
	
	function att:elementRender()
		CustomizableWeaponry_KK.ins2.renderTargetSightStencil(self, att)
	end
end

function att:attachFunc()
	self.OverrideAimMouseSens = 0.25
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