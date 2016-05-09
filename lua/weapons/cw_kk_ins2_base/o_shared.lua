
local SP = game.SinglePlayer()

// Custom GLs

function SWEP:SetupDataTables()
	self:DTVar("Int", 0, "State")
	self:DTVar("Int", 1, "Shots")
	self:DTVar("Float", 0, "HolsterDelay")
	self:DTVar("Bool", 0, "Suppressed")
	self:DTVar("Bool", 1, "Safe")
	self:DTVar("Bool", 2, "BipodDeployed")
	self:DTVar("Bool", 3, "INS2GLActive")
	self:DTVar("Angle", 0, "ViewOffset")
end

// LUA VM Recoil only for RT scopes

function SWEP:simulateRecoil()
	if self.dt.State ~= CW_AIMING and not self.freeAimOn then
		self.FOVHoldTime = UnPredictedCurTime() + self.FireDelay * 2
		
		if self.HipFireFOVIncrease then
			self.FOVTarget = math.Clamp(self.FOVTarget + 8 / (self.Primary.ClipSize_Orig * 0.75) * self.FOVPerShot, 0, 7)
		end
	end
	
	if self.freeAimOn and not self.dt.BipodDeployed then -- we only want to add the 'roll' view shake when we're not using a bipod in free-aim mode
		self.lastViewRoll = math.Clamp(self.lastViewRoll + self.Recoil * 0.5, 0, 15)
		self.lastViewRollTime = UnPredictedCurTime() + FrameTime() * 3
	end
	
	self.lastShotTime = CurTime() + math.Clamp(self.FireDelay * 3, 0, 0.3) -- save the last time we shot
	
	if self.BoltBone then
		self:offsetBoltBone()
	end
	
	if self.LuaViewmodelRecoil then
		if (self.dt.State ~= CW_AIMING and not self.FullAimViewmodelRecoil) or self.FullAimViewmodelRecoil then
			-- increase intensity of the viewmodel recoil with each shot
			self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 1, self.Recoil * 0.15)
			self.LuaVMRecoilLowerSpeed = 0
			
			if not self.dt.BipodDeployed then
				self:makeVMRecoil()
			end
		end
	end
	
	if self.ReticleInactivityPostFire then
		self.reticleInactivity = UnPredictedCurTime() + self.ReticleInactivityPostFire
	end
end

// firemode switch animations and reticle inactivity

