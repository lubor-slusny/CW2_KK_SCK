if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "lmgBox"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MG-42"
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.Shell = "KK_INS2_762x54"
	SWEP.Shell2 = "KK_INS2_556x45_link"

	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.CustomizePos = Vector(6.488, -1.627, -2.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.IronsightPos = Vector(-2.3517, -2, 1.2473)
	SWEP.IronsightAng = Vector(0.0334, 0, 0)

	SWEP.CustomizationMenuScale = 0.015
end

SWEP.Attachments = {
	["+reload"] = {header = "Ammo", offset = {200, 600}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	draw = "base_ready",
	
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire_1","base_fire_2"},
	base_fire_aim = {"iron_fire_1","iron_fire_2"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",				// tacticool
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
	bipod_reload = "deployed_reload",
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
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_mg42.mdl"
SWEP.WorldModel		= "models/weapons/w_mg42.mdl"

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2de
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.ww2de

SWEP.WMPos = Vector(13.486, 0.5, -3)
SWEP.WMAng = Vector(-5, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 250
SWEP.Primary.DefaultClip	= 250
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.92x57MM"

SWEP.FireDelay = 60/1200
SWEP.FireSound = "CW_KK_INS2_WW2_MG42_FIRE"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 60

SWEP.BipodDeployTime = 2.18
SWEP.BipodUndeployTime = 1.73

SWEP.FirstDeployTime = 3.13
SWEP.DeployTime = 0.83

SWEP.ReloadTimes = {
	base_reload = {6.2, 8.21},
	base_reload_empty = {6.94, 8.96},
	
	deployed_reload = {6, 7.97},
	deployed_reload_empty = {6.95, 8.96},
}

SWEP.Chamberable = false
SWEP.BipodInstalled = true
SWEP.WeaponLength = 26

SWEP.MuzzleVelocity = 740

if CLIENT then
	function SWEP:updateOtherParts()
		local vm = self.CW_VM
		local cycle = vm:GetCycle()
		
		local clip = self:Clip1()
		local ammo
		
		if self.getFullestMag then
			ammo = math.max(self:Clip1(), self:getFullestMag(), -1)
		else
			ammo = self.Owner:GetAmmoCount(self.Primary.Ammo) + clip
		end
		
		if self.Sequence:find("reload") and cycle > 0.4 and cycle < 1 then
			self:setBodygroup(1,math.Clamp(ammo,0,18))
		else
			self:setBodygroup(1,math.Clamp(clip,0,18))
		end
		
		if self.dt.BipodDeployed then
			self:SetSequence(1)
		else
			self:SetSequence(0)
		end
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
		
		makeShell(self, att.Pos, ang, att.Ang:Forward() * 50, 0.6, 10)
		
		-- // shell link
		self._shellTable = self._shellTable2
		att = self.CW_VM:GetAttachment(2)
		ang = EyeAngles()
		tweak = self._shellTable.rv
		if tweak then
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
		end
		
		makeShell(self, att.Pos, ang, att.Ang:Forward() * 30, 0.6, 10)
	end
end