local att = {}
att.name = "kk_ins2_ww2_sling"
att.displayNameShort = "Sling"
att.displayName = "Weapon Sling"

att.statModifiers = {
	DrawSpeedMult = 0.3,
	HolsterSpeed = 0.3,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Boosts deploy speed of weapon that you switch to.", c = CustomizableWeaponry.textColors.VPOSITIVE},
	}
	
	function att:elementRender()
	end
	
	function att:attachFunc()
	end
	
	function att:detachFunc()
	end
	
end

function att:holsterEnd(swWep)
	if self.ActiveAttachments[att.name] then
		swWep.oneTimeDeploySpeed = att.statModifiers.DrawSpeedMult
	end
end

CustomizableWeaponry.callbacks:addNew("holsterEnd", "KK_INS2_WW2_SLING", att.holsterEnd)

CustomizableWeaponry:registerAttachment(att)