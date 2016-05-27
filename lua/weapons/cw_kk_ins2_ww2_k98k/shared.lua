if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Kar-98k"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"

	SWEP.Shell = "KK_INS2_762x54"
	SWEP.ShellDelay = 0.75
	
	SWEP.BackupSights = {
		["kk_ins2_scope_mosin"] = {
			Vector(-2.5615, -4, 1.588),
			Vector(0.2652, 0.0073, 0)
		},
	}
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_kar98k_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/a_optic_kar98k.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_kar98k_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/w_optic_kar98k.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.5615, -4, 1.588)
	SWEP.IronsightAng = Vector(0.2652, 0.0073, 0)

	SWEP.KKINS2ScopeZF4Pos = Vector(-2.8233, -2, 1.2934)
	SWEP.KKINS2ScopeZF4Ang = Vector(0, 0, 0)

	SWEP.KKINS2ScopeMosinPos = Vector(-2.8003, 0, 0.9761)
	SWEP.KKINS2ScopeMosinAng = Vector(0, 0, 0)

	SWEP.KKINS2ScopeMosinPos = Vector(-2.5434, -1.5, 0.3398)
	SWEP.KKINS2ScopeMosinAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.018
end

SWEP.Attachments = {
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_scope_mosin"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	reload_start = "",
	insert = "",
	reload_end = "",
	idle = "",	
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "base_draw_empty",
	base_fire = "base_fire_start",
	base_fire_aim = "iron_fire_start",
	base_fire_last = "base_fire_last",
	base_fire_last_aim = "iron_fire_last",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_bolt = "base_fire_end",
	base_bolt_aim = "iron_fire_end",
	base_reload = "base_reload_empty_stripper",
	base_reload_empty = "base_reload_empty_stripper",
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start_empty",
	-- base_reload_start_empty = "base_reload_start",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end",
	base_reload_end_empty = "base_reload_end",
	base_idle = "base_idle",
	base_idle_empty = "base_idle_empty",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_safe_empty = "base_down_empty",
	base_safe_empty_aim = "iron_down_empty",
	base_melee = "base_melee",
	base_melee_empty = "base_melee_empty"
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_kar98k.mdl"
SWEP.WorldModel		= "models/weapons/w_kar98k.mdl"

SWEP.WMPos = Vector(14, 0.5, -3)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2de
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.92x57MM"

SWEP.FireDelay = 60/36
SWEP.FireSound = "CW_KK_INS2_WW2_K98_FIRE"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 61

SWEP.FirstDeployTime = 2.9
SWEP.DeployTime = 0.73

SWEP.RecoilToSpread = 0.8 

SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15

SWEP.ReloadStartTime = 1.28
SWEP.ReloadStartTimeEmpty = 1.28
SWEP.InsertShellTime = 0.99
SWEP.ReloadFinishWait = 1.49
SWEP.ReloadFinishWaitEmpty = 1.49

SWEP.SnapToIdlePostReload = false

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = SWEP.FireDelay + 0.2
SWEP.GlobalDelayOnShoot = SWEP.FireDelay

SWEP.KK_INS2_emptyIdle = true
SWEP.WeaponLength = 38

-- SWEP.ReloadTime = 0.1
-- SWEP.ReloadHalt = 4.49
-- SWEP.ReloadTime_Empty = 0.1
-- SWEP.ReloadHalt_Empty = 4.49

function SWEP:fireAnimFunc()
	local clip = self:Clip1()
	local mag = ""
	
	if clip == 1 then
		mag = "_last"
	elseif clip == 0 then
		mag = "_empty"
	end
	
	local prefix = self:getForegripMode()
	local suffix = ""
	
	if self:isAiming() then
		suffix = "_aim"
	end
	
	if clip > 0 then
		CustomizableWeaponry.actionSequence.new(self, 0.14, nil, function() 
			local prefix = self:getForegripMode()
			local suffix = ""
			
			if self:isAiming() then
				suffix = "_aim"
			end
			
			self:sendWeaponAnim(prefix .. "bolt" .. suffix,1,0)
		end)
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. mag .. suffix,1,0)
	
end //*/

if CLIENT then
	function SWEP:updateOtherParts()
		if self.Sequence:find("base_reload_start") or (self.Sequence == self.Animations.base_insert and self.CW_VM:GetCycle() < 0.62) then
			// eh
		else
			self:setBodygroup(1, self:Clip1())
		end
		
		self.NoShells = self.Sequence:find("fire_last")
	end
end
