AddCSLuaFile()

local models = {
	["models/weapons/upgrades/a_optic_aimpoint.mdl"] = "models/weapons/upgrades/a_optic_aimp2x.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_l.mdl"] = "models/weapons/upgrades/a_optic_aimp2x_l.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_m.mdl"] = "models/weapons/upgrades/a_optic_aimp2x_m.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_l.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_l_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_m.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_m_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l_2x.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m.mdl"] = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m_2x.mdl",
	["primaryModel"] = "magnifModel",
}

local wmodels = {
	["models/weapons/upgrades/a_optic_aimpoint.mdl"] = "models/weapons/upgrades/w_magaim.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_l.mdl"] = "models/weapons/upgrades/w_magaim.mdl",
	["models/weapons/upgrades/a_optic_aimpoint_m.mdl"] = "models/weapons/upgrades/w_magaim.mdl",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_l.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_m.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l.mdl"] = "magnifModel",
	["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m.mdl"] = "magnifModel",
	["primaryModel"] = "magnifModel",
}

local att = {}
att.name = "kk_ins2_magnifier"
att.displayName = "2x Magnifier Scope"
att.displayNameShort = "2x Zoom"
att.aimPos = {"KKINS2MagnifierPos", "KKINS2MagnifierAng"}
att.isSecondarySight = true

att.statModifiers = {
	OverallMouseSensMult = -0.07
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Provides 2x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
	}
	
	-- local rc
	local RTMat = Material("models/weapons/optics/lense_rt")
	
	local old, x, y, ang
	local Ini = true
	
	local lens = surface.GetTextureID("cw2/gui/lense")
	local cd, alpha, reticleTime = {}, 0.5, 0
	
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 8
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	function att:INS2_DrawRenderTarget()
		if not self.ActiveAttachments[att.name] then return end
		local currentPrimarySight = self:getCurrentPrimarySight()
		
		local rc
		if currentPrimarySight then
			rc = self:getSightColor(currentPrimarySight)
		else
			rc = {r = 0, g = 0, b = 0, a = 0}
		end
		
		local scopeEnt = self.AttachmentModelsVM[att.name].ent
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		local isAiming = self:isAiming()
		
		// reset aimposition when primary sight is changed
		if self.lastPrimarySight != currentPrimarySight then
			local velement = self.AttachmentModelsVM[currentPrimarySight]
			if velement then
				velement.active = false
			end
			self.AimPos = self[att.aimPos[1]]
			self.AimAng = self[att.aimPos[2]]
			
			magnifierModel = models[velement.model]
			scopeEnt:SetModel(magnifierModel)
		end
		self.lastPrimarySight = currentPrimarySight
		
		-- // something
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
			reticleTime = math.Approach(reticleTime, 1, FrameTime() * 1.8)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
			reticleTime = 0
		end
		
		// magnifier velement stuff
		if isAiming then 
			scopeEnt:SetSequence("4x_zoom")
		else
			scopeEnt:SetSequence("4x_idle")
		end
		
		// render target
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
		
		if self.freeAimOn then
			ang = self:getTelescopeAngles()
		else
			ang = self:getReticleAngles()
			
			ang:RotateAroundAxis(ang:Right(), self.ACOGAxisAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.ACOGAxisAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.ACOGAxisAlign.forward)
		end
		
		if self.ViewModelFlip then
			ang.r = -self.BlendAng.z
		else
			ang.r = self.BlendAng.z
		end
		
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(CustomizableWeaponry_KK.rts.ins2_scope)
		render.SetViewPort(0, 0, 0, 0)
			
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				-- surface.SetDrawColor(255, 255, 255, 255)
				-- surface.SetTexture(surface.GetTextureID("cw2/reticles/reticle_chevron"))
				-- surface.DrawTexturedRect(0, 0, 512, 512)
				
				local dh, dv, rx, ry
				
				dh = 1
				dv = 1
					
				if reticleTime == 1 then
					dh = math.Clamp(self:getDifferenceToAimPos(self.AimPos, self.AimAng, 0, 1, 0.3),0,2)
					dv = math.Clamp(self:getDifferenceToAimPos(self.AimPos, self.AimAng, 1, 0, 0.3),0,2)
				end
				
				rx = dh * 512 - 1024
				ry = dv * 512 - 1024
		
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(surface.GetTextureID("models/weapons/attachments/cw_kk_ins2_shared/fake_long"))
				surface.DrawTexturedRect(rx, ry, 1536, 1536)	
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(surface.GetTextureID("models/weapons/attachments/cw_kk_ins2_shared/fake"))
				surface.DrawTexturedRect(6, 6, 500, 500)	
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(256, 256, 512, 512, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if RTMat then
			RTMat:SetTexture("$basetexture", CustomizableWeaponry_KK.rts.ins2_scope)
		end
	end
end

function att:attachFunc()
	if CLIENT then
		if not self._KK_INS2_RTF_original then
			self._KK_INS2_RTF_original = self.RenderTargetFunc or function() end
		end
		
		self.RenderTargetFunc = function()
			self:_KK_INS2_RTF_original()
			att.INS2_DrawRenderTarget(self)
		end
	
		local currentPrimarySight = self:getCurrentPrimarySight()
		
		if currentPrimarySight and self.AttachmentModelsVM and self.AttachmentModelsVM.kk_ins2_magnifier and self.AttachmentModelsVM.kk_ins2_magnifier.ent then
			magnifierModel = models[self.AttachmentModelsVM[currentPrimarySight].model]
			if magnifierModel then
				self.AttachmentModelsVM.kk_ins2_magnifier.ent:SetModel(magnifierModel)
				if self.AttachmentModelsVM[currentPrimarySight] then
					self.AttachmentModelsVM[currentPrimarySight].active = false
				end
			end
		end
		
		self.AimPos = self[att.aimPos[1]]
		self.AimAng = self[att.aimPos[2]]
	end
	
	self.BlurOnAim = true
end

function att:detachFunc()
	if CLIENT then
		self.RenderTargetFunc = self._KK_INS2_RTF_original
		
		local currentPrimarySight = self:getCurrentPrimarySight()
		
		if currentPrimarySight and self.AttachmentModelsVM and self.AttachmentModelsVM[currentPrimarySight] then
			self.AttachmentModelsVM[currentPrimarySight].active = true
		end
		
		// restore aimpositions
		local cwSight = CustomizableWeaponry.sights[currentPrimarySight]
		if cwSight then
			self.AimPos = self[cwSight.aimPos[1]]
			self.AimAng = self[cwSight.aimPos[2]]
		else
			self.AimPos = self.AimPos_Orig
			self.AimAng = self.AimAng_Orig
		end
		
	end
	
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)
