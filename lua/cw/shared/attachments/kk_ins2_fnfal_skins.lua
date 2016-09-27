local att = {}
att.name = "kk_ins2_fnfal_skin"
att.displayName = "Black FAL Finish"
att.displayNameShort = "Black"
att.isBG = true

att.statModifiers = {
	RecoilMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
	
	function att:attachFunc()
		self.CW_VM:SetSubMaterial(0, "models/weapons/fal/blvck.mdl")
	end

	function att:detachFunc()
		self.CW_VM:SetSubMaterial(0)
	end	
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "kk_ins2_fnfal_skin2"
att.displayName = "Gr€€n FAL Finish"
att.displayNameShort = "Green"
att.isBG = true

att.statModifiers = {
	RecoilMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
	
	function att:attachFunc()
		self.CW_VM:SetSubMaterial(0, "models/weapons/fal/dosh.mdl")
	end

	function att:detachFunc()
		self.CW_VM:SetSubMaterial(0)
	end	
end

CustomizableWeaponry:registerAttachment(att)
