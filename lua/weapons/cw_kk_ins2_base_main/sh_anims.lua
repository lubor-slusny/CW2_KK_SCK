
local SP = game.SinglePlayer()
local isBipod, wasBipod, cycle, suffix, anim, prefix, rate, clip

if CLIENT then
	function SWEP:playSwitchBipod()
		if not self.BipodInstalled then 
			return
		end
		
		wasBipod = self._KK_INS2_wasBipod
		isBipod = self.dt.BipodDeployed
		cycle = self.CW_VM:GetCycle()

		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		else
			suffix = ""
		end
			
		if isBipod != wasBipod and wasBipod != nil then
			if self.Sequence:find("reload") and cycle < 1 then
				self._KK_INS2_postReloadBipodSwitch = true
			else
				if isBipod then
					self:playAnim("bipod_in" .. suffix) 
				else 
					self:playAnim("bipod_out" .. suffix) 
				end
			end
			self.reticleInactivity = UnPredictedCurTime() + (self.CW_VM:SequenceDuration())
		end
		if self._KK_INS2_postReloadBipodSwitch and self.Sequence:find("reload") and cycle > 0.9 then
			if isBipod then
				self:playAnim("bipod_in" .. suffix) 
			else 
				self:playAnim("bipod_out" .. suffix) 
			end
			self.reticleInactivity = UnPredictedCurTime() + (self.CW_VM:SequenceDuration())
			self._KK_INS2_postReloadBipodSwitch = false
		end
		
		self._KK_INS2_wasBipod = isBipod
	end
	
	local canDoStuff, wasSprint, isSprint, wasSafe, isSafe
	
	function SWEP:playHolsterTransitions()
		cycle = self.CW_VM:GetCycle()
		
		canDoStuff = 
			(self.dt.State != CW_CUSTOMIZE) and 
			(self.dt.State != CW_ACTION) and 
			self:isReticleActive() and 
			not (self.Base == "cw_kk_ins2_nade_base" and self.dt.PinPulled) and
			not self:isReloading() and
			not (self.GlobalDelay > CurTime()) and
			not (self.Sequence:find("ready") and cycle < 1) and
			not (self.Sequence:find("reload") and cycle < 1) and
			-- self._KK_INS2_PickedUp and
			-- not self.ShotgunReload and
			true
		
		wasSprint = self._KK_INS2_wasSprint
		isSprint = self:isRunning()
		
		isSprint = isSprint and canDoStuff
		
		if isSprint != wasSprint and wasSprint != nil then
			if isSprint then
				self:sprintAnimFunc()
			elseif canDoStuff then
				self:idleAnimFunc()
			end
		end
		
		self._KK_INS2_wasSprint = isSprint
		
		if isSprint then return end
		if self.Base == "cw_kk_ins2_mel_base" then return end
		
		wasSafe = self._KK_INS2_wasSafe
		isSafe = self.dt.Safe or self:isNearWall()
		
		isSafe = isSafe and canDoStuff
		
		if canDoStuff then
			if isSafe then
				self:safetyAnimFunc()
			elseif isSafe != wasSafe then
				self:idleAnimFunc()
			end
		elseif wasSafe then 
			if (self.dt.State == CW_CUSTOMIZE) then
				self:idleAnimFunc()
			end
		end
		
		self._KK_INS2_wasSafe = isSafe
	end
	
	function SWEP:sprintAnimFunc()
		if self.Slot == 2 or self.Slot == 3 then
			anim = "safe"
			rate = 1
		else
			anim = "sprint"
			rate = self.SprintAnimSpeed
		end
		
		prefix = self:getForegripMode()
		suffix = ""
			
		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	
		self:playAnim(prefix .. anim .. suffix,rate,0)
	end

	function SWEP:safetyAnimFunc()
		anim = "safe"
		prefix = self:getForegripMode()
		suffix = ""
		
		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
		
		if self:isAiming() /*or self.Slot == 1*/ then
			suffix = suffix .. "_aim"
		end
		
		self:playAnim(prefix .. anim .. suffix,1,0)
		-- self.reticleInactivity = UnPredictedCurTime() + 0.5
	end

	function SWEP:firemodeAnimFunc()
		anim = "firemode"
		prefix = self:getForegripMode()
		suffix = ""
		
		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
		
		if self:isAiming() then
			suffix = suffix .. "_aim"
		end
		
		self:playAnim(prefix .. anim .. suffix,1,0)
		
		if self.Animations[prefix .. anim .. suffix] then
			self.reticleInactivity = UnPredictedCurTime() + (self.CW_VM:SequenceDuration())
		end
	end
		
	function SWEP:idleAnimFunc()
		prefix = self:getForegripMode()
		
		if self.KKINS2Melee or self.KKINS2Nade then
			anim = "idle"
		else
			-- anim = "idle" // only idle anims are for base_ prefix, it used to use draw anim for others anyway
			anim = "holster"
		end
		
		suffix = ""
		rate = -1
		-- cycle = 0.45
		cycle = 0
		
		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
		
		-- if self.dt.State == CW_CUSTOMIZE then
			-- cycle = 1
		-- end
		
		-- if self:isAiming() then
			-- rate = 2
			-- cycle = 0.5
		-- end
		
		self:playAnim(prefix .. anim .. suffix,rate,cycle)
	end
