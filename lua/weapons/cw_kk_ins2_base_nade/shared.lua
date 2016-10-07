if not CustomizableWeaponry then return end

AddCSLuaFile()

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

SWEP.AddSafeMode = false

SWEP.FirstDeployTime = 0.6
SWEP.DeployTime = 0.6
SWEP.HolsterTime = 0.5

SWEP.SpeedDec = 0
SWEP.WeaponLength = 40

SWEP.fuseTime = 3			// grenade fuse time

SWEP.timeToThrow = 0.8		// minimal allowed length of pinpull animation
SWEP.spawnTime = 0.2		// delay between start of throw animation and creation of grenade ent
SWEP.swapTime = 0.7			// minimal allowed length of throw animation

SWEP.spoonTime = 23/30		// delay between start of pinpull_cook animation and start of fuse timer
SWEP.timeToThrowCook = 0.8	// minimal allowed length of pinpull_cook animation
SWEP.spawnTimeCook = 0.2	// delay between start of throw_cook animation and creation of grenade ent
SWEP.swapTimeCook = 0.7		// minimal allowed length of throw_cook animation

SWEP.canCook = true			// enable cooking
SWEP.mustCook = false		// cooking only (overrides SWEP.canCook)
SWEP.canPlant = false		// can stick to "wall" when "near-wall"

SWEP.spoonTimePlant = 1		// delay between start of plant animation and start of fuse timer
SWEP.spawnTimePlant = 1.17	// delay between start of plant animation and creation of grenade ent
SWEP.swapTimePlant = 1.7	// minimal allowed length of plant animation

SWEP.PlantPos = Vector()	// position offset for planted entities (tr.HitPos-relative)
SWEP.PlantAng = Vector()	// angle tweak for planted entities

SWEP.maxVelDelay = 1.35		// delay between start of pinpull animation and full throw velocity being available (full length of pinpull animation)
SWEP.maxVelDelayCook = 1.7	// delay between start of pinpull_cook animation and full throw velocity being available (full length of pinpull_cook animation)

//-----------------------------------------------------------------------------
// EquipAmmo replacement for SWEP.Primary.DefaultClip
//-----------------------------------------------------------------------------

if SERVER then	
	function SWEP:EquipAmmo(ply)
		ply:GiveAmmo(1, self.Primary.Ammo)
	end
end

//-----------------------------------------------------------------------------
// Equip replacement for SWEP.Primary.Clip
//-----------------------------------------------------------------------------

if SERVER then
	function SWEP:equipFunc()
		local ply = self.Owner
		ply:GiveAmmo(1, self.Primary.Ammo)
	end
end

//-----------------------------------------------------------------------------
// OnDrop edited to 
// - replace dropped SWEP with live grenade if pin was pulled prior to drop
// - remove one round from players inventory
//-----------------------------------------------------------------------------
	
if SERVER then
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

//-----------------------------------------------------------------------------
// this does not work
//-----------------------------------------------------------------------------

function SWEP:ShouldDropOnDie()
	return self.dt.PinPulled
end

//-----------------------------------------------------------------------------
// SetupDataTables edited to initialize dt.PinPulled
//-----------------------------------------------------------------------------

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

//-----------------------------------------------------------------------------
// getMuzzlePosition edited to use bone matrices
//-----------------------------------------------------------------------------

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

//-----------------------------------------------------------------------------
// nothing to reload
// for now
//-----------------------------------------------------------------------------

function SWEP:Reload() end
	
//-----------------------------------------------------------------------------
// IndividualThink edited to
// - play draw anim after increasing ammo reserve to 1 
// - use custom timings for entity spawns, fuse timer, animation delays
// - spawn projectile entity using separate function
// - apply throw velocity using separate function
// - use shouldSuppressAmmoUsage callback
// - overcook grenade using separate function
// - plant charges when possible
//-----------------------------------------------------------------------------

local SP = game.SinglePlayer()

