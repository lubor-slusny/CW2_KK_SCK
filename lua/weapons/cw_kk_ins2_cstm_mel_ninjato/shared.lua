if not CustomizableWeaponry then return end


if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Ninja Knife Sword Thing"
	
	SWEP.AttachmentModelsVM = {}
end

SWEP.Animations = {
	base_pickup = "draw",
	base_draw = "draw",
	base_fire = {"hitcenter1","hitcenter2","hitcenter3"},
	base_idle = "idle",
	base_holster = "holster",
	base_sprint = "sprint",
	base_crawl = "crawl",
}

SWEP.NormalHoldType = "knife"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base_melee"
SWEP.Category = "CW 2.0 KK INS2 WS"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_ninjato.mdl"
SWEP.WorldModel		= "models/weapons/w_marinebayonet.mdl"

SWEP.WMPos = Vector(3.812, 1.544, -2.83)
SWEP.WMAng = Vector(99.385, -22.739, 18.048)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted(SWEP)

SWEP.FirstDeployTime = 0.6
SWEP.DeployTime = 0.6
SWEP.HolsterTime = 0.6

SWEP.Sounds = {
	draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	}, 
	
	crawl = {
		{time = 10/25, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/25, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},
}