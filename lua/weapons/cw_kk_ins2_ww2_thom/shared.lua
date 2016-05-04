if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1928A1 Thompson"
	
	SWEP.IconLetter = "q"
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.Shell = "KK_INS2_45apc"

	SWEP.AttachmentModelsVM = {
		["handguard"] = {model = "models/weapons/upgrades/a_thompson_standard.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), merge = true, active = true},
		["kk_ins2_mag_thom_20"] = {model = "models/weapons/upgrades/a_thompson_mag_20.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_mag_thom_30"] = {model = "models/weapons/upgrades/a_thompson_mag_30.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_mag_thom_50"] = {model = "models/weapons/upgrades/a_thompson_mag_50.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_thompson_foregrip.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["handguard"] = {model = "models/weapons/upgrades/w_thompson_standard.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_thom_20"] = {model = "models/weapons/upgrades/w_thompson_mag_20.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_mag_thom_30"] = {model = "models/weapons/upgrades/w_thompson_mag_30.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_mag_thom_50"] = {model = "models/weapons/upgrades/w_thompson_mag_50.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_thompson_foregrip.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.IronsightPos = Vector(-2.2377, -2, 1.0456)
	SWEP.IronsightAng = Vector(0.1611, 0.0052, 0)

end

SWEP.WeaponLength = 16

SWEP.Attachments = {
	-- {header = "Sight", offset = {500, -500}, atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint"}},
	-- {header = "Barrel", offset = {-200, -500}, atts = {"md_saker"}},
	{header = "Under", offset = {-500, 0}, atts = {"kk_ins2_vertgrip"}},
	-- {header = "Extras", offset = {125, 100}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "MagZ", offset = {-50, 500}, atts = {"kk_ins2_mag_thom_30", "kk_ins2_mag_thom_50"}},
	-- {header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Chamberable = false
SWEP.KKINS_emptyIdle = true

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire = {"base_fire_1", "base_fire_2"},
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3"},
	base_fire_last = "base_fire_last",
	base_fire_last_aim = "iron_fire_last",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_reload_mm = "base_reload_drum",
	base_reload_empty_mm = "base_reloadempty_drum",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_firemode = "base_fireselect",
	base_firemode_empty = "base_fireselect_empty",
	base_firemode_aim = "iron_fireselect",
	base_firemode_empty_aim = "iron_fireselect_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_safe_empty = "base_down_empty",
	base_safe_empty_aim = "iron_down_empty",
	
	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_draw_empty = "foregrip_draw_empty",
	foregrip_fire = {"foregrip_fire_1", "foregrip_fire_2"},
	foregrip_fire_aim = {"foregrip_iron_fire_1","foregrip_iron_fire_2","foregrip_iron_fire_3"},
	foregrip_fire_last = "foregrip_fire_last",
	foregrip_fire_last_aim = "foregrip_iron_fire_last",
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_reload_mm = "foregrip_reload_drum",
	foregrip_reload_empty_mm = "foregrip_reloadempty_drum",
	foregrip_idle = "foregrip_draw",
	foregrip_idle_empty = "foregrip_draw_empty",
	foregrip_holster = "foregrip_holster",
	foregrip_holster_empty = "foregrip_holster_empty",
	foregrip_firemode = "foregrip_fireselect",
	foregrip_firemode_empty = "foregrip_fireselect_empty",
	foregrip_firemode_aim = "foregrip_iron_fireselect",
	foregrip_firemode_empty_aim = "foregrip_iron_fireselect_empty",
	foregrip_sprint = "foregrip_sprint",
	foregrip_sprint_empty = "foregrip_sprint_empty",
	foregrip_safe = "foregrip_down",
	foregrip_safe_empty = "foregrip_down_empty",
	foregrip_safe_aim = "foregrip_iron_down",
	foregrip_safe_empty_aim = "foregrip_iron_down_empty",
}

SWEP.ReloadTimes = {
	base_reload = {2.1,2.92},
	base_reloadempty = {2.1,4.1},
	base_reload_drum = {4.3,5.48},
	base_reloadempty_drum = {4.6,6.92},
	foregrip_reload = {2.1,2.92},
	foregrip_reloadempty = {2.1,4.1},
	foregrip_reload_drum = {4.3,5.48},
	foregrip_reloadempty_drum = {4.6,6.92},
}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_thompson.mdl"
SWEP.WorldModel		= "models/weapons/w_thompson.mdl"

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2us

SWEP.WMPos = Vector(0.699, 0.395, 0.862)
SWEP.WMAng = Vector(-4.99, 3.065, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.085
SWEP.FireSound = "CW_KK_INS2_WW2_THOMPSON_FIRE"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.7
SWEP.MaxSpreadInc = 0.035
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 23

SWEP.FirstDeployTime = 1.9
SWEP.DeployTime = 0.71

SWEP.ReloadTime = 2
SWEP.ReloadHalt = 2.92
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt_Empty = 4.1

if CLIENT then 
	function SWEP:updateOtherParts()
		local active = self.ActiveAttachments
		local vms = self.AttachmentModelsVM
		
		vms.handguard.active = !(active.kk_ins2_vertgrip)
		vms.kk_ins2_mag_thom_20.active = !(active.kk_ins2_mag_thom_30 or active.kk_ins2_mag_thom_50)
	end
end
