
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
	
	if self.ShotgunReload and !self.dt.INS2GLActive then
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
	return self._currentGrenadeLauncher != nil
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
	return self._currentPrimarySight and self._currentPrimarySight.name
end

function SWEP:getSecondarySight()
	return self._currentSecondarySight and self._currentSecondarySight.name
end

function SWEP:getGLAttName()
	return (self._currentGrenadeLauncher and self._currentGrenadeLauncher.displayNameShort) or "No grenade launcher attached."
end

if CLIENT then
	function SWEP:drawVMShells()
		for _,v in pairs(self._deployedShells) do
			if IsValid(v) then
				if v._drawAsVM > CurTime() then
					v:DrawModel()
				else
					v:SetNoDraw(false)
				end
			end
		end
	end
end

local makeShell = CustomizableWeaponry_KK.ins2.makeShell
local vm, att, dir, ang, tweak

function SWEP:shellEvent(sh)
	if SERVER then return end
	
	sh = sh or self._shellTable
	
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		att = vm:GetAttachment(self.WorldShellEjectionAttachmentID)
		local ejectVelocity = att.Ang:Forward() * (self.ShellEjectVelocity or 200)
		
		ang = att.Ang
		tweak = self._shellTable.rw
		if tweak then
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
		end
		
		makeShell(self, att.Pos, ang, ejectVelocity, 0.5, 10, sh)
	else
		vm = self.CW_VM
		att = vm:GetAttachment(self.ViewShellAttachmentID)
		
		if self.InvertShellEjectAngle then
			dir = -att.Ang:Forward()
		else
			dir = att.Ang:Forward()
		end
		
		if self.ShellPosOffset then
			att.Pos = att.Pos + (self.ShellPosOffset.x) * att.Ang:Right()
			att.Pos = att.Pos + (self.ShellPosOffset.y) * att.Ang:Forward()
			att.Pos = att.Pos + (self.ShellPosOffset.z) * att.Ang:Up()
		end
		
		ang = EyeAngles()
		tweak = self._shellTable.rv
			
		if tweak then
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
		end
		
		makeShell(self, att.Pos + dir * self.ShellOffsetMul, ang, dir * (self.ShellEjectVelocity or 200), 0.6, 10, sh)
	end
end

function SWEP:shellEvent2()
	self:shellEvent(self._shellTable2)
end
