
local SP = game.SinglePlayer()
local isBipod, wasBipod, cycle, activity, suffix, anim, prefix, rate, clip

if CLIENT then
	function SWEP:playSwitchBipod()
		if not self.BipodInstalled then 
			return
		end
		
		wasBipod = self._KK_INS2_wasBipod
		isBipod = self.dt.BipodDeployed
		cycle = self.CW_VM:GetCycle()
		activity = self.Sequence

		if self:Clip1() == 0 and self.KK_INS2_emptyIdle then
			suffix = "_empty"
		else
			suffix = ""
		end
			
		if isBipod != wasBipod and wasBipod != nil then
			if activity:find("reload") and cycle < 1 then
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
		if self._KK_INS2_postReloadBipodSwitch and activity:find("reload") and cycle > 0.9 then
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
	
	function SWEP:sprintAnimFunc()
		if self.Slot == 2 or self.Slot == 3 then
			anim = "safe"
		else
			anim = "sprint"
		end
		
		prefix = self:getForegripMode()
		suffix = ""
			
		if self:Clip1() == 0 and self.KK_INS2_emptyIdle then
			suffix = "_empty"
		end
	
		if self.Slot == 2 or self.Slot == 3 then
			self:playAnim(prefix .. anim .. suffix,1,0)
		else
			self:playAnim(prefix .. anim .. suffix,self.SprintAnimSpeed,0)
		end
	end

	function SWEP:safetyAnimFunc()
		anim = "safe"
		prefix = self:getForegripMode()
		suffix = ""
		
		if self:Clip1() == 0 and self.KK_INS2_emptyIdle then
			suffix = "_empty"
		end
		
		if self:isAiming() or self.Slot == 1 then
			suffix = suffix .. "_aim"
		end
		
		self:playAnim(prefix .. anim .. suffix,1,0)
		-- self.reticleInactivity = UnPredictedCurTime() + 0.5
	end

	function SWEP:firemodeAnimFunc()
		anim = "firemode"
		prefix = self:getForegripMode()
		suffix = ""
		
		if self:Clip1() == 0 and self.KK_INS2_emptyIdle then
			suffix = "_empty"
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
		-- anim = "idle" // only idle anims are for base_ prefix, it used to use draw anim for others anyway
		anim = "holster"
		suffix = ""
		rate = -1
		-- cycle = 0.45
		cycle = 0
		
		if self:Clip1() == 0 and self.KK_INS2_emptyIdle then
			suffix = "_empty"
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
	prefix = self:getForegripMode()
	
	if not self._KK_INS2_PickedUp then
		if !(clip == 0 and self.KK_INS2_emptyIdle) and self.Owner then // wtf owner?
			self:pickupAnimFunc(prefix)
			return		
		end
	end
	
	clip = self:Clip1()
	suffix = ""
	
	if clip == 0 and self.KK_INS2_emptyIdle then
		suffix = "_empty"
	end
	
	self:sendWeaponAnim(prefix .. "draw" .. suffix,self.DrawSpeed,0)
end

function SWEP:meleeAnimFunc()
	clip = self:Clip1()
	cyc = 0
	rate = 1
	prefix = self:getForegripMode()
	suffix = ""
	
	if self.KK_INS2_emptyIdle and clip == 0 then
		suffix = "_empty"
	end
	
	self:sendWeaponAnim(prefix .. "melee" .. suffix,rate,cyc)
end //*/
	
function SWEP:fireAnimFunc()
	clip = self:Clip1()
	cyc = 0
	rate = 1
	prefix = self:getForegripMode()
	suffix = ""
	
	if clip == 1 and self.KK_INS2_emptyIdle then
		suffix = "_last"
	elseif (clip == 0 and not self.dt.INS2GLActive) or (self.dt.INS2GLActive and not self.M203Chamber) then
		suffix = "_empty"
	end
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix,rate,cyc)
end //*/

-- function SWEP:fireAnimFunc() end

function SWEP:_holsterAnimFunc()
	prefix = self:getForegripMode()
	suffix = ""
	
	if self:Clip1() == 0 and self.KK_INS2_emptyIdle then
		suffix = "_empty"
	end
	
	self:sendWeaponAnim(prefix .. "holster" .. suffix,self.HolsterSpeed or 1,0)
end //*/

if SP then
	function SWEP:holsterAnimFunc()
		self:_holsterAnimFunc()
	end
end
