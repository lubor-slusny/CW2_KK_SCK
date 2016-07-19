
if CLIENT then
	CustomizableWeaponry_KK.ins2.stencilLenses = CustomizableWeaponry_KK.ins2.stencilLenses or {}
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/aimpoint_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/kobra_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/optics/eotech_lense"] = true
	CustomizableWeaponry_KK.ins2.stencilLenses["models/weapons/attachments/cw_kk_ins2_cstm_barska/barska_lense"] = true
end

if CLIENT then
	local strStencil = "models/weapons/attachments/cw_kk_ins2_shared/stencil"
	local strNoDraw = "models/weapons/attachments/cw_kk_ins2_shared/nodraw"

	CustomizableWeaponry_KK.ins2.stencilLenses[strStencil] = true
	CustomizableWeaponry_KK.ins2.stencilLenses[strNoDraw] = false
	
	local tblIsLense = CustomizableWeaponry_KK.ins2.stencilLenses
	local v
	
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
				if tblIsLense[m] then
					v.stencilEnt:SetSubMaterial(i - 1, strStencil)
				else
					v.stencilEnt:SetSubMaterial(i - 1, strNoDraw)
				end
			end
		else
			if not v.merge then
				v.stencilEnt:SetPos(v.ent:GetPos())
				v.stencilEnt:SetAngles(v.ent:GetAngles())
			end
			
			v.stencilEnt:SetSequence(v.ent:GetSequence())
			v.stencilEnt:DrawModel()
		end
	end
	
	local iMatDot = Material("cw2/reticles/aim_reticule")

	local colBlue = Color(0,255,0)
	local colWhite = Color(255,255,255)
	local colWhiteTr = Color(255,255,255,123)
	
	local cvFreeze = GetConVar("cw_kk_freeze_reticles")
	local cvAnimated = GetConVar("cw_kk_ins2_animate_reticle")
	
	local CW2ATTS = CustomizableWeaponry.registeredAttachmentsSKey
	local tblLams = {
		"kk_ins2_lam", 
		"kk_ins2_m6x", 
		"kk_ins2_anpeq15"
	}
	
	local attachmEnt, retAtt
	local retSize, retDist, retPos, retNorm, retAng
	local EA, nearWallOutTime
	
	function CustomizableWeaponry_KK.ins2:stencilSight(att)
		if not att then return end
		if not self.ActiveAttachments[att.name] then return end
		
		if not self.AttachmentModelsVM then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		self._KK_INS2_stencilsDisableLaser = false // this got little NASTY			
			for _,lam in pairs(tblLams) do
				if self.ActiveAttachments[lam] then
					CW2ATTS[lam].elementRender(self)
				end
			end
		self._KK_INS2_stencilsDisableLaser = true
		
		if self.ActiveAttachments.kk_ins2_magnifier then return end
		
		attachmEnt = self.AttachmentModelsVM[att.name].ent
		retAtt = attachmEnt:GetAttachment(1)
		
		if not retAtt then 
			error("You are using invalid \"" .. self.AttachmentModelsVM[att.name].model .. "\" model. Check your other addons for conflicting files.")
			return
		end
		
		retSize = att._reticleSize * (self.AttachmentModelsVM[att.name].retSizeMult or 1)
		
		render.ClearStencil()
		render.SetStencilEnable(true)
		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilReferenceValue(1)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		
		CustomizableWeaponry_KK.ins2.drawStencilEnt(self, att)
		
		render.SetStencilWriteMask(2)
		render.SetStencilTestMask(2)
		render.SetStencilReferenceValue(2)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilReferenceValue(1)
		
		retDist = (retAtt.Pos:Distance(EyePos())) * 50 
		retPos = retAtt.Pos + retAtt.Ang:Forward() * retDist
		
		render.SetMaterial(iMatDot)
		
		if cvFreeze:GetInt() == 1 then
			cam.IgnoreZ(true)
				render.DrawSprite(retPos, retSize/2, retSize/2, colBlue)
				render.DrawSprite(retPos, retSize/2, retSize/2, colBlue)
				render.DrawSprite(retPos, retSize/6, retSize/6, colWhite)
				render.DrawSprite(retPos, retSize/6, retSize/6, colWhite)
			cam.IgnoreZ(false)
		end
		
		if self:isNearWall() then
			nearWallOutTime = CurTime() + 0.3
		elseif not nearWallOutTime then 
			nearWallOutTime = CurTime()
		end
		
		if (cvAnimated:GetInt() != 1 or cvFreeze:GetInt() == 1) or (!self:isAiming() and self.dt.BipodDeployed) then
			if self:isReticleActive() and nearWallOutTime < CurTime() then // 
				EA = self:getReticleAngles()
				retPos = EyePos() + EA:Forward() * retDist
			end
		end
		
		retNorm = retAtt.Ang:Forward()
		retAng = 90 + retAtt.Ang.z
		
		render.SetMaterial(att._reticle)
		
		cam.IgnoreZ(true)
			render.CullMode(MATERIAL_CULLMODE_CW)
				render.DrawQuadEasy(retPos, retNorm, retSize, retSize, colWhite, retAng)
				render.DrawQuadEasy(retPos, retNorm, retSize, retSize, colWhiteTr, retAng)
			render.CullMode(MATERIAL_CULLMODE_CCW)
		cam.IgnoreZ(false)
		
		render.SetStencilEnable(false)
	end
	
	local colMainReticle = Color(255,255,255,255)
	local colTopReticle = Color(255,255,255,255)
	
	local rc
	
	function CustomizableWeaponry_KK.ins2:stencilColorableSight(att)
		if not att then return end
		if not self.ActiveAttachments[att.name] then return end
		
		if not self.AttachmentModelsVM then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		self._KK_INS2_stencilsDisableLaser = false // this got little NASTY			
			for _,lam in pairs(tblLams) do
				if self.ActiveAttachments[lam] then
					CW2ATTS[lam].elementRender(self)
				end
			end
		self._KK_INS2_stencilsDisableLaser = true
		
		if self.ActiveAttachments.kk_ins2_magnifier then return end
		
		attachmEnt = self.AttachmentModelsVM[att.name].ent
		retAtt = attachmEnt:GetAttachment(1)
		
		if not retAtt then 
			error("You are using invalid \"" .. self.AttachmentModelsVM[att.name].model .. "\" model. Check your other addons for conflicting files.")
			return
		end
		
		retSize = att._reticleSize * (self.AttachmentModelsVM[att.name].retSizeMult or 1)
		
		render.ClearStencil()
		render.SetStencilEnable(true)
		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilReferenceValue(1)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		
		CustomizableWeaponry_KK.ins2.drawStencilEnt(self, att)
		
		render.SetStencilWriteMask(2)
		render.SetStencilTestMask(2)
		render.SetStencilReferenceValue(2)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilReferenceValue(1)
		
		retDist = (retAtt.Pos:Distance(EyePos())) * 50 
		retPos = retAtt.Pos + retAtt.Ang:Forward() * retDist
		
		render.SetMaterial(iMatDot)
		
		if cvFreeze:GetInt() == 1 then
			cam.IgnoreZ(true)
				render.DrawSprite(retPos, retSize/2, retSize/2, colBlue)
				render.DrawSprite(retPos, retSize/2, retSize/2, colBlue)
				render.DrawSprite(retPos, retSize/6, retSize/6, colWhite)
				render.DrawSprite(retPos, retSize/6, retSize/6, colWhite)
			cam.IgnoreZ(false)
		end
		
		if self:isNearWall() then
			nearWallOutTime = CurTime() + 0.3
		elseif not nearWallOutTime then 
			nearWallOutTime = CurTime()
		end
		
		if (cvAnimated:GetInt() != 1 or cvFreeze:GetInt() == 1) or (!self:isAiming() and self.dt.BipodDeployed) then
			if self:isReticleActive() and nearWallOutTime < CurTime() then
				EA = self:getReticleAngles()
				retPos = EyePos() + EA:Forward() * retDist
			end
		end
		
		retNorm = retAtt.Ang:Forward()
		retAng = 90 + retAtt.Ang.z
		
		cam.IgnoreZ(true)
			render.CullMode(MATERIAL_CULLMODE_CW)
				
				rc = self:getSightColor(att.name)
				colMainReticle.r = rc.r
				colMainReticle.g = rc.g
				colMainReticle.b = rc.b
				
				render.SetMaterial(att._reticleCol)
				render.DrawQuadEasy(retPos, retNorm, retSize, retSize, colMainReticle, retAng)
				
				-- local m = math.sqrt(rc.r * rc.r + rc.g * rc.g + rc.b * rc.b)
				
				colTopReticle.r = math.sqrt(rc.r) + 150
				colTopReticle.g = math.sqrt(rc.g) + 150
				colTopReticle.b = math.sqrt(rc.b) + 150
				
				render.SetMaterial(att._reticleTop)
				render.DrawQuadEasy(retPos, retNorm, retSize, retSize, colTopReticle, retAng)
				
			render.CullMode(MATERIAL_CULLMODE_CCW)
		cam.IgnoreZ(false)
		
		render.SetStencilEnable(false)
	end
end
