local att = {}
att.name = "kk_ins2_ww2_knife"
att.displayName = "You call that a knife?"
att.displayNameShort = "A Knife"

att.statModifiers = {
	OverallMouseSensMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Replaces quick-grenade attack.", c = CustomizableWeaponry.textColors.NEUTRAL},
	}
	
	function att:elementRender()
	end
	
	function att:attachFunc()
	end
	
	function att:detachFunc()
	end
end

CustomizableWeaponry:registerAttachment(att)