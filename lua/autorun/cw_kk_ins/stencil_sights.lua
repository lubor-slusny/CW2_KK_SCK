
if CLIENT then
	local _stencilMat = "models/weapons/attachments/cw_kk_ins2_shared/stencil"
	local _nodrawMat = "models/weapons/attachments/cw_kk_ins2_shared/nodraw"

	local dotMat = Material("cw2/reticles/aim_reticule")
	local stencilMat = Material(_stencilMat)
	local nodrawMat = Material(_nodrawMat)

	local white = Color(255,255,255)
	local whiteHalf = Color(255,255,255,123)
	
	CustomizableWeaponry_KK.ins2.stencilLenses = CustomizableWeaponry_KK.ins2.stencilLenses or {}
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/aimpoint_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/kobra_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/eotech_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/attachments/cw_kk_ins2_cstm_barska/barska_lense"] = true
	
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/lense_rt"] = true
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/mosin_lense"] = true
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/optic_lense"] = true
	
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/4x_reticule"] = true
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/elcan_reticule"] = true
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/mk4_crosshair"] = true
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/mosin_crosshair"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/parallax_mask"] = true
	-- CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/po4x_reticule"] = true
	
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/attachments/cw_kk_ins2_cstm_acog/elcan_reticule"] = true

	-- "models/weapons/optics/4x_reticule"
	-- "models/weapons/optics/aimpoint_lense"
	-- "models/weapons/optics/aimpoint_reticule"
	-- "models/weapons/optics/aimpoint_reticule_holo"
	-- "models/weapons/optics/elcan_reticule"
	-- "models/weapons/optics/eotech_lense"
	-- "models/weapons/optics/eotech_reticule"
	-- "models/weapons/optics/eotech_reticule_holo"
	-- "models/weapons/optics/kobra_dm"
	-- "models/weapons/optics/kobra_dot"
	-- "models/weapons/optics/kobra_lense"
	-- "models/weapons/optics/lense_rt"
	-- "models/weapons/optics/lense_rt_kobra"
	-- "models/weapons/optics/mk4_crosshair"
	-- "models/weapons/optics/mosin_crosshair"
	-- "models/weapons/optics/mosin_lense"
	-- "models/weapons/optics/optic_lense"
	-- "models/weapons/optics/parallax_mask"
	-- "models/weapons/optics/po4x_reticule"
	-- "models/weapons/optics/weapon_eotech_dm"
	-- "models/weapons/optics/weapon_rail_dm"
	-- "models/weapons/optics/weapon_rail2_dm"

	CustomizableWeaponry_KK.ins2.stencilLenses[_stencilMat] = true
	CustomizableWeaponry_KK.ins2.stencilLenses[_nodrawMat] = true
	
	local isLense = CustomizableWeaponry_KK.ins2.stencilLenses
	
	local size, rc, isAiming, freeze, isScopePos, attachmEnt, retAtt, retDist, retPos, EA, retAng, retNorm, v
	
	function CustomizableWeaponry_KK.ins2:drawStencilEnt(att)
		v = self.AttachmentModelsVM[att.name]
		if not v.stencilEnt then
			v.stencilEnt = self:createManagedCModel(v.ent:GetModel(), RENDERGROUP_BOTH)
			v.stencilEnt:SetNoDraw(true)
			
			if v.size then
				v.matrix = Matrix()
				v.matrix:Scale(v.size)
				v.stencilEnt:EnableMatrix("RenderMultiply", v.matrix)
			end
			
			if v.bodygroups then
				for main, sec in pairs(v.bodygroups) do
					v.stencilEnt:SetBodygroup(main, sec)
				end
			end
			
			v.stencilEnt:SetupBones()
			
			if v.merge then
				v.stencilEnt:SetParent(self.CW_VM)
				v.stencilEnt:AddEffects(EF_BONEMERGE)
			end
			
			for i,m in pairs(v.stencilEnt:GetMaterials()) do
				if isLense[m] then
					v.stencilEnt:SetSubMaterial(i - 1, _stencilMat)
				else
					v.stencilEnt:SetSubMaterial(i - 1, _nodrawMat)
				end
			end
		else
			-- if not v.merge then
				v.stencilEnt:SetPos(v.ent:GetPos())
				v.stencilEnt:SetAngles(v.ent:GetAngles())
			-- end
			
			v.stencilEnt:SetSequence(v.ent:GetSequence())
			v.stencilEnt:DrawModel()
		end
	end
	
	local nearWallOutTime
	
	function CustomizableWeaponry_KK.ins2:stencilSight(att)
		if not self.AttachmentModelsVM then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		self._laserStencilCheck = false // this got little NASTY
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"].elementRender(self)
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_combo"].elementRender(self)
		self._laserStencilCheck = true
		
		if not self.ActiveAttachments[att.name] then return end
		if self.ActiveAttachments.kk_ins2_magnifier then return end
		
		size = att._reticleSize * (self.AttachmentModelsVM[att.name].retSizeMult or 1)
		rc = self:getSightColor(att.name)
		isAiming = self:isAiming()
		freeze = GetConVarNumber("cw_kk_freeze_reticles") != 0
		isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		
		self.AttachmentModelsVM[att.name].nodraw = false
		attachmEnt = self.AttachmentModelsVM[att.name].ent
		
		retAtt = attachmEnt:GetAttachment(1)
		
		if not retAtt then 
			error("You are using invalid \"" .. self.AttachmentModelsVM[att.name].model .. "\" model. Check your other addons for conflicting files.")
		end
		
		-- if !freeze then
			/*stencil stuff*/
			render.ClearStencil()
			render.SetStencilEnable(true)
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilReferenceValue(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		-- end
		
		CustomizableWeaponry_KK.ins2.drawStencilEnt(self, att)
		
		-- if !freeze then
			/*stencil stuff*/
			render.SetStencilWriteMask(2)
			render.SetStencilTestMask(2)
			render.SetStencilReferenceValue(2)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilReferenceValue(1)
		-- end
		
		/*prepare reticle pos*/
		retDist = (retAtt.Pos:Distance(EyePos())) * 50 
		retPos = retAtt.Pos + retAtt.Ang:Forward() * retDist
		
		/*debug reticle - always attached to scope*/
		render.SetMaterial(dotMat)
		
		if freeze then
			cam.IgnoreZ(true)
				render.DrawSprite(retPos, size/2, size/2, Color(0,255,0))
				render.DrawSprite(retPos, size/2, size/2, Color(0,255,0))
				render.DrawSprite(retPos, size/6, size/6, white)
				render.DrawSprite(retPos, size/6, size/6, white)
			cam.IgnoreZ(false)
		end
		
		-- nearWallOutTime = 0
		
		if self:isNearWall() then
			nearWallOutTime = CurTime() + 0.3
		elseif not nearWallOutTime then 
			nearWallOutTime = CurTime()
		end
		
		-- if freeze then
			/*main reticle - centered when aiming and active*/
			if self:isReticleActive() and (isAiming or self.dt.BipodDeployed) and nearWallOutTime < CurTime() then
				EA = self:getReticleAngles()	
				retPos = EyePos() + EA:Forward() * retDist
			end
		-- end
		
		render.SetMaterial(att._reticle)
		
		retNorm = retAtt.Ang:Forward()
		retAng = 90 + retAtt.Ang.z
		
		cam.IgnoreZ(true)
			render.CullMode(MATERIAL_CULLMODE_CW)
				render.DrawQuadEasy(retPos, retNorm, size, size, white, retAng)
				render.DrawQuadEasy(retPos, retNorm, size, size, whiteHalf, retAng)
			render.CullMode(MATERIAL_CULLMODE_CCW)
		cam.IgnoreZ(false)
		
		-- if !freeze then
			/*disable stencils*/
			render.SetStencilEnable(false)
		-- end
	end
end
