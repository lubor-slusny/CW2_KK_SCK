AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Professional Russian"
	
	SWEP.IconLetter = "C"
	
	SWEP.AttachmentModelsVM = {
		["nade"] = {model = "models/weapons/w_at4_projectile.mdl", bone = "Weapon", pos = Vector(0.028, 0.087, 18.68), angle = Angle(-90, 90, 0), size = Vector(0.75, 0.75, 0.75), active = true},
	}
	
	SWEP.HUD_MagText = "0 > "
end

SWEP.CanRestOnObjects = false

SWEP.Animations = {
	draw = "base_draw",
	throw = "throw",
	pullpin = "pullback_high",
	
	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
}
	
SWEP.Sounds = {
	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_GRENADE_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_GRENADE_HOLSTER"},
	},

	base_crawl = {
		{time = 10/25, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/25, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	pullback_high = {
		{time = 1/20, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 5/20, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE"},
		{time = 8/20, sound = "CW_KK_INS2_MOLOTOV_IGNITE"},
		{time = 17/20, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE"},
	},

	pullback_highbake = {
		{time = 1, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 5, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE"},
		{time = 8, sound = "CW_KK_INS2_MOLOTOV_IGNITE"},
		{time = 17, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE"},
	},

	pullback_low = {
		{time = 1, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 5, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE"},
		{time = 8, sound = "CW_KK_INS2_MOLOTOV_IGNITE"},
		{time = 17, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE"},
	},

	throw = {
		{time = 0, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		{time = 0.01, sound = "CW_KK_INS2_RPG_FIRE"},
	},

	throw_bake = {
		{time = 0, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		{time = 0.01, sound = "CW_KK_INS2_RPG_FIRE"},
	},

	throw_low = {
		{time = 0, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		{time = 0.01, sound = "CW_KK_INS2_RPG_FIRE"},
	}
}
	
SWEP.SpeedDec = 5

SWEP.Slot = 5
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_nade_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_rpg_pro.mdl"
-- SWEP.WorldModel		= "models/weapons/w_at4_projectile.mdl"
SWEP.WorldModel		= "models/weapons/w_cw_kk_ins2_rpg7_projectile_pd2.mdl"

SWEP.WMPos = Vector(14.17, -0.193, -25.729)
SWEP.WMAng = Angle(113.916, 13.63, 0)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.contentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.contentMounted()

SWEP.AdminOnly			= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "RPG 40MM"

SWEP.timeToThrow = 1.2

SWEP.Effect_Lighter = "fire_verysmall_01"
SWEP.Effect_Rag = "embers_small_01"

PrecacheParticleSystem(SWEP.Effect_Lighter)
PrecacheParticleSystem(SWEP.Effect_Rag)

if CLIENT then
	local boneIds = {}
	
	function SWEP:RenderTargetFunc()
		local vm = self.CW_VM
		
		if not self.elementRender.nade_fx then
			for _,v in pairs({"Rag_God", "Weapon", "Liq_top", "Bone01", "Bone02", "Bone03", "Bone04", "Bone06", "Bone07"}) do 
				boneIds[v] = vm:LookupBone(v)
			end
			
			function self.elementRender:nade_fx()
				local cyc = vm:GetCycle()
				local seq = self.Sequence
				
				if seq == "pullback_high" then
					if cyc < 1 then
						ParticleEffectAttach(self.Effect_Lighter, PATTACH_POINT_FOLLOW, vm, 1)
					end

					if cyc > 0.34 then
						local ed = EffectData()
						ed:SetOrigin(vm:GetAttachment(2).Pos)
						ed:SetScale(0.1)
						util.Effect("MetalSpark", ed)
					end
				else
					vm:StopParticles()
				end
			end
		end
		
		for _,v in pairs(boneIds) do 
			vm:ManipulateBoneScale(v, Vector(0.01,0.01,0.01))
		end
	end
	
	function SWEP:getMuzzlePosition()
		return self.CW_VM:GetAttachment(2)
	end
end

local SP = game.SinglePlayer()

function SWEP:IndividualThink()
	weapons.GetStored("cw_kk_ins2_base").IndividualThink(self)

	if SP and CLIENT then return end
	
	local curTime = CurTime()
	
	if self.dt.PinPulled then
		if curTime > self.throwTime then
			if not self.Owner:KeyDown(IN_ATTACK) then
				if not self.animPlayed then
					self.entityTime = CurTime() + 0.15
					self:sendWeaponAnim("throw")
					self.Owner:SetAnimation(PLAYER_ATTACK1)
				end
				
				if curTime > self.entityTime then
					if SERVER then
						CustomizableWeaponry_KK.ins2.fireRPG(self, IsFirstTimePredicted())
						
						if not CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage") then
							self:TakePrimaryAmmo(1)
							CustomizableWeaponry.callbacks.processCategory(wep, "postConsumeAmmo")
						end
					end
					
					self:SetNextPrimaryFire(curTime + 1)
					
					timer.Simple(self.swapTime, function()
						if IsValid(self) then
							if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then -- we're out of ammo, strip this weapon
								self.Owner:ConCommand("lastinv")
							else
								self:drawAnimFunc()
							end
						end
					end)
					
					self.dt.PinPulled = false
				end
				
				self.animPlayed = true
			end
		end
	end
end
