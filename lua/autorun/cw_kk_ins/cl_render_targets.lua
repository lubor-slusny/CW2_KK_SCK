
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
	local iRearMat = surface.GetTextureID("cw2/reticles/scope_leo")
	
	local imInnerRim = Material(strInnerRim)
	local imOuterRim = Material(strOuterRim)
	
	local colWhite = Color(255,255,255)
	local colBlack = Color(0,0,0)
	
	local tblLams = {
		"kk_ins2_lam", 
		"kk_ins2_m6x", 
		"kk_ins2_anpeq15"
	}
	
	local tblSupps = {
		"kk_ins2_pbs1", 
		"kk_ins2_pbs5", 
		"kk_ins2_suppressor_ins", 
		"kk_ins2_suppressor_pistol", 
		"kk_ins2_suppressor_sec", 
		"kk_ins2_suppressor_shotgun", 
		"kk_ins2_suppressor_sterling"
	}
	
	local imFrontMat = Material("models/weapons/optics/kobra_dot")
	
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
		local rtSize = self:getRenderTargetSize()
		
		local mdlAttRear = attachmEnt:GetAttachment(1)
		local mdlAttFront = attachmEnt:GetAttachment(2)
		
		cd.w = rtSize
		cd.h = rtSize
		cd.fov = att._rtFov
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, rtSize, rtSize)
			render.RenderView(cd)
			
			do
				local retSize = 100
				local retAtt = attachmEnt:GetAttachment(2)
				local retPos = retAtt.Pos
				local retAng = -90 - retAtt.Ang.z
				local retNorm = -retAtt.Ang:Forward()

				local ang = mdlAttRear.Ang
				ang:RotateAroundAxis(ang:Forward(), -90)
				
				cam.Start3D(mdlAttRear.Pos, ang)
					-- self.CW_VM:DrawModel()
					
					for _,lam in pairs(tblLams) do
						if self.ActiveAttachments[lam] then
							-- self.AttachmentModelsVM[lam].ent:DrawModel()
							CustomizableWeaponry.registeredAttachmentsSKey[lam].elementRender(self)
						end
					end
					
					-- for _,supp in pairs(tblSupps) do
						-- if self.ActiveAttachments[supp] then
							-- self.AttachmentModelsVM[supp].ent:DrawModel()
						-- end
					-- end
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
				surface.DrawTexturedRect(0, 0, rtSize, rtSize)
				
				if GetConVarNumber("cw_kk_freeze_reticles") == 1 then
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetTexture(iRearMat)
					surface.DrawTexturedRect(-rtSize/2, -rtSize/2, rtSize * 2, rtSize * 2)
					surface.DrawTexturedRect(-rtSize/2, -rtSize/2, rtSize * 2, rtSize * 2)
					surface.DrawTexturedRect(-rtSize/2, -rtSize/2, rtSize * 2, rtSize * 2)
				end
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(rtSize / 2, rtSize / 2, rtSize, rtSize, 90)
			cam.End2D()
			
			-- cam.Start3D(self.Owner:GetShootPos())
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
			-- cam.End3D()
			
		render.SetViewPort(0, 0, old_x, old_y)
		render.SetRenderTarget(old_rt)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end

	function CustomizableWeaponry_KK.ins2:renderTargetSightStencil(att)
		if GetConVarNumber("cw_kk_freeze_reticles") != 1 then return end
		
		local attachmEnt = self.AttachmentModelsVM[att.name].ent
		local retAtt = attachmEnt:GetAttachment(2)
		local retPos = retAtt.Pos
		local retAng = -90 - retAtt.Ang.z
		local retNorm = -retAtt.Ang:Forward()

		cam.IgnoreZ(true)
			render.SetMaterial(imFrontMat)
			render.DrawQuadEasy(retPos, retNorm, 50, 50, colWhite, retAng)
			render.DrawQuadEasy(retPos, retNorm, 50, 50, colWhite, retAng)
		cam.IgnoreZ(false)
	end
end
