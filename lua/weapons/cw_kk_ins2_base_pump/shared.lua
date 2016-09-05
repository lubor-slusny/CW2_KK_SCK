if not CustomizableWeaponry then return end

AddCSLuaFile()

SWEP.Base = "cw_kk_ins2_base_main"

local SP = game.SinglePlayer()

local IFTP, CT

SWEP.isShot = false
SWEP.pumpTime = 0.6

function SWEP:PrimaryAttack()
	if self.isShot then return end

	if not self:canFireWeapon(1) then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry_KK.ins2.quickGrenade.canThrow(self) then
			CustomizableWeaponry_KK.ins2.quickGrenade.throw(self)
			return
		end
	end
	
	if not self:canFireWeapon(2) then
		return
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if not self:canFireWeapon(3) then
		return
	end
	
	IFTP = IsFirstTimePredicted()
	
	if self.dt.INS2GLActive then
		if IFTP and ((SP and SERVER) or (!SP and CLIENT)) then
			self:fireAnimFunc()
		end
		
		if self.M203Chamber then
			self:fireM203(IFTP)
		else
			self:SetNextPrimaryFire(CurTime() + 0.5)
		end
		
		return
	end
	
	if self:Clip1() == 0 then
		if IFTP and ((SP and SERVER) or (!SP and CLIENT)) then
			self:fireAnimFunc()
		end
		
		self:SetNextPrimaryFire(CurTime() + 0.3)
		
		return
	end
	
	if self.BurstAmount and self.BurstAmount > 0 then
		if self.dt.Shots >= self.BurstAmount then
			return
		end
		
		self.dt.Shots = self.dt.Shots + 1
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	CT = CurTime()
	
	if IFTP then
		local muzzleData = EffectData()
		muzzleData:SetEntity(self)
		util.Effect("cw_kk_ins2_muzzleflash", muzzleData)
		
		if self.dt.Suppressed then
			self:EmitSound(self.FireSoundSuppressed, 105, 100)
		else
			self:EmitSound(self.FireSound, 105, 100)
		end
		
		if ((SP and SERVER) or (!SP and CLIENT)) then
			self:fireAnimFunc()
		end
		
		self:FireBullet(self.Damage, self.CurCone, self.ClumpSpread, self.Shots)
		self:makeFireEffects()
		self:MakeRecoil()
		self:addFireSpread(CT)
		
		if CLIENT then
			self:simulateRecoil()
		end
		
		if SP and SERVER then
			SendUserMessage("CW_Recoil", self.Owner)
		end
		
		-- apply a global delay after shooting, if there is one
		if self.GlobalDelayOnShoot then
			self.GlobalDelay = CT + self.GlobalDelayOnShoot
		end
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "postFire")
	
	local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
	
	if not suppressAmmoUsage then
		self:TakePrimaryAmmo(self.AmmoPerShot)
		self.isShot = true
	end
	
	if self:Clip1() == 0 then
		self:SetNextPrimaryFire(CT + math.Clamp(self.FireDelay, 0.5, self.FireDelay))
	else
		self:SetNextPrimaryFire(CT + self.FireDelay)
	end
	
	-- either force the weapon back to hip after firing, or don't
	if self.ForceBackToHipAfterAimedShot then
		self.dt.State = CW_IDLE
		self:SetNextSecondaryFire(CT + self.ForcedHipWaitTime)
	else
		self:SetNextSecondaryFire(CT + self.FireDelay)
	end
	
	self.ReloadWait = CT + (self.WaitForReloadAfterFiring and self.WaitForReloadAfterFiring or self.FireDelay)
	
	CustomizableWeaponry.callbacks.processCategory(self, "postConsumeAmmo")
end

local shouldDrawCrosshair, cycle, canDoStuff, wasSprint, isSprint, wasSafe, isSafe

function SWEP:IndividualThink()
	self:DrawShadow(false)
	
	if self:Clip1() > 0 and self:GetNextPrimaryFire() < CurTime() and self.isShot and not self.Owner:KeyDown(IN_ATTACK) then
		local prefix = self:getForegripMode()
		local suffix = ""
		
		if self:isAiming() then
			suffix = "_aim"
		end
		
		self:sendWeaponAnim(prefix .. "bolt" .. suffix,1,0)
		
		self.isShot = false
		
		self:SetNextPrimaryFire(CurTime() + self.pumpTime)
		self.GlobalDelay = CurTime() + self.pumpTime
	end
	
	if self:Clip1() < 1 then
		self.isShot = false
	end
	
	if CLIENT then
		-- self.NoFreeAim = self:isAiming()
		shouldDrawCrosshair = self.Owner:ShouldDrawLocalPlayer()
		self.CrosshairEnabled = shouldDrawCrosshair
		self.FadeCrosshairOnAim = !shouldDrawCrosshair
		
		if !SP and not IsFirstTimePredicted() then return end
		
		if self.Slot != 2 and self.Slot != 3 then
			if self.Sequence:find("sprint") then
				self.ViewModelMovementScale = self.ViewModelMovementScale_sprint
			else
				self.ViewModelMovementScale = self.ViewModelMovementScale_base
			end
		end
		
		// 2b removed
		// I guess
		self:updateReloadTimes()
		
		// and now, cosmetix
		
		self:updateHands()
		self:updateBelt()
		self:updateOtherParts()
		
		self:playSwitchBipod()
		
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
end
