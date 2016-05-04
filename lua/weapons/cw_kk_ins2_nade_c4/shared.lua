AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "C4"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "I"
	
	SWEP.AttachmentModelsVM = {}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
	SWEP.HUD_MagText = "Planted: "
end

SWEP.CanRestOnObjects = false
SWEP.grenadeEnt = "cw_grenade_thrown"

SWEP.Animations = {
	draw = "base_draw",
	throw = "base_throw",
	plant = "base_plant",
	pullpin = "base_pullback",
	
	base_pickup = "base_draw",
	base_idle = "base_idle",
	base_draw = "base_draw",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	
	det_boom = "det_detonate",
	det_draw = "det_draw",
	det_holster = "det_holster",
	det_idle = "det_idle",
}

SWEP.Sounds = {
	base_plant = {
		{time = 0, sound = "CW_KK_INS2_C4_ARMMOVEMENT"},
		{time = 16/30, sound = "CW_KK_INS2_C4_PLANTPLACE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 10/29, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/29, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	base_pullback = {
		{time = 6/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
	},

	secondary_pullback = {
		{time = 6/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
	},

	low_pullback = {
		{time = 6/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
	},

	base_throw = {
		{time = 7/33, sound = "CW_KK_INS2_C4_THROW"},
	},

	secondary_throw = {
		{time = 7/33, sound = "CW_KK_INS2_C4_THROW"},
	},

	low_throw = {
		{time = 7/30, sound = "CW_KK_INS2_C4_THROW"},
	},

	det_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	det_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	det_crawl = {
		{time = 10/29, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/29, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	det_detonate = {
		{time = 10/30, sound = "CW_KK_INS2_C4_TRIGGERSEC"},
		{time = 20/30, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},
}
	
SWEP.SpeedDec = 5

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "slam"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"single"}
SWEP.Base = "cw_kk_ins2_nade_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_c4_sec.mdl"
SWEP.WorldModel		= "models/weapons/w_cw_kk_ins2_c4.mdl"

SWEP.WMPos = Vector(5.5, 3.295, -1.765)
SWEP.WMAng = Angle(-28.962, 165.365, 70)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.Primary.ClipSize		= 256
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "C4"

-- SWEP.swapTime = 0.7

local SP = game.SinglePlayer()

function SWEP:throwC4()
	if CLIENT then
		if SP or IsFirstTimePredicted() then
			self:playAnim("throw", 1, 0)
		end
		
		-- self.c4_msg_text = "U tried to throw C4. No server-side code found for dat."
		-- self.c4_msg_time = CurTime() + 1
	end
end

function SWEP:plantC4()
	if CLIENT then
		if SP or IsFirstTimePredicted() then
			self:playAnim("plant", 1, 0)
		end
		
		-- self.c4_msg_text = "U tried to plant C4. Here, have a frag nade."
		-- self.c4_msg_time = CurTime() + 1
	end
end

function SWEP:detonateC4()
	if CLIENT then
		-- self.c4_msg_text = "U tried to detonate ur C4s. I highly doubt uve planted any."
		-- self.c4_msg_time = CurTime() + 1
	end
	
	self:SetClip1(0)
end

function SWEP:detonateLast()
	if self:canAnimate() then
		self:sendWeaponAnim("det_boom", 1, 0)
		
		CustomizableWeaponry.actionSequence.new(self, 0.62, nil, function()
			self:sendWeaponAnim("det_idle", 1, 0)
		end)
	end
	
	CustomizableWeaponry.actionSequence.new(self, 0.5, nil, function()
		self:detonateC4()
	end)
	
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
end

function SWEP:PrimaryAttack()
	if SP and SERVER then
		SendUserMessage("OMG_GARRY_PRIMARY", self.Owner)
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		if self:isNearWall() then
			self:plantC4()
		else
			self:throwC4()
		end
		
		if SERVER then
			self:SetClip1(self:Clip1() + 1)
			
			local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
			if not suppressAmmoUsage then
				self.Owner:RemoveAmmo(1, self.Primary.Ammo)
			end
		end
			
		if self:canAnimate() then
			CustomizableWeaponry.actionSequence.new(self, 1, nil, function()
				if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
					self:drawAnimFunc()
				else
					self:sendWeaponAnim("det_draw", 1, 0)
				end
			end)
		end		

		self:SetNextPrimaryFire(CurTime() + 1.5)
		self:SetNextSecondaryFire(CurTime() + 1.5)
	else
		self:detonateLast()
	end
end

function SWEP:canAnimate()
	return (SP and SERVER) or (!SP and CLIENT and IsFirstTimePredicted())
end

function SWEP:SecondaryAttack()
	if SP and SERVER then
		SendUserMessage("OMG_GARRY_SECONDARY", self.Owner)
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		if CLIENT then
			self.reticleInactivity = UnPredictedCurTime() + 2
		end
		
		if self:canAnimate() then
			self:_holsterAnimFunc()
			
			CustomizableWeaponry.actionSequence.new(self, 0.4, nil, function()
				self:sendWeaponAnim("det_draw", 1, 0)
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.7, nil, function()
				self:sendWeaponAnim("det_boom", 1, 0)
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 1.7, nil, function()
				self:drawAnimFunc()
			end)
		end
		
		CustomizableWeaponry.actionSequence.new(self, 1.1, nil, function()
			self:detonateC4()
		end)

		self:SetNextPrimaryFire(CurTime() + 2)
		self:SetNextSecondaryFire(CurTime() + 2.5)
	else
		self:detonateLast()
	end
end

function SWEP:getForegripMode()
	if self.dt.C4detonator then 
		return "det_"
	else
		return "base_"
	end
end

function SWEP:drawAnimFunc()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		self:sendWeaponAnim("base_draw", 1, 0)
	else
		self:sendWeaponAnim("det_draw", 1, 0)
	end
end

function SWEP:idleAnimFunc()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		self:sendWeaponAnim("base_idle", 1, 0)
	else
		self:sendWeaponAnim("det_idle", 1, 0)
	end
end

if CLIENT then
	SWEP.DrawCustomWM = false
	
	function SWEP:updateOtherParts()
		self.WMEnt:SetBodygroup(1,1)
	end
	
	function SWEP:getMuzzlePosition()
		local m 
		
		if self:isReticleActive() then
			m = self.CW_VM:GetBoneMatrix(57)
		else
			m = self.CW_VM:GetBoneMatrix(61)
		end
		
		return {Pos = m:GetTranslation(), Ang = m:GetAngles()}
	end
	
	CustomizableWeaponry.callbacks:addNew("overrideReserveAmmoText", "KK_INS2_BASE", function(wep)
		return false, "lolo", Color(255,255,255,255)
	end)
end

// and now insane framework, just for this gun

if CLIENT then
	usermessage.Hook("OMG_GARRY_PRIMARY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		
		wep:PrimaryAttack()
	end)
	
	usermessage.Hook("OMG_GARRY_SECONDARY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		
		wep:SecondaryAttack()
	end)
	
	local font = "CW_HUD24"
	local fadeTime = 0.7
	local white = Color(255,255,255,alpha)
	local black = Color(0,0,0,alpha)
			
	CustomizableWeaponry.callbacks:addNew("drawToHUD", "KK_INS2_C4", function(wep, cwHudEnabled) // actually not really, Ive copy pasted this from my other script
		if wep:GetClass() != "cw_kk_ins2_nade_c4" then return end
			
		local CT = CurTime()
		local mTime = wep.c4_msg_time
		
		if mTime and (mTime + fadeTime) > CT then
			surface.SetFont(font)
			
			local len = surface.GetTextSize(wep.c4_msg_text)
			local x,y = (ScrW()) / 2, ScrH() / 2
			
			if mTime > CT then
				white.a = 255
				black.a = 255
			else
				white.a = math.Clamp(mTime + fadeTime - CT, 0, fadeTime) * 255
				black.a = math.Clamp(mTime + fadeTime - CT, 0, fadeTime) * 255
			end
			
			draw.ShadowText(wep.c4_msg_text, font, x, y, white, black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end)
end