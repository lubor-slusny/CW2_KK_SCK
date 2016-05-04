local att = {}
att.name = "kk_ins2_galil_sar"
att.displayName = "Short Assault Rifle"
att.displayNameShort = "SAR"
att.isBG = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	AimSpreadMult = 0.3,
	DrawSpeedMult = 0.05,
	DamageMult = 0.1,
	RecoilMult = 0.1,
	WeaponLength = -4
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

function att:attachFunc()
	if CLIENT then
		self.CW_VM:SetModel("models/weapons/v_galil_sar.mdl")
		self.WMEnt:SetModel("models/weapons/w_galil_sar.mdl")
		
		self.AttachmentModelsVM.kk_ins2_vertgrip.ent:SetModel("models/weapons/upgrades/a_foregrip_sec2.mdl")
		
		-- self.DrawCustomWM = true
	end
	
	self:SetModel("models/weapons/w_galil_sar.mdl") // this is a no go
	self.WorldModel = "models/weapons/w_galil_sar.mdl" // but this makes a lot more sense, right?
end

function att:detachFunc()
	if CLIENT then
		self.CW_VM:SetModel("models/weapons/v_galil.mdl")
		self.WMEnt:SetModel("models/weapons/w_galil.mdl")
		
		self.AttachmentModelsVM.kk_ins2_vertgrip.ent:SetModel("models/weapons/upgrades/a_foregrip_ins.mdl")
		
		-- self.DrawCustomWM = false
	end
	
	self:SetModel("models/weapons/w_galil.mdl")
	self.WorldModel = "models/weapons/w_galil.mdl"
end

CustomizableWeaponry:registerAttachment(att)
