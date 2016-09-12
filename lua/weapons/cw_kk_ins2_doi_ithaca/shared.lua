if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Ithaca"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m3"

	SWEP.NoShells = true
	SWEP.Shell = "KK_INS2_12guage"
	-- SWEP.ShellDelay = 13/30
	
	SWEP.ShellViewAngleAlign = {Forward = 90, Right = 0, Up = 0}
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-2.0952, -2.5, 1.2975)
	SWEP.IronsightAng = Vector(0.2605, -0.0341, 0)

	SWEP.CustomizationMenuScale = 0.015
end

SWEP.Attachments = {
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_slugrounds", "am_flechetterounds"}}
}

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire_1", "base_fire_2"},
	base_fire_aim = {"iron_fire_1", "iron_fire_2"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_bolt = {"base_fire_cock_1", "base_fire_cock_2"},
	base_bolt_aim = {"iron_fire_cock_1", "iron_fire_cock_2"},
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start_empty",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end",
	base_reload_end_empty = "base_reload_end",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_kk_ins2_base_pump"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_ithaca.mdl"
SWEP.WorldModel		= "models/weapons/w_ithaca.mdl"

SWEP.WMPos = Vector(4.763, 0.935, -2.445)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2gb
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2gb

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 9
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

-- SWEP.FireDelay = 0.8
SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_M590_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M590_FIRE_SUPPRESSED"
SWEP.Recoil = 3

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.013
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 11

SWEP.FirstDeployTime = 2.2
SWEP.DeployTime = 0.8
SWEP.HolsterTime = 0.6

SWEP.ReloadFirstShell = 2.25

SWEP.ReloadStartTime = 0.6
SWEP.ReloadStartTimeEmpty = 2.59
SWEP.InsertShellTime = 0.97
SWEP.ReloadFinishWait = 0.66
SWEP.ReloadFinishWaitEmpty = 0.66

SWEP.Chamberable = true
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = SWEP.FireDelay + 0.2
SWEP.GlobalDelayOnShoot = SWEP.FireDelay

SWEP.WeaponLength = 18

SWEP.MuzzleVelocity = 381

-- function SWEP:updateReloadTimes()
	-- local mode = self:getForegripMode()

	-- if self:Clip1() == 0 then
		-- self.Animations.reload_start = self.Animations[mode .. "reload_start_empty"]
		-- self.Animations.insert = nil
		-- self.ReloadStartTime = 2.2
	-- else
		-- self.Animations.reload_start = self.Animations[mode .. "reload_start"]
		-- self.Animations.insert = self.Animations[mode .. "insert"]
		-- if self.base_ReloadStartTime then
			-- self.ReloadStartTime = self[mode .. "ReloadStartTime"] or self.base_ReloadStartTime
		-- end
	-- end
	
	-- self.Animations.reload_end = self.Animations[mode .. "reload_end"]
	-- self.Animations.idle = self.Animations[mode .. "reload_end"]
	
	-- if self.base_InsertShellTime then
		-- self.InsertShellTime = self[mode .. "InsertShellTime"] or self.base_InsertShellTime
	-- end
	-- if self.base_ReloadFinishWait then
		-- self.ReloadFinishWait = self[mode .. "ReloadFinishWait"] or self.base_ReloadFinishWait
	-- end
-- end

-- function SWEP:fireAnimFunc()
	-- local clip = self:Clip1()
	-- local mag = ""
	
	-- if clip == 0 then
		-- mag = "_empty"
	-- end
	
	-- local prefix = self:getForegripMode()
	-- local suffix = ""
	
	-- if self:isAiming() then
		-- suffix = "_aim"
	-- end
	
	-- if clip > 0 then
		-- CustomizableWeaponry.actionSequence.new(self, 0.28, nil, function() 
			-- local prefix = self:getForegripMode()
			-- local suffix = ""
			
			-- if self:isAiming() then
				-- suffix = "_aim"
			-- end
			
			-- self:sendWeaponAnim(prefix .. "bolt" .. suffix,1,0)
		-- end)
	-- end
	
	-- self:sendWeaponAnim(prefix .. "fire" .. mag .. suffix,1,0)
	
-- end //*/