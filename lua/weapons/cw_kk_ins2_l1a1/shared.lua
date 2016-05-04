if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

util.PrecacheModel("models/weapons/v_l1a1.mdl")
util.PrecacheModel("models/weapons/w_l1a1.mdl")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "L1A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "KK_INS2_762x51"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_standard_l1a1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_l1a1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_mag_l1a1_20"] = {model = "models/weapons/upgrades/a_magazine_l1a1_20.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_fal_30"] = {model = "models/weapons/upgrades/a_magazine_fal_l1a1_30.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["md_saker"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), attachment = "muzzle_supp"},

		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/a_bipod_fal.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},		
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 1.2},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/a_optic_mosin_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
		
				
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},		
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/w_bipod_m40.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_ins_foregrip.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/w_scope_mosin.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.485, -2, 0.4526)
	SWEP.IronsightAng = Vector(0.6052, 0, 0)

	SWEP.KKINS2AimpointPos = Vector(-2.47, -2, -0.25)
	SWEP.KKINS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.KKINS2MagnifierPos = Vector(-2.47, -2, -0.2819)
	SWEP.KKINS2MagnifierAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.47, -2, -0.2842)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)

	SWEP.KKINS2EoTechPos = Vector(-2.4707, -2, -0.2911)
	SWEP.KKINS2EoTechAng = Vector(0, 0, 0)

	SWEP.KKINS2ElcanPos = Vector(-2.4738, -2, -0.3768)
	SWEP.KKINS2ElcanAng = Vector(0, 0, 0)

	SWEP.KKINS2KobraPos = Vector(-2.4696, -2, -0.1385)
	SWEP.KKINS2KobraAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMACOGPos = Vector(-2.4729, -1, -0.6027)
	SWEP.KKINS2CSTMACOGAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.4788, -2, -0.2754)
	SWEP.KKINS2CSTMMicroT1Ang = Vector(0, 0, 0)

	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.4749, -2, -0.2717)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.4683, -2, -0.2642)
	SWEP.KKINS2CSTMCompM4SAng = Vector(0, 0, 0)

	// sth sth sth theater fk this
	
	SWEP.KKINS2PO4Pos = Vector(-2.4123, -2, -0.177)
	SWEP.KKINS2PO4Ang = Vector(0, 0, 0)

	SWEP.KKINS2ScopeMosinPos = Vector(-2.4489, -1, -0.1553)
	SWEP.KKINS2ScopeMosinAng = Vector(0, 0, 0)

	SWEP.KKINS2KobraPos = Vector(-2.4696, -2, -0.3519)
	SWEP.KKINS2KobraAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.02
end

SWEP.WeaponLength = 28

