
local SP = game.SinglePlayer()

function SWEP:PrimaryAttack()
	if not self:canFireWeapon(1) then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry_KK.ins2.canThrow(self) then
			CustomizableWeaponry_KK.ins2.throwGrenade(self)
			return
		-- else
		-- if CustomizableWeaponry_KK.ins2.canKnife(self) then
			-- CustomizableWeaponry_KK.ins2.meleeKnife(self)
			-- return
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
	
	local IFTP = IsFirstTimePredicted()
	
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
	
	mag = self:Clip1()
	
	if mag == 0 then
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
		util.Effect("cw_kk_ins2_muzzleflash", muzzleData) // NO
		
		if self.dt.Suppressed then
			self:EmitSound(self.FireSoundSuppressed, 105, 100)
		else
			self:EmitSound(self.FireSound, 105, 100)
		end
		
		if ((SP and SERVER) or (!SP and CLIENT)) then
			self:fireAnimFunc()
		end
		
		if self.Primary.Ammo == "RPG 40MM" then
			CustomizableWeaponry_KK.ins2.fireRPG(self, IFTP, true)
		else
			self:FireBullet(self.Damage, self.CurCone, self.ClumpSpread, self.Shots)
		end
		
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
	end
	
	if self:Clip1() == 0 then
		self:SetNextPrimaryFire(CT + 0.5)
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

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length

function SWEP:SecondaryAttack()
	if self.ShotgunReloadState != 0 then
		return
	end
	
	if self.ReloadDelay then
		return
	end
	
	if CurTime() < self.GlobalDelay then
		return false
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if self.InactiveWeaponStates[self.dt.State] or (self.dt.State == CW_AIMING and self.HoldToAim) then
		return
	end
	
	if self:isNearWall() then
		return
	end
	
	local IFTP = IsFirstTimePredicted()
	
	if self.Owner:KeyDown(IN_USE) then
		if self:hasInstalledGL() then
			if self.ToggleM203States[self.dt.State] then
				if self.dt.INS2GLActive then
					self.dt.INS2GLActive = false
					
					if (SERVER and SP) or (CLIENT and !SP and IFTP) then
						self:sendWeaponAnim("gl_turn_off",1.5,0)
					end
				else
					self.dt.INS2GLActive = true
					
					if (SERVER and SP) or (CLIENT and !SP and IFTP) then
						self:sendWeaponAnim("gl_turn_on",1.5,0)
					end
				end
				
				self:delayEverything(0.6)
				
				return
			end
		end
	end
	
	if not self.Owner:OnGround() or Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * self.RunStateVelocity then
		return
	end
	
	CT = CurTime()
	
	if self.dt.State ~= CW_AIMING then
		self.dt.State = CW_AIMING
		
		if self:filterPrediction() then
			self:EmitSound("CW_TAKEAIM")
		end
	else
		self.dt.State = CW_IDLE
		
		if self:filterPrediction() then
			self:EmitSound("CW_LOWERAIM")
		end
	end
	
	if IFTP then
		self.AimTime = UnPredictedCurTime() + 0.25
		
		if self.PreventQuickScoping then
			self.AddSpread = math.Clamp(self.AddSpread + 0.03, 0, self.MaxSpreadInc)
			self.SpreadWait = CT + 0.3
		end
	end
	
	if SP and SERVER then
		SendUserMessage("CW_AimTime", self.Owner)
	end
	
	self:SetNextSecondaryFire(CT + 0.1)
end
