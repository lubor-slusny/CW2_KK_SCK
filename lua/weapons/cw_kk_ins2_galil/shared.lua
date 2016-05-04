if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Galil"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.Shell = "KK_INS2_556x45"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_galil"] = {model = "models/weapons/upgrades/a_standard_galil.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_mount_galil.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_mag_galil_35"] = {model = "models/weapons/upgrades/a_magazine_galil_35.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_galil_75"] = {model = "models/weapons/upgrades/a_magazine_galil_75.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_suppressor_ins"] = {model = "models/weapons/upgrades/a_suppressor_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/a_bipod_galil.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 1.2},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_mount_galil.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_galil_35"] = {model = "models/weapons/upgrades/w_magazine_galil_35.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_mag_galil_75"] = {model = "models/weapons/upgrades/w_magazine_galil_75.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_suppressor_ins"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/w_bipod_galil.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_ins_foregrip.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-2.2259, -2, 0.6884)
	SWEP.IronsightAng = Vector(-0.0408, 0.039, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.2232, 0, -0.4952)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)

	SWEP.KKINS2AimpointPos = Vector(-2.2319, -2, -0.4955)
	SWEP.KKINS2AimpointAng = Vector(0, -0.02, 0)

	SWEP.KKINS2CSTMACOGPos = Vector(-2.2344, -1, -0.8283)
	SWEP.KKINS2CSTMACOGAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.2341, -2, -0.5023)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.2276, -2, -0.5042)
	SWEP.KKINS2MagnifierAng = Vector(0.1, -0.02, 0)

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.2265, -2, -0.4997)
	SWEP.KKINS2CSTMCompM4SAng = Vector(0, 0, 0)

	SWEP.KKINS2EoTechPos = Vector(-2.2277, 0, -0.4398)
	SWEP.KKINS2EoTechAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMACOGPos = Vector(-2.2234, -3, -0.609)
	SWEP.KKINS2CSTMACOGAng = Vector(0, 0, 0)

	// sth sth sth theater
	
	SWEP.KKINS2EoTechPos = Vector(-2.2228, -2, -0.4827)
	SWEP.KKINS2EoTechAng = Vector(0, 0, 0)

	SWEP.KKINS2AimpointPos = Vector(-2.2319, -2, -0.4955)
	SWEP.KKINS2AimpointAng = Vector(0, 0, 0)

	SWEP.KKINS2KobraPos = Vector(-2.2149, -2, -0.587)
	SWEP.KKINS2KobraAng = Vector(0, 0, 0)

	SWEP.KKINS2PO4Pos = Vector(-2.1738, -4, -0.2444)
	SWEP.KKINS2PO4Ang = Vector(0, 0, 0)

	SWEP.KKINS2ElcanPos = Vector(-2.2233, -2, -0.601)
	SWEP.KKINS2ElcanAng = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.2215, -2, -0.5042)
	SWEP.KKINS2MagnifierAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.016
end

