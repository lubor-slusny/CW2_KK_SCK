
local SP = game.SinglePlayer()

function SWEP:SetupDataTables()
	self:DTVar("Int", 0, "State")
	self:DTVar("Int", 1, "Shots")
	self:DTVar("Float", 0, "HolsterDelay")
	self:DTVar("Bool", 0, "Suppressed")
	self:DTVar("Bool", 1, "Safe")
	self:DTVar("Bool", 2, "BipodDeployed")
	self:DTVar("Bool", 3, "INS2GLActive") // coz I dont want to copy-pasta whole cw_menu + initfunc 
	self:DTVar("Angle", 0, "ViewOffset")
end

function SWEP:simulateRecoil()
	if self:hasInstalledRTScope() and (self:isAiming() or self.ShotgunReload) then
		weapons.GetStored("cw_base").simulateRecoil(self)
	end
	
	if self.ReticleInactivityPostFire then
		self.reticleInactivity = UnPredictedCurTime() + self.ReticleInactivityPostFire
	end
end

local delay, lastFM

function SWEP:CycleFiremodes()
	if self.dt.INS2GLActive then return end
	
	lastFM = self.FireMode
	
	t = self.FireModes
	
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
	
	if (#self.FireModes < 3) then // why # instead of table.Count?
		delay = 0.25
	elseif lastFM == "safe" then
		delay = 0.2
	else
		delay = 1
	end
	
	if self.FireMode != self.FireModes[t.last] and self.FireModes[t.last] then
		CT = CurTime()
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
	
	t = CustomizableWeaponry.firemodes.registeredByID[n]
	self.Primary.Automatic = t.auto
	self.FireMode = n
	self.BurstAmount = t.burstamt
	
	if self.FireMode == "safe" then
		self.dt.Safe = true
	else
		self.dt.Safe = false
	end
	
	umsg.Start("CW_KK_INS_FIREMODE")
		umsg.Entity(self.Owner)
		umsg.String(n)
	umsg.End()
end

if CLIENT then
	local function CW_ReceiveFireMode(um)
		ply = um:ReadEntity()
		Mode = um:ReadString()
		
		if IsValid(ply) then
			wep = ply:GetActiveWeapon()
			lastFM = wep.FireMode
			wep.FireMode = Mode
			
			if IsValid(ply) and IsValid(wep) and wep.CW20Weapon then
				if CustomizableWeaponry.firemodes.registeredByID[Mode] then
					t = CustomizableWeaponry.firemodes.registeredByID[Mode]
					
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

	usermessage.Hook("CW_KK_INS_FIREMODE", CW_ReceiveFireMode)
end
