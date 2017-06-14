local att = {}
att.name = "ins_gl"
att.displayName = "Grenade Launcher"
att.displayNameShort = "GL"
att.isGrenadeLauncher = true

att.statModifiers = {
	DrawSpeedMult = -0.2,
	OverallMouseSensMult = -0.2,
	RecoilMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/m203")
	att.description = {[1] = {t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	function att:attachFunc()
		self:resetM203Anim()
	end
	
	function att:detachFunc()
		self:resetM203Anim()
		self.dt.M203Active = false
		self.M203AngDiff = Angle(0, 0, 0)
	end
end

CustomizableWeaponry:registerAttachment(att)
