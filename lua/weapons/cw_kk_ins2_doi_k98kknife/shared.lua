if not CustomizableWeaponry then return end

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Kar-98k Bayonet"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.AttachmentModelsVM = {}
end

SWEP.Animations = {
	draw = "draw",

	base_pickup = "draw",
	base_draw = "draw",
	base_fire = {"hitcenter1","hitcenter2"},
	base_idle = "idle",
	base_holster = "holster",
	base_sprint = "sprint",
}

SWEP.NormalHoldType = "knife"
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
SWEP.ViewModel		= "models/weapons/v_k98kbayonet.mdl"
SWEP.WorldModel		= "models/weapons/w_bayonet_kar98k.mdl"

SWEP.WMPos = Vector(3.812, 1.544, -2.83)
SWEP.WMAng = Vector(99.385, -22.739, 18.048)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.models.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()
