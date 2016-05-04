if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "brMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "G-43"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "KK_INS2_762x54"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_g43.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_scope_zf4"] = {model = "models/weapons/upgrades/a_optic_zf4.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_4.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.4403, -2, 0.8474)
	SWEP.IronsightAng = Vector(0.3287, 0.0068, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.3987, 0, -0.3412)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCMorePos = Vector(-2.3953, 0, -0.3158)
	SWEP.KKINS2CSTMCMoreAng = Vector(0, 0, 0)

	SWEP.KKINS2ScopeZF4Pos = Vector(-2.376, -2, -0.0463)
	SWEP.KKINS2ScopeZF4Ang = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.019
end

SWEP.WeaponLength = 22

SWEP.Attachments = {
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_scope_zf4"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	-- {header = "Under", offset = {-500, 0}, atts = {"kk_ins2_vertgrip"}},
	-- {header = "Lasers", offset = {125, 100}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	-- {header = "Magazine", offset = {-50, 500}, atts = {"kk_ins2_mag_thom_30", "kk_ins2_mag_thom_50"}},
	-- {header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.KK_INS2_emptyIdle = true

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire = {"base_fire_1","base_fire_2"},
	base_fire_aim = {"iron_fire_1", "iron_fire_2", "iron_fire_3"},
	base_fire_last = "base_fire_last",
	base_fire_last_aim = "iron_fire_last",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reloadfull",
	base_reload_empty = "base_reloadempty",
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
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_g43.mdl"
SWEP.WorldModel		= "models/weapons/w_g43.mdl"

SWEP.WMPos = Vector(10, 1.009, -4)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.92x57MM"

SWEP.FireDelay = 0.25
SWEP.FireSound = "CW_KK_INS2_WW2_G43_FIRE"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 59

SWEP.FirstDeployTime = 1.87
SWEP.DeployTime = 0.71

SWEP.RecoilToSpread = 0.8 

SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15

SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Empty = 2.3
SWEP.ReloadHalt = 3.3
SWEP.ReloadHalt_Empty = 4.6

SWEP.SnapToIdlePostReload = false
