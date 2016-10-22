if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "m1Clip"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1 Garand"
	
	SWEP.IconLetter = "n"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.NoShells = true
	
	SWEP.Shell = "KK_INS2_762x54"
	SWEP.ShellEjectVelocity = 150
	
	SWEP.Shell2 = "KK_INS2_GARAND"
	SWEP.Shell2EjectVelocity = 150
	SWEP.Shell2ViewAngleAlign = {Forward = 0, Right = 30, Up = -90}
	SWEP.Shell2WorldAngleAlign = {Forward = 0, Right = 0, Up = 90}
	
	SWEP.BackupSights = {
		["kk_ins2_scope_m82"] = {
			Vector(-2.4643, -2, 1.1174),
			Vector(-0.4782, 0.006, 0)
		},
	}
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_iron_garand_l.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_iron_garand_s.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_scope_m82"] = {model = "models/weapons/upgrades/a_optic_garand.mdl", pos = Vector(), angle = Angle(), size = Vector(0.075, 0.075, 0.075), merge = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_garand_bayonet.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/w_garand_bayonet.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}
	
	SWEP.IronsightPos = Vector(-2.4643, -2, 1.1174)
	SWEP.IronsightAng = Vector(-0.4782, 0.006, 0)

	SWEP.FoldSightPos = Vector(-2.4643, -2, 1.1174)
	SWEP.FoldSightAng = Vector(-0.4782, 0.006, 0)

	SWEP.KKINS2ScopeM82Pos = Vector(-1.3779, -3.5, 0.7695)
	SWEP.KKINS2ScopeM82Ang = Vector()

	SWEP.CustomizationMenuScale = 0.02
end

SWEP.MuzzleEffect = "muzzleflash_garand_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_garand_3p"

SWEP.SightBGs = {main = 0, foldsight = 0}

SWEP.Attachments = {
	{header = "Sight", offset = {400, -500}, atts = {"bg_foldsight", "kk_ins2_scope_m82"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	{header = "Stock", offset = {1000, 0}, atts = {"kk_ins2_ww2_sling"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "base_draw_empty",
	base_fire = {"base_fire_1","base_fire_2"},
	base_fire_aim = {"iron_fire_1", "iron_fire_2", "iron_fire_3"},
	base_fire_last = "base_fire_last",
	base_fire_last_aim = "iron_fire_last",
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reloadfull",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_idle_empty = "empty_idle",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_sprint_knife = "base_sprint_bayonet",
	base_sprint_knife_empty = "base_sprint_bayonet_empty",
	base_safe = "base_down",
	base_safe_empty = "base_down_empty",
	base_safe_aim = "iron_down",
	base_safe_empty_aim = "iron_down_empty",
	base_crawl = "base_crawl",
	base_crawl_empty = "base_crawl_empty",
	
	base_melee = "base_melee",
	base_melee_empty = "base_melee_empty",
}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_garand.mdl"
SWEP.WorldModel		= "models/weapons/w_garand.mdl"

SWEP.WMPos = Vector(14.986, 0.921, -3.038)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2us
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".30-06"

SWEP.FireDelay = 0.17
SWEP.FireSound = "CW_KK_INS2_DOI_GARAND_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_M14_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 59

SWEP.FirstDeployTime = 2
SWEP.DeployTime = 0.7
SWEP.HolsterTime = 0.5

SWEP.RecoilToSpread = 0.8 

SWEP.Chamberable = false
SWEP.KK_INS2_EmptyIdle = true

SWEP.WeaponLength = 22

SWEP.MuzzleVelocity = 853

SWEP.ReloadTimes = {
	base_reloadfull = {4, 5.13, KK_INS2_REVOLVER_SPEED_UNLOAD, 1.1},
	base_reloadempty = {2.2, 3.33},
}

SWEP.freezeBeltOnStart = {
	base_reloadfull = true
}

if CLIENT then
	local bone = 66
	local dir = Vector(0,0,-1)

	local vm, att, pos, ang, velocity, align, shellEnt

	function SWEP:shellEvent2()
		if self.Owner:ShouldDrawLocalPlayer() then
			vm = self:getMuzzleModel()
			
			att = vm:GetAttachment(self.ShellWorldAttachmentID)
			
			pos = att.Pos
			ang = att.Ang
			velocity = self.Owner:GetVelocity() + ang:Forward() * (50)
			
			align = self.Shell2WorldAngleAlign
			ang:RotateAroundAxis(ang:Right(), align.Right)
			ang:RotateAroundAxis(ang:Forward(), align.Forward)
			ang:RotateAroundAxis(ang:Up(), align.Up)
			
			CustomizableWeaponry_KK.ins2.shells:make(
				pos,
				ang,
				velocity,
				self._shellTable2,
				self.Shell2Scale
			)
		else
			vm = self.CW_VM
			
			att = vm:GetBoneMatrix(bone)
			
			pos = att:GetTranslation()
			ang = att:GetAngles()
			velocity = self.Owner:GetVelocity() + dir * (self.Shell2EjectVelocity or 200)
			
			align = self.Shell2ViewAngleAlign
			ang:RotateAroundAxis(ang:Right(), align.Right)
			ang:RotateAroundAxis(ang:Forward(), align.Forward)
			ang:RotateAroundAxis(ang:Up(), align.Up)
			
			shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
				pos,
				ang,
				velocity,
				self._shellTable2,
				self.Shell2Scale
			)
		end
	end
end
