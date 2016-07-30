if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_anims.lua")
AddCSLuaFile("sh_callbacks.lua")
AddCSLuaFile("sh_utilities.lua")
AddCSLuaFile("sv_hooks.lua")

AddCSLuaFile("cl_shells.lua")
AddCSLuaFile("o_cl_calcview.lua")
AddCSLuaFile("o_cl_hud.lua")
AddCSLuaFile("o_cl_model.lua")
AddCSLuaFile("o_sh_attacks.lua")
AddCSLuaFile("o_sh_m203.lua")
AddCSLuaFile("o_sh_think.lua")
AddCSLuaFile("o_shared.lua")

include("sh_anims.lua")
include("sh_callbacks.lua")
include("sh_utilities.lua")
include("sv_hooks.lua")

include("o_sh_attacks.lua")
include("o_sh_m203.lua")
include("o_sh_think.lua")
include("o_shared.lua")

if CLIENT then
	include("cl_shells.lua")
	include("o_cl_calcview.lua")
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

SWEP.TSGlass = Material("models/weapons/optics/lense_rt")

SWEP.NoFreeAim = true
SWEP.LuaViewmodelRecoil = false
SWEP.BipodDeployTime = 1.15
SWEP.BipodUndeployTime = 1.15
SWEP.HolsterTime = 0.4

SWEP.KK_IGNORE_MAGSYS_TWEAK = true

SWEP.KKINS2Wep = true
SWEP.KKINS2RCE = false
SWEP.KKINS2Melee = false
SWEP.KKINS2Nade = false
SWEP.KK_INS2_EmptyIdle = false

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.models.m67
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.models.bayonet
SWEP.CW_KK_40MM_MDL = "models/weapons/upgrades/a_projectile_m203.mdl"

SWEP.FirstDeployTime = 5
SWEP.WeaponLength = 20

if CLIENT then	
	SWEP.PosBasedMuz = true
	
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.WorldMuzzleAttachmentID = 1
	
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 0
	SWEP.ShellViewAttachmentName = "shell"
	SWEP.ShellViewAngleAlign = {Forward = 0, Right = 0, Up = 0}
	SWEP.ShellWorldAttachmentID = 2
	SWEP.ShellWorldAngleAlign = {Forward = 0, Right = 0, Up = 0}
	
	SWEP.Shell2 = false
	
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
end

SWEP.AttachmentExclusions = {
	["bg_foldsight"] = {"kk_ins2_magnifier", "kk_ins2_sights_cstm"},
	["kk_ins2_cstm_acog"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_cmore"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_barska"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_microt1"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_sureshot"] = {"kk_ins2_magnifier"},
	["kk_ins2_cstm_susat"] = {"kk_ins2_magnifier"},
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
	["kk_ins2_cstm_susat"] = {"kk_ins2_sights_cstm"},
}

local SP = game.SinglePlayer()
local shouldDrawCrosshair, cycle, canDoStuff, wasSprint, isSprint, wasSafe, isSafe

function SWEP:CW_KK_MELEE()
	if SERVER then
		if self._KK_INS2_PickedUp == false then return end
		if self.meleeAttackDelay and self.meleeAttackDelay > CurTime() then return end
	
		if self.KKINS2Melee then
			self:PrimaryAttack()
			
			self.meleeAttackDelay = CurTime() + self.FireDelay
			return
		end
		
		if CustomizableWeaponry_KK.ins2.canKnife(self) then
			CustomizableWeaponry_KK.ins2.meleeKnife(self)
		end
	end
end

function SWEP:IndividualThink()
	self:DrawShadow(false)
	
	if CLIENT then
		-- self.NoFreeAim = self:isAiming()
		shouldDrawCrosshair = self.Owner:ShouldDrawLocalPlayer()
		self.CrosshairEnabled = shouldDrawCrosshair
		self.FadeCrosshairOnAim = !shouldDrawCrosshair
		
		if !SP and not IsFirstTimePredicted() then return end
		
		if self.Slot != 2 and self.Slot != 3 then
			if self.Sequence:find("sprint") then
				self.ViewModelMovementScale = self.ViewModelMovementScale_sprint
			else
				self.ViewModelMovementScale = self.ViewModelMovementScale_base
			end
		end
		
		// 2b removed
		// I guess
		self:updateReloadTimes()
		
		// and now, cosmetix
		
		self:updateHands()
		self:updateOtherParts()
		
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
	-- print(self:GetClass() .. ":Initialize()", "@", CurTime())
	
	self:updateReloadTimes()
	
	weapons.GetStored("cw_base").Initialize(self)
	
	self:PrepareForPickup()
