AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M16A4"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.Shell = "KK_INS2_556x45"

	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_carryhandle_m16.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["bg_foldsight"] = {model = "models/weapons/attachments/v_cw_kk_ins2_flipsight.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		-- ["bottomRailCover"] = {model = "models/weapons/upgrades/a_standard_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["cover_short"] = {model = "models/weapons/upgrades/a_standard2_m16a4.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["cover_long"] = {model = "models/weapons/upgrades/a_standard_m16a4.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/a_bipod_ar.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/a_foregrip_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), attachment = "Foregrip"},
		["kk_ins2_gl_m203"] = {model = "models/weapons/upgrades/a_gl_m203.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_rail.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_rail.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["ins_scope_m40"] = {model = "models/weapons/upgrades/a_optic_m40_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["ins_scope_mosin"] = {model = "models/weapons/upgrades/a_optic_mosin_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["ins_scope_po"] = {model = "models/weapons/upgrades/a_optic_po4x24_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska_l.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/w_flipup1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		-- ["bottomRailCover"] = {model = "models/weapons/upgrades/a_standard_m4a1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["md_saker"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/w_bipod_m40.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_vertgrip"] = {model = "models/weapons/upgrades/w_foregrip_sec1.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		-- ["kk_ins2_gl_m203_merge"] = {model = "models/weapons/upgrades/w_m203.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_gl_m203"] = {model = "models/weapons/upgrades/w_m203.mdl", attachment = "gl", pos = Vector(-12,1.1,0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0,0,0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	// used
	SWEP.IronsightPos_def = Vector(-2.4954, -2, 0.6686)
	SWEP.IronsightAng_def = Vector(-0.2838, 0.05, 0)

	SWEP.FoldSightPos_def = Vector(-2.4932, -2, 0.9581)
	SWEP.FoldSightAng_def = Vector(-0.8694, 0.0447, 0)

	SWEP.KKINS2CSTMBarskaPos_def = Vector(-2.4877, -2, 0.6744)
	SWEP.KKINS2CSTMBarskaAng_def = Vector(-0.2659, 0.0539, 0)

	SWEP.KKINS2AimpointPos_def = Vector(-2.4968, -2, 0.5831)
	SWEP.KKINS2AimpointAng_def = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos_def = Vector(-2.4914, -1, 0.5701)
	SWEP.KKINS2MagnifierAng_def = Vector(0, 0, 0)

	SWEP.KKINS2ElcanPos = Vector(-2.4917, -2, 0.5397)
	SWEP.KKINS2ElcanAng = Vector(0, 0, 0)

	-- // guess what
	-- SWEP.IronsightPos_bipod = Vector(-2.41, -2, 0.02)
	-- SWEP.IronsightAng_bipod = Vector(-0.17, 0.05, 0)
	
	-- SWEP.KKINS2CSTMBarskaPos_bipod = Vector(-2.41, -2, -0.1)
	-- SWEP.KKINS2CSTMBarskaAng_bipod = Vector(0, 0, 0)
	
	-- SWEP.KKINS2AimpointPos_bipod = Vector(-2.41, -2, -0.1)
	-- SWEP.KKINS2AimpointAng_bipod = Vector(0, 0, 0)
	
	-- SWEP.KKINS2MagnifierPos_bipod = Vector(-2.41, -2, -0.1)
	-- SWEP.KKINS2MagnifierAng_bipod = Vector(0.4, -0.2, 0)
	
	-- SWEP.FoldSightPos_bipod = Vector(-2.4056, -2, 0.3246)
	-- SWEP.FoldSightAng_bipod = Vector(-0.7938, 0.0447, 0)

	-- // guess what not
	-- SWEP.FoldSightPos_gl = Vector(-3.3749, -2, 1.3162)
	-- SWEP.FoldSightAng_gl = Vector(-3.0719, -0.934, 0)

	-- SWEP.KKINS2AimpointPos_gl = Vector(-3.3859, -2, 0.9123)
	-- SWEP.KKINS2AimpointAng_gl = Vector(-2.2398, -1.0179, 0)

	-- SWEP.IronsightPos_gl = Vector(-3.3845, -2, 1.0197)
	-- SWEP.IronsightAng_gl = Vector(-2.4582, -0.9573, 0)

	-- SWEP.KKINS2CSTMBarskaPos_gl = Vector(-3.3598, -2, 1.041)
	-- SWEP.KKINS2CSTMBarskaAng_gl = Vector(-2.5391, -0.9637, 0)

	-- SWEP.KKINS2MagnifierPos_gl = Vector(-3.3435, -2, 0.9015)
	-- SWEP.KKINS2MagnifierAng_gl = Vector(-2, -0.6, 0)

	
	SWEP.KKINS2AimpointPos = SWEP.KKINS2AimpointPos_def
	SWEP.KKINS2AimpointAng = SWEP.KKINS2AimpointAng_def

	SWEP.FoldSightPos = SWEP.FoldSightPos_def
	SWEP.FoldSightAng = SWEP.FoldSightAng_def

	SWEP.KKINS2MagnifierPos = SWEP.KKINS2MagnifierPos_def
	SWEP.KKINS2MagnifierAng = SWEP.KKINS2MagnifierAng_def

	SWEP.IronsightPos = SWEP.IronsightPos_def
	SWEP.IronsightAng = SWEP.IronsightAng_def

	SWEP.KKINS2CSTMBarskaPos = SWEP.KKINS2CSTMBarskaPos_def
	SWEP.KKINS2CSTMBarskaAng = SWEP.KKINS2CSTMBarskaAng_def

	SWEP.M203Pos = Vector(-0.5204, -2, 1.1308)
	SWEP.M203Ang = Vector(0.685, 0.05, 0)

	SWEP.CustomizationMenuScale = 0.018
end

SWEP.SightBGs = {main = 0, foldsight = 0}

SWEP.Attachments = {
	{header = "Sight", offset = {500, -500},  atts = {"bg_foldsight", "kk_ins2_cstm_barska", "kk_ins2_aimpoint", "kk_ins2_elcan"}},
	{header = "Barrel", offset = {-200, -500},  atts = {"md_saker", "kk_ins2_hoovy"}},
	{header = "Under", offset = {-500, 0},  atts = {"kk_ins2_bipod", "kk_ins2_vertgrip", "kk_ins2_gl_m203"}},
	{header = "Extras", offset = {125, 200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
	{header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready", // coz drawanimfunc doesnt play always
	
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
	foregrip_fire_aim = {"foregrip_iron_fire","foregrip_iron_fire_a","foregrip_iron_fire_b","foregrip_iron_fire_c","foregrip_iron_fire_d","foregrip_iron_fire_e","foregrip_iron_fire_f"},
	foregrip_fire_empty = "foregrip_dryfire",
	foregrip_fire_empty_aim = "foregrip_iron_dryfire",
	foregrip_reload = "foregrip_reload",
	foregrip_reload_empty = "foregrip_reloadempty",
	foregrip_idle = "foregrip_draw",
	foregrip_holster = "foregrip_holster",
	foregrip_firemode = "foregrip_fireselect",
	foregrip_firemode_aim = "foregrip_iron_fireselect",
	foregrip_sprint = "foregrip_sprint",
	foregrip_safe = "foregrip_down",
	foregrip_safe_aim = "foregrip_iron_down",
	
	gl_off_pickup = "gl_ready",
	gl_off_draw = "gl_draw",
	gl_off_fire = "gl_fire",
	gl_off_fire_aim = {"gl_iron_fire","gl_iron_fire_a","gl_iron_fire_b","gl_iron_fire_c","gl_iron_fire_d","gl_iron_fire_e","gl_iron_fire_f"},
	gl_off_fire_empty = "gl_dryfire",
	gl_off_fire_empty_aim = "gl_iron_dryfire",
	gl_off_reload = "gl_reload",
	gl_off_reload_empty = "gl_reloadempty",
	gl_off_idle = "gl_draw",
	gl_off_holster = "gl_holster",
	gl_off_firemode = "gl_fireselect",
	gl_off_firemode_aim = "gl_fireselect",
	gl_off_sprint = "gl_sprint",
	gl_off_safe = "gl_down",
	gl_off_safe_aim = "gl_iron_down",
	
	gl_on_draw = "glsetup_draw",
	gl_on_fire = "glsetup_fire",
	gl_on_fire_aim = "glsetup_iron_fire",
	gl_on_fire_empty = "glsetup_dryfire",
	gl_on_fire_empty_aim = "glsetup_iron_dryfire",
	gl_on_reload = "glsetup_reload",
	gl_on_idle = "glsetup_draw",
	gl_on_holster = "glsetup_holster",
	gl_on_sprint = "glsetup_sprint",
	gl_on_safe = "glsetup_down",
	gl_on_safe_aim = "glsetup_iron_down",
	
	gl_turn_on = "glsetup_in",
	gl_turn_off = "glsetup_out",
	
	bipod_fire = "deployed_fire",
	bipod_fire_aim = "deployed_fire",
	bipod_fire_last = "deployed_fire",
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_dryfire",
	bipod_reload = "deployed_reload_half",
	bipod_reload_empty = "deployed_reload_empty",
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_aim = "deployed_iron_fireselect",
	
	bipod_in = "deployed_in",
	bipod_idle = "deployed_idle",
	bipod_out = "deployed_out",
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_m16a3.mdl"
SWEP.WorldModel		= "models/weapons/w_m16.mdl"

SWEP.WMPos = Vector(5.219, 0.554, -0.893)
SWEP.WMAng = Vector(-10, -1, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.066666666666667
SWEP.FireSound = "CW_KK_INS2_M16A4_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M16A4_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 28

SWEP.FirstDeployTime = 2.25
SWEP.DeployTime = 0.71

SWEP.base_ReloadTime = 2.9
SWEP.base_ReloadTime_Empty = 2.9
SWEP.base_ReloadHalt = 3.7
SWEP.base_ReloadHalt_Empty = 4.3

SWEP.gl_on_ReloadTime = 2.6
SWEP.gl_on_ReloadHalt = 3.17

function SWEP:fireAnimFunc()
	local clip = self:Clip1()
	local cyc = 0
	local rate = 1
	local prefix = self:getForegripMode()
	local suffix = ""
	
	if clip == 1 and self.KKINS_emptyIdle then
		suffix = "_last"
	elseif (clip == 0 and not self.dt.INS2GLActive) or (self.dt.INS2GLActive and not self.M203Chamber) then
		suffix = "_empty"
	end
	
	if self:isAiming() then
		if self.ShotgunReload then
		
		else
			if (self:hasInstalledRTScope() and clip != 0) then
				cyc = 1
			elseif (self.dt.BipodDeployed and self:isAiming()) then
				cyc = 0.4
			end
		end
		suffix = suffix .. "_aim"
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix,rate,cyc)
end //*/
	
if CLIENT then 
	function SWEP:updateOtherParts()
		local hasInstalledScope = self:getActiveAttachmentInCategory(1) != nil
		local isBipod = self.dt.BipodDeployed
		local isGL = self.dt.INS2GLActive
		
		local _3 = self:getActiveAttachmentInCategory(3)
		self.AttachmentModelsVM.cover_long.active = _3 == nil or _3 == "kk_ins2_bipod"
		self.AttachmentModelsVM.cover_short.active = self.ActiveAttachments.kk_ins2_vertgrip
		
		-- // bipod aimpos switch
		-- if self.ActiveAttachments.kk_ins2_magnifier then
			-- local name = "KKINS2Magnifier"
			-- if isBipod then
				-- self[name .. "Pos"] = self[name .. "Pos_bipod"]
				-- self[name .. "Ang"] = self[name .. "Ang_bipod"]
			-- elseif isGL then
				-- self[name .. "Pos"] = self[name .. "Pos_gl"]
				-- self[name .. "Ang"] = self[name .. "Ang_gl"]
			-- else
				-- self[name .. "Pos"] = self[name .. "Pos_def"]
				-- self[name .. "Ang"] = self[name .. "Ang_def"]
			-- end
			-- self.AimPos = self[name .. "Pos"]
			-- self.AimAng = self[name .. "Ang"]
		-- elseif hasInstalledScope then
			-- local sight = CustomizableWeaponry.sights[self:getActiveAttachmentInCategory(1)]
			-- if isBipod then
				-- self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_bipod"]
				-- self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_bipod"]
			-- elseif isGL then
				-- self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_gl"]
				-- self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_gl"]
			-- else
				-- self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_def"]
				-- self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_def"]
			-- end
			-- self.AimPos = self[sight.aimPos[1]]
			-- self.AimAng = self[sight.aimPos[2]]
		-- else
			-- if isBipod then
				-- self.IronsightPos = self.IronsightPos_bipod
				-- self.IronsightAng = self.IronsightAng_bipod
			-- elseif isGL then
				-- self.IronsightPos = self.IronsightPos_gl
				-- self.IronsightAng = self.IronsightAng_gl
			-- else
				-- self.IronsightPos = self.IronsightPos_def
				-- self.IronsightAng = self.IronsightAng_def
			-- end
			-- self.AimPos = self.IronsightPos
			-- self.AimAng = self.IronsightAng
		-- end
		
		-- // bipod aimpos switch
		-- if self.ActiveAttachments.kk_ins2_magnifier then
			-- local name = "KKINS2Magnifier"
			-- if isBipod then
				-- self[name .. "Pos"] = self[name .. "Pos_bipod"]
				-- self[name .. "Ang"] = self[name .. "Ang_bipod"]
			-- else
				-- self[name .. "Pos"] = self[name .. "Pos_def"]
				-- self[name .. "Ang"] = self[name .. "Ang_def"]
			-- end
			
			-- if isGL then
				-- self.AimPos = self.M203Pos
				-- self.AimAng = self.M203Ang
			-- else
				-- self.AimPos = self[name .. "Pos"]
				-- self.AimAng = self[name .. "Ang"]
			-- end
		-- elseif hasInstalledScope then
			-- local sight = CustomizableWeaponry.sights[self:getActiveAttachmentInCategory(1)]
			-- if isBipod then
				-- self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_bipod"]
				-- self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_bipod"]
			-- else
				-- self[sight.aimPos[1]] = self[sight.aimPos[1] .. "_def"]
				-- self[sight.aimPos[2]] = self[sight.aimPos[2] .. "_def"]
			-- end
			
			-- if isGL then
				-- self.AimPos = self.M203Pos
				-- self.AimAng = self.M203Ang
			-- else
				-- self.AimPos = self[sight.aimPos[1]]
				-- self.AimAng = self[sight.aimPos[2]]
			-- end
		-- else
			-- if isBipod then
				-- self.IronsightPos = self.IronsightPos_bipod
				-- self.IronsightAng = self.IronsightAng_bipod
			-- else
				-- self.IronsightPos = self.IronsightPos_def
				-- self.IronsightAng = self.IronsightAng_def
			-- end
			
			-- if isGL then
				-- self.AimPos = self.M203Pos
				-- self.AimAng = self.M203Ang
			-- else
				-- self.AimPos = self.IronsightPos
				-- self.AimAng = self.IronsightAng
			-- end
		-- end
		
		// bipod aimpos switch // 3rd iteration kek
		if self.ActiveAttachments.kk_ins2_magnifier then
			local name = "KKINS2Magnifier"
			if isGL then
				self.AimPos = self.M203Pos
				self.AimAng = self.M203Ang
			else
				self.AimPos = self[name .. "Pos"]
				self.AimAng = self[name .. "Ang"]
			end
		elseif hasInstalledScope then
			local sight = CustomizableWeaponry.sights[self:getActiveAttachmentInCategory(1)]
			if isGL then
				self.AimPos = self.M203Pos
				self.AimAng = self.M203Ang
			else
				self.AimPos = self[sight.aimPos[1]]
				self.AimAng = self[sight.aimPos[2]]
			end
		else
			if isGL then
				self.AimPos = self.M203Pos
				self.AimAng = self.M203Ang
			else
				self.AimPos = self.IronsightPos
				self.AimAng = self.IronsightAng
			end
		end
		
		-- local vm = self.CW_VM
		-- local cycle = vm:GetCycle()
		
		-- if self.Sequence == self.Animations.bipod_out and cycle > 0.9 then
			-- self:playAnim("base_idle",1,1) 
		-- elseif self.Sequence == self.Animations.bipod_in and cycle > 0.9 then
			-- self:playAnim("bipod_idle",1,1) 
		-- elseif (self.Sequence == self.Animations.gl_turn_on or self.Sequence == self.Animations.gl_on_draw) and cycle > 0.9 then
			-- self:playAnim("gl_on_fire",1,1) 
		-- end
		
		// WM
		
		if isBipod then
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(1)
		else
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(0)
		end
	end
end