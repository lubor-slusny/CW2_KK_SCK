local att = {}
att.name = "kk_ins2_fnfal_skin"
att.displayName = "Tactical Night Camo"
att.displayNameShort = "Black"
att.isBG = true

att.statModifiers = {
	RecoilMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Secksy as phuck.", c = CustomizableWeaponry.textColors.VPOSITIVE},
	}
	
	function att:attachFunc()
		self.CW_VM:SetSubMaterial(0, "models/weapons/fal/blvck.mdl")
		self:SetSubMaterial(0, "models/weapons/fal/w_blvck.mdl")
	end

	function att:detachFunc()
		self.CW_VM:SetSubMaterial(0)
		self:SetSubMaterial(0)
	end	
end

CustomizableWeaponry:registerAttachment(att)