SWEP.Attachments = {
	-- {header = "Sight", offset = {300, -600}, atts = {"kk_ins2_cstm_barska", "kk_ins2_cstm_eotechxps", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Sight", offset = {500, -600}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4"}},
	{header = "Barrel", offset = {-200, -600}, atts = {"kk_ins2_suppressor_ins", "kk_ins2_suppressor_sec"}},
	{header = "Under", offset = {-500, -150}, atts = {"kk_ins2_bipod", "kk_ins2_vertgrip"}},
	{header = "Extras", offset = {150, -150}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "MagZ", offset = {-200, 350}, atts = {"kk_ins2_mag_galil_75"}},
	{header = "Variant", offset = {400, 350}, atts = {"kk_ins2_galil_sar"}},
	{header = "More Sight", offset = {1100, -150}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {1000, 350}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.AttachmentExclusions = {
	["kk_ins2_suppressor_ins"] = {"kk_ins2_galil_sar"},
}

SWEP.AttachmentDependencies = {
	["kk_ins2_suppressor_sec"] = {"kk_ins2_galil_sar"},
}

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire_a","iron_fire_b","iron_fire_c"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_mm = "base_reload_drum",
	base_reload_empty = "base_reloadempty",
	base_reload_empty_mm = "base_reloadempty_drum",
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
	foregrip_fire_aim = {"foregrip_iron_fire_a","foregrip_iron_fire_b","foregrip_iron_fire_c"},
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_mm = "foregrip_reload_drum",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_reload_empty_mm = "foregrip_reloadempty_drum",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_firemode = "foregrip_fireselect",
	foregrip_firemode_aim = "foregrip_iron_fireselect",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
	
	bipod_in = "deployed_in",
	bipod_fire = "deployed_fire",
	bipod_fire_aim = {"deployed_iron_fire_a","deployed_iron_fire_b","deployed_iron_fire_c"},
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_mm = "deployed_reload_drum",
	bipod_reload_empty = "deployed_reload_empty",
	bipod_reload_empty_mm = "deployed_reload_empty_drum",
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_aim = "deployed_iron_fireselect",
	bipod_out = "deployed_out",
}
	
-- SWEP.ReloadTimes = {					// mess
	-- base_reload = {2.2, 3.54},
	-- base_reloadempty = {2.2, 5},
	
	-- base_reload_drum = {2.2, 5.55},
	-- base_reloadempty_drum = {2.2, 7.55},
	
	-- foregrip_reload = {2.2, 3.54},
	-- foregrip_reloadempty = {2.2, 5},
	
	-- foregrip_reload_drum = {2.2, 5.5},
	-- foregrip_reloadempty_drum = {2.2, 7.55},
	
	-- deployed_reload = {2.2, 3.8},
	-- deployed_reload_empty = {2.2, 5.4},
	
	-- deployed_reload_drum = {2.2, 5.5},
	-- deployed_reload_empty_drum = {2.2, 7.55}
-- }
	
SWEP.ReloadTimes = {					//qc
	base_reload = {70/32.2, 3.5},
	base_reloadempty = {70/32.2, 5},
	base_reload_drum = {116/31.8, 5.5},
	base_reloadempty_drum = {116/31.8, 7.55},
	
	foregrip_reload = {70/32.2, 3.5},
	foregrip_reloadempty = {70/32.2, 5},
	foregrip_reload_drum = {116/31.8, 5.5},
	foregrip_reloadempty_drum = {116/31.8, 7.55},
	
	deployed_reload = {70/30, 3.8},
	deployed_reload_empty = {70/30, 5.4},
	deployed_reload_drum = {116/31.8, 5.5},
	deployed_reload_empty_drum = {116/31.8, 7.55},
}
	
-- SWEP.ReloadTimes = {					//qc + mess
	-- base_reload = {00000/32.2, 3.5},
	-- base_reloadempty = {00000/32.2, 5},
	-- base_reload_drum = {00000/31.8, 5.5},
	-- base_reloadempty_drum = {00000/31.8, 7.55},
	
	-- foregrip_reload = {00000/32.2, 3.5},
	-- foregrip_reloadempty = {00000/32.2, 5},
	-- foregrip_reload_drum = {00000/31.8, 5.5},
	-- foregrip_reloadempty_drum = {00000/31.8, 7.55},
	
	-- deployed_reload = {00000/30, 3.8},
	-- deployed_reload_empty = {00000/30, 5.4},
	-- deployed_reload_drum = {00000/31.8, 5.5},
	-- deployed_reload_empty_drum = {00000/31.8, 7.55},
-- }

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 20/30, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
		{time = 39/30, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 48/30, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
		{time = 60/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_GALIL_EMPTY"},
	},

	base_fireselect = {
		{time = 13/30, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
	},

	base_reload = {
		{time = 19/32.2, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/32.2, sound = "CW_KK_INS2_GALIL_MAGOUT"},
		{time = 71/32.2, sound = "CW_KK_INS2_GALIL_MAGIN"},
		{time = 99/32.2, sound = "CW_KK_INS2_GALIL_RATTLE"},
	},

	base_reloadempty = {
		{time = 19/32.2, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/32.2, sound = "CW_KK_INS2_GALIL_MAGOUT"},
		{time = 71/32.2, sound = "CW_KK_INS2_GALIL_MAGIN"},
		{time = 99/32.2, sound = "CW_KK_INS2_GALIL_RATTLE"},
		{time = 121/32.2, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 130/32.2, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
	},

	base_reload_drum = {
		{time = 19/31.8, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUT"},
		{time = 28/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUTRATTLE"},
		{time = 30/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGFETCH"},
		{time = 105/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGIN"},
		{time = 142/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGHIT"},
		{time = 161/31.8, sound = "CW_KK_INS2_GALIL_RATTLE"},
	},

	base_reloadempty_drum = {
		{time = 19/31.8, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUT"},
		{time = 28/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUTRATTLE"},
		{time = 30/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGFETCH"},
		{time = 105/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGIN"},
		{time = 142/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGHIT"},
		{time = 161/31.8, sound = "CW_KK_INS2_GALIL_RATTLE"},
		{time = 190/31.8, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 201/31.8, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
		{time = 223/31.8, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_GALIL_EMPTY"},
	},

	iron_fireselect = {
		{time = 13/30, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 20/30, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
		{time = 39/30, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 48/30, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
		{time = 60/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_GALIL_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 13/30, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 19/32.2, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/32.2, sound = "CW_KK_INS2_GALIL_MAGOUT"},
		{time = 71/32.2, sound = "CW_KK_INS2_GALIL_MAGIN"},
		{time = 99/32.2, sound = "CW_KK_INS2_GALIL_RATTLE"},
	},

	foregrip_reloadempty = {
		{time = 19/32.2, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/32.2, sound = "CW_KK_INS2_GALIL_MAGOUT"},
		{time = 71/32.2, sound = "CW_KK_INS2_GALIL_MAGIN"},
		{time = 99/32.2, sound = "CW_KK_INS2_GALIL_RATTLE"},
		{time = 121/32.2, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 130/32.2, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
	},

	foregrip_reload_drum = {
		{time = 19/31.8, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUT"},
		{time = 28/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUTRATTLE"},
		{time = 30/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGFETCH"},
		{time = 105/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGIN"},
		{time = 142/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGHIT"},
		{time = 161/31.8, sound = "CW_KK_INS2_GALIL_RATTLE"},
	},

	foregrip_reloadempty_drum = {
		{time = 19/31.8, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUT"},
		{time = 28/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUTRATTLE"},
		{time = 30/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGFETCH"},
		{time = 105/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGIN"},
		{time = 142/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGHIT"},
		{time = 161/31.8, sound = "CW_KK_INS2_GALIL_RATTLE"},
		{time = 190/31.8, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 201/31.8, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
		{time = 223/31.8, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_GALIL_EMPTY"},
	},

	foregrip_iron_fireselect = {
		{time = 13/30, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
	},

	deployed_in = {
		{time = 20/37.2, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART"},
		{time = 28/37.2, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND"},
	},

	deployed_out = {
		{time = 30/37.5, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_GALIL_EMPTY"},
	},

	deployed_fireselect = {
		{time = 13/42, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
	},

	deployed_reload = {
		{time = 19/30, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/30, sound = "CW_KK_INS2_GALIL_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_GALIL_MAGIN"},
	},

	deployed_reload_empty = {
		{time = 19/30, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/30, sound = "CW_KK_INS2_GALIL_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_GALIL_MAGIN"},
		{time = 100/30, sound = "CW_KK_INS2_GALIL_RATTLE"},
		{time = 121/30, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 130/30, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
	},

	deployed_reload_drum = {
		{time = 19/31.8, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUT"},
		{time = 28/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUTRATTLE"},
		{time = 30/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGFETCH"},
		{time = 105/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGIN"},
		{time = 142/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGHIT"},
		{time = 160/31.8, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	deployed_reload_empty_drum = {
		{time = 19/31.8, sound = "CW_KK_INS2_GALIL_MAGRELEASE"},
		{time = 22/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUT"},
		{time = 28/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGOUTRATTLE"},
		{time = 30/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGFETCH"},
		{time = 105/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGIN"},
		{time = 142/31.8, sound = "CW_KK_INS2_GALIL_DRUM_MAGHIT"},
		{time = 157/31.8, sound = "CW_KK_INS2_GALIL_RATTLE"},
		{time = 190/31.8, sound = "CW_KK_INS2_GALIL_BOLTBACK"},
		{time = 201/31.8, sound = "CW_KK_INS2_GALIL_BOLTRELEASE"},
		{time = 223/31.8, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_GALIL_EMPTY"},
	},

	deployed_iron_fireselect = {
		{time = 13/30, sound = "CW_KK_INS2_GALIL_FIRESELECT"},
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
SWEP.ViewModel		= "models/weapons/v_galil.mdl"
SWEP.WorldModel		= "models/weapons/w_galil.mdl"

SWEP.WMPos = Vector(4.919, 0.964, -1.055)
SWEP.WMAng = Angle(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 35
SWEP.Primary.DefaultClip	= 35
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 60/750
SWEP.FireSound = "CW_KK_INS2_GALIL_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_GALIL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 33

SWEP.FirstDeployTime = 2.6
SWEP.DeployTime = 0.6

if CLIENT then 
	function SWEP:updateOtherParts()
		local active = self.ActiveAttachments
		
		self.AttachmentModelsVM.kk_ins2_galil.active = !active.kk_ins2_bipod
		self.AttachmentModelsVM.kk_ins2_mag_galil_35.active = !active.kk_ins2_mag_galil_75
		
		// WM
		
		if self.dt.BipodDeployed then
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(1)
		else
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(0)
		end
	end
end