function SWEP:CycleFiremodes()
	if self.dt.INS2GLActive then return end
	
	local lastFM = self.FireMode
	local t = self.FireModes
	
	if not t.last then
		t.last = 2
	else
		if not t[t.last + 1] then
			t.last = 1
		else
			t.last = t.last + 1
		end
	end
	
	if self.dt.State == CW_AIMING or self:isBipodDeployed() then
		if self.FireModes[t.last] == "safe" then
			t.last = 1
		end
	end
	
	local delay = 1
	
	if (#self.FireModes < 3) then // why # instead of table.Count?
		delay = 0.25
	elseif lastFM == "safe" then
		delay = 0.2
	end
	
	if self.FireMode != self.FireModes[t.last] and self.FireModes[t.last] then
		local CT = CurTime()
		self:SelectFiremode(self.FireModes[t.last])
		self:SetNextPrimaryFire(CT + delay)
		self:SetNextSecondaryFire(CT + delay)
		self.ReloadWait = CT + delay
	end
end

function SWEP:SelectFiremode(n)
	if CLIENT then
		return
	end
	
	local t = CustomizableWeaponry.firemodes.registeredByID[n]
	self.Primary.Automatic = t.auto
	self.FireMode = n
	self.BurstAmount = t.burstamt
	
	if self.FireMode == "safe" then
		self.dt.Safe = true
	else
		self.dt.Safe = false
	end
	
	umsg.Start("CW_KK_INS2_FIREMODE")
		umsg.Entity(self.Owner)
		umsg.String(n)
	umsg.End()
end

if CLIENT then
	local ply, mode, wep, lastFM
	
	local function CW_ReceiveFireMode(um)
		ply = um:ReadEntity()
		mode = um:ReadString()
		
		if IsValid(ply) then
			wep = ply:GetActiveWeapon()
			lastFM = wep.FireMode
			wep.FireMode = mode
			
			if IsValid(ply) and IsValid(wep) and wep.CW20Weapon then
				if CustomizableWeaponry.firemodes.registeredByID[mode] then
					t = CustomizableWeaponry.firemodes.registeredByID[mode]
					
					wep.Primary.Automatic = t.auto
					wep.BurstAmount = t.burstamt
					wep.FireModeDisplay = t.display
					wep.BulletDisplay = t.buldis
					wep.CheckTime = CurTime() + 2
					
					if lastFM != "safe" then
						wep:firemodeAnimFunc()
					end
				end
			end
		end
	end

	usermessage.Hook("CW_KK_INS2_FIREMODE", CW_ReceiveFireMode)
end

// custom GL reload

local CT, mag

function SWEP:Reload()
	CT = CurTime()
	
	if self.ReloadDelay or CT < self.ReloadWait or self.dt.State == CW_ACTION or self.ShotgunReloadState != 0 then
		return
	end
	
	if CT < self.GlobalDelay then
		return
	end
	
	if self.dt.INS2GLActive then
		if not self.M203Chamber and self.Owner:GetAmmoCount("40MM") > 0 then
			self.dt.State = CW_IDLE
			
			self:beginReload()
		end
		
		return
	end
	
	if self.Owner:KeyDown(IN_USE) and self.dt.State != CW_RUNNING then
		self:CycleFiremodes()
		return
	end
	
	mag = self:Clip1()
	
	local cantReload, overrideMagCheck, overrideAmmoCheck = CustomizableWeaponry.callbacks.processCategory(self, "canReload", mag == 0)
	
	if cantReload then
		return
	end
	
	if not overrideMagCheck then
		if (self.Chamberable and mag >= self.Primary.ClipSize_Orig + 1) then
			return
		end
	end
	
	if not overrideAmmoCheck then
		if self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 then
			return
		end
	end
	
	if not self.Chamberable and mag >= self.Primary.ClipSize then
		return
	end
		
	self.dt.State = CW_IDLE
	
	self:beginReload()
end

// updating reload times

local CT, mag, ammo

function SWEP:beginReload()
	self:updateReloadTimes()
	
	CT = CurTime()
	mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

	self.lastMag = mag
	
	if self.ShotgunReload then
		self.WasEmpty = mag == 0
		
		local anim = self:getForegripMode() .. "reload_start"
		local time = CT + self.ReloadStartTime / self.ReloadSpeed
		
		if self.WasEmpty then
			anim = anim .. "_empty"
			time = CT + self.ReloadStartTimeEmpty / self.ReloadSpeed
			
			if SERVER and self.ReloadFirstShell then
				CustomizableWeaponry.actionSequence.new(self, self.ReloadFirstShell, nil, function()
					if self.ShotgunReloadState == 0 then return end	// melee attack interuption
					
					self:SetClip1(mag + 1)
					self.Owner:SetAmmo(ammo - 1, self.Primary.Ammo)
					
					if ammo - 1 <= 0 then
						self.ShotgunReloadState = 2
					end
				end)
			end
		end
		
		self:sendWeaponAnim(anim, self.ReloadSpeed)
		
		self.ReloadDelay = time
		self:SetNextPrimaryFire(time)
		self:SetNextSecondaryFire(time)
		self.GlobalDelay = time
		self.ShotgunReloadState = 1
	else	
		local reloadTime = nil
		local reloadHalt = nil
		
		// maybe make some custom getReloadTime function for all this?
		if self.dt.INS2GLActive then
			reloadTime = self.gl_on_ReloadTime or 2
			reloadHalt = self.gl_on_ReloadHalt or 2.6
		elseif mag == 0 then
			if self.Chamberable then
				self.Primary.ClipSize = self.Primary.ClipSize_Orig
			end
			
			reloadTime = self.ReloadTime_Empty
			reloadHalt = self.ReloadHalt_Empty
		else
			reloadTime = self.ReloadTime
			reloadHalt = self.ReloadHalt
			
			if self.Chamberable then
				self.Primary.ClipSize = self.Primary.ClipSize_Orig + 1
			end
		end
		// ===========================================================
		
		reloadTime = reloadTime / self.ReloadSpeed
		reloadHalt = reloadHalt / self.ReloadSpeed
		
		self.ReloadDelay = CT + reloadTime
		self:SetNextPrimaryFire(CT + reloadHalt)
		self:SetNextSecondaryFire(CT + reloadHalt)
		self.GlobalDelay = CT + reloadHalt
		
		if self.reloadAnimFunc then
			self:reloadAnimFunc(mag)
		else
			if self.Animations.reload_empty and mag == 0 then
				self:sendWeaponAnim("reload_empty", self.ReloadSpeed)
			else
				self:sendWeaponAnim("reload", self.ReloadSpeed)
			end
		end
	end
	
	if SERVER then
		SendUserMessage("CW_KK_INS2_RELOADINACTIVITY", self.Owner)
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "beginReload", mag == 0)
	
	self.Owner:SetAnimation(PLAYER_RELOAD)
