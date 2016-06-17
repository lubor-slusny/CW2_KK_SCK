if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_soundscript.lua")
include("sh_soundscript.lua")

local spawnable = file.Exists("models/weapons/aof/v_m79.mdl", "GAME") and file.Exists("models/weapons/aof/w_m79.mdl", "GAME")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "[AO5] M79"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectFont = "HL2MPTypeDeath"
	SWEP.IconLetter = "7"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.NoShells = true
	SWEP.Shell = "KK_INS2_40mm"
	
	SWEP.AttachmentModelsVM = {}
	
	SWEP.IronsightPos = Vector(-2.3908, -2, 0.3153)
	SWEP.IronsightAng = Vector(0.9848, 0, 0)

	SWEP.ReloadViewBobEnabled = false
	SWEP.HUD_MagText = "BREECH: "
	SWEP.CustomizationMenuScale = 0.015
end

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = false
SWEP.ReticleInactivityPostFire = 0.8

SWEP.Attachments = {
	{header = "", offset = {500, 0}, atts = {"kk_ins2_gp25_ammo"}},
}

SWEP.KK_INS2_EmptyIdle = true

SWEP.Animations = {
	draw = "base_ready",

	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire_last = "base_fire",
	base_fire_last_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reload",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "empty_holster",
	base_sprint = "base_sprint",
	base_sprint_empty = "empty_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_safe_empty = "empty_down",
	base_safe_empty_aim = "empty_iron_down",
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/aof/v_m79.mdl"
SWEP.WorldModel		= "models/weapons/aof/w_m79.mdl"

SWEP.WMPos = Vector(5.243, 1.562, -1.657)
SWEP.WMAng = Vector(-15, 1, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted() and spawnable
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted() and spawnable

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "40MM"

SWEP.FireDelay = 0.8
SWEP.FireSound = "CW_KK_INS2_P2A1_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_P2A1_FIRE"
SWEP.Recoil = 3

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 1
SWEP.Damage = 10

SWEP.FirstDeployTime = 0.5
SWEP.DeployTime = 0.5

SWEP.ReloadTime = 4.6
SWEP.ReloadTime_Empty = 4.6
SWEP.ReloadHalt = 5.17
SWEP.ReloadHalt_Empty = 5.17

function SWEP:FireBullet(Damage, CurCone, ClumpSpread, Shots)
	if Shots == 1 then
		local target = CustomizableWeaponry.grenadeTypes.registered[self.Grenade40MM]

		if not target then
			CustomizableWeaponry.grenadeTypes.defaultFireFunc(self)
		else
			target.fireFunc(self)
		end
		
		CustomizableWeaponry.grenadeTypes.selectFireSound(self, target)
	else
		weapons.GetStored("cw_base").FireBullet(self, Damage, CurCone, ClumpSpread, Shots)
	end
end

if CLIENT then
	local down = Vector(0,0,10)
	
	function SWEP:updateOtherParts()
		local cyc = self.CW_VM:GetCycle()
		
		if self.Sequence == self.Animations.base_reload and cyc > 0.25 and cyc < 0.4 then
			if self._shellCoolDown and self._shellCoolDown > CurTime() then
				return
			end
			
			self._shellCoolDown = CurTime() + 3
			
			local att = self.CW_VM:GetAttachment(2)
			local dir = att.Ang:Forward()
			local pos = att.Pos + dir * 10
			local ang = self.Owner:EyeAngles()
			ang:RotateAroundAxis(ang:Up(), 180)
			
			CustomizableWeaponry_KK.ins2.makeShell(self, pos, ang, down, 0.6, 10)
		end
	end
end