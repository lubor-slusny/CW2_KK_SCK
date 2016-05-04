AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RPG7"
	
	SWEP.SelectFont = "HL2MPTypeDeath"
	SWEP.IconLetter = "3"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.RearEffectw = true
	SWEP.NoShells = true
	
	SWEP.AttachmentModelsVM = {
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_sterling.mdl", bone = "RPG_Body", pos = Vector(-1.795, -11.804, -2.003), angle = Angle(0, -90, -180), size = Vector(0.899, 0.899, 0.899)},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_sterling.mdl", bone = "RPG_Body", pos = Vector(-1.795, -11.804, -2.003), angle = Angle(0, -90, -180), size = Vector(0.899, 0.899, 0.899)},
		
		["kk_counter"] = {model = "models/weapons/stattrack.mdl", bone = "RPG_Body", pos = Vector(0.605, -2.793, 2.559), angle = Angle(0, 0, 0), size = Vector(0.28, 0.28, 0.28)},
	}
	
	SWEP.AttachmentModelsWM = {
		-- ["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_sterling.mdl", bone = "ValveBiped.Bip01_R_Hand", pos = Vector(-8.582, -2.365, 0.243), angle = Angle(-10, 0, 0), size = Vector(1.25, 1.25, 1.25)},
		-- ["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_sterling.mdl", bone = "ValveBiped.Bip01_R_Hand", pos = Vector(-8.582, -2.365, 0.243), angle = Angle(-10, 0, 0), size = Vector(1.25, 1.25, 1.25)},
		
		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_sterling.mdl", bone = "R Hand", pos = Vector(-14.497, 1.049, 6.086), angle = Angle(-10, 0, 180), size = Vector(1.25, 1.25, 1.25)},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_sterling.mdl", bone = "R Hand", pos = Vector(-14.497, 1.049, 6.086), angle = Angle(-10, 0, 180), size = Vector(1.25, 1.25, 1.25)},
	}
	
	SWEP.LaserAngAdjust = Angle(0,-1,0)
	
	SWEP.IronsightPos = Vector(-2.1193, -2, -0.9167) // cod stayle
	SWEP.IronsightAng = Vector(2.7606, 0.032, 0)

	SWEP.IronsightPos = Vector(-2.1193, -2, -0.9167) // zeroed for rpg drop
	SWEP.IronsightAng = Vector(1.5694, 0.032, 0)

	SWEP.IronsightPos = Vector(-2.1193, -2, -0.9167) // rpg drop got fixed
	SWEP.IronsightAng = Vector(2.6952, 0.0549, 0)

	SWEP.SprintPos = Vector(0, -1, 0)
	SWEP.SprintAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0, -1, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintAnimSpeed = 1
	SWEP.ViewModelMovementScale_sprint = 0.6
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.CustomizationMenuScale = 0.01
	SWEP.HUD_MagText = "Tube: "
end

SWEP.Chamberable = false

SWEP.Attachments = {
	-- {header = "Nope, no attachments for this one.", offset = {-250, 0}, atts = {}},
	-- {header = "Just sit back and enjoy awsum rpg rockets.", offset = {-250, 75}, atts = {}}
	{header = "Sry, this had to happen.", offset = {300, -500}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_combo"}},
}

if CustomizableWeaponry_KK.HOME then
	table.insert(SWEP.Attachments, {header = "CSGO", offset = {800, 0}, atts = {"kk_counter"}})
end

SWEP.KKINS_emptyIdle = true

SWEP.Animations = {
	draw = "base_ready",

	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_draw_empty = "empty_draw",
	base_fire = "base_fire",
	base_fire_aim = "iron_fire",
	base_fire_last = "base_fire",
	base_fire_last_aim = "iron_fire",
	base_fire_empty = "empty_dryfire",
	base_fire_empty_aim = "empty_dryfire",
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
	base_safe_empty_aim = "iron_down_empty",
}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 15/32.5, sound = "CW_KK_INS2_RPG_FETCH"},
		{time = 77/32.5, sound = "CW_KK_INS2_RPG_LOAD1"},
		{time = 97/32.5, sound = "CW_KK_INS2_RPG_LOAD2"},
		{time = 135/32.5, sound = "CW_KK_INS2_RPG_ENDGRAP"},
	},

	base_draw = {
		{time = 0/32.5, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0/32.5, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 0/32, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 13/32, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	base_reload = {
		{time = 15/32.5, sound = "CW_KK_INS2_RPG_FETCH"},
		{time = 77/32.5, sound = "CW_KK_INS2_RPG_LOAD1"},
		{time = 97/32.5, sound = "CW_KK_INS2_RPG_LOAD2"},
		{time = 135/32.5, sound = "CW_KK_INS2_RPG_ENDGRAP"},
	},

	empty_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	empty_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	empty_dryfire = {
		{time = 1/30, sound = "CW_KK_INS2_GP30_EMPTY"},
	},

	empty_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 13/32, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	}
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
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_rpg.mdl"
SWEP.WorldModel		= "models/weapons/w_rpg7.mdl"

SWEP.DrawCustomWM = true
SWEP.WMPos = Vector(7.035, 5.085, -0.366)
SWEP.WMAng = Vector(-10.386, 0, -120)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "RPG 40MM"

SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_RPG_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_RPG_FIRE"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 1
SWEP.Damage = 100

SWEP.FirstDeployTime = 4.71
SWEP.DeployTime = 1.14

SWEP.ReloadTime = 3.77 // 90/32.5
SWEP.ReloadTime_Empty = 3.77
SWEP.ReloadHalt = 5
SWEP.ReloadHalt_Empty = 5

function SWEP:fireAnimFunc()
	local clip = self:Clip1()
	local cyc = 0.2727
	local rate = 1
	local prefix = "base_"
	local suffix = ""
	
	if clip == 1 then
		suffix = "_last"
	elseif clip == 0 then
		suffix = "_empty"
		cyc = 0
	end
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
	end
	
	self:sendWeaponAnim(prefix .. "fire" .. suffix,rate,cyc)
end //*/

local mins, maxs = Vector(-8, -8, -1), Vector(8, 8, 1)

local td = {}
td.mins = mins
td.maxs = maxs

function SWEP:isNearWall()
	td.start = self.Owner:GetShootPos()
	td.endpos = td.start + self.Owner:EyeAngles():Forward() * 70
	td.filter = self.Owner
	
	local tr = util.TraceLine(td)
	
	if tr.Hit or (IsValid(tr.Entity) and not tr.Entity:IsPlayer()) then
		return true
	end
	
	return false
end

if CLIENT then 
	function SWEP:updateOtherParts()
		self.WMEnt:SetBodygroup(1, 1 - self:Clip1())
		self:SetBodygroup(1, 1 - self:Clip1())
	end
end

-- function SWEP:IndividualThink()
	-- weapons.GetStored("cw_kk_ins2_base").IndividualThink(self)

	-- if CLIENT then 
		-- self.WMEnt:SetBodygroup(1, 1 - self:Clip1())
	-- else
		-- self:SetBodygroup(1, 1 - self:Clip1())
	-- end
	
	-- self:SetBodygroup(1, 1 - self:Clip1())
-- end
