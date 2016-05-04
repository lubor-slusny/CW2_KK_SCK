if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

util.PrecacheModel("models/weapons/v_cw_kk_ins2_rpk_tac.mdl")
util.PrecacheModel("models/weapons/w_cw_kk_ins2_rpk_tac.mdl")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RPK"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.Shell = "KK_INS2_762x39"
	
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

	SWEP.IronsightPos_def = Vector(-2.3, -2, 0.13)
	SWEP.IronsightAng_def = Vector(0.95, 0.05, 0)
	
	SWEP.KKINS2CSTMBarskaPos_def = Vector(-2.3, -2, -0.4)
	SWEP.KKINS2CSTMBarskaAng_def = Vector(0, 0, 0)
	
	SWEP.KKINS2AimpointPos_def = Vector(-2.3, -2, -0.4)
	SWEP.KKINS2AimpointAng_def = Vector(0, 0, 0)
	
	SWEP.KKINS2MagnifierPos_def = Vector(-2.3, -2, -0.4)
	SWEP.KKINS2MagnifierAng_def = Vector(-1, 0.1, 0)
	
	// coz why nut
	SWEP.KKINS2CSTMBarskaPos_sopmod = Vector(-2.3112, -2, -0.3098)
	SWEP.KKINS2CSTMBarskaAng_sopmod = Vector(0, 0, 0)

	SWEP.IronsightPos_sopmod = Vector(-2.3118, -2, 0.4771)
	SWEP.IronsightAng_sopmod = Vector(0.7678, 0.05, 0)

	SWEP.KKINS2AimpointPos_sopmod = Vector(-2.3086, -2, -0.2996)
	SWEP.KKINS2AimpointAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos_sopmod = Vector(-2.2933, -8, -0.1859)
	SWEP.KKINS2MagnifierAng_sopmod = Vector(-1, 0.1, 0)

	// sth
	SWEP.IronsightPos = SWEP.IronsightPos_def
	SWEP.IronsightAng = SWEP.IronsightAng_def
	
	SWEP.KKINS2CSTMBarskaPos = SWEP.KKINS2CSTMBarskaPos_def
	SWEP.KKINS2CSTMBarskaAng = SWEP.KKINS2CSTMBarskaAng_def
	
	SWEP.KKINS2AimpointPos = SWEP.KKINS2AimpointPos_def
	SWEP.KKINS2AimpointAng = SWEP.KKINS2AimpointAng_def
	
	SWEP.KKINS2MagnifierPos = SWEP.KKINS2MagnifierPos_def
	SWEP.KKINS2MagnifierAng = SWEP.KKINS2MagnifierAng_def
	
	SWEP.KKINS_implicitBipod = true
	SWEP.CustomizationMenuScale = 0.018
end

SWEP.BipodInstalled = true

SWEP.Attachments = {
	{header = "Sight", offset = {600, -500},  atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint"}},
	{header = "Barrel", offset = {0, -500},  atts = {"md_saker"}},
	{header = "Package", offset = {-400, 100}, atts = {"kk_ins2_rpk_sopmod"}},
	{header = "Extras", offset = {200, 100}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "More Sight", offset = {1200, -100}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 300}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready", // coz drawanimfunc doesnt play always
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3","iron_fire_4"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	bipod_in = "deployed_in",
	bipod_fire = "deployed_fire",
	bipod_fire_aim = {"deployed_iron_fire_1","deployed_iron_fire_2"},
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_empty = "deployed_reloadempty",
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
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_rpk.mdl"
SWEP.WorldModel		= "models/weapons/w_rpk.mdl"

SWEP.WMPos = Vector(5.627, 0.66, -1.397)
SWEP.WMAng = Angle(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 75
SWEP.Primary.DefaultClip	= 75
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_KK_INS2_RPK_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_RPK_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 33

SWEP.FirstDeployTime = 2.1
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
		
		//packg aimpos switch
		if self.ActiveAttachments.kk_ins2_magnifier then
			local name = "KKINS2Magnifier"
			if isBipod then
				self[name .. "Pos"] = self[name .. "Pos_sopmod"]
				self[name .. "Ang"] = self[name .. "Ang_sopmod"]
			else
				self[name .. "Pos"] = self[name .. "Pos_def"]
				self[name .. "Ang"] = self[name .. "Ang_def"]
			end
			self.AimPos = self[name .. "Pos"]
			self.AimAng = self[name .. "Ang"]
		elseif hasInstalledScope then
			local sight = CustomizableWeaponry.sights[self:getActiveAttachmentInCategory(1)]
			if isBipod then
				self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_sopmod"]
				self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_sopmod"]
			else
				self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_def"]
				self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_def"]
			end
			self.AimPos = self[sight.aimPos[1]]
			self.AimAng = self[sight.aimPos[2]]
		else
			if isBipod then
				self.IronsightPos = self.IronsightPos_sopmod
				self.IronsightAng = self.IronsightAng_sopmod
			else
				self.IronsightPos = self.IronsightPos_def
				self.IronsightAng = self.IronsightAng_def
			end
			self.AimPos = self.IronsightPos
			self.AimAng = self.IronsightAng
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