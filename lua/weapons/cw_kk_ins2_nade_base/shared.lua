if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_anims.lua")
include("sh_anims.lua")

SWEP.KKINS2Nade = true

if CLIENT then	
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Grenade base (KK INS2 Edit)"
	
	SWEP.SprintAnimSpeed = 1.2
	SWEP.ViewModelMovementScale_sprint = 0.5
	SWEP.ViewModelMovementScale_base = 0.6
	SWEP.DisableSprintViewSimulation = true
	SWEP.HUD_3D2DScale = 0.008
	
	SWEP.HUD_3D2DBone = 59
	
	SWEP.CustomizePos = Vector()
	SWEP.CustomizeAng = Vector()
	
	SWEP.CustomizationMenuScale = 0.01
end

SWEP.CanRestOnObjects = false
	
-- SWEP.SprintingEnabled = false
SWEP.AimingEnabled = false
SWEP.CanCustomize = false
SWEP.AccuracyEnabled = false

SWEP.Attachments = {}
SWEP.Sounds = {}

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.HoldToAim				= false

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001
SWEP.Recoil = 3

SWEP.DeployTime = 0.6
SWEP.HolsterTime = 0.5

SWEP.SpeedDec = 0
SWEP.WeaponLength = 0

SWEP.fuseTime = 3			// grenade fuse time

SWEP.timeToThrow = 0.8		// full length of pinpull animation
SWEP.spawnTime = 0.2		// delay between start of throw animation and creation of grenade ent
SWEP.swapTime = 0.7			// full length of throw animation

SWEP.spoonTime = 23/30		// delay between start of pinpull_cook animation and start of fuse timer
SWEP.timeToThrowCook = 0.8	// full length of pinpull_cook animation
SWEP.spawnTimeCook = 0.2	// delay between start of throw_cook animation and creation of grenade ent
SWEP.swapTimeCook = 0.7		// full length of throw_cook animation

SWEP.canCook = true

if SERVER then	
	function SWEP:EquipAmmo(ply)
		ply:GiveAmmo(1, self.Primary.Ammo)
	end
	
	function SWEP:equipFunc()
		local ply = self.Owner
		ply:GiveAmmo(1, self.Primary.Ammo)
	end
	
	function SWEP:OnDrop()
		if IsValid(self.lastOwner) then
			if self.lastOwner:GetAmmoCount(self.Primary.Ammo) > 0 then
				self.lastOwner:RemoveAmmo(1, self.Primary.Ammo)
					
					if self.dt.PinPulled then
						local grenade = self:createProjectile()
						
						if IsValid(grenade) then	
							grenade:SetPos(self:GetPos())
							grenade:SetAngles(self:GetAngles())
							
							local phy = grenade and grenade:GetPhysicsObject()
							if phy then 
								phy:SetVelocity(self:GetVelocity())
							end
						end
						
						SafeRemoveEntity(self)
					end
					
				return
			end
		end
		
		SafeRemoveEntity(self)
	end	
end

function SWEP:ShouldDropOnDie()
	return self.dt.PinPulled
end

function SWEP:Initialize()
	weapons.GetStored("cw_base").Initialize(self)
	self._KK_INS2_PickedUp = true
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Int", 1, "Shots")
	self:NetworkVar("Float", 0, "HolsterDelay")
	self:NetworkVar("Bool", 0, "Suppressed")
	self:NetworkVar("Bool", 1, "Safe")
	self:NetworkVar("Bool", 2, "BipodDeployed")
	self:NetworkVar("Bool", 3, "PinPulled")
	self:NetworkVar("Angle", 0, "ViewOffset")
end

if CLIENT then
	local m
	local muz = {}
	
	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		else
			m = self.CW_VM:GetBoneMatrix(self.HUD_3D2DBone)
		end
		
		muz.Pos = m:GetTranslation()
		muz.Ang = m:GetAngles()
		return muz
	end
end

function SWEP:Reload()
end
	
local SP = game.SinglePlayer()

