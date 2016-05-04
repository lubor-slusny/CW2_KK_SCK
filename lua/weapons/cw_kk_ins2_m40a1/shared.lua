if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M40A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "KK_INS2_762x51"
	SWEP.ShellDelay = 0.26 + 19/30
	
	SWEP.BackupSights = {
		["kk_ins2_elcan"] = {
			Vector(-2.7946, -2, -1.0583),
			Vector(-0.4447, 0.0147, 0)
		},
		["kk_ins2_cstm_acog"] = {
			Vector(-1.3473, -2, -0.5532),
			Vector(0, 0, 0)
		}
	}
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_standard_m40.mdl", pos = Vector(0, 0, 0), angle = Angle(90, 90, 0), size = Vector(1, 1, 1), merge = true, active = true},

		["kk_counter"] = {model = "models/weapons/stattrack.mdl", bone = "Weapon", rel = "", pos = Vector(1.236, -7.261, 1.273), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["kk_textbox"] = {model = "models/weapons/uid.mdl", bone = "Weapon", rel = "", pos = Vector(1.4, -6, 2.15), angle = Angle(0, -90, 0), size = Vector(1.5, 1.5, 1.5)},
		
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/a_bipod_m40.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_sec_shotgun.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_sec_shotgun.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_shotgun.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 1.2},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_scope_m40"] = {model = "models/weapons/upgrades/a_optic_m40.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/a_optic_mosin_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/w_flipup_m40.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/w_sil_sec1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_bipod"] = {model = "models/weapons/upgrades/w_bipod_m40.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	
		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_scope_m40"] = {model = "models/weapons/upgrades/w_scope_m40.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_mosin"] = {model = "models/weapons/upgrades/w_scope_mosin.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
	}
	
	-- SWEP.WElements = {
		-- ["scout"] = { type = "Model", model = "models/weapons/w_m40.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.021, 0.694, -1.369), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		-- ["awp"] = { type = "Model", model = "models/weapons/w_m40.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.919, 0.822, -1.236), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	-- }
	
	SWEP.KKINS2ScopeMosinPos = Vector(-2.791, -2, 0.479)
	SWEP.KKINS2ScopeMosinAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-2.815, -1, 0.2)
	SWEP.IronsightAng = Vector(-0.03, 0.03, 0)

	SWEP.KKINS2KobraPos = Vector(-2.8054, -2, 0.2518)
	SWEP.KKINS2KobraAng = Vector(0, 0, 0)

	SWEP.KKINS2EoTechPos = Vector(-2.8057, -2, 0.3303)
	SWEP.KKINS2EoTechAng = Vector(0, 0, 0)

	SWEP.KKINS2AimpointPos = Vector(-2.8108, -2, 0.3609)
	SWEP.KKINS2AimpointAng = Vector(0, 0, 0)

	SWEP.KKINS2ElcanPos = Vector(-2.8018, -3, 0.248)
	SWEP.KKINS2ElcanAng = Vector(0, 0, 0)

	SWEP.KKINS2PO4Pos = Vector(-2.7451, -3, 0.4511)
	SWEP.KKINS2PO4Ang = Vector(0, 0, 0)

	SWEP.KKINS2ScopeM40Pos = Vector(-2.8131, 0, 0.6989)
	SWEP.KKINS2ScopeM40Ang = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.8017, -3, 0.3467)
	SWEP.KKINS2MagnifierAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.022
end