end

function SWEP:unloadWeapon(force)
	if !force and self.dt.State != CW_CUSTOMIZE then return end
	
	weapons.GetStored("cw_base").unloadWeapon(self)
	
	if SERVER then
		if self.usesMagazines and self:usesMagazines() then
			weapons.GetStored("cw_base").unloadMagazine(self)
		end
	end
	
	if CLIENT then
		if self.KK_INS2_EmptyIdle then
			self:idleAnimFunc()
		end
	end
end

// majority of First deploy logic

function SWEP:OnDrop(...)
	self:PrepareForPickup(true)
	
	-- if self.allocatedMags and #self.allocatedMags > 0 then
		-- for key, roundCount in ipairs(self.allocatedMags) do
			-- self.Owner:GiveAmmo(roundCount, self.Primary.Ammo, true)
		-- end
		
		-- self.Owner:cwAddMagazine(self.magType, #self.allocatedMags)
	-- end
end

local prefix, suffix

function SWEP:PrepareForPickup(drop)
	self._KK_INS2_PickedUp = false
	
	CustomizableWeaponry.actionSequence.new(self, 0.1, nil, function()
		if !SP and IsFirstTimePredicted() then
			self:drawAnimFunc()
		end
		
		if self.KK_INS2_EmptyIdle and self:Clip1() == 0 then return end
		
		if drop then
			self:setGlobalDelay(self.FirstDeployTime - 0.2)
		else
			self:setGlobalDelay(self.FirstDeployTime - 0.1)
			-- self:SetClip1(self.Primary.ClipSize)
		end
	end)
	
	CustomizableWeaponry.actionSequence.new(self, self.FirstDeployTime - 0.5, nil, function()
		self._KK_INS2_PickedUp = true
	end)
	
	if SERVER then
		self.dt.INS2GLActive = false
	
		if !SP then
			umsg.Start("CW_KK_INS2_PREPAREFORPICKUP")
				umsg.Entity(self)
			umsg.End()
		end
	else
		if !SP then
			prefix = self:getForegripMode()
			suffix = ""
			
			if self:Clip1() == 0 and self.KK_INS2_EmptyIdle then
				suffix = "_empty"
			end
			
			self:sendWeaponAnim(prefix .. "holster" .. suffix,1,1)
		end
	end
end

if CLIENT then
	usermessage.Hook("CW_KK_INS2_PREPAREFORPICKUP", function(um)
		local wep = um:ReadEntity()
		if !IsValid(wep) or wep.Base != "cw_kk_ins2_base" then return end
		
		wep:PrepareForPickup()
	end)
end

function SWEP:toggleGLMode(IFTP)
	if self._currentGrenadeLauncher.ww2GrenadeLauncher then
		if self.dt.INS2GLActive then
			self.dt.INS2GLActive = false
			
			if self.M203Chamber then
				if (SERVER and SP) or (CLIENT and !SP and IFTP) then
					self:sendWeaponAnim("gl_turn_off",1,0)
				end
				self:delayEverything(self.gl_off_time or 7)
			else
				if (SERVER and SP) or (CLIENT and !SP and IFTP) then
					self:sendWeaponAnim("gl_turn_off_empty",1,0)
				end
				self:delayEverything(self.gl_off_shot_time or 2)
			end
			
			self:unloadM203()
		else
			if self.Owner:GetAmmoCount("40MM") < 1 then 
				return 
			end
			
			self.dt.INS2GLActive = true
			
			if (SERVER and SP) or (CLIENT and !SP and IFTP) then
				if self:Clip1() > 0 then
					self:sendWeaponAnim("gl_turn_on_full",1,0)
				else
					self:sendWeaponAnim("gl_turn_on",1,0)
				end
			end
			
			CustomizableWeaponry.actionSequence.new(self, self.gl_on_ReloadTime, nil, function()
				self.M203Chamber = true
				if SERVER then
					self.Owner:RemoveAmmo(1, "40MM")
					SendUserMessage("CW_KK_INS2_READYM203", self.Owner)
				end
			end)
			
			self:delayEverything(self.gl_on_time or 7)
		end
	else
		if self.dt.INS2GLActive then
			self.dt.INS2GLActive = false
			
			if (SERVER and SP) or (CLIENT and !SP and IFTP) then
				self:sendWeaponAnim("gl_turn_off",1.5,0)
			end
		else
			self.dt.INS2GLActive = true
			
			if (SERVER and SP) or (CLIENT and !SP and IFTP) then
				self:sendWeaponAnim("gl_turn_on",1.5,0)
			end
		end
		
		self:delayEverything(0.6)
	end
end
