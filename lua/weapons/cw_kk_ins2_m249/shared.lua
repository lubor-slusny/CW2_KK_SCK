if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "lmgBox"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M249"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	
	SWEP.Shell = "KK_INS2_556x45"
	SWEP.Shell2 = "KK_INS2_556x45_link"
	SWEP.ShellEjectVelocity = 50
	SWEP.MuzzleEffect = "muzzleflash_6"

	SWEP.AttachmentModelsVM = {		
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_12ga.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_counter"] = {model = "models/weapons/stattrack.mdl", bone = "Weapon", pos = Vector(0.026, -7.77, 4.057), angle = Angle(0, 0, 50), size = Vector(0.699, 0.699, 0.699)},
		["kk_textbox"] = {model = "models/weapons/uid.mdl", bone = "LidCont", pos = Vector(0.441, -5.015, -0.156), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		
		["kk_counter_mag"] = {model = "models/weapons/stattrack.mdl", bone = "Magazine", rel = "", pos = Vector(1.149, -0.976, 1.919), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		-- ["fas2"] = {model = "models/gmod4phun/60rndmag.mdl", bone = "Weapon", pos = Vector(1.47, 1.057, 2.095), angle = Angle(45, 0, 0), size = Vector(0.779, 0.779, 0.779)},
		["fas2"] = {model = "models/gmod4phun/60rndmag.mdl", bone = "Magazine", pos = Vector(1.294, 1.832, 2.471), angle = Angle(45, 0, 0), size = Vector(0.779, 0.779, 0.779)},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/w_sil_pistol.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

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
	
	SWEP.CustomizePos = Vector(4.488, -1.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.IronsightPos = Vector(-2.0484, 0, 0.9581)
	SWEP.IronsightAng = Vector(0, 0.03, 0)

	SWEP.KKINS2KobraPos = Vector(-2.0139, -2, 0.1313)
	SWEP.KKINS2KobraAng = Vector(0, 0, 0)

	SWEP.KKINS2EoTechPos = Vector(-2.0008, -2, 0)
	SWEP.KKINS2EoTechAng = Vector(0, 0, 0)

	SWEP.KKINS2AimpointPos = Vector(-2.0127, -2, -0.002)
	SWEP.KKINS2AimpointAng = Vector(0, 0, 0)

	SWEP.KKINS2ElcanPos = Vector(-2.0071, -2, -0.0976)
	SWEP.KKINS2ElcanAng = Vector(0, 0, 0)

	SWEP.KKINS2PO4Pos = Vector(-1.9575, -2, 0.2637)
	SWEP.KKINS2PO4Ang = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.0063, -1, 0.0037)
	SWEP.KKINS2MagnifierAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCMorePos = Vector(-2.0127, -2, -0.002)
	SWEP.KKINS2CSTMCMoreAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.0008, -2, 0)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.0127, -2, -0.002)
	SWEP.KKINS2CSTMMicroT1Ang = Vector(0, 0, 0)

	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.0008, -2, 0)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.0127, -2, -0.002)
	SWEP.KKINS2CSTMCompM4SAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMACOGPos = Vector(-2.0071, -2, -0.0976)
	SWEP.KKINS2CSTMACOGAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.014
end

SWEP.Chamberable = false
SWEP.BipodInstalled = true
SWEP.WeaponLength = 28

