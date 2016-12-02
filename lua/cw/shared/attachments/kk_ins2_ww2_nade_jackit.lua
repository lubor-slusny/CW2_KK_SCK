local att = {}
att.name = "kk_ins2_ww2_nade_jackit"
att.displayNameShort = "Jacket"
att.displayName = "Frag Jacket"

att.statModifiers = {
	VelocitySensitivityMult = -0.3,
	OverallMouseSensMult = -0.15,
	RecoilMult = -0.2,
}

att.activeVM = "models/weapons/v_splintering_stielhandgranate.mdl"
att.activeWM = "models/weapons/w_splintering_stielhandgranate.mdl"
att.origVM = "models/weapons/v_stielhandgranate.mdl"
att.origWM = "models/weapons/w_stielhandgranate.mdl"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Causes grenade to create more shrapnels upon detonation.", c = CustomizableWeaponry.textColors.VPOSITIVE}
	}
	
	att.SelectIconOverride = surface.GetTextureID("vgui/inventory/weapon_splintering")
end

function att:attachFunc()
	-- self.ViewModel = att.activeVM
	self.WorldModel = att.activeWM
	
	-- if CLIENT then
		-- self.CW_VM:SetModel(self.ViewModel)
	-- end
end

function att:detachFunc()
	-- self.ViewModel = att.origVM
	self.WorldModel = att.origWM
	
	-- if CLIENT then
		-- self.CW_VM:SetModel(self.ViewModel)
	-- end
end

CustomizableWeaponry:registerAttachment(att)
