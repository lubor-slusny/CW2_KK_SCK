
if CLIENT then
	CustomizableWeaponry_KK.rts = CustomizableWeaponry_KK.rts or {}

	CustomizableWeaponry_KK.rts.ins2_scope = GetRenderTarget("cw_kk_ins2_scope", 512, 512, false)
	CustomizableWeaponry_KK.rts.ins2_scope_init = true
end

local _innerRim = "models/weapons/attachments/cw_kk_ins2_shared/fake"
local _outerRim = "models/weapons/attachments/cw_kk_ins2_shared/fake20"

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("cw2/reticles/reticle_chevron")
	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	
	local Ini = true
	local alpha = 0.5
	
	local cd = {}
	cd.x = 0
	cd.y = 0
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	local innerRim = surface.GetTextureID(_innerRim)
	local outerRim = surface.GetTextureID(_outerRim)
	local aimPosBuild = surface.GetTextureID("cw2/reticles/scope_leo")
	
	function CustomizableWeaponry_KK.ins2:renderTargetSight(att)
		local complexTelescopics = self:canUseComplexTelescopics()
		
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
		
		if self.freeAimOn then
			ang = self.Owner:EyeAngles()
		else
			ang = self.AttachmentModelsVM[att.name].ent:GetAttachment(1).Ang
			ang:RotateAroundAxis(ang:Forward(), -90)
		end
		
		local size = self:getRenderTargetSize()
		
		cd.w = size
		cd.h = size
		cd.fov = att._rtFov
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, size, size)
			render.RenderView(cd)

			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				local intensity = 2
				local dh, dv = 1,1
					
				dh = math.Clamp(self:getDifferenceToAimPos(self.AimPos, self.AimAng, 0, intensity, 0.3),0,2)
				dv = math.Clamp(self:getDifferenceToAimPos(self.AimPos, self.AimAng, -intensity, 0, 0.3),0,2)
				
				local x,y = dh * size - size, dv * size - size
				
				x = -x
				y = -y
					
					surface.SetDrawColor(255, 255, 255, 255)
					if att._rtReticle then
						surface.SetTexture(att._rtReticle)
					else
						surface.SetTexture(innerRim)
					end
					surface.DrawTexturedRect(x, y, size, size)
					
					surface.SetTexture(outerRim)
					/*UP*/
					surface.DrawTexturedRect(x, y - (size*2), size, size*2)
					/*RIGHT*/
					surface.DrawTexturedRect(x + size, y - (size*2), size*2, size*5)
					/*DOWN*/
					surface.DrawTexturedRect(x, y + size, size, size*2)
					/*LEFT*/
					surface.DrawTexturedRect(x - (size*2), y - (size*2), size*2, size*5)
					
				x = -x
				y = -y
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(innerRim)
				surface.DrawTexturedRect(x, y, size, size)
				
				surface.SetTexture(outerRim)
				/*UP*/
				surface.DrawTexturedRect(x, y - (size*2), size, size*2)
				/*RIGHT*/
				surface.DrawTexturedRect(x + size, y - (size*2), size*2, size*5)
				/*DOWN*/
				surface.DrawTexturedRect(x, y + size, size, size*2)
				/*LEFT*/
				surface.DrawTexturedRect(x - (size*2), y - (size*2), size*2, size*5)
				
				if GetConVarNumber("cw_kk_freeze_reticles") != 0 then
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetTexture(aimPosBuild)
					surface.DrawTexturedRect(-size/2, -size/2, size * 2, size * 2)
					surface.DrawTexturedRect(-size/2, -size/2, size * 2, size * 2)
					surface.DrawTexturedRect(-size/2, -size/2, size * 2, size * 2)
				end
				
				-- surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				-- surface.SetTexture(lens)
				-- surface.DrawTexturedRectRotated(size / 2, size / 2, size, size, 90)
			cam.End2D()
			
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

