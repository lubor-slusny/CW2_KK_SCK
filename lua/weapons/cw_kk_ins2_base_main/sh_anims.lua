
local SP = game.SinglePlayer()
local isBipod, wasBipod, cycle, suffix, anim, prefix, rate, clip

if CLIENT then
	function SWEP:playSwitchBipod()
		if self.KKINS2Melee or self.KKINS2Nade then 
			return 
		end
		
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
		if not self._KK_INS2_PickedUp then 
			return 
		end
		
		cycle = self.CW_VM:GetCycle()
		
		canDoStuff = 
			(self.dt.State != CW_CUSTOMIZE) and 					// no swapping in CW Menu
			(self.dt.State != CW_ACTION) and 						// no swapping during knife attack/quick grenade throw
			self:isReticleActive() and 								// no swapping during... eh?
			not (self.KKINS2Nade and self.dt.PinPulled) and			// no swapping after pin-pull
			not self:isReloading() and								// no swapping during reload
			not (self.GlobalDelay > CurTime()) and					// ??
			not (self.Sequence:find("ready") and cycle < 1) and		// double check if we re not unboxing the weapon atm
			not (self.Sequence:find("reload") and cycle < 1) and	// double check if reload isnt going on atm
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
		if self.KKINS2Melee then return end
		
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
		cycle = 0
		
		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	
		if self.KKINS2Nade and self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then 
			-- self:playAnim("base_draw", -1, 0)
			anim = "holster"
			rate = 1
			cycle = 1
		end
		
		self:playAnim(prefix .. anim .. suffix, rate, cycle)
	end

	function SWEP:safetyAnimFunc()
		if self.KKINS2Nade then 
			return 
		end
		
		anim = "safe"
		prefix = self:getForegripMode()
		suffix = ""
		
		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
		
		if self:isAiming() /*or self.Slot == 1*/ then
			suffix = suffix .. "_aim"
		end
		
		self:playAnim(prefix .. anim .. suffix, 1, 0)
		-- self.reticleInactivity = UnPredictedCurTime() + 0.5
	end

	function SWEP:firemodeAnimFunc()
		if self.KKINS2Nade then 
			return 
		end
		
		anim = "firemode"
		prefix = self:getForegripMode()
		suffix = ""
		
		if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
		
		if self:isAiming() then
			suffix = suffix .. "_aim"
		end
		
		self:playAnim(prefix .. anim .. suffix, 1, 0)
		
		if self.Animations[prefix .. anim .. suffix] then
			self.reticleInactivity = UnPredictedCurTime() + (self.CW_VM:SequenceDuration())
		end
	end
		
	function SWEP:idleAnimFunc()
		prefix = self:getForegripMode()
		suffix = ""
		anim = "idle"
		rate = -1
		-- cycle = 0.45
		cycle = 0
		
		if self.KKINS2Melee then
			rate = 1
		elseif self.KKINS2Nade then
			rate = 1
			if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
				anim = "holster"
				cycle = 1
			end
		else
			-- anim = "idle" // only idle anims are for base_ prefix, it used to use draw anim for others anyway
			anim = "holster"
		end
		
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
		
		self:playAnim(prefix .. anim .. suffix, rate, cycle)
	end
end

function SWEP:pickupAnimFunc(mode)
	mode = mode or self:getForegripMode()
	anim = "pickup"
	
	if self.KKINS2Melee or self.KKINS2Nade then
		anim = "draw"
	end
	
	if SERVER then
		self:sendWeaponAnim(mode .. anim, self.DrawSpeed, 0)
	end
	
	if CLIENT then
		if self.Sequence != self.Animations[mode .. anim] then
			self:playAnim(mode .. anim, self.DrawSpeed, 0)
		end
	end
end

function SWEP:drawAnimFunc(ctrl)
	if not self._KK_INS2_PickedUp then
		return
	end
	
	prefix = self:getForegripMode()
	suffix = ""
	anim = "draw"
	rate = self.DrawSpeed
	cycle = 0
	
	clip = self:Clip1()
	
	-- if not ctrl then return end
	
	if self.dt.INS2GLActive then
		if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	else
		if clip == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty" .. self._KK_INS2_customEmptySuffix
		end
	end
	
	if self.KKINS2Nade and self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then 
		anim = "holster"
		cycle = 1
	end
	
	self:sendWeaponAnim(prefix .. anim .. suffix, rate, cycle)
