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

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001
SWEP.Recoil = 3

SWEP.FirstDeployTime = 0.5
SWEP.DeployTime = 0.5

SWEP.SpeedDec = 0
SWEP.WeaponLength = 0

SWEP.timeToThrow = 0.8
SWEP.swapTime = 0.7
SWEP.fuseTime = 3

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
				return
			end
		end
		
		SafeRemoveEntity(self)
	end
end

function SWEP:Initialize()
	weapons.GetStored("cw_base").Initialize(self)
	self._KK_INS2_PickedUp = true
end

function SWEP:SetupDataTables()
	self:DTVar("Int", 0, "State")
	self:DTVar("Int", 1, "Shots")
	self:DTVar("Float", 0, "HolsterDelay")
	self:DTVar("Bool", 0, "Suppressed")
	self:DTVar("Bool", 1, "Safe")
	self:DTVar("Bool", 2, "BipodDeployed")
	self:DTVar("Bool", 3, "PinPulled") // coz I dont want to copy-pasta whole cw_menu + initfunc 
	self:DTVar("Angle", 0, "ViewOffset")
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
	
	SWEP.DrawCustomWM = true
	
	function SWEP:updateOtherParts()
		self.WMEnt:SetBodygroup(1,1)
	end
end

function SWEP:Reload()
end
	
local SP = game.SinglePlayer()

function SWEP:IndividualThink()
	self.lastOwner = self.Owner
	
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
			if not self.Owner:KeyDown(IN_ATTACK) then
				if not self.animPlayed then
					self.entityTime = CurTime() + 0.15
					self:sendWeaponAnim("throw")
					self.Owner:SetAnimation(PLAYER_ATTACK1)
				end
				
				if curTime > self.entityTime then
					if SERVER then
						local grenade = ents.Create(self.grenadeEnt)
						grenade.Model = self.WM or self.WorldModel
						
						if self:GetClass() == "cw_kk_ins2_nade_anm14" then
							grenade.BreakOnImpact = false
						end
						
						grenade:SetPos(self.Owner:GetShootPos())
						grenade:SetAngles(self.Owner:EyeAngles())
						grenade:Spawn()
						grenade:Activate()
						grenade:Fuse(self.fuseTime)
						grenade:SetOwner(self.Owner)
						CustomizableWeaponry.quickGrenade:applyThrowVelocity(self.Owner, grenade, 800, Vector(0, 0, 150))
						
						if not CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage") then
							self:TakePrimaryAmmo(1)
							CustomizableWeaponry.callbacks.processCategory(wep, "postConsumeAmmo")
						end
					end
					
					self:SetNextPrimaryFire(curTime + 1)
					
					timer.Simple(self.swapTime, function()
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
			end
		end
	end
end

function SWEP:PrimaryAttack()
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
	self.throwTime = CurTime() + self.timeToThrow
	self:sendWeaponAnim("pullpin")
end

function SWEP:SecondaryAttack()
	// throw low or cok
	// cok preferably
end
