local att = {}
att.name = "kk_ins2_ww2_sling"
att.displayNameShort = "Sling"
att.displayName = "Weapon Sling"

att.statModifiers = {
	DrawSpeedMult = 0.5
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
	
	function att:elementRender()
	end
	
	function att:attachFunc()
	end
	
	function att:detachFunc()
	end
end

CustomizableWeaponry:registerAttachment(att)