SWEP.Attachments = {
	{header = "Sight", offset = {500, -450}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4", "kk_ins2_scope_m40", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {-100, -450}, atts = {"kk_ins2_suppressor_sec"}},
	{header = "Under", offset = {-400, 0}, atts = {"kk_ins2_bipod"}},
	{header = "Lasers", offset = {225, 400}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1100, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+use"] = {header = "Sight Contract", offset = {500, -0}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {1000, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

if CustomizableWeaponry_KK.HOME then
	-- table.insert(SWEP.Attachments, {header = "Skill1", offset = {2100, -800}, atts = {"kk_aimbot"}})
	-- table.insert(SWEP.Attachments, {header = "Skill2", offset = {2100, -400}, atts = {"kk_wallhaq"}})
	table.insert(SWEP.Attachments, {header = "CSGO", offset = {2100, -200}, atts = {"kk_counter"}})
	table.insert(SWEP.Attachments, {header = "CSGO", offset = {2100, 200}, atts = {"kk_textbox"}})
end

SWEP.Animations = {
	draw = "base_ready",
	reload_start = "",
	insert = "",
	reload_end = "",
	idle = "",	
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire_start",
	base_fire_aim = "iron_fire_start",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_bolt = "base_fire_end",
	base_bolt_aim = "iron_fire_end",
	base_reload_start = "base_reload_start",
	base_reload_start_empty = "base_reload_start",
	base_insert = "base_reload_insert",
	base_reload_end = "base_reload_end_empty",
	base_reload_end_empty = "base_reload_end_empty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	
	bipod_in = "deploy_in",
	bipod_fire = "deployed_fire_start",
	bipod_fire_aim = "deployed_iron_fire_start",
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_bolt = "deployed_fire_end",
	bipod_bolt_aim = "deployed_iron_fire_end",
	bipod_reload_start = "deployed_reload_start",
	bipod_reload_start_empty = "deployed_reload_start",
	bipod_insert = "deployed_reload_insert",
	bipod_reload_end = "deployed_reload_end",
	bipod_reload_end_empty = "deployed_reload_end",
	bipod_out = "deploy_out",
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 2
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_m40a1.mdl"
SWEP.WorldModel		= "models/weapons/w_m40.mdl"

SWEP.WMPos = Vector(4.919, 0.822, -1.236)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 60/33
SWEP.FireSound = "CW_KK_INS2_M40A1_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M40A1_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 66

SWEP.FirstDeployTime = 2.96
SWEP.DeployTime = 0.71

SWEP.RecoilToSpread = 0.8 

SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15

SWEP.ReloadStartTime = 0.9
SWEP.ReloadStartTimeEmpty = 0.9
SWEP.InsertShellTime = 0.825
SWEP.ReloadFinishWait = 1.1
SWEP.ReloadFinishWaitEmpty = 1.1

SWEP.SnapToIdlePostReload = false

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = true
SWEP.ReticleInactivityPostFire = SWEP.FireDelay + 0.3
SWEP.GlobalDelayOnShoot = SWEP.FireDelay

SWEP.WeaponLength = 38

-- function SWEP:updateReloadTimes()
	-- local mode = self:getForegripMode()

	-- if SERVER or not self.shotgunReloading then
		-- self.Animations.reload_start = self.Animations[mode .. "reload_start"]
		-- self.Animations.insert = self.Animations[mode .. "insert"]
		-- self.Animations.reload_end = self.Animations[mode .. "reload_end"]
		-- self.Animations.idle = self.Animations[mode .. "reload_end"]
	-- end
	
	-- if self.base_ReloadStartTime then
		-- self.ReloadStartTime = self[mode .. "ReloadStartTime"] or self.base_ReloadStartTime
	-- end
	-- if self.base_InsertShellTime then
		-- self.InsertShellTime = self[mode .. "InsertShellTime"] or self.base_InsertShellTime
	-- end
	-- if self.base_ReloadFinishWait then
		-- self.ReloadFinishWait = self[mode .. "ReloadFinishWait"] or self.base_ReloadFinishWait
	-- end
-- end

if CLIENT then
	function SWEP:updateOtherParts() // call me clientSideThink
		local vm = self.CW_VM
		local cycle = vm:GetCycle()
		local activity = self.Sequence
		
		if activity:find("reload_start") then
			self.shotgunReloading = true
		end
		
		if activity:find("reload_end") then
			self.shotgunReloading = false
		end
		
		if self.dt.BipodDeployed then
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(1)
		else
			self.AttachmentModelsWM.kk_ins2_bipod.ent:SetSequence(0)
		end
	end	

	function SWEP:playSwitchBipod()
		local isBipod = self.dt.BipodDeployed
		local vm = self.CW_VM
		local cycle = vm:GetCycle()
		local activity = self.Sequence
		
		local canPlay = !(((activity:find("reload") or activity:find("fire_end")) and cycle < 1) or self.shotgunReloading)
		
		if isBipod != self._KK_INS2_wasBipod and self._KK_INS2_wasBipod != nil then
			if canPlay then
				if isBipod then
					self:playAnim("bipod_in") 
				else 
					self:playAnim("bipod_out") 
				end
				self.reticleInactivity = UnPredictedCurTime() + (self.CW_VM:SequenceDuration())
			else
				self.KKINS_postReloadBipodSwitch = true
			end
		end
		if self.KKINS_postReloadBipodSwitch and canPlay then
			if isBipod then
				self:playAnim("bipod_in") 
			else 
				self:playAnim("bipod_out") 
			end
			self.reticleInactivity = UnPredictedCurTime() + (self.CW_VM:SequenceDuration())
			self.KKINS_postReloadBipodSwitch = false
		end
		
		self._KK_INS2_wasBipod = isBipod
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

if CLIENT then
	function SWEP:nametagElementRender()
		local ent = self.AttachmentModelsVM.kk_textbox.ent
		
		local osd = os.date("*t")
		
		ent._KKCSGOOFFSET = 0
		ent._KKCSGOTXT = string.format(
			"T: %02d:%02d:%02d R: %d/%03d", 
			osd.hour, 
			osd.min, 
			osd.sec, 
			self:Clip1(),
			self.Owner:GetAmmoCount(self.Primary.Ammo)
		)
	end
end