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

local ep3 = {t = "Detaching unloads all allocated magazines.", c = CustomizableWeaponry.textColors.REGULAR}

function att:attachFunc()
	if CustomizableWeaponry.magSystem and CLIENT then
		att.description[3] = ep3
	end
	
	self.ShotgunReload = false
	self.magType = "revLoader"
end

function att:detachFunc()
	self.ShotgunReload = true
	
	if CustomizableWeaponry.magSystem and SERVER then
		local residueAmmo = 0
		
		for key, value in pairs(self.allocatedMags) do
			if value > 0 then
				residueAmmo = residueAmmo + value
				self.allocatedMags[key] = 0
			end
		end
		
		if residueAmmo > 0 then
			self.Owner:GiveAmmo(residueAmmo, self.Primary.Ammo)
			self:networkMags()
		end
	end
		
	self.magType = "NONE"
end

CustomizableWeaponry:registerAttachment(att)