SWEP.Attachments = {
	{header = "Sight", offset = {400, -500}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_suppressor_sec"}},
	{header = "Lasers", offset = {-400, 0}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1000, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+use"] = {header = "Sight Contract", offset = {400, 0}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {200, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

if CustomizableWeaponry_KK.HOME then
	table.insert(SWEP.Attachments, {header = "Skill1", offset = {2100, -600}, atts = {"kk_aimbot"}})
	table.insert(SWEP.Attachments, {header = "Skill2", offset = {2100, -200}, atts = {"kk_wallhaq"}})
	table.insert(SWEP.Attachments, {header = "CSGO", offset = {2100, 200}, atts = {"kk_counter"}})
	table.insert(SWEP.Attachments, {header = "CSGO", offset = {2100, 600}, atts = {"kk_textbox"}})
end

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire_1","base_fire_2","base_fire_3"},
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3","iron_fire_4"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload_half",				// tacticool
	base_reload_empty = "base_reload_empty",	// empty, dryfired
	base_reload_empty_charged = "base_reload",				// empty, charged
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	bipod_in = "deployed_in",
	bipod_fire = {"deployed_fire_1","deployed_fire_2"},
	bipod_fire_aim = {"deployed_iron_fire_1","deployed_iron_fire_2"},
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload_half",
	bipod_reload_empty = "deployed_reload_empty",
	bipod_reload_empty_charged = "deployed_reload",
	bipod_out = "deployed_out",
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_m249.mdl"
SWEP.WorldModel		= "models/weapons/w_m249.mdl"

SWEP.WMPos = Vector(5.184, 0.935, -1.03)
SWEP.WMAng = Vector(-10, -1, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 60/800
SWEP.FireSound = "CW_KK_INS2_M249_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M249_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 39

SWEP.FirstDeployTime = 2.5
SWEP.DeployTime = 0.83

SWEP.ReloadTimes = {					
	-- base_reload = {186/31.5, 9.5},		//qc
	-- base_reload_half = {186/31.5, 9.84},
	-- base_reload_empty = {150/31.5, 11},
	
	base_reload = {7.3, 9.5},			// CVMT
	base_reload_half = {8, 9.84},
	base_reload_empty = {9.35, 11},
	
	-- deployed_reload = {186/32.5, 8.77},
	-- deployed_reload_half = {186/32.5, 9.5},
	-- deployed_reload_empty = {150/32.5, 10.52},
	
	deployed_reload = {7.1, 8.77},
	deployed_reload_half = {7.9, 9.5},
	deployed_reload_empty = {8.85, 10.52},
}

if CLIENT then
	local counterExists = file.Exists("models/weapons/stattrack.mdl", "GAME")
	
	local cycle, clip, ammo, setBG
	
	function SWEP:updateOtherParts()
		cycle = self.CW_VM:GetCycle()
		
		clip = self:Clip1()

		if self.getFullestMag then
			ammo = math.max(self:Clip1(), self:getFullestMag(), -1)
		else
			ammo = self.Owner:GetAmmoCount(self.Primary.Ammo) + clip
		end
		
		if self.Sequence:find("reload") and cycle > 0.4 and cycle < 1 then
			self.AttachmentModelsVM.kk_counter_mag.ent._KKCSGONUM = ammo
			setBG = math.Clamp(ammo,0,16)
		else
			self.AttachmentModelsVM.kk_counter_mag.ent._KKCSGONUM = clip
			setBG = math.Clamp(clip,0,16)
		end
		
		self:setBodygroup(1,setBG)
		
		if self.dt.BipodDeployed then
			self:SetSequence(1)
		else
			self:SetSequence(0)
		end
		
		self.AttachmentModelsVM.kk_counter_mag.active = counterExists and CustomizableWeaponry_KK.HOME
		
		-- self.AttachmentModelsVM.kk_counter_mag.active = false
		-- self.AttachmentModelsVM.fas2.active = true
		-- self:setBodygroup(1,0)
		-- self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("Magazine"), Vector(0.01,0.01,0.01))
	end
	
	local makeShell = CustomizableWeaponry_KK.ins2.makeShell
	
	local att, ang, tweak
	
	function SWEP:CreateShell(sh) // this func was edited for this specific vmodel only
		if self.Owner:ShouldDrawLocalPlayer() then
			return
		end
		
		// main shell
		self._shellTable = self._shellTable1
		att = self.CW_VM:GetAttachment(3)
		ang = EyeAngles()
		tweak = self._shellTable.rv
		if tweak then
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
		end
		
		-- CustomizableWeaponry_KK.ins2.makeShell(self, att.Pos, ang, att.Ang:Forward() * 50, 0.6, 10)
		makeShell(self, att.Pos, ang, att.Ang:Forward() * 50, 0.6, 10)
		
		-- // shell link
		self._shellTable = self._shellTable2
		att = self.CW_VM:GetAttachment(4)
		ang = EyeAngles()
		tweak = self._shellTable.rv
		if tweak then
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
		end
		
		-- CustomizableWeaponry_KK.ins2.makeShell(self, att.Pos, ang, att.Ang:Forward() * 50, 0.6, 10)
		makeShell(self, att.Pos, ang, att.Ang:Forward() * 50, 0.6, 10)
	end
end
