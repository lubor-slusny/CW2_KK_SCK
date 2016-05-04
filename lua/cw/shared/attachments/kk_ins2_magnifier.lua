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
	
	-- local simpleTextureDefault = surface.GetTextureID("models/weapons/optics/4x_reticule")
	-- local simpleTextureXPS = surface.GetTextureID("models/weapons/attachments/cw_kk_ins2_cstm_eotechxps/4x_reticule")
	
	local simpleTextureDefault = surface.GetTextureID("models/weapons/optics/aimpoint_reticule_holo")
	local simpleTextureXPS = surface.GetTextureID("models/weapons/optics/eotech_reticule_holo")

	local simpleTextures = {
		["_default"] = {tex = simpleTextureDefault, offset = {0, 1}, size = {64, 64}},
		["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl"] = {tex = simpleTextureXPS, offset = {0, 1}, size = {128, 128}},
		["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_l.mdl"] = {tex = simpleTextureXPS, offset = {0, 1}, size = {128, 128}},
		["models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m.mdl"] = {tex = simpleTextureXPS, offset = {0, 1}, size = {128, 128}},
	}

	att.zoomTextures = {
		{tex = simpleTextureDefault, offset = {0, 1}, size = {128, 128}},
		{tex = surface.GetTextureID("models/weapons/attachments/cw_kk_ins2_shared/fake"), offset = {0, 1}},
	}
	
	att._rtFov = 8
	
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
			
			att.zoomTextures[1] = simpleTextures[velement.model] or simpleTextures["_default"]
			self.ZoomTextures = att.zoomTextures
		end
		self.lastPrimarySight = currentPrimarySight
		
		// magnifier velement stuff
		if isAiming then 
			scopeEnt:SetSequence("4x_zoom")
		else
			scopeEnt:SetSequence("4x_idle")
		end
		
		CustomizableWeaponry_KK.ins2.renderTargetSight(self, att)
	end
	
	function att:elementRender()
		CustomizableWeaponry_KK.ins2.renderTargetSightSetup(self, att)
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
	
	self.SimpleTelescopicsFOV = 70
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
	
	self.SimpleTelescopicsFOV = nil
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)
