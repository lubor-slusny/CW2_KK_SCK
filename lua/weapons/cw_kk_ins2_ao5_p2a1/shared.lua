if not CustomizableWeaponry then return end

local spawnable = file.Exists("models/weapons/aof/v_flashgun.mdl", "GAME") and file.Exists("models/weapons/aof/w_flashgun.mdl", "GAME")

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK P2A1: M84 Legend"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectFont = "HL2MPTypeDeath"
	SWEP.IconLetter = "7"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.NoShells = true
	SWEP.Shell = "KK_INS2_12guage"
	
	SWEP.AttachmentModelsVM = {}
	
	SWEP.IronsightPos = Vector(-2.4598, -2, 0.5881)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.01
	SWEP.ReloadViewBobEnabled = false
	SWEP.HUD_MagText = "BREECH: "
end

SWEP.Chamberable = false
SWEP.SnapToIdlePostReload = false
SWEP.ShotgunReload = false

SWEP.Attachments = {
	-- ["+reload"] = {header = "Ammo", offset = {0, 0}, atts = {"am_slugrounds", "am_flechetterounds"}}
}

SWEP.KK_INS2_EmptyIdle = true

SWEP.Animations = {
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
	base_crawl = "base_crawl",
	base_crawl_empty = "empty_crawl",
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 AO5"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/aof/v_flashgun.mdl"
SWEP.WorldModel		= "models/weapons/aof/w_flashgun.mdl"

SWEP.WMPos = Vector(5.243, 1.562, -1.657)
SWEP.WMAng = Vector(-1, -5, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted() and spawnable
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted() and spawnable

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Flash Grenades"

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
SWEP.Shots = 12
SWEP.Damage = 10

SWEP.FirstDeployTime = 1.5
SWEP.DeployTime = 0.5
SWEP.HolsterTime = 0.5

SWEP.ReloadTimes = {
	base_reload = {3.15, 5.17}
}

function SWEP:FireBullet()
	if SERVER then
		local pos = self.Owner:GetShootPos()
		local eyeAng = self.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		local offset = /*forward * 30 +*/ eyeAng:Right() * 4 - eyeAng:Up() * 3
		
		local nade = ents.Create("cw_kk_ins2_projectile_m84")
		
		nade.Model = "models/weapons/w_m84.mdl"
		
		eyeAng:RotateAroundAxis(eyeAng:Right(), 90)
		
		nade:SetPos(pos + offset)
		nade:SetAngles(eyeAng)
		nade:Spawn()
		nade:Activate()
		nade:SetOwner(self:GetOwner())
		
		nade:Fuse(1.8)
		
		local phys = nade:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:SetVelocity(forward * 3395.6625)
		end
	end
end

if CLIENT then
	local down = Vector(0,0,10)
	
	function SWEP:updateOtherParts()
		local cyc = self.CW_VM:GetCycle()
		
		if self.Sequence == self.Animations.base_reload and cyc > 0.28 and cyc < 0.5 then
			if self._shellCoolDown and self._shellCoolDown > CurTime() then
				return
			end
			
			self._shellCoolDown = CurTime() + 3
			
			local att = self.CW_VM:GetAttachment(2)
			local dir = att.Ang:Forward()
			local pos = att.Pos + dir * 10
			local ang = self.Owner:EyeAngles()
			ang:RotateAroundAxis(ang:Up(), 180)
			
			CustomizableWeaponry_KK.ins2.shells:make(pos, ang, down, self._shellTable, 1)
		end
	end
end