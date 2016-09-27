local att = {}
att.name = "kk_ins2_galil_sar"
att.displayName = "Short Assault Rifle"
att.displayNameShort = "SAR"
att.isBG = true
att.KK_INS2_playIdle = true
att.WeaponLength = -4

att.statModifiers = {
	AimSpreadMult = 0.3,
	DrawSpeedMult = 0.05,
	DamageMult = 0.1,
	RecoilMult = 0.1,
	-- WeaponLength = -4
}

att.activeVM = "models/weapons/v_galil_sar.mdl"
att.activeWM = "models/weapons/w_galil_sar.mdl"
att.origVM = "models/weapons/v_galil.mdl"
att.origWM = "models/weapons/w_galil.mdl"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

function att:attachFunc()
	if CLIENT then
		self.AttachmentModelsVM.kk_ins2_vertgrip.ent:SetModel("models/weapons/upgrades/a_foregrip_sec2.mdl")
		self.CW_VM:SetModel(att.activeVM)
	end
	
	self.WorldModel = att.activeWM
end

function att:detachFunc()
	if CLIENT then
		self.AttachmentModelsVM.kk_ins2_vertgrip.ent:SetModel("models/weapons/upgrades/a_foregrip_ins.mdl")
		self.CW_VM:SetModel(att.origVM)
	end
	
	self.WorldModel = att.origWM
end

CustomizableWeaponry:registerAttachment(att)