end

function SWEP:pickupAnimFunc(mode)
	self:sendWeaponAnim((mode or self:getForegripMode()) .. "pickup")
end

function SWEP:drawAnimFunc()
	-- print(self:GetClass() .. ":drawAnimFunc()", "@", CurTime())
	
	prefix = self:getForegripMode()
	
	if not self._KK_INS2_PickedUp then
		if !(clip == 0 and self.KK_INS2_EmptyIdle) then
			self:pickupAnimFunc(prefix)
			return		
		end
	end
	
	clip = self:Clip1()
	suffix = ""
	rate = self.DrawSpeed
	
	if self.dt.INS2GLActive then
		if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	else
		if clip == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	end
	
	self:sendWeaponAnim(prefix .. "draw" .. suffix,rate,0)
end

function SWEP:meleeAnimFunc()
	clip = self:Clip1()
	cyc = 0
	rate = 1
	prefix = self:getForegripMode()
	suffix = ""
	
	if self.KK_INS2_EmptyIdle and clip == 0 then
		suffix = "_empty" .. self._KK_INS2_customEmptySuffix
	end
	
	self:sendWeaponAnim(prefix .. "melee" .. suffix,rate,cyc)
end //*/
	
function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cyc = 0
	rate = 1
	prefix = self:getForegripMode()
	suffix = ""
	
	if clip == 1 and self.KK_INS2_EmptyIdle then
		suffix = "_last" .. self._KK_INS2_customEmptySuffix
	elseif (clip == 0 and not self.dt.INS2GLActive) or (self.dt.INS2GLActive and not self.M203Chamber) then
		suffix = "_empty" .. self._KK_INS2_customEmptySuffix
	end
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix,rate,cyc)
	
	if self.KK_INS2_BoltAction and not self.dt.INS2GLActive and clip > 0 then
		CustomizableWeaponry.actionSequence.new(self, self.KK_INS2_BoltAction, nil, function()
			self:sendWeaponAnim(prefix .. "bolt" .. suffix,1,0)
		end)
	end
end //*/

-- function SWEP:fireAnimFunc() end

function SWEP:_holsterAnimFunc()
	prefix = self:getForegripMode()
	suffix = ""
	
	if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
		suffix = "_empty" .. self._KK_INS2_customEmptySuffix
	end
	
	self:sendWeaponAnim(prefix .. "holster" .. suffix,self.HolsterSpeed or 1,0)
end //*/

-- if SP then
	function SWEP:holsterAnimFunc()
		self:_holsterAnimFunc()
	end
-- end
