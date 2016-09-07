
if CLIENT then
	CustomizableWeaponry_KK.ins2.rtSight = CustomizableWeaponry_KK.ins2.rtSight or {}
end

if CLIENT then
	local old_rt, old_x, old_y, ang, light
	local iLens = surface.GetTextureID("cw2/gui/lense")
	local iMatLens = Material("cw2/gui/lense")
	local alpha = 0.5
	
	local cd = {}
	cd.x = 0
	cd.y = 0
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	local strInnerRim = "models/weapons/attachments/cw_kk_ins2_shared/fake"
	local strOuterRim = "models/weapons/attachments/cw_kk_ins2_shared/fake20"

	local iInnerRim = surface.GetTextureID(strInnerRim)
	local iOuterRim = surface.GetTextureID(strOuterRim)
	local iRearMat = surface.GetTextureID("cw2/reticles/scope_leo")
	
	local iMatInnerRim = Material(strInnerRim)
	local iMatOuterRim = Material(strOuterRim)
	local iMatFront = Material("models/weapons/optics/kobra_dot")
	
	local colWhite = Color(255,255,255)
	local colBlack = Color(0,0,0)
	
	local CW2ATTS = CustomizableWeaponry.registeredAttachmentsSKey
	local tblLams = {
		"kk_ins2_lam", 
		"kk_ins2_m6x", 
		"kk_ins2_anpeq15"
	}
	
	local cvFreeze = GetConVar("cw_kk_freeze_reticles")
	local cvDrawVM = GetConVar("cw_kk_ins2_draw_vm_in_rt")
	
	local attachmEnt, mdlAttRear, mdlAttFront
	local retPos, retAng, retNorm
	
	local complexTelescopics, rtSize, oldStencilChk
	
	function CustomizableWeaponry_KK.ins2.rtSight:renderTarget(wep, att)
		if not att then return end
		if not wep.ActiveAttachments[att.name] then return end
		
		complexTelescopics = wep:canUseComplexTelescopics()
		
		if not complexTelescopics then
			wep.TSGlass:SetTexture("$basetexture", iMatLens:GetTexture("$basetexture"))
			return
		end
		
		if !wep.dt.INS2GLActive and wep:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		attachmEnt = wep.AttachmentModelsVM[att.name].ent
		mdlAttRear = attachmEnt:GetAttachment(1)
		mdlAttFront = attachmEnt:GetAttachment(2)
		
		if wep.freeAimOn then
			ang = wep.Owner:EyeAngles()
		else
			ang = mdlAttRear.Ang
			ang:RotateAroundAxis(ang:Forward(), -90)
		end
		
		rtSize = wep:getRenderTargetSize()
		
		cd.w = rtSize
		cd.h = rtSize
		cd.fov = att._rtFov
		cd.angles = ang
		cd.origin = wep.Owner:GetShootPos()

		old_x, old_y = ScrW(), ScrH()
		old_rt = render.GetRenderTarget()
		
		render.SetRenderTarget(wep.ScopeRT)
		render.SetViewPort(0, 0, rtSize, rtSize)
			if alpha != 1 then 
				render.RenderView(cd)
			end
			
			cam.Start3D(mdlAttRear.Pos, ang)
				if cvDrawVM:GetInt() == 1 then
					wep.CW_VM:DrawModel()
				end
				
				oldStencilChk = wep._KK_INS2_stencilsDisableLaser
				
				wep._KK_INS2_stencilsDisableLaser = false
					for _,lam in pairs(tblLams) do
						if wep.ActiveAttachments[lam] then
							CW2ATTS[lam].elementRender(wep)
						end
					end
				wep._KK_INS2_stencilsDisableLaser = oldStencilChk
			cam.End3D()
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(att._rtReticle or iInnerRim)
				surface.DrawTexturedRect(0, 0, rtSize, rtSize)
				
				if cvFreeze:GetInt() == 1 then
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetTexture(iRearMat)
					for _ = 1,3 do
						surface.DrawTexturedRect(-rtSize/2, -rtSize/2, rtSize * 2, rtSize * 2)
					end
				end
				
				ang = wep.Owner:EyeAngles()
				ang.p = ang.p + wep.BlendAng.x
				ang.y = ang.y + wep.BlendAng.y
				ang.r = ang.r + wep.BlendAng.z
				ang = -ang:Forward()
				
				light = render.ComputeLighting(wep.Owner:GetShootPos(), ang)

				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(iLens)
				surface.DrawTexturedRectRotated(rtSize / 2, rtSize / 2, rtSize, rtSize, 90)
			cam.End2D()
			
		render.SetViewPort(0, 0, old_x, old_y)
		render.SetRenderTarget(old_rt)
		
		if wep.TSGlass then
			wep.TSGlass:SetTexture("$basetexture", wep.ScopeRT)
		end
	end

	local MP = !game.SinglePlayer()
	
	function CustomizableWeaponry_KK.ins2.rtSight:stencil(wep, att)
		if MP then return end
		if cvFreeze:GetInt() != 1 then return end
		
		attachmEnt = wep.AttachmentModelsVM[att.name].ent
		mdlAttRear = attachmEnt:GetAttachment(1)
		mdlAttFront = attachmEnt:GetAttachment(2)
		
		// front
		retPos = mdlAttFront.Pos
		retAng = -90 - mdlAttFront.Ang.z
		retNorm = -mdlAttFront.Ang:Forward()

		cam.IgnoreZ(true)
			render.SetMaterial(iMatFront)
			render.DrawQuadEasy(retPos, retNorm, 50, 50, colWhite, retAng)
			render.DrawQuadEasy(retPos, retNorm, 50, 50, colWhite, retAng)
		cam.IgnoreZ(false)
		
		-- // rear
		-- retPos = mdlAttRear.Pos
		-- retAng = -90 - mdlAttRear.Ang.z
		-- retNorm = -mdlAttRear.Ang:Forward()

		-- cam.IgnoreZ(true)
			-- render.SetMaterial(iMatFront)
			-- render.DrawQuadEasy(retPos, retNorm, 0.5, 0.5, colWhite, retAng)
		-- cam.IgnoreZ(false)
	end
end
