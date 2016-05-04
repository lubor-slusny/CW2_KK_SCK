if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_anims.lua")
AddCSLuaFile("sh_callbacks.lua")
AddCSLuaFile("sh_utilities.lua")

AddCSLuaFile("o_cl_hud.lua")
AddCSLuaFile("o_cl_model.lua")
AddCSLuaFile("o_sh_attacks.lua")
AddCSLuaFile("o_sh_m203.lua")
AddCSLuaFile("o_sh_think.lua")
AddCSLuaFile("o_shared.lua")

include("sh_anims.lua")
include("sh_callbacks.lua")
include("sh_utilities.lua")

include("o_sh_attacks.lua")
include("o_sh_m203.lua")
include("o_sh_think.lua")
include("o_shared.lua")

if CLIENT then
	include("o_cl_hud.lua")
	include("o_cl_model.lua")
end

SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Knife Kitty"
SWEP.Contact		= "http://steamcommunity.com/profiles/76561198012236670/"
SWEP.Purpose		= "detaching shared functions"
SWEP.Instructions	= "dont spawn this directly, have phun"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.LuaViewmodelRecoil = false

SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15
SWEP.TSGlass = Material("models/weapons/optics/lense_rt")

SWEP.KKINS2Wep = true
SWEP.FirstDeployTime = 5
SWEP.WeaponLength = 20

