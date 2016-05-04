local att = {}
att.name = "kk_ins2_cstm_eotechxps"
att.displayName = "EoTech XPS"
att.displayNameShort = "XPS"
att.aimPos = {"KKINS2CSTMEoTechXPSPos", "KKINS2CSTMEoTechXPSAng"}
att.FOVModifier = 15
att.isSight = true
-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "models/weapons/optics/eotech_reticule_holo"
	att._reticleSize = 3

	function att:drawReticle()
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		
		if isScopePos and not self:isAiming() or not self:isReticleActive() or self:isNearWall() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self[att.aimPos[1]], self[att.aimPos[2]], att._reticleSize)

		-- draw the reticle only when it's close to center of the aiming position
		if diff > 0.9 and diff < 1.1 then
			cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local EA = self:getReticleAngles()
				
				local renderColor = Color(255, 255, 255)
				renderColor.a = (0.13 - dist) / 0.13 * 255
				
				local pos = EyePos() + EA:Forward() * 100
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				end
			cam.IgnoreZ(false)
		end
	end
end

CustomizableWeaponry:registerAttachment(att)