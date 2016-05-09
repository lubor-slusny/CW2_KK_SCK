
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

	local ply, wep
	
	usermessage.Hook("CW_KK_INS2_RELOADINACTIVITY", function()
		ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		wep = ply:GetActiveWeapon()
		if !IsValid(wep) or not wep.CW20Weapon then return end
			
		wep:reloadInactivity()
	end)
end

if CLIENT then
	function SWEP:updateStandardParts()
		self:updateHands()
		self:updateOtherParts()
	end
	
	local cvRig = GetConVar("cw_kk_ins2_rig")
	local currentRig
	
	function SWEP:updateHands()
		currentRig = math.Round(math.Clamp(cvRig:GetInt(),1,#CustomizableWeaponry_KK.ins2.hands), 0)
		
		if self._KK_INS2_rig != currentRig then
			if self.CW_KK_HANDS then
				self.CW_KK_HANDS:SetModel(CustomizableWeaponry_KK.ins2.hands[currentRig])
			end
		end
		
		self._KK_INS2_rig = currentRig
	end
	
	function SWEP:updateOtherParts()
		// whatever u want
	end
end

function SWEP:hasInstalledRTScope()
	return 
		self.ActiveAttachments.kk_ins2_magnifier or
		self.ActiveAttachments.kk_ins2_elcan or
		self.ActiveAttachments.kk_ins2_po4 or
		self.ActiveAttachments.kk_ins2_scope_m40 or
		self.ActiveAttachments.kk_ins2_scope_mosin or
		
		self.ActiveAttachments.kk_ins2_cstm_acog or
		self.ActiveAttachments.kk_ins2_cstm_pgo7 or
		
		self.ActiveAttachments.kk_ins2_scope_zf4
end

function SWEP:hasInstalledStencilSight()
	return 
		self.ActiveAttachments.kk_ins2_aimpoint or
		self.ActiveAttachments.kk_ins2_eotech or
		self.ActiveAttachments.kk_ins2_kobra or
		
		self.ActiveAttachments.kk_ins2_cstm_cmore or
		self.ActiveAttachments.kk_ins2_cstm_sureshot or
		self.ActiveAttachments.kk_ins2_cstm_barska or
		self.ActiveAttachments.kk_ins2_cstm_microt1 or
		self.ActiveAttachments.kk_ins2_cstm_eotechxps or
		self.ActiveAttachments.kk_ins2_cstm_compm4s
end

function SWEP:hasInstalledGL()
	return 
		self.ActiveAttachments.kk_ins2_gl_gp25 or 
		self.ActiveAttachments.kk_ins2_gl_m203
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

local CW2_ATTS = CustomizableWeaponry.registeredAttachmentsSKey

function SWEP:getPrimarySight()
	for k,v in pairs(self.ActiveAttachments) do
		if v and CW2_ATTS[k].isSight then
			return k
		end
	end
end

function SWEP:getSecondarySight()
	for k,v in pairs(self.ActiveAttachments) do
		if v and CW2_ATTS[k].isSecondarySight then
			return k
		end
	end
end

function SWEP:getGLAttName()
	for k,v in pairs(self.ActiveAttachments) do
		if v and CW2_ATTS[k].isGrenadeLauncher then
			return CW2_ATTS[k].displayNameShort
		end
	end
	
	return "No grenade launcher attached."
end