function SWEP:IndividualThink()
	// for OnDrop func
	self.lastOwner = self.Owner
	
	// for 0-to-1-ammo draw-anim
	local cur = self.Owner:GetAmmoCount(self.Primary.Ammo)
	local last = self._lastPrimaryAmmoCount
	if last and last < cur and cur == 1 then
		if CLIENT and self.Sequence != self.Animations.base_draw then
			self:drawAnimFunc()
		end
		self:SetNextPrimaryFire(CurTime() + self.DeployTime)
		self:SetNextSecondaryFire(CurTime() + self.DeployTime)
	end
	self._lastPrimaryAmmoCount = cur
	
	-- weapons.GetStored("cw_kk_ins2_base").IndividualThink(self)
	weapons.GetStored("cw_kk_ins2_base_main").IndividualThink(self)
	
	if SP and CLIENT then 
		return
	end

	local CT = CurTime()
	
	if self.dt.PinPulled then
		if self.throwTime and self.throwTime < CT then
			if self.keyReleased or !self.Owner:KeyDown(self._curKeyPress) then
				if not self.animPlayed then
					self.entityTime = CurTime() + self._curSpawnTime
					self:sendWeaponAnim(self._curThrowAnim)
					self.Owner:SetAnimation(PLAYER_ATTACK1)
					
					self.keyReleased = true
				end
				
				if CT > self.entityTime then
					if SERVER then
						local grenade = self:createProjectile()
						
						if IsValid(grenade) then
							self:applyThrowVelocity(grenade)
						end
					end
					
					if not CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage") then
						self.Owner:RemoveAmmo(1, self.Primary.Ammo)
						CustomizableWeaponry.callbacks.processCategory(wep, "postConsumeAmmo")
					end
					
					local animLength = self._curSwapTime - self._curSpawnTime
					
					self:SetNextPrimaryFire(CT + animLength + self.DeployTime)
					self:SetNextSecondaryFire(CT + animLength + self.DeployTime)
					
					timer.Simple(animLength, function()
						if IsValid(self) and IsValid(self.Owner) then
							if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 and not self.KKINS2RCE then
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
				if self.cookTime and (self.cookTime + self.fuseTime) < CT then
					self:SetNextPrimaryFire(CT + 1)
					self:SetNextSecondaryFire(CT + 1)
					
					if SERVER then
						self:overCook()
					end
					
					if not CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage") then
						self.Owner:RemoveAmmo(1, self.Primary.Ammo)
						CustomizableWeaponry.callbacks.processCategory(wep, "postConsumeAmmo")
					end
					
					timer.Simple(0.2, function()
						if IsValid(self) and IsValid(self.Owner) then
							if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 and not self.KKINS2RCE then
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
		
		if self.plantTime and self.plantTime < CT then
			local nw, tr = self:isNearWall()
			
			if nw and not self._grenadePlanted then
				if SERVER then
					local grenade = self:createProjectile()
					
					if IsValid(grenade) then
						local ang = tr.HitNormal:Angle()
						
						local pos = tr.HitPos
						pos = pos + ang:Forward() * self.PlantPos.x
						pos = pos + ang:Right() * self.PlantPos.y
						pos = pos + ang:Up() * self.PlantPos.z
						
						ang:RotateAroundAxis(ang:Right(), self.PlantAng.x)
						ang:RotateAroundAxis(ang:Up(), self.PlantAng.y)
						ang:RotateAroundAxis(ang:Forward(), self.PlantAng.z)
						
						grenade:SetPos(pos)
						grenade:SetAngles(ang)
							
						if (tr.Entity:GetClass() == "worldspawn") then
							grenade:PhysicsDestroy()
							-- grenade:PhysicsInit(SOLID_VPHYSICS)
						else
							constraint.Weld(tr.Entity, grenade, tr.PhysicsBone, 0, 0, true, false)
						end
					
						self._grenadePlanted = true
					end
				end
				
				local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
				if not suppressAmmoUsage then
					self.Owner:RemoveAmmo(1, self.Primary.Ammo)
				end
			end
			
			if self._curSwapTime < CT then
				if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 and not self.KKINS2RCE then
					self.Owner:ConCommand("lastinv")
				else
					self:drawAnimFunc()
				end
				
				self.dt.PinPulled = false
			end
		end
	end
end

//-----------------------------------------------------------------------------
// getControlls checks for players "Swap Attacks" setting
// - returns id of cooking key based on settings
//-----------------------------------------------------------------------------

if CLIENT then
	SWEP._cvarControlls = CreateClientConVar("cw_kk_ins2_ins_nade_ctrls", 1, true, true)
end

function SWEP:getControlls()
	local setting 
	
	if CLIENT then
		setting = self._cvarControlls:GetInt() or 1
	else
		setting = self.Owner:GetInfoNum("cw_kk_ins2_ins_nade_ctrls", 1)
	end
	
	return (2 - math.Clamp(setting, 0, 1))
end

//-----------------------------------------------------------------------------
// _attack is code shared by both PrimaryAttack and SecondaryAttack
//-----------------------------------------------------------------------------

local CT
local keyPress = {IN_ATTACK, IN_ATTACK2}

function SWEP:_attack(key)
	if self:IsOwnerCrawling() then
		return
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 and self:Clip1() < 1 then
		return
	end

	if self.dt.PinPulled then
		return
	end

	// ignore near-wall
	for i = 1, 2 do
		if not self:canFireWeapon(i) then
			return
		end
	end
	
	if self.InactiveWeaponStates[self.dt.State] then
		return
	end
	
	self.dt.PinPulled = true
	self.animPlayed = false
	self.keyReleased = false
	
	self._curKeyPress = keyPress[key]
	
	CT = CurTime()
	
	local nw, tr = self:isNearWall()
	self.plantTime = nil
	self.attackStartTime = CT
	
	if nw and self.canPlant then							// if wep allows planting and we re near-wall then plant
		self:sendWeaponAnim("plant")
		self.plantTime = CT + self.spawnTimePlant
		self.cookTime = CT + self.spoonTimePlant
		
		self._grenadePlanted = false
		self.throwTime = nil
		
		self._curThrowAnim = nil
		self._curSwapTime = CT + self.swapTimePlant
		self._curSpawnTime = nil
		
		self:SetNextPrimaryFire(self._curSwapTime)
		self:SetNextSecondaryFire(self._curSwapTime)
	elseif self.mustCook or (self.canCook and key == self:getControlls()) then 	// if wep allows it and pressed key is cooking key then cook
		self:sendWeaponAnim("pull_cook")
		self.throwTime = CT + self.timeToThrowCook
		self.cookTime = CT + self.spoonTime
		
		self._curThrowAnim = "throw_cook"
		self._curSwapTime = self.swapTimeCook
		self._curSpawnTime = self.spawnTimeCook
		
		self._maxVelocityTime = CT + self.maxVelDelayCook
	else													// else hold your spoon
		self:sendWeaponAnim("pullpin")
		self.throwTime = CT + self.timeToThrow
		self.cookTime = nil
		
		self._curThrowAnim = "throw"
		self._curSwapTime = self.swapTime
		self._curSpawnTime = self.spawnTime
		
		self._maxVelocityTime = CT + self.maxVelDelay
	end
end

//-----------------------------------------------------------------------------
// PrimaryAttack contents moved to _attack
//-----------------------------------------------------------------------------

function SWEP:PrimaryAttack()
	self:_attack(1)
end

//-----------------------------------------------------------------------------
// SecondaryAttack contents moved to _attack
//-----------------------------------------------------------------------------

function SWEP:SecondaryAttack()
	self:_attack(2)
end

//-----------------------------------------------------------------------------
// overCook is
// - called once fuse timer runs out while holding the grenade
// - separate function to allow derived SWEPs to override this behavior
//-----------------------------------------------------------------------------

function SWEP:overCook()
	local hitPos = self.Owner:EyePos() + (self.Owner:EyeAngles():Forward() * 18)
	
	local grenade = ents.Create(self.grenadeEnt)
	
	if IsValid(grenade) then
		grenade:SetNoDraw(true)
		grenade:SetPos(hitPos)
		grenade:Spawn()
		grenade:Activate()
		grenade:SetOwner(self.Owner)
		
		self:fuseProjectile(grenade, 0)
	end
end

//-----------------------------------------------------------------------------
// createProjectile
// - initializes grenade entity
// - calls fuseProjectile to set timer on grenade entity
// - returns created entity
// - separate function to allow derived SWEPs to override this behavior
//-----------------------------------------------------------------------------

function SWEP:createProjectile()
	local grenade = ents.Create(self.grenadeEnt)
	
	if IsValid(grenade) then
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
		
		self:fuseProjectile(grenade)
	end
	
	return grenade
end

//-----------------------------------------------------------------------------
// fuseProjectile
// - sets fuse timer on passed grenade entity
// - separate function to allow derived SWEPs to override this behavior
//-----------------------------------------------------------------------------

function SWEP:fuseProjectile(grenade, overrideTime)
	local time
	
	if self.cookTime then
		time = math.Clamp((self.cookTime + self.fuseTime) - CurTime(), 0, self.fuseTime)
	else
		time = self.fuseTime
	end
	
	time = overrideTime or time
	
	grenade:Fuse(time)
end

//-----------------------------------------------------------------------------
// applyThrowVelocity
// - gets velocity multipliers and applies velocity to passed grenade entity
// - separate function to allow derived SWEPs to override this behavior
//-----------------------------------------------------------------------------

local v = Vector(0, 0, 150)

function SWEP:applyThrowVelocity(grenade)
	local forward, up = self:getThrowVelocityMods()
	
	CustomizableWeaponry.quickGrenade:applyThrowVelocity(self.Owner, grenade, 800 * forward, v * up)
end

//-----------------------------------------------------------------------------
// nothing to update
//-----------------------------------------------------------------------------

function SWEP:updateReloadTimes() end

//-----------------------------------------------------------------------------
// getThrowVelocityMods counts velocity multipliers based on
// extra time spent in pinpull animation - full anim played -> max velocity
//-----------------------------------------------------------------------------

function SWEP:getThrowVelocityMods()
	local min, max = self.throwTime, self._maxVelocityTime
	local CT = CurTime() - self._curSpawnTime 					// fixes offset caused by delay between start of throw anim and ent creation
	local mul = math.Clamp((CT - min) / (max - min), 0, 1)
	
	local min, max = 0.5, 1.4
	local forward = min + mul * (max - min)
	
	local min, max = 0.8, 1.2
	local up = min + mul * (max - min)

	return forward, up
end
