
if CLIENT then
	CustomizableWeaponry_KK.rts = CustomizableWeaponry_KK.rts or {}

	CustomizableWeaponry_KK.rts.ins2_scope = GetRenderTarget("cw_kk_ins2_scope", 512, 512, false)
	CustomizableWeaponry_KK.rts.ins2_scope_init = true
end

local strInnerRim = "models/weapons/attachments/cw_kk_ins2_shared/fake"
local strOuterRim = "models/weapons/attachments/cw_kk_ins2_shared/fake20"

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
	
	local iInnerRim = surface.GetTextureID(strInnerRim)
	local iOuterRim = surface.GetTextureID(strOuterRim)
	local aimPosBuild = surface.GetTextureID("cw2/reticles/scope_leo")
	
	local imInnerRim = Material(strInnerRim)
	local imOuterRim = Material(strOuterRim)
	
	local colWhite = Color(255,255,255)
	local colBlack = Color(0,0,0)
	
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
		
		old_x, old_y = ScrW(), ScrH()
		old_rt = render.GetRenderTarget()
		
		if self.freeAimOn then
			ang = self.Owner:EyeAngles()
		else
			ang = self.AttachmentModelsVM[att.name].ent:GetAttachment(1).Ang
			ang:RotateAroundAxis(ang:Forward(), -90)
		end
		
		local attachmEnt = self.AttachmentModelsVM[att.name].ent
		local size = self:getRenderTargetSize()

		cd.w = size
		cd.h = size
		cd.fov = att._rtFov
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		-- cd.origin = attachmEnt:GetAttachment(1).Pos
		
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, size, size)
		
			_KK_RT_GOING_ON = true
				render.RenderView(cd)
			_KK_RT_GOING_ON = false
			
			local retSize = 140
			local retAtt = attachmEnt:GetAttachment(2)
			local retPos = retAtt.Pos
			local retAng = -90 - retAtt.Ang.z
			local retNorm = -retAtt.Ang:Forward()

			do
			ehAtt = attachmEnt:GetAttachment(1)
			ehAtt.Ang:RotateAroundAxis(ehAtt.Ang:Forward(), -90)
			
			cam.Start3D(ehAtt.Pos, ehAtt.Ang)
			-- cam.Start3D()
				-- self.CW_VM:DrawModel()
				
				for _,lam in pairs({"kk_ins2_lam", "kk_ins2_m6x", "kk_ins2_anpeq15"}) do
					if self.ActiveAttachments[lam] then
						CustomizableWeaponry.registeredAttachmentsSKey[lam].elementRender(self)
					end
				end
				
				-- cam.IgnoreZ(true)
					-- render.SetMaterial(imInnerRim)
					-- render.DrawQuadEasy(retPos, retNorm, retSize, retSize, colWhite, retAng)
					
					-- render.SetMaterial(imOuterRim)
					
					-- /*UP*/
					-- offset = -retAtt.Ang:Right() * retSize*3
					-- render.DrawQuadEasy(retPos + offset, retNorm, retSize, retSize * 5, colBlack, retAng)
					
					-- /*RIGHT*/
					-- offset = retAtt.Ang:Up() * retSize*3
					-- render.DrawQuadEasy(retPos + offset, retNorm, retSize * 5, retSize * 11, colBlack, retAng)
					
					-- /*DOWN*/
					-- offset = retAtt.Ang:Right() * retSize*3
					-- render.DrawQuadEasy(retPos + offset, retNorm, retSize, retSize * 5, colBlack, retAng)
					
					-- /*LEFT*/
					-- offset = -retAtt.Ang:Up() * retSize*3
					-- render.DrawQuadEasy(retPos + offset, retNorm, retSize * 5, retSize * 11, colBlack, retAng)
				-- cam.IgnoreZ(false)
				
			cam.End3D()
			end
			
			
			local lang = self.Owner:EyeAngles()
			lang.p = lang.p + self.BlendAng.x
			lang.y = lang.y + self.BlendAng.y
			lang.r = lang.r + self.BlendAng.z
			lang = -lang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), lang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				if att._rtReticle then
					surface.SetTexture(att._rtReticle)
				else
					surface.SetTexture(iInnerRim)
				end
				surface.DrawTexturedRect(0, 0, size, size)
				
				if GetConVarNumber("cw_kk_freeze_reticles") != 0 then
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetTexture(aimPosBuild)
					surface.DrawTexturedRect(-size/2, -size/2, size * 2, size * 2)
					surface.DrawTexturedRect(-size/2, -size/2, size * 2, size * 2)
					surface.DrawTexturedRect(-size/2, -size/2, size * 2, size * 2)
				end
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(size / 2, size / 2, size, size, 90)
			cam.End2D()
			
		render.SetViewPort(0, 0, old_x, old_y)
		render.SetRenderTarget(old_rt)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

if CLIENT then
	function CustomizableWeaponry_KK.ins2:renderTargetSightStencil(att)
	
	end
end
