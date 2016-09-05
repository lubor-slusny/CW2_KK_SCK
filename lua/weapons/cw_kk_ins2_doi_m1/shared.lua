if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1 Carbine"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "KK_INS2_762x33"
	SWEP.ShellDelay = 0.06
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_iron_m1a1_s.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_iron_m1a1_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_mag_m1a1_15"] = {model = "models/weapons/upgrades/a_magazine_m1a1_15.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/a_magazine_m1a1_30.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_m1a1_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {		
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/w_iron_m1a1_s.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_iron_m1a1_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_mag_m1a1_15"] = {model = "models/weapons/upgrades/w_magazine_m1a1_15.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_m1a1_30"] = {model = "models/weapons/upgrades/w_magazine_m1a1_30.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_bayonet_m1a1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.4773, -3, 1.2686)
	SWEP.IronsightAng = Vector(0, 0.0355, 0)

	SWEP.FoldSightPos = Vector(-2.4838, -3, 1.1628)
	SWEP.FoldSightAng = Vector(0.2625, 0.0079, 0)

	SWEP.CustomizationMenuScale = 0.016
end

SWEP.Attachments = {
	{header = "Sight", offset = {400, -500}, atts = {"bg_foldsight"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	{header = "Magazine", offset = {-200, 600}, atts = {"kk_ins2_mag_m1a1_30"}},
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire_1", "iron_fire_2", "iron_fire_3"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_mm = "base_reload_ext",
	base_reload_empty = "base_reloadempty",
	base_reload_empty_mm = "base_reloadempty_ext",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	base_melee = "base_melee",
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cw_kk_doi_m1.mdl"
SWEP.WorldModel		= "models/weapons/w_cw_kk_doi_m1.mdl"

SWEP.WMPos = Vector(5.986, 0.921, -0.038)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2us
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".30 Carbine"

SWEP.FireDelay = 60/600
SWEP.FireSound = "CW_KK_INS2_DOI_M1_FIRE"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 41

SWEP.FirstDeployTime = 1.5
SWEP.DeployTime = 0.5

SWEP.RecoilToSpread = 0.8 

SWEP.ReloadSpeed = 1
SWEP.base_ReloadTime = 2.25
SWEP.base_ReloadTime_Empty = 2.25
SWEP.base_ReloadHalt = 3.05
SWEP.base_ReloadHalt_Empty = 4.55

SWEP.SnapToIdlePostReload = false

SWEP.SightBGs = {main = 0, foldsight = 0}

SWEP.WeaponLength = 20

SWEP.MuzzleVelocity = 607

if CLIENT then 
	function SWEP:updateStandardParts()
		local v = !self.ActiveAttachments.kk_ins2_mag_m1a1_30
		
		self.AttachmentModelsVM.kk_ins2_mag_m1a1_15.active = v
		self:setWElementActive("kk_ins2_mag_m1a1_15", v)
	end
end
