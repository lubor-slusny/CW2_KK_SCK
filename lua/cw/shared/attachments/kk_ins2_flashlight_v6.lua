local att = {}
att.name = "kk_ins2_flashlight"
att.displayName = "Light Emitting Module v6.1"
att.displayNameShort = "LEM6"
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT

att.statModifiers = {
	// OverallMouseSensMult = -0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "[impulse 100] toggles on/off.", c = CustomizableWeaponry.textColors.REGULAR},
		[2] = {t = "100% clientside projected texture.", c = CustomizableWeaponry.textColors.VPOSITIVE},
	}
	
	att.reticle = "cw2/reticles/aim_reticule"
	
	local model, beamAtt
	
	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end
		
		beamAtt = nil
		
		if self.KK_INS2_FL_SRC_OVERRIDE then
			beamAtt = self:KK_INS2_FL_SRC_OVERRIDE()
		end
		
		if beamAtt == nil and self.AttachmentModelsVM[att.name] then
			model = self.AttachmentModelsVM[att.name].ent
			beamAtt = model:GetAttachment(1)
		end
		
		if beamAtt == nil then
			model = self.CW_VM
			beamAtt = model:GetAttachment(1)
		end

		CustomizableWeaponry_KK.ins2.flashlight.v6.elementRender(self, beamAtt)
	end
	
	// for V6 LEM, true - ON, false - OFF
	function att:getLEMState()
		-- return (self.dt.INS2LAMMode % 2) != 0
		return (self:GetNWInt("INS2LAMMode") % 2) != 0
	end
end

function att:attachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v6.attach(self, att)
end

function att:detachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v6.detach(self, att)
end

if CLIENT then
	CustomizableWeaponry:createStatText(att)
end

CustomizableWeaponry:registerAttachment(att)
