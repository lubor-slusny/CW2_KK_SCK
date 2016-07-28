if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Panzerfaust"
	
	SWEP.SelectFont = "CW_SelectIcons2"
	SWEP.IconLetter = "i"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.RearEffectw = true
	SWEP.NoShells = true
	
	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}
	
	SWEP.IronsightPos = Vector(-2.6525, -2, 0.2846) // 60M
	SWEP.IronsightAng = Vector(1.2093, 0, 7)

	SWEP.SprintAnimSpeed = 1
	SWEP.ViewModelMovementScale_sprint = 0.6
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.CustomizationMenuScale = 0.01
	SWEP.HUD_MagText = "TUBE: "
	SWEP.MuzzleAttachmentName = "glmuzzle"
end

SWEP.Chamberable = false
SWEP.WeaponLength = 35

SWEP.Attachments = {
}

SWEP.KK_INS2_EmptyIdle = true

SWEP.Animations = {
	draw = "panzerfaust_ready",

	base_pickup = "panzerfaust_ready",
	base_draw = "panzerfaust_draw",
	base_draw_empty = "panzerfaust_draw_empty",
	base_fire_last = "panzerfaust_fire",
	base_fire_last_aim = "panzerfaust_iron_fire",
	base_fire_empty = "panzerfaust_dryfire",
	base_fire_empty_aim = "panzerfaust_iron_dryfire",
	base_reload_start = "panzerfaust_holster_empty",
	base_reload_end = "panzerfaust_ready",
	base_idle = "panzerfaust_idle",
	base_idle_empty = "panzerfaust_idle_empty",
	base_holster = "panzerfaust_holster",
	base_holster_empty = "panzerfaust_holster_empty",
	base_sprint = "panzerfaust_sprint",
	base_sprint_empty = "panzerfaust_sprint_empty",
	base_safe = "panzerfaust_down",
	base_safe_aim = "panzerfaust_iron_down",
	base_safe_empty = "panzerfaust_down_empty",
	base_safe_empty_aim = "panzerfaust_iron_down_empty",
}

SWEP.SpeedDec = 15

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "rpg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"single"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2 DOI"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_panzerfaust.mdl"
SWEP.WorldModel		= "models/weapons/w_panzerfaust.mdl"

SWEP.DrawCustomWM = true
SWEP.WMPos = Vector(6.035, 0.5, -3)
SWEP.WMAng = Vector(-8, 0, -180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenades.models.ww2de
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnives.ww2de

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.doiContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.doiContentMounted()

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Panzerfaust"

SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_KK_INS2_WW2_PANZERFAUST_FIRE"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 1
SWEP.Damage = 100

SWEP.FirstDeployTime = 3.5
SWEP.DeployTime = 0.91

SWEP.ReloadTime = 3.77 // 90/32.5
SWEP.ReloadTime_Empty = 3.77
SWEP.ReloadHalt = 5
SWEP.ReloadHalt_Empty = 5

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
