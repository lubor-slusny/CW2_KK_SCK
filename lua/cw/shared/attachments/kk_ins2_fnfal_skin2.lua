local att = {}
att.name = "kk_ins2_fnfal_skin2"
att.displayName = "Green Finnish"
att.displayNameShort = "Green"
att.isBG = true

att.statModifiers = {
	RecoilMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		-- {t = "Secksy as phuck.", c = CustomizableWeaponry.textColors.VPOSITIVE},
	}
	
	function att:attachFunc()
		self.CW_VM:SetSubMaterial(0, "models/weapons/fal/dosh.mdl")
		self:SetSubMaterial(0, "models/weapons/fal/w_dosh.mdl")
	end

	function att:detachFunc()
		self.CW_VM:SetSubMaterial(0)
		self:SetSubMaterial(0)
	end	
end

CustomizableWeaponry:registerAttachment(att)