SWEP.AttachmentExclusions = {
	["bg_foldsight"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
	["kk_ins2_cstm_acog"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_cmore"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_barska"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_microt1"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_sureshot"] = {"kk_ins2_magnifier"},
	["kk_ins2_aimpoint"] = {"kk_ins2_sights_cstm"},
	["kk_ins2_elcan"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
	["kk_ins2_eotech"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
	["kk_ins2_kobra"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
	["kk_ins2_po4"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
	["kk_ins2_scope_m40"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
	["kk_ins2_scope_mosin"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
}

SWEP.AttachmentDependencies = {
	-- ["kk_ins2_aimpoint"] = {"kk_ins2_sights_base"},
	-- ["kk_ins2_elcan"] = {"kk_ins2_sights_base"},
	-- ["kk_ins2_eotech"] = {"kk_ins2_sights_base"},
	-- ["kk_ins2_kobra"] = {"kk_ins2_sights_base"},
	-- ["kk_ins2_po4"] = {"kk_ins2_sights_base"},
	-- ["kk_ins2_scope_m40"] = {"kk_ins2_sights_base"},
	-- ["kk_ins2_scope_mosin"] = {"kk_ins2_sights_base"},
	
	["kk_ins2_cstm_cmore"] = {"kk_ins2_sights_cstm"},
	["kk_ins2_cstm_barska"] = {"kk_ins2_sights_cstm"},
	["kk_ins2_cstm_eotechxps"] = {"kk_ins2_sights_cstm"},
	["kk_ins2_cstm_microt1"] = {"kk_ins2_sights_cstm"},
	["kk_ins2_cstm_compm4s"] = {"kk_ins2_sights_cstm"},
	["kk_ins2_cstm_acog"] = {"kk_ins2_sights_cstm"},
}

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.m67
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.bayonet
SWEP.CW_KK_40MM_MDL = "models/weapons/upgrades/a_projectile_m203.mdl"
	
if CLIENT then	
	SWEP.PosBasedMuz = true
	
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.ShellAttachmentName = "shell"
	SWEP.ShellScale = 1
	
	SWEP.WorldMuzzleAttachmentID = 1
	SWEP.WorldShellEjectionAttachmentID = 2
	
	SWEP.SwayIntensity = 0.7
	SWEP.AimSwayIntensity = 0.3
	SWEP.ZoomAmount = 0
	SWEP.FOVPerShot = 0
	
	SWEP.SprintAnimSpeed = 1.5
	SWEP.ViewModelMovementScale_sprint = 0
	SWEP.ViewModelMovementScale_base = 1
	
	SWEP.CW_KK_HANDS_MDL = "models/weapons/v_hands_vip.mdl"
	
	SWEP.knifeTime = 0
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(0, 0, 0)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.LaserPosAdjust = Vector(0, 0, 0) 
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
	
	SWEP.IronsightPos = Vector(0, 0, 0)
	SWEP.IronsightAng = Vector(0, 0, 0)

	// aim positions
	
	SWEP.KKINS2AimpointPos = Vector(0, 0, 0)
	SWEP.KKINS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.KKINS2EoTechPos = Vector(0, 0, 0)
	SWEP.KKINS2EoTechAng = Vector(0, 0, 0)
	
	SWEP.KKINS2KobraPos = Vector(0, 0, 0)
	SWEP.KKINS2KobraAng = Vector(0, 0, 0)
	
	SWEP.KKINS2MagnifierPos = Vector(0, 0, 0)
	SWEP.KKINS2MagnifierAng = Vector(0, 0, 0)
	
	SWEP.KKINS2PO4Pos = Vector(0, 0, 0)
	SWEP.KKINS2PO4Ang = Vector(0, 0, 0)
	
	SWEP.KKINS2ScopeM40Pos = Vector(0, 0, 0)
	SWEP.KKINS2ScopeM40Ang = Vector(0, 0, 0)
	
	SWEP.KKINS2ScopeMosinPos = Vector(0, 0, 0)
	SWEP.KKINS2ScopeMosinAng = Vector(0, 0, 0)
	
	SWEP.KKINS2ElcanPos = Vector(0, 0, 0)
	SWEP.KKINS2ElcanAng = Vector(0, 0, 0)
	
	// Custom sights
	
	-- SWEP.KKINS2CSTMACOGPos = Vector(0, 0, 0)
	-- SWEP.KKINS2CSTMACOGAng = Vector(0, 0, 0)
	
	-- SWEP.KKINS2CSTMCMorePos = Vector(0, 0, 0)
	-- SWEP.KKINS2CSTMCMoreAng = Vector(0, 0, 0)
	
	-- SWEP.KKINS2CSTMBarskaPos = Vector(0, 0, 0)
	-- SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)
	
	-- SWEP.KKINS2CSTMCompM4SPos = Vector(0, 0, 0)
	-- SWEP.KKINS2CSTMCompM4SAng = Vector(0, 0, 0)
	
	-- SWEP.KKINS2CSTMEoTechXPSPos = Vector(0, 0, 0)
	-- SWEP.KKINS2CSTMEoTechXPSAng = Vector(0, 0, 0)
	
	-- SWEP.KKINS2CSTMMicroT1Pos = Vector(0, 0, 0)
	-- SWEP.KKINS2CSTMMicroT1Ang = Vector(0, 0, 0)
	
	-- SWEP.KKINS2CSTMSureShotPos = Vector(0, 0, 0)
	-- SWEP.KKINS2CSTMSureShotAng = Vector(0, 0, 0)
	
	// WW2
	
	SWEP.KKINS2ScopeZF4Pos = Vector(0, 0, 0)
	SWEP.KKINS2ScopeZF4Ang = Vector(0, 0, 0)
	
	-- SWEP.CustomizePos = Vector(0, 0, 0)
	-- SWEP.CustomizeAng = Vector(0, 0, 0)
end
	
local SP = game.SinglePlayer()
local shouldDrawCrosshair, cycle, canDoStuff, wasSprint, isSprint, wasSafe, isSafe

function SWEP:IndividualThink()
	self:DrawShadow(false)
	
	if CLIENT then
		shouldDrawCrosshair = self.Owner:ShouldDrawLocalPlayer()
		self.CrosshairEnabled = shouldDrawCrosshair
		self.FadeCrosshairOnAim = !shouldDrawCrosshair
		
		self.NoFreeAim = self:getPrimarySight() != nil // and self:isAiming()
		
		if !SP and not IsFirstTimePredicted() then return end
		
		// I can afford coz times are based on anims
		// and anims are based purely on attachments
		// (FAS2 M60 has stuff based on attachments AND current clip)
		self:updateReloadTimes()
		
		// and now, cosmetix
		
		self:updateStandardParts()
		
		self:playSwitchBipod()
		
		cycle = self.CW_VM:GetCycle()
		
		canDoStuff = 
			(self.dt.State != CW_CUSTOMIZE) and 
			(self.dt.State != CW_ACTION) and 
			self:isReticleActive() and 
			not (self.Base == "cw_kk_ins2_nade_base" and self.dt.PinPulled) and
			not self:isReloading() and
			not (self.GlobalDelay > CurTime()) and
			not (self.Sequence:find("ready") and cycle < 1) and
			not (self.Sequence:find("reload") and cycle < 1) and
			-- self._KK_INS2_PickedUp and
			-- not self.ShotgunReload and
			true
		
		wasSprint = self._KK_INS2_wasSprint
		isSprint = self:isRunning()
		
		isSprint = isSprint and canDoStuff
		
		if isSprint != wasSprint and wasSprint != nil then
			if isSprint then
				self:sprintAnimFunc()
			elseif canDoStuff then
				self:idleAnimFunc()
			end
		end
		
		self._KK_INS2_wasSprint = isSprint
		
		if isSprint then return end
		if self.Base == "cw_kk_ins2_mel_base" then return end
		
		wasSafe = self._KK_INS2_wasSafe
		isSafe = self.dt.Safe or self:isNearWall()
		
		isSafe = isSafe and canDoStuff
		
		if canDoStuff then
			if isSafe then
				self:safetyAnimFunc()
			elseif isSafe != wasSafe then
				self:idleAnimFunc()
			end
		elseif wasSafe then 
			if (self.dt.State == CW_CUSTOMIZE) then
				self:idleAnimFunc()
			end
		end
		
		self._KK_INS2_wasSafe = isSafe
	end
end

function SWEP:Initialize()
	self:updateReloadTimes()
	
	weapons.GetStored("cw_base").Initialize(self)
	self:PrepareForPickup()
end

function SWEP:unloadWeapon()
	if self.dt.State != CW_CUSTOMIZE then return end
	
	weapons.GetStored("cw_base").unloadWeapon(self)
	
	if CLIENT then
		if self.KK_INS2_emptyIdle then
			self:idleAnimFunc()
		end
	end
end

function SWEP:unloadMagazine()
	if self.dt.State != CW_CUSTOMIZE then return end
	
	weapons.GetStored("cw_base").unloadMagazine(self)
end

// majority of First deploy logic

function SWEP:OnDrop()
	self:PrepareForPickup(true)
end

local prefix, suffix

function SWEP:PrepareForPickup(drop)
	self._KK_INS2_PickedUp = false
	
	CustomizableWeaponry.actionSequence.new(self, 0.1, nil, function()
		if !SP and IsFirstTimePredicted() then
			self:drawAnimFunc()
		end
		
		if self.KK_INS2_emptyIdle and self:Clip1() == 0 then return end
		
		if drop then
			self:setGlobalDelay(self.FirstDeployTime - 0.2)
		else
			self:setGlobalDelay(self.FirstDeployTime - 0.1)
			-- self:SetClip1(self.Primary.ClipSize)
		end
	end)
	
	if SERVER then
		self.dt.INS2GLActive = false
	
		if !SP then
			umsg.Start("CW20_KK_INS_PREPAREFORPICKUP")
				umsg.Entity(self)
			umsg.End()
		end
	else
		if !SP then
			prefix = self:getForegripMode()
			suffix = ""
			
			if self:Clip1() == 0 and self.KK_INS2_emptyIdle then
				suffix = "_empty"
			end
			
			self:sendWeaponAnim(prefix .. "holster" .. suffix,1,1)
		end
	end
end

if CLIENT then
	usermessage.Hook("CW20_KK_INS_PREPAREFORPICKUP", function(um)
		local wep = um:ReadEntity()
		if !IsValid(wep) or wep.Base != "cw_kk_ins2_base" then return end
		
		wep:PrepareForPickup()
	end)
end
