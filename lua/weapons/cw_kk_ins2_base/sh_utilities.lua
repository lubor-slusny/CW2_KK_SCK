
local SP = game.SinglePlayer()

local mode, customSuffix, fullA, emptyA, fullT, emptyT

function SWEP:updateReloadTimes()
	mode = self:getForegripMode()
	customSuffix = self._KK_INS2_customSuffix or ""

	if self.ReloadTimes then	// extend, finish
		//	2do: 
		//		shotgun reloads
		//		non-chamberable reloads
		//		[openbolt(charged/fired) reloads]
	
		fullA = self.Animations[mode .. "reload" .. customSuffix]
		emptyA = self.Animations[mode .. "reload_empty" .. customSuffix]
		
		self.Animations.reload = fullA
		self.Animations.reload_empty = emptyA
		
		fullT = self.ReloadTimes[fullA]
		emptyT = self.ReloadTimes[emptyA]
		
		self.ReloadTime = fullT and fullT[1] or emptyT and emptyT[1]
		self.ReloadHalt = fullT and fullT[2] or emptyT and emptyT[2]
		self.ReloadTime_Empty = emptyT and emptyT[1] or fullT and fullT[1]
		self.ReloadHalt_Empty = emptyT and emptyT[2] or fullT and fullT[2]
		
		return
	end
		
	// delete below once above is finished	
	
	if self.ShotgunReload then
		self.Animations.reload_start = self.Animations[mode .. "reload_start"]
		self.Animations.insert = self.Animations[mode .. "insert"]
		self.Animations.reload_end = self.Animations[mode .. "reload_end"]
		self.Animations.idle = self.Animations[mode .. "reload_end"]
		
		if self.base_ReloadStartTime then
			self.ReloadStartTime = self[mode .. "ReloadStartTime"] or self.base_ReloadStartTime
		end
		if self.base_InsertShellTime then
			self.InsertShellTime = self[mode .. "InsertShellTime"] or self.base_InsertShellTime
		end
		if self.base_ReloadFinishWait then
			self.ReloadFinishWait = self[mode .. "ReloadFinishWait"] or self.base_ReloadFinishWait
		end
	else
		self.Animations.reload = self.Animations[mode .. "reload" .. customSuffix]
		self.Animations.reload_empty = self.Animations[mode .. "reload_empty" .. customSuffix]
			
		if self.base_ReloadTime then
			self.ReloadTime = self[mode .. "ReloadTime"] or self.base_ReloadTime
		end
		if self.base_ReloadHalt then
			self.ReloadHalt = self[mode .. "ReloadHalt"] or self.base_ReloadHalt
		end
		if self.base_ReloadTime_Empty then
			self.ReloadTime_Empty = self[mode .. "ReloadTime_Empty"] or self.base_ReloadTime_Empty
		end
		if self.base_ReloadHalt_Empty then
			self.ReloadHalt_Empty = self[mode .. "ReloadHalt_Empty"] or self.base_ReloadHalt_Empty
		end
	end
end

if CLIENT then
	function SWEP:reloadInactivity()
		if self.ShotgunReload then
			self.reticleInactivity = UnPredictedCurTime() + 1 // (self.CW_VM:SequenceDuration()) + 1
		else
			if self:Clip1() == 0 then
				self.reticleInactivity = UnPredictedCurTime() + self.ReloadHalt_Empty
			else
				self.reticleInactivity = UnPredictedCurTime() + self.ReloadHalt
			end
		end
	end

	usermessage.Hook("CW_KK_INS2_RELOADINACTIVITY", function()
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) or not wep.CW20Weapon then return end
			
		wep:reloadInactivity()
	end)
end

