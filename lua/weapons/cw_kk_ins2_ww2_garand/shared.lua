if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1 Garand"
	
	SWEP.IconLetter = "n"
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "KK_INS2_762x54"
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_iron"] = {model = "models/weapons/upgrades/a_standard_garand.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, active = true},
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_m1a1.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},
		
		["kk_ins2_ww2_knife"] = {model = "models/weapons/upgrades/a_bayonet.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_scope_zf4"] = {model = "models/weapons/upgrades/a_optic_zf4.mdl", pos = Vector(0,0,-3.5), angle = Angle(90, 0, 90), size = Vector(1, 1, 1), attachment = "Optic"},
		
		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 1.2},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska_l.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = true, retSizeMult = 1.2},
	}

	SWEP.IronsightPos = Vector(-2.4643, -2, 1.1174)
	SWEP.IronsightAng = Vector(-0.4782, 0.006, 0)

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.4533, -4, -0.0716)
	SWEP.KKINS2CSTMBarskaAng = Vector(0, 0, 0)

	SWEP.KKINS2CSTMCMorePos = Vector(-2.448, -4, -0.0874)
	SWEP.KKINS2CSTMCMoreAng = Vector(0, 0, 0)

	SWEP.KKINS2ScopeZF4Pos = Vector(-2.4251, -8, 0.6407)
	SWEP.KKINS2ScopeZF4Ang = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.02
end

SWEP.WeaponLength = 22

SWEP.Attachments = {
	-- {header = "Sight", offset = {500, -500}, atts = {"kk_ins2_cstm_barska", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_cstm_acog", "kk_ins2_po4", "kk_ins2_scope_mosin", "kk_ins2_scope_m40"}},
	{header = "Sight", offset = {500, -500}, atts = {"kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_scope_zf4"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_ww2_knife"}},
	-- {header = "Under", offset = {-500, 0}, atts = {"kk_ins2_bipod"}},
	-- {header = "Extras", offset = {125, 200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	-- {header = "More Sight", offset = {1200, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Chamberable = false
SWEP.KKINS_emptyIdle = true

SWEP.Animations = {
	draw = "base_ready",

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
	base_idle_empty = "base_idle_empty",
	base_holster = "base_holster",
	base_holster_empty = "base_holster_empty",
	base_sprint = "base_sprint",
	base_sprint_empty = "base_sprint_empty",
	base_safe = "base_down",
	base_safe_empty = "base_down_empty",
	base_safe_aim = "iron_down",
	base_safe_empty_aim = "iron_down_empty",
	
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
SWEP.Category = "CW 2.0 KK INS2 WW2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_garand.mdl"
SWEP.WorldModel		= "models/weapons/w_garand.mdl"

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.ww2us

SWEP.WMPos = Vector(1.542, 0, 0.976)
SWEP.WMAng = Vector(-12.174, 1.458, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.ww2ContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.ww2ContentMounted()

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x63MM"

SWEP.FireDelay = 0.17
SWEP.FireSound = "CW_KK_INS2_WW2_GARAND_FIRE"
SWEP.Recoil = 1.6

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 42

SWEP.FirstDeployTime = 2
SWEP.DeployTime = 0.94

SWEP.RecoilToSpread = 0.8 

SWEP.ReloadTime = 4
SWEP.ReloadHalt = 5.13
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt_Empty = 3.33

if CLIENT then 
	function SWEP:updateOtherParts()
		if self.Sequence:find("reload") and self.CW_VM:GetCycle() > 0.3 then
			self:setBodygroup(1, math.Clamp(self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1(), 0, 9))
		else
			self:setBodygroup(1, self:Clip1())
		end
	end
end