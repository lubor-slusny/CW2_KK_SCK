if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

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
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_06.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_pbs1"] = {model = "models/weapons/upgrades/a_suppressor_ak.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 1.2},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_6.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_pbs1"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.IronsightPos_def = Vector(-2.3, -2, 0.13)
	SWEP.IronsightAng_def = Vector(0.95, 0.05, 0)

	SWEP.KKINS2KobraPos_def = Vector(-2.3107, -2, -0.5233)
	SWEP.KKINS2KobraAng_def = Vector(0, 0, 0)
	
	SWEP.KKINS2EoTechPos_def = Vector(-2.3099, -2, -0.4734)
	SWEP.KKINS2EoTechAng_def = Vector(0, 0, 0)

	SWEP.KKINS2AimpointPos_def = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2AimpointAng_def = Vector(0, 0, 0)

	SWEP.KKINS2ElcanPos_def = Vector(-2.3062, -2, -0.5652)
	SWEP.KKINS2ElcanAng_def = Vector(0, 0, 0)

	SWEP.KKINS2PO4Pos_def = Vector(-2.2495, -2, -0.3634)
	SWEP.KKINS2PO4Ang_def = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos_def = Vector(-2.307, -2, -0.4629)
	SWEP.KKINS2MagnifierAng_def = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCMorePos_def = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2CSTMCMoreAng_def = Vector(0, 0, 0)

	SWEP.KKINS2CSTMBarskaPos_def = Vector(-2.3099, -2, -0.4734)
	SWEP.KKINS2CSTMBarskaAng_def = Vector(0, 0, 0)

	SWEP.KKINS2CSTMMicroT1Pos_def = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2CSTMMicroT1Ang_def = Vector(0, 0, 0)

	SWEP.KKINS2CSTMEoTechXPSPos_def = Vector(-2.3099, -2, -0.4734)
	SWEP.KKINS2CSTMEoTechXPSAng_def = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCompM4SPos_def = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2CSTMCompM4SAng_def = Vector(0, 0, 0)

	SWEP.KKINS2CSTMACOGPos_def = Vector(-2.3062, -2, -0.5652)
	SWEP.KKINS2CSTMACOGAng_def = Vector(0, 0, 0)

	// coz why nut
	SWEP.IronsightPos_sopmod = Vector(-2.3118, -2, 0.4771)
	SWEP.IronsightAng_sopmod = Vector(0.7678, 0.05, 0)

	SWEP.KKINS2KobraPos_sopmod = Vector(-2.3107, -8, -0.3917)
	SWEP.KKINS2KobraAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2EoTechPos_sopmod = Vector(-2.3099, -8, -0.3084)
	SWEP.KKINS2EoTechAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2AimpointPos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2AimpointAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2ElcanPos_sopmod = Vector(-2.3068, -10, -0.401)
	SWEP.KKINS2ElcanAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2PO4Pos_sopmod = Vector(-2.2503, -10, -0.2003)
	SWEP.KKINS2PO4Ang_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos_sopmod = Vector(-2.307, -10, -0.3014)
	SWEP.KKINS2MagnifierAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCMorePos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2CSTMCMoreAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2CSTMBarskaPos_sopmod = Vector(-2.3099, -8, -0.3084)
	SWEP.KKINS2CSTMBarskaAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2CSTMMicroT1Pos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2CSTMMicroT1Ang_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2CSTMEoTechXPSPos_sopmod = Vector(-2.3099, -8, -0.3084)
	SWEP.KKINS2CSTMEoTechXPSAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCompM4SPos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2CSTMCompM4SAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS2CSTMACOGPos_sopmod = Vector(-2.3068, -10, -0.401)
	SWEP.KKINS2CSTMACOGAng_sopmod = Vector(0, 0, 0)

	SWEP.KKINS_implicitBipod = true
	SWEP.CustomizationMenuScale = 0.018
end

SWEP.BipodInstalled = true
SWEP.WeaponLength = 26
-- SWEP.WeaponLength = 22 // sopmod

SWEP.Attachments = {
	{header = "Sight", offset = {600, -500}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4"}},
	-- {header = "Sight", offset = {600, -500}, atts = {"kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {0, -500}, atts = {"kk_ins2_pbs1"}},
	{header = "Package", offset = {-400, 100}, atts = {"kk_ins2_rpk_sopmod"}},
	{header = "Extras", offset = {200, 100}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1200, -100}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 300}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	
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