if CLIENT then
	function SWEP:getGLAttName()
		for k,v in pairs(self.ActiveAttachments) do
			if v and CustomizableWeaponry.registeredAttachmentsSKey[k].isGrenadeLauncher then
				return CustomizableWeaponry.registeredAttachmentsSKey[k].displayNameShort
			end
		end
		
		return "No GL attached."
	end
	
	function SWEP:updateStandardParts()
		if self.AttachmentModelsVM then
			if self:getPrimarySight() != nil then
				if self.AttachmentModelsVM.kk_ins2_optic_iron then
					self.AttachmentModelsVM.kk_ins2_optic_iron.active = false
				end
				if self.AttachmentModelsVM.kk_ins2_optic_rail then
					self.AttachmentModelsVM.kk_ins2_optic_rail.active = true
				end
			else
				if self.AttachmentModelsVM.kk_ins2_optic_iron then
					self.AttachmentModelsVM.kk_ins2_optic_iron.active = true
				end
				if self.AttachmentModelsVM.kk_ins2_optic_rail then
					self.AttachmentModelsVM.kk_ins2_optic_rail.active = false
				end
			end
			
			if self.AttachmentModelsWM then // move somewhere else
				for k,v in pairs(self.AttachmentModelsVM) do
					if self.AttachmentModelsWM[k] then
						self.AttachmentModelsWM[k].active = v.active
					end
				end
			end
		end
		
		self:updateOtherParts()
		self:updateHands()
	end
	
	function SWEP:updateOtherParts()
	end
	
	function SWEP:updateHands()
		local currentRig = math.Round(math.Clamp(GetConVarNumber("cw_kk_ins2_rig"),1,table.Count(CustomizableWeaponry_KK.ins2.hands)), 0)
		
		if self._KK_INS2_rig != currentRig then
			if self.CW_KK_HANDS then
				self.CW_KK_HANDS:SetModel(CustomizableWeaponry_KK.ins2.hands[currentRig])
			end
		end
		
		self._KK_INS2_rig = currentRig
	end
end

function SWEP:hasInstalledRTScope()	// to be extended
	local res = false
	
	res = res or self.ActiveAttachments.kk_ins2_magnifier
	res = res or self.ActiveAttachments.kk_ins2_elcan
	res = res or self.ActiveAttachments.kk_ins2_po4
	res = res or self.ActiveAttachments.kk_ins2_scope_m40
	res = res or self.ActiveAttachments.kk_ins2_scope_mosin
	
	res = res or self.ActiveAttachments.kk_ins2_cstm_acog
	res = res or self.ActiveAttachments.kk_ins2_cstm_pgo7
	
	res = res or self.ActiveAttachments.kk_ins2_scope_zf4
	
	return res
end

function SWEP:hasInstalledStencilSight()
	local res = false
	
	res = res or self.ActiveAttachments.kk_ins2_aimpoint
	res = res or self.ActiveAttachments.kk_ins2_eotech
	res = res or self.ActiveAttachments.kk_ins2_kobra
	
	res = res or self.ActiveAttachments.kk_ins2_cstm_cmore
	res = res or self.ActiveAttachments.kk_ins2_cstm_sureshot
	res = res or self.ActiveAttachments.kk_ins2_cstm_barska
	res = res or self.ActiveAttachments.kk_ins2_cstm_microt1
	res = res or self.ActiveAttachments.kk_ins2_cstm_eotechxps
	res = res or self.ActiveAttachments.kk_ins2_cstm_compm4s
	
	return res
end

function SWEP:hasInstalledGL()	// to be extended
	return self.ActiveAttachments.kk_ins2_gl_gp25 or self.ActiveAttachments.kk_ins2_gl_m203
end

function SWEP:getForegripMode()
	if self.ActiveAttachments.kk_ins2_vertgrip then 
		return "foregrip_"
	elseif self:hasInstalledGL() then
		if self.dt.INS2GLActive then
			return "gl_on_"
		else
			return "gl_off_"
		end
	elseif self.dt.BipodDeployed then 
		return "bipod_"
	end
	
	return "base_"
end

function SWEP:getPrimarySight()
	for k,v in pairs(self.ActiveAttachments) do
		if v and CustomizableWeaponry.registeredAttachmentsSKey[k].isSight then
			return k
		end
	end
end

function SWEP:getSecondarySight()
	for k,v in pairs(self.ActiveAttachments) do
		if v and CustomizableWeaponry.registeredAttachmentsSKey[k].isSecondarySight then
			return k
		end
	end
end
