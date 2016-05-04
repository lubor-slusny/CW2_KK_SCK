AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1919A6 Browning"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.Shell = "KK_INS2_762x54"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_06.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_ak.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_6.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.IronsightPos = Vector(-2.9734, -2, 1.4944)
	SWEP.IronsightAng = Vector(0.2271, -0.0204, 0)

	SWEP.KKINS_implicitBipod = true
	SWEP.CustomizationMenuScale = 0.018
end

SWEP.Chamberable = false
SWEP.BipodInstalled = true

SWEP.Attachments = {
	["+reload"] = {header = "Ammo", offset = {900, 300}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready", // coz drawanimfunc doesnt play always
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire_1", "base_fire_2"},
	base_fire_aim = {"iron_fire_1","iron_fire_2"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reload_empty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	bipod_in = "deployed_in",
	bipod_fire = {"deployed_fire_1","deployed_fire_2"},
	bipod_fire_aim = {"deployed_iron_fire_1","deployed_iron_fire_2"},
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_empty = "deployed_reload_empty",
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_aim = "deployed_fireselect",
	bipod_out = "deployed_out",
}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 14/28, sound = "CW_KK_INS2_RPK_FIRESELECT"},
		{time = 29/28, sound = "CW_KK_INS2_RPK_BOLTBACK"},
		{time = 41/28, sound = "CW_KK_INS2_RPK_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 15/30, sound = "CW_KK_INS2_UNIVERSAL_RightCrawl"},
		{time = 38/30, sound = "CW_KK_INS2_UNIVERSAL_LeftCrawl"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_RPK_EMPTY"},
	},

	base_fireselect = {
		{time = 17/30, sound = "CW_KK_INS2_RPK_FIRESELECT"},
	},

	base_reload = {
		{time = 20/30, sound = "CW_KK_INS2_RPK_MAGRELEASE"},
		{time = 23/30, sound = "CW_KK_INS2_RPK_MAGOUT"},
		{time = 35/30, sound = "CW_KK_INS2_RPK_MAGOUTRATTLE"},
		{time = 50/30, sound = "CW_KK_INS2_RPK_FETCHMAG"},
		{time = 97/30, sound = "CW_KK_INS2_RPK_MAGIN"},
		{time = 122/30, sound = "CW_KK_INS2_RPK_RATTLE"},
	},

	base_reloadempty = {
		{time = 20/30, sound = "CW_KK_INS2_RPK_MAGRELEASE"},
		{time = 23/30, sound = "CW_KK_INS2_RPK_MAGOUT"},
		{time = 35/30, sound = "CW_KK_INS2_RPK_MAGOUTRATTLE"},
		{time = 50/30, sound = "CW_KK_INS2_RPK_FETCHMAG"},
		{time = 97/30, sound = "CW_KK_INS2_RPK_MAGIN"},
		{time = 122/30, sound = "CW_KK_INS2_RPK_RATTLE"},
		{time = 146/30, sound = "CW_KK_INS2_RPK_BOLTBACK"},
		{time = 153/30, sound = "CW_KK_INS2_RPK_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_RPK_EMPTY"},
	},

	iron_fireselect = {
		{time = 17/30, sound = "CW_KK_INS2_RPK_FIRESELECT"},
	},

	deployed_in = {
		{time = 16/30, sound = "CW_KK_INS2_RPK_BIPODDEPLOY"},
	},

	deployed_out = {
		{time = 13/30, sound = "CW_KK_INS2_RPK_MAGOUTRATTLE"},
		{time = 20/30, sound = "CW_KK_INS2_RPK_BIPODRETRACT"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_RPK_EMPTY"},
	},

	deployed_fireselect = {
		{time = 17/30, sound = "CW_KK_INS2_RPK_FIRESELECT"},
	},

	deployed_reload = {
		{time = 16/30, sound = "CW_KK_INS2_RPK_MAGRELEASE"},
		{time = 35/30, sound = "CW_KK_INS2_RPK_MAGOUT"},
		{time = 44/30, sound = "CW_KK_INS2_RPK_MAGOUTRATTLE"},
		{time = 80/30, sound = "CW_KK_INS2_RPK_FETCHMAG"},
		{time = 111/30, sound = "CW_KK_INS2_RPK_MAGIN"},
		{time = 130/30, sound = "CW_KK_INS2_RPK_ENDDEPLOYEDRELOAD"},
	},

	deployed_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_RPK_MAGRELEASE"},
		{time = 35/30, sound = "CW_KK_INS2_RPK_MAGOUT"},
		{time = 44/30, sound = "CW_KK_INS2_RPK_MAGOUTRATTLE"},
		{time = 80/30, sound = "CW_KK_INS2_RPK_FETCHMAG"},
		{time = 111/30, sound = "CW_KK_INS2_RPK_MAGIN"},
		{time = 150/30, sound = "CW_KK_INS2_RPK_BOLTBACK"},
		{time = 157/30, sound = "CW_KK_INS2_RPK_BOLTRELEASE"},
		{time = 168/30, sound = "CW_KK_INS2_RPK_ENDDEPLOYEDRELOAD"},
	},

	deployed_iron_idle = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_IronIdle"},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_RPK_EMPTY"},
	},

	deployed_iron_fireselect = {
		{time = 17/30, sound = "CW_KK_INS2_RPK_FIRESELECT"},
	},
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_m1919.mdl"
SWEP.WorldModel		= "models/weapons/w_m1919.mdl"

SWEP.WMPos = Vector(5.627, 0.66, -1.397)
SWEP.WMAng = Angle(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 18
SWEP.Primary.DefaultClip	= 18
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.92x57MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_WW2_BROWNING_FIRE"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 33

SWEP.FirstDeployTime = 3.13
SWEP.DeployTime = 0.94

SWEP.BipodDeployTime = 1.5
SWEP.BipodUndeployTime = 1.9

SWEP.ReloadTime = 0
SWEP.ReloadTime_Empty = 0
SWEP.ReloadHalt = 0
SWEP.ReloadHalt_Empty = 0

SWEP.base_ReloadTime = 3.4
SWEP.base_ReloadTime_Empty = 3.4
SWEP.base_ReloadHalt = 4.5
SWEP.base_ReloadHalt_Empty = 6

SWEP.bipod_ReloadTime = 116/30
SWEP.bipod_ReloadTime_Empty = 116/30
SWEP.bipod_ReloadHalt = 4.8
SWEP.bipod_ReloadHalt_Empty = 6

if CLIENT then
	function SWEP:updateOtherParts()
		local hasInstalledScope = self:getActiveAttachmentInCategory(1) != nil
		local isBipod = self.ActiveAttachments.kk_ins2_rpk_sopmod
		local vm = self.CW_VM
		local cycle = vm:GetCycle()
		
		local clip = self:Clip1()
		local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo) + clip
		
		if self.Sequence:find("reload") and cycle > 0.3 then
			self:setBodygroup(1,math.Clamp(ammo,0,18))
		else
			self:setBodygroup(1,math.Clamp(clip,0,18))
		end
		
		if self.dt.BipodDeployed then
			self.WMEnt:SetSequence(1)
			self:SetSequence(1)
		else
			self.WMEnt:SetSequence(0)
			self:SetSequence(0)
		end
	end
end