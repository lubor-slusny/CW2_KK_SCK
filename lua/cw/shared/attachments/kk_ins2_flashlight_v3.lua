local att = {}
att.name = "kk_ins2_flashlight3"
att.displayName = "Light Emitting Module v3.1"
att.displayNameShort = "LEM"
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT

att.statModifiers = {
	OverallMouseSensMult = -0.05
}

if CLIENT then
	-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.displayIcon = surface.GetTextureID("atts/wipshit")
	att.description = {
		{t = "Less files, less ents.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		{t = "Shitty like first one.", c = CustomizableWeaponry.textColors.VNEGATIVE},
		{t = "Now works in MP.", c = CustomizableWeaponry.textColors.VPOSITIVE},
	}
	
	att.reticle = "cw2/reticles/aim_reticule"
	
	local model, beamAtt, pos, ang, col
	
	function att:elementRender()
		beamAtt = nil
		
		if self.KK_INS2_FL_SRC_OVERRIDE then
			beamAtt = self:KK_INS2_FL_SRC_OVERRIDE()
		end
		
		if beamAtt == nil and self.AttachmentModelsVM[att.name] then
			model = self.AttachmentModelsVM[att.name].ent
			beamAtt = model:GetAttachment(model:LookupAttachment("Laser"))
		end
		
		if beamAtt == nil then
			model = self.CW_VM
			beamAtt = model:GetAttachment(model:LookupAttachment("Laser"))
		end

		if beamAtt == nil then
			return
		end
		
		if !self.dt.Safe then
			self._KK_INS2_SV_FL_turnOffWhenSafe = CurTime() + 0.1
		end
		
		if self._KK_INS2_SV_FL_turnOffWhenSafe and self._KK_INS2_SV_FL_turnOffWhenSafe < CurTime() then return end
		
		CustomizableWeaponry_KK.ins2.flashlight.v3.elementRender(self, beamAtt)
	end
end

function att:attachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v3.attach(self)
end

function att:detachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v3.detach(self)
end
	
CustomizableWeaponry:registerAttachment(att)
