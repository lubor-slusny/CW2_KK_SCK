local att = {}
att.name = "kk_ins2_ww2_stripper"
att.displayNameShort = "Strip"
att.displayName = "Stripper clip"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
	
	function att:elementRender()
	end
end

function att:attachFunc()
	self.ShotgunReload = false
end

function att:detachFunc()
	self.ShotgunReload = true
end

CustomizableWeaponry:registerAttachment(att)