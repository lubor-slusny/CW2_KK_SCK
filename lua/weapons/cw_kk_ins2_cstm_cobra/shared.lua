if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "King Cobra"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.Shell = "KK_INS2_45apc"
	SWEP.NoShells = true
	
	SWEP.AttachmentModelsVM = {
		["loader"] = {model = "models/weapons/upgrades/a_cobraloader_rev.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
	}

	SWEP.IronsightPos = Vector(-1.848, 0, -0.1013)
	SWEP.IronsightAng = Vector(0, 0.0687, 0)

	SWEP.CustomizationMenuScale = 0.01

	SWEP.SprintAnimSpeed = 1.1
	SWEP.ReloadViewBobEnabled = false
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.Chamberable = false
SWEP.ShotgunReload = false
SWEP.WeaponLength = 16

SWEP.Attachments = {
	-- {header = "Barrel", offset = {-500, -400}, atts = {"md_cobram2"}},
	-- {header = "Extras", offset = {-0, -600}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	-- {header = "Reload Aid", offset = {600, 50}, atts = {"kk_ins2_revolver_mag"}},
	["+reload"] = {header = "Ammo", offset = {-400, 50}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end",
	base_reload_end_empty = "base_reload_end",
	base_idle = "base_reload_end",	
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire","base_fire2"},
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload_speed",
	base_reload_empty = "base_reload_speed",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WS"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_cstm_cobra.mdl"
SWEP.WorldModel		= "models/weapons/w_cw_kk_ins2_cstm_cobra.mdl"

SWEP.WMPos = Vector(5.309, 1.623, -1.616)
SWEP.WMAng = Vector(-3, -5, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.wsContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.wsContentMounted()

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".357 Magnum"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_REVOLVER_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_REVOLVER_FIRE_SUPPRESSED"
SWEP.Recoil = 2.6

SWEP.HipSpread = 0.039
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.35
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 50

SWEP.FirstDeployTime = 2.54
SWEP.DeployTime = 0.46

SWEP.ReloadTime = 3.6
SWEP.ReloadHalt = 4.2

SWEP.ReloadTime_Empty = 3.6
SWEP.ReloadHalt_Empty = 4.2

SWEP.ReloadStartTime = 2.36
SWEP.ReloadStartTimeEmpty = 2.36
SWEP.InsertShellTime = 0.98
SWEP.ReloadFinishWait = 1.74
SWEP.ReloadFinishWaitEmpty = 1.74

function SWEP:beginReload()
	if self.ShotgunReload then
		mag = self:Clip1()
	
		local time = CT + self.ReloadStartTime / self.ReloadSpeed
		
		self.lastMag = 0
		self.WasEmpty = mag == 0
		self.ReloadDelay = time
		self:SetNextPrimaryFire(time)
		self:SetNextSecondaryFire(time)
		self.GlobalDelay = time
		self.ShotgunReloadState = 1
		
		self:sendWeaponAnim("reload_start")
		
		CustomizableWeaponry.actionSequence.new(self, 2, nil, function()
			local amt = self:Clip1()
			self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Primary.Ammo) + amt, self.Primary.Ammo)
			self:SetClip1(0)
		end)
		
		CustomizableWeaponry.callbacks.processCategory(self, "beginReload", mag == 0)
		
		self.Owner:SetAnimation(PLAYER_RELOAD)
	else
		weapons.GetStored("cw_base").beginReload(self)
	end
end

if CLIENT then 
	local bullet = 1
	local shell = 2

	function SWEP:updateOtherParts()
		local vm = self.CW_VM
		local cyc = vm:GetCycle()
		
		local clip = self:Clip1()
		local reserve = self.Owner:GetAmmoCount(self.Primary.Ammo) + clip
		
		if self.ShotgunReload then
			local dumping = self.Sequence == self.Animations.base_reload_start
			local loading = self.Sequence == self.Animations.base_insert // or self.Sequence == self.Animations.base_reload_end
		
			if dumping then 
				self:setBodygroup(1,clip)
			else
				self:setBodygroup(1,6)
			end
			
			if loading then
				self:setBodygroup(2,clip)
			else
				self:setBodygroup(2,math.Clamp(reserve,0,6))
			end
		else
			local dumping = self.Sequence == self.Animations.base_reload and cyc < 0.41
			local loading = self.Sequence == self.Animations.base_reload and cyc > 0.41 and cyc < 1
		
			if loading then
				self:setBodygroup(1,math.Clamp(reserve,0,6))
			else
				self:setBodygroup(1,clip)
			end
			
			self:setBodygroup(2,6)
		end
	end
end
