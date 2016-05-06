if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AT4"
	
	SWEP.SelectFont = "CW_SelectIcons2"
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.RearEffectw = true
	SWEP.NoShells = true
	
	SWEP.AttachmentModelsVM = {
		["kk_counter_front"] = {model = "models/weapons/stattrack.mdl", bone = "AT4", rel = "", pos = Vector(-0.029, 3.767, 2.51), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), ignoreKKBGO = true, active = true, nodraw = true},
		["kk_counter_mid"] = {model = "models/weapons/stattrack.mdl", bone = "AT4", rel = "", pos = Vector(1.218, -8.176, 1.179), angle = Angle(-47.401, 0, 0), size = Vector(0.699, 0.699, 0.699), ignoreKKBGO = true, active = true, nodraw = true},
		["kk_counter_back"] = {model = "models/weapons/stattrack.mdl", bone = "AT4", rel = "", pos = Vector(-0.788, -10.893, 2.131), angle = Angle(0, -90, 15), size = Vector(1, 1, 1), ignoreKKBGO = true, active = true, nodraw = true},
	}
	
	-- SWEP.IronsightPos = Vector(-1.292, -2, 0.5674)
	-- SWEP.IronsightAng = Vector(2.0493, -1.9418, 0)
	
	-- SWEP.IronsightPos = Vector(-1.292, -2, 0.5674) // zeroed for rpg drop
	-- SWEP.IronsightAng = Vector(1.2005, -1.9418, 0)

	SWEP.IronsightPos = Vector(-1.292, -2, 0.5674) // rpg drop fixed
	SWEP.IronsightAng = Vector(1.9728, -1.9566, 0)

	SWEP.ViewModelMovementScale_sprint = 0.5
	SWEP.CustomizationMenuScale = 0.01
	SWEP.HUD_MagText = "TUBE: "
end

SWEP.Attachments = {
	{header = "Nope, no attachments for this one.", offset = {-250, 0}, atts = {}},
	{header = "Just sit back and enjoy awsum rpg rockets.", offset = {-250, 75}, atts = {}}
}

SWEP.Animations = {
	draw = "at4_ready",

	base_pickup = "at4_ready",
	base_draw = "at4_draw",
	base_fire = "at4_fire",
	base_fire_aim = "at4_iron_fire",
	base_reload_start = "at4_toss",
	base_reload_end = "at4_ready",
	base_idle = "idle",
	base_holster = "at4_holster",
	base_sprint = "at4_sprint",
	base_safe = "at4_down",
	base_safe_aim = "at4_iron_down",
}
	
SWEP.Sounds = {
	at4_crawl = {
		{time = 15.0000004470348/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 38.0000004172325/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	at4_fire = {
		{time = 3.00000004470348/30, sound = "CW_KK_INS2_M9_SAFETY"},
	},

	at4_iron_fire = {
		{time = 3.00000004470348/30, sound = "CW_KK_INS2_M9_SAFETY"},
	},

	at4_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	at4_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	at4_ready = {
		{time = 0, sound = "Draw"},
		{time = 16.0000006109476/31, sound = "CW_KK_INS2_AT4_READY"},
		{time = 42.0000006258488/31, sound = "CW_KK_INS2_AT4_LATCH01"},
		{time = 50.0000001490116/31, sound = "CW_KK_INS2_AT4_LATCH02"},
		{time = 75.0000017881393/31, sound = "CW_KK_INS2_AT4_SHOULDER"},
	},

	at4_toss = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEANOUT"},
		{time = 20.9999990463257/31, sound = "CW_KK_INS2_UNIVERSAL_WEAPONLOWER"},
	},
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "rpg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"single"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_at4.mdl"
SWEP.WorldModel		= "models/weapons/w_at4.mdl"

SWEP.WMPos = Vector(7, 1, -2)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AT4 Launcher"

SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_AT4_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_AT4_FIRE"

SWEP.Recoil = 0.5
SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 1
SWEP.Damage = 100

SWEP.DeployTime = 0.5

SWEP.ReloadTime = 5.1
SWEP.ReloadTime_Empty = 5.1
SWEP.ReloadHalt = 5.2
SWEP.ReloadHalt_Empty = 5.2

SWEP.Chamberable = false
SWEP.CanCustomize = false

SWEP.FirstDeployTime = 3.4
SWEP.WeaponLength = 40

function SWEP:updateReloadTimes() end
	
function SWEP:fireAnimFunc()
	local clip = self:Clip1()
	local cyc = 0.2
	local rate = 1
	local prefix = "base_"
	local suffix = ""
	
	if clip == 0 then
		suffix = "_empty"
	end
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix,rate,cyc)
end //*/

function SWEP:reloadAnimFunc(lm)
	self.dt.AT4ReloadEnd = CurTime() + self.ReloadHalt
	
	self:sendWeaponAnim("base_reload_start",self.ReloadSpeed,0)

	CustomizableWeaponry.actionSequence.new(self, 1.8, nil, function()
		if not self.ReloadDelay then return end
		self:sendWeaponAnim("base_reload_end",self.ReloadSpeed,0)
	end)
end //*/

function SWEP:SetupDataTables()
	self:DTVar("Int", 0, "State")
	self:DTVar("Int", 1, "Shots")
	self:DTVar("Float", 0, "HolsterDelay")
	self:DTVar("Float", 1, "AT4ReloadEnd")
	self:DTVar("Bool", 0, "Suppressed")
	self:DTVar("Bool", 1, "Safe")
	self:DTVar("Bool", 2, "BipodDeployed")
	self:DTVar("Angle", 0, "ViewOffset")
end

function SWEP:getReloadProgress()
	local CT = CurTime()
	
	if self.dt.AT4ReloadEnd < CT then return end
	
	return math.Round((CT - self.dt.AT4ReloadEnd + self.ReloadHalt) * 100 / self.ReloadHalt)
end

if CustomizableWeaponry_KK.HOME then 
	AddCSLuaFile("_src_go.lua")
	include("_src_go.lua")
end