if CLIENT then
	local innerRim = Material(_innerRim)
	local outerRim = Material(_outerRim)
	
	local rearMat = Material("models/weapons/optics/kobra_dot")
	
	local white = Color(255,255,255)
	local color = Color(0,0,0)
	
	local size, attachmEnt, retAtt, retPos, retAng, retNorm, offset
		
	function CustomizableWeaponry_KK.ins2:renderTargetSightStencil(att)
		-- if not self.ActiveAttachments[att.name] then return end
		
		attachmEnt = self.AttachmentModelsVM[att.name].ent
	
		-- render.ClearStencil()
		-- render.SetStencilEnable(true)
		-- render.SetStencilWriteMask(1)
		-- render.SetStencilTestMask(1)
		-- render.SetStencilReferenceValue(1)
		-- render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		-- render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		-- render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		-- render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		
		-- CustomizableWeaponry_KK.ins2.drawStencilEnt(self, att)
		
		-- render.SetStencilWriteMask(2)
		-- render.SetStencilTestMask(2)
		-- render.SetStencilReferenceValue(2)
		-- render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		-- render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		-- render.SetStencilWriteMask(1)
		-- render.SetStencilTestMask(1)
		-- render.SetStencilReferenceValue(1)
		
		-- retAtt = attachmEnt:GetAttachment(2)
		-- retPos = retAtt.Pos
		-- retAng = -90 - retAtt.Ang.z
		-- retNorm = -retAtt.Ang:Forward()
		
		-- cam.IgnoreZ(true)
			-- if att._reticleMat then
				-- size = 300
				-- render.SetMaterial(att._reticleMat)
			-- else
				-- size = 240
				-- render.SetMaterial(innerRim)
			-- end
			
			-- render.DrawQuadEasy(retPos, retNorm, size, size, white, retAng)
			
			-- render.SetMaterial(outerRim)
			
			-- /*UP*/
			-- offset = -retAtt.Ang:Right() * size*3
			-- render.DrawQuadEasy(retPos + offset, retNorm, size, size * 5, color, retAng)
			
			-- /*RIGHT*/
			-- offset = retAtt.Ang:Up() * size*3
			-- render.DrawQuadEasy(retPos + offset, retNorm, size * 5, size * 11, color, retAng)
			
			-- /*DOWN*/
			-- offset = retAtt.Ang:Right() * size*3
			-- render.DrawQuadEasy(retPos + offset, retNorm, size, size * 5, color, retAng)
			
			-- /*LEFT*/
			-- offset = -retAtt.Ang:Up() * size*3
			-- render.DrawQuadEasy(retPos + offset, retNorm, size * 5, size * 11, color, retAng)
		-- cam.IgnoreZ(false)
		
		-- render.SetStencilEnable(false)
		
		
		if GetConVarNumber("cw_kk_freeze_reticles") == 0 then return end
		
		/*FRONT NODE*/
		retAtt = attachmEnt:GetAttachment(2)
		retPos = retAtt.Pos
		retAng = 90 + retAtt.Ang.z
		retNorm = retAtt.Ang:Forward()
		
		cam.IgnoreZ(true)
			render.CullMode(MATERIAL_CULLMODE_CW)
				size = 50
				render.SetMaterial(rearMat)
				render.DrawQuadEasy(retPos, retNorm, size, size, color, retAng)
				render.DrawQuadEasy(retPos, retNorm, size, size, color, retAng)
			render.CullMode(MATERIAL_CULLMODE_CCW)
		cam.IgnoreZ(false)
		
		-- /*REAR NODE*/
		-- retAtt = attachmEnt:GetAttachment(1)
		-- retPos = retAtt.Pos
		-- retAng = 90 + retAtt.Ang.z
		-- retNorm = retAtt.Ang:Forward()
		
		-- cam.IgnoreZ(true)
			-- render.CullMode(MATERIAL_CULLMODE_CW)
				-- size = 1
				-- render.SetMaterial(rearMat)
				-- render.DrawQuadEasy(retPos, retNorm, size, size, color, retAng)
				-- render.DrawQuadEasy(retPos, retNorm, size, size, color, retAng)
			-- render.CullMode(MATERIAL_CULLMODE_CCW)
		-- cam.IgnoreZ(false)
	end
end
