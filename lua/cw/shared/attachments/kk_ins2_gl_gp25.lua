local att = {}
att.name = "kk_ins2_gl_gp25"
att.displayName = "GP25"
att.displayNameShort = "GP25"
att.isGrenadeLauncher = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	DrawSpeedMult = -0.2,
	OverallMouseSensMult = -0.2,
	RecoilMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {[1] = {t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	function att:elementRender()
		if self.AttachmentModelsVM and self.AttachmentModelsVM[att.name] and self.AttachmentModelsVM[att.name].ent then 
			local ent = self.AttachmentModelsVM[att.name].ent
			if self.Grenade40MM == 2 then
				ent:SetSkin(1)
			else
				ent:SetSkin(0)
			end
		end
	end
end

function att:attachFunc()
end

function att:detachFunc()
	self.dt.INS2GLActive = false
end
	
CustomizableWeaponry:registerAttachment(att)
