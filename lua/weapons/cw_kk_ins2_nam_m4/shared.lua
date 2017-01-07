if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M607"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_nam_m607")
	
	SWEP.Shell = "KK_INS2_556x45"
	SWEP.ShellDelay = 0.06
	
	SWEP.BackupSights = {
		["kk_ins2_elcan"] = {
			Vector(-2.5337, 0, -0.6528), 
			Vector(-0.4573, 0, 0)
		}
	}
	
	SWEP.AttachmentModelsVM = {
		["std_mag"] = {model = "models/weapons/upgrades/a_magazine_m607_20.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true}, 
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/a_magazine_m607_30.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true}, 
		
		["kk_ins2_suppressor_ins"] = {model = "models/weapons/upgrades/a_suppressor_ins.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_ins.mdl", pos = Vector(), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
	}

	SWEP.AttachmentModelsWM = {
		["std_mag"] = {model = "models/weapons/upgrades/w_magazine_m607_20.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/w_magazine_m607_30.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_suppressor_ins"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_ins_foregrip.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.4916, -3, 0.629)
	SWEP.IronsightAng = Vector(-0.223, 0.0476, 0)

	SWEP.CustomizationMenuScale = 0.014
end

SWEP.MuzzleEffect = "muzzleflash_m16_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_m16_3rd"

SWEP.Attachments = {
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_suppressor_ins"}},
	{header = "Under", offset = {-500, 0}, atts = {"kk_ins2_vertgrip"}},
	{header = "Magazine", offset = {-50, 500}, atts = {"kk_ins2_mag_m1a1_30"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready", 
	base_draw = "base_draw", 
	base_fire = "base_fire", 
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire", 
	base_fire_empty_aim = "iron_dryfire", 
	base_reload = "base_reload", 
	base_reload_empty = "base_reloadempty",
	base_reload_mm = "base_reload_ext", 
	base_reload_empty_mm = "base_reloadempty_ext",
	base_idle = "base_idle", 
	base_holster = "base_holster", 
	base_sprint = "base_sprint", 
	base_safe = "base_down", 
	base_safe_aim = "iron_down", 
	base_crawl = "base_crawl", 
	
	foregrip_pickup = "foregrip_ready", 
	foregrip_draw = "foregrip_draw", 
	foregrip_fire = "foregrip_fire", 
	foregrip_fire_aim = "foregrip_iron_fire",
	foregrip_fire_empty = "foregrip_dryfire", 
	foregrip_fire_empty_aim = "foregrip_iron_dryfire", 
	foregrip_reload = "foregrip_reload", 
	foregrip_reload_empty = "foregrip_reloadempty", 
	foregrip_reload_mm = "foregrip_reload_ext", 
	foregrip_reload_empty_mm = "foregrip_reloadempty_ext", 
	foregrip_idle = "foregrip_holster", 
	foregrip_holster = "foregrip_holster", 
	foregrip_sprint = "foregrip_sprint", 
	foregrip_safe = "foregrip_down", 
	foregrip_safe_aim = "foregrip_iron_down", 
	foregrip_crawl = "foregrip_crawl", 
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 B2K"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_nam_m607.mdl"
SWEP.WorldModel		= "models/weapons/w_nam_m607.mdl"

SWEP.WMPos = Vector(5.018, 0.711, -0.743)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted3(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted3(SWEP)

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.066666666666667
SWEP.FireSound = "CW_KK_INS2_NAM_M4_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_MK18_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1025

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 39

SWEP.FirstDeployTime = 1.5
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.6

SWEP.WeaponLength = 20

SWEP.MuzzleVelocity = 808

SWEP.ReloadTimes = {
	base_reload = {2.3, 3},
	base_reloadempty = {2.9, 4.6},
	base_reload_ext = {2.3, 3},
	base_reloadempty_ext = {2.9, 4.6},
	
	foregrip_reload = {2.3, 3},
	foregrip_reloadempty = {2.9, 4.6},
	foregrip_reload_ext = {2.3, 3},
	foregrip_reloadempty_ext = {2.9, 4.6},
}

if CLIENT then
	function SWEP:updateStandardParts()
		self:setElementActive("std_mag", !self.ActiveAttachments.kk_ins2_mag_m1a1_30)
	end
end