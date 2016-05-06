local att = {}
att.name = "kk_ins2_flashlight6"
att.displayName = "Light Emitting Module v6"
att.displayNameShort = "LEM6"
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT

att.statModifiers = {}

if CLIENT then
	-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.displayIcon = surface.GetTextureID("atts/wipshit")
	att.description = {
		[1] = {t = "FREAKIN CLIENTSIDE PROJECTED TEXTURES!!!", c = CustomizableWeaponry.textColors.VPOSITIVE},
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
			beamAtt = model:GetAttachment(model:LookupAttachment("Laser"))
		end
		
		if beamAtt == nil then
			model = self.CW_VM
			beamAtt = model:GetAttachment(model:LookupAttachment("Laser"))
		end

		CustomizableWeaponry_KK.ins2.flashlight.v6.elementRender(self, beamAtt, (self._KK_INS2_LAM_MODE % 2) != 0)
	end
end

function att:attachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v6.attach(self)
end

function att:detachFunc()
	CustomizableWeaponry_KK.ins2.flashlight.v6.detach(self)
end

if CLIENT then
	CustomizableWeaponry:createStatText(att)
end

CustomizableWeaponry:registerAttachment(att)
