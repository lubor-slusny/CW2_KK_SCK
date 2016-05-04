local att = {}
att.name = "kk_ins2_anpeq15"
att.displayName = "AN/PEQ-15"
att.displayNameShort = "ATPIAL"

att.statModifiers = {
	VelocitySensitivityMult = -0.2,
	OverallMouseSensMult = -0.2,
	HipSpreadMult = -0.2,
	DrawSpeedMult = -0.1,
	MaxSpreadIncMult = -0.25
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		-- {t = "Combines... things.", c = Color(0,255,0,255)},
		{t = "[impulse 100] cycles through modes.", c = CustomizableWeaponry.textColors.REGULAR},
		{t = "Mode resets on re-attach.", c = CustomizableWeaponry.textColors.REGULAR},
		-- {t = "Colors are determined by previous atts in category.", c = CustomizableWeaponry.textColors.REGULAR},
	}
	
	local rgb = {"r","g","b","a"}
	local mode, laserAtt, lightAtt
	
	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end
		
		-- att.description[1].c[rgb[math.random(1,3)]] = math.random(255)
		
		mode = self._KK_INS2_LAM_MODE
		
		if self.AttachmentModelsVM[att.name] then
			laserAtt = self.AttachmentModelsVM[att.name].ent:GetAttachment(1)
			lightAtt = self.AttachmentModelsVM[att.name].ent:GetAttachment(2)
		else
			laserAtt = self.AttachmentModelsVM["kk_ins2_lam"].ent:GetAttachment(1)
			lightAtt = self.AttachmentModelsVM["kk_ins2_flashlight"].ent:GetAttachment(1)
		end
		
		if (mode % 2) == 1 then
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"]._elementRender(self, laserAtt)
		else
			self.lastLaserPos = nil
		end
		
		if mode > 1 then
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_flashlight"]._elementRender(self, lightAtt)
		end
	end
end

function att:attachFunc()
	CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_flashlight"].attachFunc(self)
	
	if CLIENT then
		self._KK_INS2_LAM_MODE = 0
		if not self.AttachmentModelsVM[att.name] then
			self.AttachmentModelsVM["kk_ins2_flashlight"].active = true
			self.AttachmentModelsVM["kk_ins2_lam"].active = true
		end
	end
end

function att:detachFunc()	
	if CLIENT then
		if not self.AttachmentModelsVM[att.name] then
			self.AttachmentModelsVM["kk_ins2_flashlight"].active = false
			self.AttachmentModelsVM["kk_ins2_lam"].active = false
		end
	end
end

CustomizableWeaponry:registerAttachment(att)
