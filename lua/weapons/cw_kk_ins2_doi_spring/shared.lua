if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1903A3 Springfield"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"

	SWEP.Shell = "KK_INS2_762x54"
	SWEP.ShellDelay = 0
	SWEP.NoShells = true
	
	SWEP.BackupSights = {}
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_iron_springfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["bolt_scope"] = {model = "models/weapons/upgrades/a_bolt_springfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["bolt_iron"] = {model = "models/weapons/upgrades/a_bolt_springfield_ext.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_ww2_stripper"] = {model = "models/weapons/upgrades/a_springfield_stripper_clip.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_garand_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_m73"] = {model = "models/weapons/upgrades/a_optic_springfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/w_iron_springfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_garand_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_m73"] = {model = "models/weapons/upgrades/w_optic_springfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.5643, -3, 1.3156)
	SWEP.IronsightAng = Vector(-0.03, 0.03, 0)

	SWEP.KKINS2ScopeM73Pos = Vector(-2.5631, -3, 1.2384)
	SWEP.KKINS2ScopeM73Ang = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.015
end

SWEP.Attachments = {
	-- {header = "Sight", offset = {500, -500}, atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_cstm_acog", "kk_ins2_po4", "kk_ins2_scope_mosin", "kk_ins2_scope_m40"}},
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_scope_m73"}, exclusions = {["kk_ins2_ww2_stripper"] = true}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	{header = "Clip", offset = {200, 0}, atts = {"kk_ins2_ww2_stripper"}, exclusions = {["kk_ins2_scope_m73"] = true}},
	-- {header = "Under", offset = {-500, 0}, atts = {"kk_ins2_bipod"}},
	-- {header = "Lasers", offset = {125, 200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	-- {header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
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
	base_reload = "base_reload_full_clip",
	base_reload_empty = "base_reload_empty_clip",
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start_empty",
	-- base_reload_start_empty = "base_reload_start",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end",
	base_reload_end_empty = "base_reload_end",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_safe_empty = "base_down_empty",
	base_safe_empty_aim = "iron_down_empty",
	base_melee = "base_melee",
	base_melee_empty = "base_melee_empty",
	base_crawl = "base_crawl",
	base_crawl_empty = "base_crawl_empty",
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_springfield.mdl"
SWEP.WorldModel		= "models/weapons/w_springfield.mdl"

SWEP.WMPos = Vector(14, 0, -2)
SWEP.WMAng = Vector(-10, 2, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2us
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".30-06"

-- SWEP.FireDelay = 60/36
SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_DOI_SPRING_FIRE"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 61

SWEP.FirstDeployTime = 2.7
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.5

SWEP.RecoilToSpread = 0.8 

SWEP.SnapToIdlePostReload = false

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = SWEP.FireDelay + 0.2
SWEP.GlobalDelayOnShoot = SWEP.FireDelay

SWEP.KK_INS2_EmptyIdle = true
SWEP.WeaponLength = 38

SWEP.MuzzleVelocity = 854

SWEP.ReloadTimes = {
	base_fire_end = {20/35, 1.49},
	iron_fire_end = {18/35, 1.49},
	
	base_reload_full_clip = {90/33.4, 4.49, KK_INS2_STRIPPERCLIP_UNLOAD_ONE, 27/33.4},
	base_reload_empty_clip = {90/33.4, 4.49},
	base_reload_start = {29/34.5, 1.25, KK_INS2_SHOTGUN_UNLOAD_ONE},
	base_reload_start_empty = {1.25, 1.25},
	base_reload_insert = {20/37.2, 0.99},
	base_reload_end = {1.45, 1.45},
}

if CLIENT then
	function SWEP:updateStandardParts()
		self:setElementActive("bolt_iron", !self.ActiveAttachments.kk_ins2_scope_m73)
		self:setElementActive("bolt_scope", self.ActiveAttachments.kk_ins2_scope_m73)
	end
end
