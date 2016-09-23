if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Lods-Emone"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"

	SWEP.NoShells = true
	SWEP.Shell = "KK_INS2_762x54"
	-- SWEP.ShellDelay = 0.7
		
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_iron_enfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_ww2_stripper"] = {model = "models/weapons/upgrades/a_enfield_stripper_clip.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_enfield_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_enfield_bayonet_spike.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_gl_enfield"] = {model = "models/weapons/upgrades/a_enfield_gl.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_scope_enfield"] = {model = "models/weapons/upgrades/a_optic_enfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_enfield_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_enfield_bayonet_spike.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_gl_enfield"] = {model = "models/weapons/upgrades/w_enfield_gl.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_enfield"] = {model = "models/weapons/upgrades/w_optic_enfield.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.5678, -3, 1.5173)
	SWEP.IronsightAng = Vector(-0.1284, 0, 0)

	SWEP.KKINS2ScopeEnfieldPos = Vector(-2.5738, -1.5, 0.8389)
	SWEP.KKINS2ScopeEnfieldAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(-2.71, -6, 1.8053)
	SWEP.M203Ang = Vector(-4.5019, 0, 0)

	SWEP.CustomizationMenuScale = 0.018
end

SWEP.Attachments = {
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_scope_enfield"}, exclusions = {["kk_ins2_ww2_stripper"] = true}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife", "kk_ins2_gl_enfield"}},
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	{header = "Clip", offset = {200, 0}, atts = {"kk_ins2_ww2_stripper"}, exclusions = {["kk_ins2_scope_enfield"] = true}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
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
	base_reload = "base_reload_full_clip",
	base_reload_empty = "base_reload_empty_clip",
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start_empty",
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

	gl_off_pickup = "base_ready",
	gl_off_draw = "base_draw",
	gl_off_draw_empty = "base_draw_empty",
	gl_off_fire = "base_fire_start",
	gl_off_fire_aim = "iron_fire_start",
	gl_off_fire_last = "base_fire_last",
	gl_off_fire_last_aim = "iron_fire_last",
	gl_off_fire_empty = "base_dryfire",
	gl_off_fire_empty_aim = "iron_dryfire",
	gl_off_bolt = "base_fire_end",
	gl_off_bolt_aim = "iron_fire_end",
	gl_off_reload = "base_reload_full_clip",
	gl_off_reload_empty = "base_reload_empty_clip",
	gl_off_reload_start = "base_reload_start",
	gl_off_reload_start_empty = "base_reload_start_empty",
	gl_off_insert = "base_reload_insert",
	gl_off_reload_end = "base_reload_end",
	gl_off_reload_end_empty = "base_reload_end",
	gl_off_idle = "base_idle",
	gl_off_idle_empty = "empty_idle",
	gl_off_holster = "base_holster",
	gl_off_holster_empty = "base_holster_empty",
	gl_off_sprint = "base_sprint",
	gl_off_sprint_empty = "base_sprint_empty",
	gl_off_safe = "base_down",
	gl_off_safe_aim = "iron_down",
	gl_off_safe_empty = "base_down_empty",
	gl_off_safe_empty_aim = "iron_down_empty",
	gl_off_melee = "base_melee",
	gl_off_melee_empty = "base_melee_empty",
	gl_off_crawl = "base_crawl",
	gl_off_crawl_empty = "base_crawl_empty",
	
	gl_on_draw = "glsetup_draw",
	gl_on_draw_empty = "glsetup_draw_empty",
	gl_on_fire = "glsetup_fire",
	gl_on_fire_aim = "glsetup_iron_fire",
	gl_on_fire_empty = "glsetup_dryfire",
	gl_on_fire_empty_aim = "glsetup_iron_dryfire",
	gl_on_reload = "glsetup_reload",
	gl_on_idle = "glsetup",
	gl_on_idle_empty = "glsetup_idle_empty",
	gl_on_holster = "glsetup_holster",
	gl_on_holster_empty = "glsetup_holster_empty",
	gl_on_sprint = "glsetup_sprint",
	gl_on_sprint_empty = "glsetup_sprint_empty",
	gl_on_safe = "glsetup_down",
	gl_on_safe_aim = "glsetup_iron_down",
	gl_on_safe_empty = "glsetup_down_empty",
	gl_on_safe_empty_aim = "glsetup_iron_down_empty",
	gl_on_crawl = "glsetup_crawl",
	gl_on_crawl_empty = "glsetup_crawl_empty",
	
	gl_turn_on_full = "glsetup_in",
	gl_turn_on = "glsetup_in_empty",
	gl_turn_off = "glsetup_out",
	gl_turn_off_empty = "glsetup_out_empty",
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
SWEP.ViewModel		= "models/weapons/v_enfield.mdl"
SWEP.WorldModel		= "models/weapons/w_enfield.mdl"

SWEP.WMPos = Vector(14, 0.5, -3)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2gb
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2gb

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".303 British"

-- SWEP.FireDelay = 60/36
SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_DOI_ENFIELD_FIRE"
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

SWEP.ReloadStartTime = 1.12
SWEP.ReloadStartTimeEmpty = 1.12
SWEP.InsertShellTime = 0.92
SWEP.ReloadFinishWait = 1.3
SWEP.ReloadFinishWaitEmpty = 1.3

SWEP.SnapToIdlePostReload = false

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = SWEP.FireDelay + 0.2
SWEP.GlobalDelayOnShoot = SWEP.FireDelay

SWEP.KK_INS2_EmptyIdle = true
SWEP.KK_INS2_EmptyIdleGL = true
SWEP.WeaponLength = 38

SWEP.gl_on_time = 6.62
SWEP.gl_off_time = 5.0
SWEP.gl_off_shot_time = 2.23
SWEP.gl_on_ReloadTime = 5.32
SWEP.gl_on_ReloadHalt = 6.62

SWEP.ReloadTime = 5.19
SWEP.ReloadHalt = 7.39
SWEP.ReloadTime_Empty = 5.19
SWEP.ReloadHalt_Empty = 7.39

SWEP.MuzzleVelocity = 744
SWEP.boltAction_pumpTime = 1.2