end

// M203 2 - for melee attacks that interupt reloads

local mag, ammo

function SWEP:finishReload()
	if self.dt.INS2GLActive then
		if SERVER then
			self.Owner:RemoveAmmo(1, "40MM")
			SendUserMessage("CW_KK_INS2_READYM203", self.Owner)
		end
		
		self.M203Chamber = true
		self.ReloadDelay = nil
		
		return
	end

	mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

	local suppressReloadLogic = CustomizableWeaponry.callbacks.processCategory(self, "defaultReloadLogic", mag == 0)
	
	if not suppressReloadLogic then
		if self.ReloadAmount then
			if SERVER then
				self:SetClip1(math.Clamp(mag + self.ReloadAmount, 0, self.Primary.ClipSize))
				self.Owner:RemoveAmmo(self.ReloadAmount, self.Primary.Ammo)
			end
		else
			if mag > 0 then
				if ammo >= self.Primary.ClipSize - mag then
					if SERVER then
						self:SetClip1(math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(self.Primary.ClipSize - mag, self.Primary.Ammo)
					end
				else
					if SERVER then
						self:SetClip1(math.Clamp(mag + ammo, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
					end
				end
			else
				if ammo >= self.Primary.ClipSize then
					if SERVER then
						self:SetClip1(math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(self.Primary.ClipSize, self.Primary.Ammo)
					end
				else
					if SERVER then
						self:SetClip1(math.Clamp(ammo, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
					end
				end
			end
		end
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "finishReload")
	
	self.ReloadDelay = nil
end

// custom shotgun reload finishing/interupting

local CT, keyDown, mag, ammo

function SWEP:finishReloadShotgun()
	CT = CurTime()
	
	if self.ShotgunReloadState == 1 then
		keyDown = self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)
		
		if self.lastMag < self:Clip1() and keyDown then
			self.ShotgunReloadState = 2
		end
		
		if CT > self.ReloadDelay then
			self:sendWeaponAnim(self:getForegripMode() .. "insert", self.ReloadSpeed)
			
			if SERVER and not SP then
				self.Owner:SetAnimation(PLAYER_RELOAD)
			end
			
			mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)
			
			if SERVER then
				self:SetClip1(mag + 1)
				self.Owner:SetAmmo(ammo - 1, self.Primary.Ammo)
			end
			
			self.ReloadDelay = CT + self.InsertShellTime / self.ReloadSpeed
			
			local clipSize = self.Primary.ClipSize
			
			if self.Chamberable and (self.ReloadFirstShell or !self.WasEmpty) then
				clipSize = clipSize + 1
			end
			
			if (mag + 1) >= (clipSize) or ammo - 1 <= 0 then
				self.ShotgunReloadState = 2
			end
		end
	elseif self.ShotgunReloadState == 2 then
		if CT > self.ReloadDelay then			
			local anim = self:getForegripMode() .. "reload_end"
			local time = CT + self.ReloadFinishWait / self.ReloadSpeed
			
			if self.WasEmpty then
				anim = anim .. "_empty"
				time = CT + self.ReloadFinishWaitEmpty / self.ReloadSpeed
			end
			
			self:sendWeaponAnim(anim, self.ReloadSpeed)
			self.ShotgunReloadState = 0
			
			self:SetNextPrimaryFire(time)
			self:SetNextSecondaryFire(time)
			self.ReloadWait = time
			self.ReloadDelay = nil
		end
	end
end

// weapon length

local mins, maxs = Vector(-8, -8, -1), Vector(8, 8, 1)

local td = {}
td.mins = mins
td.maxs = maxs

function SWEP:isNearWall()
	td.start = self.Owner:GetShootPos()
	td.endpos = td.start + self.Owner:EyeAngles():Forward() * (self.WeaponLength + 10)
	td.filter = self.Owner
	
	local tr = util.TraceLine(td)
	
	if tr.Hit or (IsValid(tr.Entity) and not tr.Entity:IsPlayer()) then
		return true
	end
	
	return false
end
