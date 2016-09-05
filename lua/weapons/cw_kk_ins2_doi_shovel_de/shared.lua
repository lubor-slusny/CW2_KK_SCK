if not CustomizableWeaponry then return end

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Shovel DE"
	
	SWEP.AttachmentModelsVM = {}
	
	SWEP.HUD_3D2DBone = 39
end

SWEP.Animations = {
	draw = "base_draw",

	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_fire = {"base_attack_1", "base_attack_2", "base_attack_3", "abase_ttack_kill"},
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
}

SWEP.NormalHoldType = "melee2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_mel_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_etool_ger.mdl"
SWEP.WorldModel		= "models/weapons/w_etool_ger.mdl"

SWEP.WMPos = Vector(3.812, 1.544, -4.83)
SWEP.WMAng = Vector(99.385, -22.739, 18.048)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()
