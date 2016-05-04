
// this file got NASTY

if CLIENT then
	local _stencilMat = "models/weapons/attachments/cw_kk_ins2_shared/stencil"
	local _nodrawMat = "models/weapons/attachments/cw_kk_ins2_shared/nodraw"

	local dotMat = Material("cw2/reticles/aim_reticule")
	local stencilMat = Material(_stencilMat)
	local nodrawMat = Material(_nodrawMat)

	local white = Color(255,255,255)
	
	CustomizableWeaponry_KK.ins2.stencilLenses = CustomizableWeaponry_KK.ins2.stencilLenses or {}
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/aimpoint_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/kobra_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/eotech_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/attachments/cw_kk_ins2_cstm_barska/barska_lense"] = true
	local isLense = CustomizableWeaponry_KK.ins2.stencilLenses
	
	local size, rc, isAiming, freeze, isScopePos, attachmEnt, retAtt, retDist, retPos, EA, retAng, retNorm, v
	
	function CustomizableWeaponry_KK.ins2:stencilSight(att)
		self._laserStencilCheck = false
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"].elementRender(self)
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_combo"].elementRender(self)
		self._laserStencilCheck = true
		
		if not self.ActiveAttachments[att.name] then return end
		if self.ActiveAttachments.kk_ins2_magnifier then return end
		
		if not self.AttachmentModelsVM then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		size = att._reticleSize
		rc = self:getSightColor(att.name)
		isAiming = self:isAiming()
		freeze = GetConVarNumber("cw_kk_freeze_reticles") != 0
		isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		
		self.AttachmentModelsVM[att.name].nodraw = false
		attachmEnt = self.AttachmentModelsVM[att.name].ent
		
		if not freeze then
			-- if not (isScopePos and (isAiming or self.dt.BipodDeployed)) then
				-- attachmEnt:DrawModel()
				-- return
			-- end
		end
		
		if !freeze then
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
		end
		
		/*"canvas" for reticle, materialoverride*/
		-- if att.stencilMats then
			-- for i,is in pairs(att.stencilMats) do
				-- if is then
					-- render.MaterialOverrideByIndex(i, stencilMat) // DOESNT DO ANYTHING AT ALL
				-- else
					-- render.MaterialOverrideByIndex(i, nodrawMat)
				-- end
			-- end
		-- else
			-- render.MaterialOverride(nodrawMat)
			-- render.MaterialOverride(stencilMat)
		-- end
		-- attachmEnt:DrawModel()
		-- render.MaterialOverride(nil)
		
		/*"canvas" for reticle, extra ent mode*/
		v = self.AttachmentModelsVM[att.name]
		if not v.stencilEnt then
			v.stencilEnt = self:createManagedCModel(v.model, RENDERGROUP_BOTH)
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
			
			-- if v.merge then
				-- v.stencilEnt:SetParent(self.CW_VM)
				-- v.stencilEnt:AddEffects(EF_BONEMERGE)
			-- end
			
			for i,m in pairs(v.stencilEnt:GetMaterials()) do
				if isLense[m] then
					v.stencilEnt:SetSubMaterial(i - 1, _stencilMat) // DOESNT DO ANYTHING WITH BONEMERGED ENTITIES
				else
					v.stencilEnt:SetSubMaterial(i - 1, _nodrawMat) // ALSO WHAT THE FUCK THAT INDEXES START @0 IN SETTER AND @1 IN GETTER
				end
			end
			
		else
			-- if not v.merge then
				-- v.stencilEnt:SetPos(v.ent:GetPos())
				-- v.stencilEnt:SetAngles(v.ent:GetAngles())
			-- end
			
			v.stencilEnt:SetPos(v.ent:GetPos())
			v.stencilEnt:SetAngles(v.ent:GetAngles())
			v.stencilEnt:DrawModel()
		end
		
		if !freeze then
			/*stencil stuff*/
			render.SetStencilWriteMask(2)
			render.SetStencilTestMask(2)
			render.SetStencilReferenceValue(2)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilWriteMask(1)
			render.SetStencilTestMask(1)
			render.SetStencilReferenceValue(1)
		end
		
		/*prepare reticle pos*/
		retAtt = attachmEnt:GetAttachment(1)
		retDist = (retAtt.Pos:Distance(EyePos())) * 50 
		retPos = retAtt.Pos + retAtt.Ang:Forward() * retDist
		
		/*debug reticle*/
		render.SetMaterial(dotMat)
		
		if freeze then
			cam.IgnoreZ(true)
				
				render.DrawSprite(retPos, size/2, size/2, Color(0,255,0))
				render.DrawSprite(retPos, size/2, size/2, Color(0,255,0))
				render.DrawSprite(retPos, size/6, size/6, white)
				render.DrawSprite(retPos, size/6, size/6, white)
				
			cam.IgnoreZ(false)
		end
		
		/*main reticle*/
		if self:isReticleActive() and isAiming then 
			EA = self:getReticleAngles()
			retPos = EyePos() + EA:Forward() * retDist
		end
		
		render.SetMaterial(att._reticle)
		
		retNorm = -EyeAngles():Forward()
		retAng = -90 - retAtt.Ang.z
		
		cam.IgnoreZ(true)
			render.DrawQuadEasy(retPos, retNorm, size, size, white, retAng)
			render.DrawQuadEasy(retPos, retNorm, size, size, white, retAng)
		cam.IgnoreZ(false)
		
		if !freeze then
			/*disable stencils*/
			render.SetStencilEnable(false)
		end
	end
end
