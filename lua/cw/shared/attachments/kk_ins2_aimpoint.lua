local att = {}
att.name = "kk_ins2_aimpoint"
att.displayName = "Aimpoint"
att.displayNameShort = "Aimpoint"
att.aimPos = {"KKINS2AimpointPos", "KKINS2AimpointAng"}
att.FOVModifier = 20
att.isSight = true
-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.07}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att._reticleSize = 0.25
	-- att.reticle = "qq_sprites/bigdot"
	-- local size = 13
	att.reticle = "models/weapons/optics/aimpoint_reticule_holo"
	local size = 8
	
	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end
		if self.ActiveAttachments.ins_magnifier then return end
		
		local rc = self:getSightColor(att.name)
		local isAiming = self:isAiming()
		local freeze = GetConVarNumber("cw_kk_freeze_reticles") != 0
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		local attachmEnt = self.AttachmentModelsVM[att.name].ent
		local stencilEnt = self.AttachmentModelsVM[att.name].stencilEnt
		
		if not freeze then
			if not (isScopePos and (isAiming or self.dt.BipodDeployed)) then 
				return
			end
		end
		
		if isAiming then
		
		end
		
		/*enable/reset stencils*/
		render.ClearStencil()
		render.SetStencilEnable(true)
			
		render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilReferenceValue(1)
		
		/*draw mesh/model*/
		local statt = attachmEnt:GetAttachment(1)
		stencilEnt:SetPos(statt.Pos)
		stencilEnt:SetAngles(statt.Ang)
		stencilEnt:DrawModel()
		
		/*prepare(?) stencils*/
		render.SetStencilReferenceValue(2)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilReferenceValue(1)
		
		/*render reticle*/
		render.SetMaterial(att._reticle)
		
		local sizeMult = (statt.Pos:Distance(EyePos())) * 50 
		local pos = statt.Pos + statt.Ang:Forward() * sizeMult
		
		if freeze then
			cam.IgnoreZ(true)
			for i = 1, 2 do
				render.DrawSprite(pos, size, size, Color(255,0,255,alpha))
				render.DrawSprite(pos, size/3, size/3, Color(255,255,255,alpha))
			end
			cam.IgnoreZ(false)
		end
		
		if self:isReticleActive() then 
			local EA = self:getReticleAngles()
			pos = EyePos() + EA:Forward() * sizeMult
		end
		
		cam.IgnoreZ(true)
			for i = 1, 2 do
				render.DrawSprite(pos, size, size, Color(255,255,255,255))
				-- render.DrawSprite(pos, size, size, Color(rc.r,rc.g,rc.b,alpha))
				-- render.DrawSprite(pos, size/3, size/3, Color(255,255,255,alpha))
			end
		cam.IgnoreZ(false)
		
		/*disable stencils*/
		render.SetStencilEnable(false)
		
		attachmEnt:DrawModel()
	end
	
	function att:attachFunc()
		if not self.AttachmentModelsVM[att.name].stencilEnt then
			self.AttachmentModelsVM[att.name].stencilEnt = self:createManagedCModel("models/weapons/attachments/v_cw_kk_ins2_stencil.mdl", RENDERGROUP_BOTH)
		end
		
		local stencilEnt = self.AttachmentModelsVM[att.name].stencilEnt
		
		-- stencilEnt:SetSkin(1)
		
		stencilEnt:SetNoDraw(true)
		local m = Matrix()
		m:Scale(self.AttachmentModelsVM[att.name].size or Vector(1, 1, 1))
		if self.AttachmentModelsVM[att.name].model:find("a_optic_aimpoint.mdl") then
			m:Scale(Vector(0.35,0.35,0.35))
		elseif self.AttachmentModelsVM[att.name].model:find("a_optic_aimpoint_m") then
			m:Scale(Vector(0.35,0.35,0.35))			
		elseif self.AttachmentModelsVM[att.name].model:find("a_optic_aimpoint_l") then
			m:Scale(Vector(0.5,0.5,0.5))
		end
		stencilEnt:EnableMatrix("RenderMultiply", m)
	end
	
	function att:detachFunc()
	end
end

CustomizableWeaponry:registerAttachment(att)