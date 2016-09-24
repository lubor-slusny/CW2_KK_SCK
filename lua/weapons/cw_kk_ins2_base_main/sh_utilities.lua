
local SP = game.SinglePlayer()

//-----------------------------------------------------------------------------
// updateReloadTimes now only updates vars used by StatDisplay
// called from 
// - SWEP:Initialize()
// - CL SWEP:Think()
//-----------------------------------------------------------------------------

local prefix, suffix

function SWEP:updateReloadTimes()
	prefix = self:getForegripMode()
	suffix = self._KK_INS2_customReloadSuffix
	
	self.ReloadTime, self.ReloadHalt = self:getAnimTimes(prefix .. "reload" .. suffix)
	self.ReloadTime_Empty, self.ReloadHalt_Empty = self:getAnimTimes(prefix .. "reload_empty" .. suffix)
	
	// we ll just check for both mag-fed and internal-mag setups coz
	// revolvers and ww2 rifles use both, why add extra checks, right?
	self.ReloadStartTime, self.ReloadStartTime = self:getAnimTimes(prefix .. "reload_start")
	self.InsertShellTime, self.InsertShellTime = self:getAnimTimes(prefix .. "insert")
	
	local _, finishEmpty = self:getAnimTimes(prefix .. "reload_end_empty")
	local _, startEmpty = self:getAnimTimes(prefix .. "reload_start_empty")
	
	if !finishEmpty or !startEmpty then
		return
	end
	
	// this should make stat display count full shotgun reload time correctly for ins2 sgs
	self.ReloadFinishWait = finishEmpty + startEmpty - self.ReloadStartTime
end

//-----------------------------------------------------------------------------
// getAnimTimes replaced old updateReloadTimes logic
//-----------------------------------------------------------------------------

local seqName, seqTable

function SWEP:getAnimTimes(animName)
	if not animName then
		local msg = tostring(self) .. ":getAnimTimes() called without parameter."
		error(msg)
		return
	end
	
	if not self.ReloadTimes then
		local msg = tostring(self) .. " Missing main ReloadTimes table."
		error(msg)
		return
	end
	
	seqName = self.Animations[animName]
	
	if not seqName or !isstring(seqName) then 
		return 
	end
	
	seqTable = self.ReloadTimes[seqName]
	
	-- print(animName, seqName, seqTable)
	
	if not seqTable then 
		local msg = tostring(self) .. " Missing ReloadTimes setup for animation \"" .. animName .. "\"."
		error(msg)
		return
	end
	
	return seqTable[1], seqTable[2], seqTable[3], seqTable[4]
end

//-----------------------------------------------------------------------------
// updateHands checks cw_kk_ins2_rig convar for changes and updates hands model
//-----------------------------------------------------------------------------

if CLIENT then
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
end

//-----------------------------------------------------------------------------
// updateBelt on first call
// - checks CW_VM for bodygroups called "belt" or "shells"
// - replaces itself with blank function or belt bodygroup handler
// shells bodygroup is handled using sound table callbacks
//-----------------------------------------------------------------------------

if CLIENT then
	local function blank() end
	
	function SWEP:updateBelt()
		local vm = self.CW_VM
		local id = vm:FindBodygroupByName("bELt")
		
		if id < 0 then
			self.updateBelt = blank
		else
			self._beltBGID = id
			self._beltBGMax = vm:GetBodygroupCount(id) - 1
			self.updateBelt = CustomizableWeaponry_KK.ins2.bulletBgs.think
		end
		
		id = vm:FindBodygroupByName("shELls")
		
		if id > -1 then
			self._shellsBGID = id
			self._shellsBGMax = vm:GetBodygroupCount(id) - 1
		end
	end
end

//-----------------------------------------------------------------------------
// updateOtherParts is called from SWEP:Think, clientside only
//-----------------------------------------------------------------------------

if CLIENT then	
	function SWEP:updateOtherParts()
		// whatever u want
	end
end

//-----------------------------------------------------------------------------
// updateStandardParts is called from post(attach|detach) callback, clientside
//-----------------------------------------------------------------------------

if CLIENT then
	function SWEP:updateStandardParts()
		// whatever u want
	end
end

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------

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

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------

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

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------

function SWEP:hasInstalledGL()
	return self._currentGrenadeLauncher != nil
end

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------

function SWEP:getForegripMode()
	if self.ActiveAttachments.kk_ins2_vertgrip then 
		return "foregrip_"
	elseif self.dt.BipodDeployed then 
		return "bipod_"
	elseif self:hasInstalledGL() then
		if self.dt.INS2GLActive then
			return "gl_on_"
		else
			return "gl_off_"
		end
	end
	
	return "base_"
end

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------

function SWEP:getPrimarySight()	
	return self._currentPrimarySight and self._currentPrimarySight.name
end

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------

function SWEP:getSecondarySight()
	return self._currentSecondarySight and self._currentSecondarySight.name
end

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------

function SWEP:getGLAttName()
	return (self._currentGrenadeLauncher and self._currentGrenadeLauncher.displayNameShort) or "No grenade launcher attached."
end
