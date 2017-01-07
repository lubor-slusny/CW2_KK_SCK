if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.TSGlass = Material("models/weapons/nam/m16a1/lense_rt")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M16A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_nam_m16a1")
	
	SWEP.Shell = "KK_INS2_556x45"
	SWEP.ShellDelay = 0.06

	SWEP.ShellViewAngleAlign = {Forward = 0, Right = 0, Up = -40}
	
	SWEP.Shell2ViewAngleAlign = {Forward = 0, Right = -90, Up = 0}
	SWEP.Shell2WorldAngleAlign = {Forward = 0, Right = -90, Up = 0}
	
	SWEP.AttachmentModelsVM = {
		["cover_long"] = {model = "models/weapons/upgrades/a_standard_m16a1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_mag_m1a1_15"] = {model = "models/weapons/upgrades/a_magazine_m16_20.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/a_magazine_m16_30.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/a_suppressor_m16.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/a_bipod_m16a1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_gl_m203"] = {model = "models/weapons/upgrades/a_m16a1_m203.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_sling"] = {model = "models/weapons/upgrades/a_m16a1_sling.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_nam_colt"] = {model = "models/weapons/upgrades/a_optics_m16a1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["cover_long"] = {model = "models/weapons/upgrades/w_standard_m16a1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_mag_m1a1_15"] = {model = "models/weapons/upgrades/w_magazine_m16_20.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/w_magazine_m16_30.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/w_suppressor_m16.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/w_bipod_m16a1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_gl_m203"] = {model = "models/weapons/upgrades/w_m16a1_m203.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_nam_colt"] = {model = "models/weapons/upgrades/w_optics_m16a1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-1.0637, -2, -0.0176)
	SWEP.IronsightAng = Vector(-0.0534, 0.0072, 0)

	SWEP.M203Pos = Vector(-1.5805, -5, -0.4545)
	SWEP.M203Ang = Vector(-0.0041, -1.7264, -2.205)

	SWEP.KKINS2NAMColtPos = Vector(-1.0662, -2, -0.6937)
	SWEP.KKINS2NAMColtAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.013
end

SWEP.MuzzleEffect = "muzzleflash_m16_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_m16_3rd"

SWEP.Attachments = {
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_scope_nam_colt"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_suppressor_sec", "kk_ins2_hoovy"}},
	{header = "Under", offset = {-500, 0}, atts = {"kk_ins2_bipod", "kk_ins2_gl_m203"}},
	{header = "Stock", offset = {600, 0}, atts = {"kk_ins2_ww2_sling"}},
	{header = "Magazine", offset = {-200, 600}, atts = {"kk_ins2_mag_m1a1_30"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire","iron_fire_a","iron_fire_b","iron_fire_c","iron_fire_d","iron_fire_e","iron_fire_f"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = {"base_reloadempty", "base_reloadempty2", "base_reloadempty3"},
	base_reload_mm = "base_reload_extended",
	base_reload_empty_mm = "base_reloadempty_extended",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",
	
	gl_off_pickup = "gl_ready",
	gl_off_draw = "gl_draw",
	gl_off_fire = "gl_fire",
	gl_off_fire_aim = {"gl_iron_fire","gl_iron_fire_a","gl_iron_fire_b","gl_iron_fire_c","gl_iron_fire_d","gl_iron_fire_e","gl_iron_fire_f"},
	gl_off_fire_empty = "gl_dryfire",
	gl_off_fire_empty_aim = "gl_iron_dryfire",
	gl_off_reload = "gl_reload",
	gl_off_reload_empty = "gl_reloadempty",
	gl_off_reload_mm = "gl_reload",
	gl_off_reload_empty_mm = "gl_reloadempty",
	gl_off_idle = "gl_holster",
	gl_off_holster = "gl_holster",
	gl_off_firemode = "gl_fireselect",
	gl_off_firemode_aim = "gl_iron_fireselect",
	gl_off_sprint = "gl_sprint",
	gl_off_safe = "gl_down",
	gl_off_safe_aim = "gl_iron_down",
	gl_off_crawl = "gl_crawl",
	
	gl_on_draw = "glsetup_draw",
	gl_on_fire = "glsetup_fire",
	gl_on_fire_aim = "glsetup_iron_fire",
	gl_on_fire_empty = "glsetup_dryfire",
	gl_on_fire_empty_aim = "glsetup_iron_dryfire",
	gl_on_reload = "glsetup_reload",
	gl_on_idle = "glsetup",
	gl_on_holster = "glsetup_holster",
	gl_on_sprint = "glsetup_sprint",
	gl_on_safe = "glsetup_down",
	gl_on_safe_aim = "glsetup_iron_down",
	gl_on_crawl = "glsetup_crawl",
	
	gl_turn_on = "glsetup_in",
	gl_turn_off = "glsetup_out",
	
	bipod_fire = "deployed_fire",
	bipod_fire_aim = "deployed_iron_fire",
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload_half",
	bipod_reload_empty = {"deployed_reload_empty", "deployed_reload_empty2"},
	bipod_reload_mm = "deployed_reload_half",
	bipod_reload_empty_mm = {"deployed_reload_empty", "deployed_reload_empty2"},
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_aim = "deployed_iron_fireselect",
	
	bipod_in = "deployed_in",
	bipod_idle = "deployed_idle",
	bipod_out = "deployed_out",
	
	menu = "menu",
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 B2K"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_nam_m16a1.mdl"
SWEP.WorldModel		= "models/weapons/w_nam_m16a1.mdl"

SWEP.WMPos = Vector(5.219, 0.554, -0.893)
SWEP.WMAng = Vector(-10, -1, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted3(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted3(SWEP)

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 60/700
SWEP.FireSound = "CW_KK_INS2_NAM_M16A1_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M16A4_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1025

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.0027
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 39

SWEP.FirstDeployTime = 3.3
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.7

SWEP.WeaponLength = 24

SWEP.SightBGs = {main = 0, foldsight = 0}

SWEP.MuzzleVelocity = 948

SWEP.ReloadTimes = {
	base_reload = {4, 4.8},
	base_reloadempty = {4, 5.65},
	base_reloadempty2 = {4, 5.65},
	base_reloadempty3 = {4, 5.65},
	
	base_reload_extended = {4, 4.8},
	base_reloadempty_extended = {4, 5.65},
	
	gl_reload = {4, 4.8},
	gl_reloadempty = {4, 5.65},
	
	glsetup_reload = {2.9, 4},
	
	glsetup_in = {1.7, 1.7},
	glsetup_out = {1.2, 1.2},
	
	deployed_reload_half = {3.3, 4},
	deployed_reload_empty = {3.3, 5},
	deployed_reload_empty2 = {3.3, 5},
}

if CLIENT then 
	function SWEP:updateStandardParts()
		self:setElementActive("cover_long", !self.ActiveAttachments.kk_ins2_gl_m203)
		self:setElementActive("kk_ins2_mag_m1a1_15", !self.ActiveAttachments.kk_ins2_mag_m1a1_30)
	end
end