SWEP.Attachments = {
	-- {header = "Sight", offset = {200, -500}, atts = {"kk_ins2_kobra", "kk_ins2_cstm_microt1", "kk_ins2_cstm_barska", "kk_ins2_cstm_eotechxps", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_cstm_compm4s", "kk_ins2_elcan", "kk_ins2_cstm_acog"}},
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4", "kk_ins2_scope_mosin"}},
	{header = "Barrel", offset = {-300, -500}, atts = {"kk_ins2_suppressor_sec"}},
	{header = "Under", offset = {-500, -50}, atts = {"kk_ins2_bipod", "kk_ins2_vertgrip"}},
	{header = "Extras", offset = {100, 0}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "MagZ", offset = {-50, 500}, atts = {"kk_ins2_mag_fal_30"}},
	{header = "More Sight", offset = {1000, -25}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {800, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire","iron_fire_a","iron_fire_b","iron_fire_c","iron_fire_d","iron_fire_e","iron_fire_f"},
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
	
	foregrip_pickup = "foregrip_ready",
	foregrip_draw = "foregrip_draw",
	foregrip_fire = "foregrip_fire",
	foregrip_fire_aim = "foregrip_iron_fire",
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire_b",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_firemode = "foregrip_fireselect",
	foregrip_firemode_aim = "foregrip_iron_fireselect_b",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
	
	bipod_in = "deployed_in",
	bipod_fire = "deployed_fire",
	bipod_fire_aim = "deployed_iron_fire",
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_empty = "deployed_reloadempty",
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_aim = "deployed_iron_fireselect",
	bipod_out = "deployed_out",
}

SWEP.ReloadTimes = {
	base_reload = {2.3, 3.4},
	base_reloadempty = {2.3, 4.3},
	foregrip_reload = {2.3, 3.4},
	foregrip_reloadempty = {2.3, 4.3},
	deployed_reload = {2.2, 3.27},
	deployed_reloadempty = {2.2, 4}
}

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_BOLTBACK"},
		{time = 31/30, sound = "CW_KK_INS2_FNFAL_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_FNFAL_EMPTY"},
	},

	base_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_FNFAL_FIRESELECT"},
	},

	base_reload = {
		{time = 17/30, sound = "CW_KK_INS2_FNFAL_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_FNFAL_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_FNFAL_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_FNFAL_RATTLE"},
	},

	base_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_FNFAL_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_FNFAL_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_FNFAL_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_FNFAL_RATTLE"},
		{time = 92/30, sound = "CW_KK_INS2_FNFAL_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_FNFAL_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_FNFAL_EMPTY"},
	},

	iron_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_FNFAL_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_BOLTBACK"},
		{time = 31/30, sound = "CW_KK_INS2_FNFAL_BOLTRELEASE"},
	},

	foregrip_draw_b = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster_b = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_FNFAL_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 14/30, sound = "CW_KK_INS2_FNFAL_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 17/30, sound = "CW_KK_INS2_FNFAL_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_FNFAL_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_FNFAL_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_FNFAL_RATTLE"},
	},

	foregrip_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_FNFAL_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_FNFAL_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_FNFAL_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_FNFAL_RATTLE"},
		{time = 92/30, sound = "CW_KK_INS2_FNFAL_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_FNFAL_BOLTRELEASE"},
	},

	foregrip_iron_dryfire_b = {
		{time = 0, sound = "CW_KK_INS2_FNFAL_EMPTY"},
	},

	foregrip_iron_fireselect_b = {
		{time = 14/30, sound = "CW_KK_INS2_FNFAL_FIRESELECT"},
	},

	deployed_in = {
		{time = 16/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART"},
		{time = 23/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND"},
	},

	deployed_out = {
		{time = 7/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_FNFAL_EMPTY"},
	},

	deployed_fireselect = {
		{time = 8/24, sound = "CW_KK_INS2_FNFAL_FIRESELECT"},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_FNFAL_EMPTY"},
	},

	deployed_iron_fireselect = {
		{time = 8/24, sound = "CW_KK_INS2_FNFAL_FIRESELECT"},
	},

	deployed_reload = {
		{time = 17/30, sound = "CW_KK_INS2_FNFAL_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_FNFAL_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_FNFAL_MAGIN"},
		{time = 84/30, sound = "CW_KK_INS2_FNFAL_RATTLE"},
	},

	deployed_reloadempty = {
		{time = 17/30, sound = "CW_KK_INS2_FNFAL_MAGRELEASE"},
		{time = 20/30, sound = "CW_KK_INS2_FNFAL_MAGOUT"},
		{time = 29/30, sound = "CW_KK_INS2_FNFAL_MAGOUTRATTLE"},
		{time = 63/30, sound = "CW_KK_INS2_FNFAL_MAGIN"},
		{time = 80/30, sound = "CW_KK_INS2_FNFAL_RATTLE"},
		{time = 92/30, sound = "CW_KK_INS2_FNFAL_BOLTBACK"},
		{time = 104/30, sound = "CW_KK_INS2_FNFAL_BOLTRELEASE"},
	},
}

SWEP.SpeedDec = 40

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
SWEP.ViewModel		= "models/weapons/v_l1a1.mdl"
SWEP.WorldModel		= "models/weapons/w_l1a1.mdl"

SWEP.WMPos = Vector(5.25, 0.816, -0.954)
SWEP.WMAng = Vector(-10, 0, 180)
	
SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 60/650
SWEP.FireSound = "CW_KK_INS2_FNFAL_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_FNFAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 42

SWEP.FirstDeployTime = 1.8
SWEP.DeployTime = 0.5

SWEP.RecoilToSpread = 0.8 

SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15

if CLIENT then
	function SWEP:updateOtherParts()
		local active = self.ActiveAttachments
		
		self.AttachmentModelsVM.kk_ins2_mag_l1a1_20.active = !active.kk_ins2_mag_fal_30
	
		if self.dt.BipodDeployed then
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(1)
		else
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(0)
		end
	end
end