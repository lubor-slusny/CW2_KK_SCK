local att = {}
att.name = "kk_ins2_cstm_compm4s"
att.displayName = "Aimpoint CompM4S"
att.displayNameShort = "CompM4S"
att.aimPos = {"KKINS2CSTMCompM4SPos", "KKINS2CSTMCompM4SAng"}
att.FOVModifier = 20
att.isSight = true
-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.07}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att.reticle = "models/weapons/optics/aimpoint_reticule_holo"
	att._reticleSize = 2
	
	function att:drawReticle()
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		
		if isScopePos and not self:isAiming() or not self:isReticleActive() or self:isNearWall() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self[att.aimPos[1]], self[att.aimPos[2]], 1)

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