end

function SWEP:meleeAnimFunc()
	if self.KKINS2Nade then 
		return 
	end
	
	clip = self:Clip1()
	cyc = 0
	rate = 1
	prefix = self:getForegripMode()
	suffix = ""
	
	if self.KK_INS2_EmptyIdle and clip == 0 then
		suffix = "_empty" .. self._KK_INS2_customEmptySuffix
	end
	
	self:sendWeaponAnim(prefix .. "melee" .. suffix, rate, cyc)
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
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix, rate, cyc)
	
	if self.KK_INS2_BoltAction and not self.dt.INS2GLActive and clip > 0 then
		CustomizableWeaponry.actionSequence.new(self, self.KK_INS2_BoltAction, nil, function()
			self:sendWeaponAnim(prefix .. "bolt" .. suffix, 1, 0)
		end)
	end
end //*/

function SWEP:holsterAnimFunc(ctrl)
	-- if not ctrl then return end
	
	prefix = self:getForegripMode()
	suffix = ""
	cycle = 0
	
	if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
		suffix = "_empty" .. self._KK_INS2_customEmptySuffix
	end
	
	if self.KKINS2Nade and self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then 
		cycle = 1
	end
	
	self:sendWeaponAnim(prefix .. "holster" .. suffix, self.HolsterSpeed, cycle)
end

// angry stuff

if SERVER then
	util.AddNetworkString("kkins2_animate")
end

function SWEP:sendWeaponAnimINS2(anim, rate, cycle, clok)
	if not anim then
		return
	end
	
	rate = rate or 1
	cycle = cycle or 0
	
	print(anim, rate, cycle, clok)
	
	if SERVER then
		net.Start("kkins2_animate")
		net.WriteEntity(self)
		net.WriteString(anim)
		net.WriteFloat(rate)
		net.WriteFloat(cycle)
		net.Send(self.Owner)
	end
	
	if self.animCallbacks and self.animCallbacks[anim] then
		self.animCallbacks[anim](self)
	end
	
	local foundAnim = self.Animations[anim]
	
	if not foundAnim then
		return
	end
	
	if type(foundAnim) == "table" then
		foundAnim = table.Random(foundAnim)
	end
	
	if self.Sounds[foundAnim] then
		self:setCurSoundTable(self.Sounds[foundAnim], rate, cycle, foundAnim)
	else
		self:removeCurSoundTable()
	end
	
	if CLIENT and clok then
		local ent = self.CW_VM
		
		ent:ResetSequence(foundAnim)
		
		if cycle > 0 then
			ent:SetCycle(cycle)
		else
			ent:SetCycle(0)
		end
		
		ent:SetPlaybackRate(rate)
	end
end

if CLIENT then
	local LocalPlayer = LocalPlayer
	
	local function kkins2_animate()
		local wep = net.ReadEntity()
		local anim = net.ReadString()
		local rate = net.ReadFloat()
		local cycle = net.ReadFloat()
		
		if wep.sendWeaponAnimINS2 then
			wep:sendWeaponAnimINS2(anim, rate, cycle, true)
		end
	end
	
	net.Receive("kkins2_animate", kkins2_animate)
end

-- // meh stuff

-- if SP then return end

-- local db = {}
-- local kek

-- if CLIENT then
	-- fnuk = function(ply, old, new)
		-- db[old] = db[old] or {}
		-- db[new] = db[new] or {}
		
		-- if IsFirstTimePredicted() then
			-- if not db[old].holster then
				-- print("holstering", old)
				-- kek = old.holsterAnimFunc and old:holsterAnimFunc(true)
				-- db[old].holster = true
				-- db[old].draw = false
			-- end
			
			-- if not db[new].draw then
				-- print("drawing", new)
				-- kek = new.drawAnimFunc and new:drawAnimFunc(true)
				-- db[new].holster = false
				-- db[new].draw = true
			-- end
		-- end
	-- end
	
	-- hook.Add("PlayerSwitchWeapon", "CW_KK_INS2_ANIMS", fnuk)
-- end

