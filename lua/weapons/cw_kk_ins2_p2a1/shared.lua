if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK P2A1"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.SelectFont = "HL2MPTypeDeath"
	SWEP.IconLetter = "7"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.NoShells = true
	
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
SWEP.ReticleInactivityPostFire = 0.8

SWEP.Attachments = {
	-- ["+reload"] = {header = "Ammo", offset = {0, 0}, atts = {"am_slugrounds", "am_flechetterounds"}}
}

SWEP.KK_INS2_emptyIdle = true

SWEP.Animations = {
	draw = "base_ready",

	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire_last = "base_fire",
	base_fire_last_aim = "iron_fire",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "base_dryfire",
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
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},

	base_reload = {
		{time = 18/30, sound = "CW_KK_INS2_P2A1_OPENBARREL"},
		{time = 39/30, sound = "CW_KK_INS2_P2A1_REMOVEFLARE"},
		{time = 61/30, sound = "CW_KK_INS2_P2A1_FlareDrop"},
		{time = 75/30, sound = "CW_KK_INS2_P2A1_INSERTFLARESTART"},
		{time = 90/30, sound = "CW_KK_INS2_P2A1_INSERTFLARE"},
		{time = 113/30, sound = "CW_KK_INS2_P2A1_CLOSEBARREL"},
		{time = 129/30, sound = "CW_KK_INS2_P2A1_COCKHAMMER"},
	},

	empty_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	empty_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	empty_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
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
SWEP.ViewModel		= "models/weapons/v_p2a1.mdl"
SWEP.WorldModel		= "models/weapons/w_p2a1.mdl"

SWEP.WMPos = Vector(5.243, 1.562, -1.657)
SWEP.WMAng = Vector(-1, -5, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Flare"

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

SWEP.FirstDeployTime = 0.5
SWEP.DeployTime = 0.5

SWEP.ReloadTime = 3.15
SWEP.ReloadTime_Empty = 3.15
SWEP.ReloadHalt = 5.17
SWEP.ReloadHalt_Empty = 5.17

function SWEP:FireBullet()
	if SERVER then
		local pos = self.Owner:GetShootPos()
		local eyeAng = self.Owner:EyeAngles()
		local forward = eyeAng:Forward()
		local offset = /*forward * 30 +*/ eyeAng:Right() * 4 - eyeAng:Up() * 3
		
		local nade = ents.Create("cw_kk_ins2_projectile_flare")
		nade:SetPos(pos + offset)
		nade:SetAngles(eyeAng)
		nade:Spawn()
		nade:Activate()
		nade:SetOwner(self:GetOwner())
		
		local phys = nade:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:SetVelocity(forward * 3395.6625)
		end
	end
end