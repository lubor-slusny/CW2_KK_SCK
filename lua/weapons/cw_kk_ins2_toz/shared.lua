AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m3"

	SWEP.Shell = "KK_INS2_12guage"
	SWEP.ShellDelay = 13/30
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_02.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_12ga.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_ins2.mdl", pos = Vector(0,0,0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_ins_shotgun.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_ins_shotgun.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(90, 90, 0), size = Vector(1, 1, 1), attachment = "Optic", adjustment = {min = -2, max = 0.5, axis = "z", inverseOffsetCalc  = true}},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_4.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_INS_foregrip.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.008, -2, 0.9)
	SWEP.IronsightAng = Vector(0, 0.04, 0)
	
	SWEP.KKINS2CSTMBarskaPos = Vector(-2.008, -2, -0.17)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)
	
	SWEP.KKINS2AimpointPos = Vector(-2.008, -2, -0.17)
	SWEP.KKINS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.KKINS2MagnifierPos = Vector(-2.008, -1, -0.17)
	SWEP.KKINS2MagnifierAng = Vector(-0.35, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.015
end

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = 0.8

SWEP.Attachments = {
	{header = "Sight", offset = {500, -450},  atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint"}},
	{header = "Barrel", offset = {-200, -450},  atts = {"md_saker"}},
	{header = "Under", offset = {-500, 0},  atts = {"kk_ins2_vertgrip"}},
	{header = "Extras", offset = {125, 200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_slugrounds", "am_flechetterounds"}}
}

SWEP.Animations = {
	draw = "base_ready",
	reload_start = "",
	insert = "",
	reload_end = "",
	idle = "",	
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_bolt = "base_fire_cock",
	base_bolt_aim = "iron_fire_cock",
	base_reload_start_empty = "base_reload_start_empty",
	base_reload_start = "base_reload_start",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_fire = "foregrip_fire",
	foregrip_fire_aim = "foregrip_iron_fire",
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_bolt = "foregrip_fire_cock",
	foregrip_bolt_aim = "foregrip_iron_fire_cock",
	foregrip_reload_start_empty = "foregrip_reload_start_empty",
	foregrip_reload_start = "foregrip_reload_start",
	foregrip_insert = "foregrip_reload_insert",
	foregrip_reload_end = "foregrip_reload_end",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
}
	
SWEP.Sounds = {
	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 26/30, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		{time = 36/30, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
	},

	base_crawl = {
		{time = 15/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 38/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},

	},

	base_fire_cock = {
		// shell @ 2 ""},
		{time = 1/24, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		{time = 5/24, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
		// pumpedrdy @ 6 ""},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_TOZ_EMPTY"},
	},

	base_reload_start = {
		{time = 5/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_reload_start_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 18/35, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		// shell @ 20 ""},
		{time = 51/35, sound = "CW_KK_INS2_TOZ_SHELLINSERT"},
		{time = 76/35, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
		// reloaded @ 78 ""},
	},

	base_reload_insert = {
		{time = 5/36, sound = "CW_KK_INS2_TOZ_SHELLINSERT"},
		// reloaded @ 15 ""},
	},

	base_reload_end = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_reload_end_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	iron_fire_cock = {
		// shell @ 4 ""},
		{time = 3/35, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		{time = 11/35, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
		// pumpedrdy @ 12 ""},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_TOZ_EMPTY"},
	},

	foregrip_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 26/30, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		{time = 36/30, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
	},

	foregrip_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	foregrip_fire_cock = {
		// shell @ 2 ""},
		{time = 1/24, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		{time = 5/24, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
		// pumpedrdy @ 6 ""},
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_TOZ_EMPTY"},
	},

	foregrip_reload_start = {
		{time = 5/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_reload_start_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 18/35, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		// shell @ 20 ""},
		{time = 51/35, sound = "CW_KK_INS2_TOZ_SHELLINSERT"},
		{time = 76/35, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
		// reloaded @ 78 ""},
	},

	foregrip_reload_insert = {
		{time = 5/36, sound = "CW_KK_INS2_TOZ_SHELLINSERT"},
		// reloaded @ 15 ""},
	},

	foregrip_reload_end = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_reload_end_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_iron_fire_cock = {
		// shell @ 3 ""},
		{time = 3/35, sound = "CW_KK_INS2_TOZ_PUMPBACK"},
		{time = 11/35, sound = "CW_KK_INS2_TOZ_PUMPFORWARD"},
		// pumpedrdy @ 12 ""},
	},

	foregrip_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_TOZ_EMPTY"},
	},
}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_toz.mdl"
SWEP.WorldModel		= "models/weapons/w_toz.mdl"

SWEP.WMPos = Vector(5.314, 0.759, -2.971)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.95
SWEP.FireSound = "CW_KK_INS2_TOZ_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_TOZ_FIRE_SUPPRESSED"
SWEP.Recoil = 3

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.013
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 10

SWEP.FirstDeployTime = 2.1
SWEP.DeployTime = 0.71

SWEP.base_ReloadStartTime = 0.5
SWEP.base_InsertShellTime = 0.72
SWEP.base_ReloadFinishWait = 0.6

function SWEP:updateReloadTimes()
	local mode = self:getForegripMode()

	if self:Clip1() == 0 then
		self.Animations.reload_start = self.Animations[mode .. "reload_start_empty"]
		self.Animations.insert = nil
		self.ReloadStartTime = 2.2
	else
		self.Animations.reload_start = self.Animations[mode .. "reload_start"]
		self.Animations.insert = self.Animations[mode .. "insert"]
		if self.base_ReloadStartTime then
			self.ReloadStartTime = self[mode .. "ReloadStartTime"] or self.base_ReloadStartTime
		end
	end
	
	self.Animations.reload_end = self.Animations[mode .. "reload_end"]
	self.Animations.idle = self.Animations[mode .. "reload_end"]
	
	if self.base_InsertShellTime then
		self.InsertShellTime = self[mode .. "InsertShellTime"] or self.base_InsertShellTime
	end
	if self.base_ReloadFinishWait then
		self.ReloadFinishWait = self[mode .. "ReloadFinishWait"] or self.base_ReloadFinishWait
	end
end

function SWEP:fireAnimFunc()
	local clip = self:Clip1()
	local mag = ""
	
	if clip == 0 then
		mag = "_empty"
	end
	
	local prefix = self:getForegripMode()
	local suffix = ""
	
	if self:isAiming() then
		suffix = "_aim"
	end
	
	if clip > 0 then
		CustomizableWeaponry.actionSequence.new(self, 0.28, nil, function() 
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