local att = {}
att.name = "ins_aimpoint"
att.displayName = "Aimpoint"
att.displayNameShort = "Aimpoint"
att.aimPos = {"INS2AimpointPos", "INS2AimpointAng"}
att.FOVModifier = 20
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.07}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/compm4")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att.reticle = "qq_sprites/bigdot"
	att._reticleSize = 0.25
	
	function att:drawReticle()
		-- if not self:isAiming() or not self:isReticleActive() then
			-- return
		-- end
		
		diff = self:getDifferenceToAimPos(self[att.aimPos[1]], self[att.aimPos[2]], 1)
		
		-- draw the reticle only when it's close to center of the aiming position
		-- if diff > 0.9 and diff < 1.1 then
			-- cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local rc = self:getSightColor(att.name)
				-- local alpha = 255
				local alpha = (0.13 - dist) / 0.13 * 255
				
				local ent = self.AttachmentModelsVM[att.name].ent
				-- local pos = ent:GetAttachment(ent:LookupAttachment("reticle")).Pos
				local pos = ent:GetAttachment(1).Pos
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, Color(rc.r,rc.g,rc.b,alpha))
					render.DrawSprite(pos, att._reticleSize/3, att._reticleSize/3, Color(255,255,255,alpha))
				end
			-- cam.IgnoreZ(false)
		-- end
	end
end

CustomizableWeaponry:registerAttachment(att)