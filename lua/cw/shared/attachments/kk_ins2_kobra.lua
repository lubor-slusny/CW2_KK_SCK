local att = {}
att.name = "kk_ins2_kobra"
att.displayName = "Kobra"
att.displayNameShort = "Kobra"
att.aimPos = {"KKINS2KobraPos", "KKINS2KobraAng"}
att.FOVModifier = 15
att.isSight = true
-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "models/weapons/optics/kobra_dot"
	att._reticleSize = 4

	function att:drawReticle()
		if not self:isAiming() or not self:isReticleActive() or self:isNearWall() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self[att.aimPos[1]], self[att.aimPos[2]], att._reticleSize)

		-- draw the reticle only when it's close to center of the aiming position
		if diff > 0.9 and diff < 1.1 then
			cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local EA = self:getReticleAngles()
				
				-- local renderColor = self:getSightColor(att.name)
				-- renderColor.a = (0.13 - dist) / 0.13 * 255
				local alpha = (0.13 - dist) / 0.13 * 255
				
				local pos = EyePos() + EA:Forward() * 100
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, Color(255,255,255,alpha))
					-- render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				end
			cam.IgnoreZ(false)
		end
	end
end

CustomizableWeaponry:registerAttachment(att)