function SWEP:IndividualThink()
	// for OnDrop func
	self.lastOwner = self.Owner
	
	// for 0-to-1-ammo draw-anim
	local cur = self.Owner:GetAmmoCount(self.Primary.Ammo)
	local last = self._lastPrimaryAmmoCount
	if last and last < cur and cur == 1 then
		self:drawAnimFunc()
		self:SetNextPrimaryFire(CurTime() + self.DeployTime)
		self:SetNextSecondaryFire(CurTime() + self.DeployTime)
	end
	self._lastPrimaryAmmoCount = cur
	
	// for some stuff that was most likely removed recently
	if self.dt.PinPulled then
		self.reticleInactivity = UnPredictedCurTime() + 1
	end

	-- weapons.GetStored("cw_kk_ins2_base").IndividualThink(self)
	weapons.GetStored("cw_kk_ins2_base_main").IndividualThink(self)
	
	if SP and CLIENT then 
		return
	end

	local curTime = CurTime()
	
	if self.dt.PinPulled then
		if curTime > self.throwTime then
			if not (self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)) then
				if not self.animPlayed then
					self.entityTime = CurTime() + self._curSpawnTime
					self:sendWeaponAnim(self._curThrowAnim)
					self.Owner:SetAnimation(PLAYER_ATTACK1)
				end
				
				if curTime > self.entityTime then
					if SERVER then
						local grenade = self:createProjectile()
						
						if IsValid(grenade) then
							self:applyThrowVelocity(grenade)
						end
					end
					
					if not CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage") then
						self:TakePrimaryAmmo(1)
						CustomizableWeaponry.callbacks.processCategory(wep, "postConsumeAmmo")
					end
					
					local animLength = self._curSwapTime - self._curSpawnTime
					
					self:SetNextPrimaryFire(curTime + animLength + self.DeployTime)
					self:SetNextSecondaryFire(curTime + animLength + self.DeployTime)
					
					timer.Simple(animLength, function()
						if IsValid(self) and IsValid(self.Owner) then
							if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then -- we're out of ammo, strip this weapon
								self.Owner:ConCommand("lastinv")
							else
								self:drawAnimFunc()
							end
						end
					end)
					
					self.dt.PinPulled = false
				end
				
				self.animPlayed = true
			else
				if self.cookTime and (self.cookTime + self.fuseTime) < curTime then
					self:SetNextPrimaryFire(curTime + 1)
					self:SetNextSecondaryFire(curTime + 1)
					
					if SERVER then
						self:overCook()
					end
					
					if not CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage") then
						self:TakePrimaryAmmo(1)
						CustomizableWeaponry.callbacks.processCategory(wep, "postConsumeAmmo")
					end
					
					timer.Simple(0.2, function()
						if IsValid(self) and IsValid(self.Owner) then
							if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then -- we're out of ammo, strip this weapon
								self.Owner:ConCommand("lastinv")
							else
								self:drawAnimFunc()
							end
						end
					end)
					
					self.dt.PinPulled = false
					self.animPlayed = true
				end
			end
		end
	end
end

if CLIENT then
	SWEP._cvarControlls = CreateClientConVar("cw_kk_ins2_ins_nade_ctrls", 0, true, true)
end

function SWEP:getControlls()
	local setting 
	
	if CLIENT then
		setting = self._cvarControlls:GetInt() or 0
	else
		setting = self.Owner:GetInfoNum("cw_kk_ins2_ins_nade_ctrls", 0)
	end
	
	return (2 - math.Clamp(setting, 0, 1))
end

local CT

function SWEP:_attack(key)
	if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 and self:Clip1() < 1 then
		return
	end

	if self.dt.PinPulled then
		return
	end
	
	for i = 1, 3 do
		if not self:canFireWeapon(i) then
			return
		end
	end
	
	self.dt.PinPulled = true
	self.animPlayed = false
	
	CT = CurTime()
	
	if self.canCook and key == self:getControlls() then
		self:sendWeaponAnim("pull_cook")
		self.throwTime = CT + self.timeToThrowCook
		self.cookTime = CT + self.spoonTime
		
		self._curThrowAnim = "throw_cook"
		self._curSwapTime = self.swapTimeCook
		self._curSpawnTime = self.spawnTimeCook
	else
		self:sendWeaponAnim("pullpin")
		self.throwTime = CT + self.timeToThrow
		self.cookTime = nil
		
		self._curThrowAnim = "throw"
		self._curSwapTime = self.swapTime
		self._curSpawnTime = self.spawnTime
	end
end

function SWEP:PrimaryAttack()
	self:_attack(1)
end

function SWEP:SecondaryAttack()
	self:_attack(2)
end

function SWEP:overCook()
	local hitPos = self.Owner:EyePos() + (self.Owner:EyeAngles():Forward() * 18)
	
	local grenade = ents.Create(self.grenadeEnt)
	grenade:SetNoDraw(true)
	grenade:SetPos(hitPos)
	grenade:Spawn()
	grenade:Activate()
	grenade:SetOwner(self.Owner)
	
	grenade:Fuse(0)
end

function SWEP:createProjectile()
	local grenade = ents.Create(self.grenadeEnt)
	grenade.Model = self.WM or self.WorldModel
	
	// move to anm14`s shared lua
	if self:GetClass() == "cw_kk_ins2_nade_anm14" then
		grenade.BreakOnImpact = false
	end
	
	grenade:SetPos(self.lastOwner:GetShootPos())
	grenade:SetAngles(self.lastOwner:EyeAngles())
	
	grenade:Spawn()
	grenade:Activate()
	grenade:SetOwner(self.lastOwner)
	
	if self.cookTime then
		grenade:Fuse(math.Clamp((self.cookTime + self.fuseTime) - CurTime(), 0, self.fuseTime))
	else
		grenade:Fuse(self.fuseTime)
	end
	
	return grenade
end

local v = Vector(0, 0, 150)

function SWEP:applyThrowVelocity(grenade)
	CustomizableWeaponry.quickGrenade:applyThrowVelocity(self.Owner, grenade, 800, v)
end
