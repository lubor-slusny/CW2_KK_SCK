if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.KKINS2RCE = true

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "C4"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "I"
	
	SWEP.AttachmentModelsVM = {
		["element_name"] = {model = "models/weapons/stattrack.mdl", bone = "SECEXP", pos = Vector(-0.64, -0.969, 0.021), angle = Angle(90, 0, 0), size = Vector(0.5, 0.5, 0.5), 
		active = function(self)
			self.AttachmentModelsVM.element_name.ent._KKCSGONUM = 160224
			return CustomizableWeaponry_KK.HOME
		end}
	}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
	SWEP.HUD_MagText = "PLANTED: "
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
	det_sprint = "det_sprint",
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

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 256
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "C4"

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001

SWEP.SpeedDec = 0
SWEP.Recoil = 1

SWEP.WeaponLength = 40

local SP = game.SinglePlayer()

if SERVER then
	hook.Add("PlayerCanPickupWeapon", "ZZZZZ_CW_KK_INS2_C4", function(ply, wep)
		if !wep.KKINS2RCE then return end
		
		if (ply:HasWeapon(wep:GetClass())) then
			owned = ply:GetWeapon(wep:GetClass())
			
			for k,v in pairs(wep.PlantedCharges) do
				if IsValid(v) then
					v.Detonator = owned
					owned.PlantedCharges[v] = v
				end
			end
			
			if wep:Clip1() == -1 then
				ply:GiveAmmo(1, wep.Primary.Ammo)
			end
			
			wep:Remove()
			return false
		else
			ply:GiveAmmo(2 - ply:GetAmmoCount(wep.Primary.Ammo), wep.Primary.Ammo)
			return true
		end
	end)
end

function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:IndividualInitialize()
	if SERVER then
		self.PlantedCharges = {}
		
		local clip = self:Clip1()
		
		if clip > 0 and IsValid(self.Owner) then
			self.Owner:GiveAmmo(self.Primary.Ammo, clip)
			self:SetClip1(0)
		end
	end
end

local curAmmo

function SWEP:IndividualThink()
	if SERVER then
		if !IsValid(self.Owner) then return end
		
		self.Owner:ShouldDropWeapon(true)
		
		if self.PlantedCharges then
			for k,v in pairs(self.PlantedCharges) do
				if !IsValid(v) then
					self.PlantedCharges[v] = nil
				end
			end
			
			self:SetClip1(table.Count(self.PlantedCharges))
		end
		
		curAmmo = self.Owner:GetAmmoCount(self.Primary.Ammo)
		
		if curAmmo > (self._lastAmmo or 1) and (self._lastAmmo == 1) then
			self:drawAnimFunc()
		end
		
		self._lastAmmo = curAmmo
	end
		
	weapons.GetStored(self.Base).IndividualThink(self)
end

function SWEP:throwC4()
	if CLIENT then
		if SP or IsFirstTimePredicted() then
			self:playAnim("throw", 1, 0)
		end
	end
	
	if SERVER then
		CustomizableWeaponry.actionSequence.new(self, 0.2, nil, function()
			local pos = self.Owner:GetShootPos()
			local eyeAng = self.Owner:EyeAngles()
			local offset = eyeAng:Up() * -3 + eyeAng:Forward() * 0 + eyeAng:Right() * 3
			local forward = eyeAng:Forward()
			
			local nade = ents.Create("cw_kk_ins2_projectile_c4")
			
			nade.Detonator = self
			self.PlantedCharges[nade] = nade
			
			nade:SetPos(pos + offset)
			nade:SetAngles(eyeAng)
			nade:Spawn()
			nade:Activate()
			
			nade:InitPhys()
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				local overallSideMod = self.Owner:KeyDown(IN_SPEED) and 2 or 1

				// take the velocity into account
				addMod = math.Clamp(self.Owner:GetVelocity():Length() / self.Owner:GetRunSpeed(), 0, 1)
				
				local velocity = forward * CustomizableWeaponry.quickGrenade.throwVelocity + CustomizableWeaponry.quickGrenade.addVelocity
				local velNorm = self.Owner:GetVelocity():GetNormal()
				velNorm.z = 0
				
				// add velocity based on player velocity normal
				velocity = velocity + velNorm * CustomizableWeaponry.quickGrenade.movementAddVelocity * addMod
				
				phys:SetVelocity(velocity / 2)
				phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
			end
			
			local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
			if not suppressAmmoUsage then
				self.Owner:RemoveAmmo(1, self.Primary.Ammo)
			end
		end)
	end
end

function SWEP:plantC4()
	if CLIENT then
		if SP or IsFirstTimePredicted() then
			self:playAnim("plant", 1, 0)
		end
	end
	
	if SERVER then
		local td = {}
		local tr, ang

		CustomizableWeaponry.actionSequence.new(self, 0.2, nil, function()
			td.start = self.Owner:GetShootPos()
			td.endpos = td.start + (self.Owner:EyeAngles() + self.Owner:GetPunchAngle()):Forward() * 200
			td.filter = self.Owner
			
			tr = util.TraceLine(td)
			ang = tr.HitNormal:Angle()
			
			if tr.Hit then
				local nade = ents.Create("cw_kk_ins2_projectile_c4")
				
				nade.Detonator = self
				self.PlantedCharges[nade] = nade
				
				nade:SetPos(tr.HitPos)
				nade:SetAngles(ang)
				nade:Spawn()
				nade:Activate()
				
				if (tr.Entity:GetClass() == "worldspawn") then
					nade:SetAngles(ang)
				else
					nade:InitPhys()
					constraint.Weld(tr.Entity, nade, tr.PhysicsBone, 0, 0, true, false)
				end
				
				local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
				if not suppressAmmoUsage then
					self.Owner:RemoveAmmo(1, self.Primary.Ammo)
				end
			end
		end)
	end
end

function SWEP:detonateC4()
	if SERVER then 
		for k,v in pairs(self.PlantedCharges) do
			v:Fuse()
		end
	end
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
	if self.Owner:KeyDown(IN_USE) then
		if self.ActiveAttachments.kk_ins2_ww2_knife and CustomizableWeaponry_KK.ins2.canKnife(self) then
			CustomizableWeaponry_KK.ins2.meleeWW2(self)
			return 
		end
		
		if CustomizableWeaponry_KK.ins2.canThrow(self) then
			CustomizableWeaponry_KK.ins2.throwGrenade(self)
			return
		end
		
		if CustomizableWeaponry_KK.ins2.canKnife(self) then
			CustomizableWeaponry_KK.ins2.meleeKnife(self)
			return
		end
	end
	
	if SP and SERVER then
		SendUserMessage("CW_KK_INS2_C4_PRIMARY", self.Owner)
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 1 then
		self.reticleInactivity = UnPredictedCurTime() + 2
		
		if self:isNearWall() then
			self:plantC4()
		else
			self:throwC4()
			-- self:plantC4()
		end
		
		if self:canAnimate() then
			CustomizableWeaponry.actionSequence.new(self, 1, nil, function()
				if self.Owner:GetAmmoCount(self.Primary.Ammo) > 1 then
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
		SendUserMessage("CW_KK_INS2_C4_SECONDARY", self.Owner)
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 1 then
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

function SWEP:updateReloadTimes() end

function SWEP:getForegripMode()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 1 then 
		return "base_"
	else
		return "det_"
	end
end

function SWEP:drawAnimFunc()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 1 then
		self:sendWeaponAnim("base_draw", 1, 0)
	else
		self:sendWeaponAnim("det_draw", 1, 0)
	end
end

function SWEP:idleAnimFunc()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 1 then
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
	
	local m
	local muz = {}
	
	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		else			
			if self:isReticleActive() then
				m = self.CW_VM:GetBoneMatrix(57)
			else
				m = self.CW_VM:GetBoneMatrix(61)
			end		
		end

		muz.Pos = m:GetTranslation()
		muz.Ang = m:GetAngles()
		return muz
	end
end

if CLIENT then
	usermessage.Hook("CW_KK_INS2_C4_PRIMARY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		
		wep:PrimaryAttack()
	end)
	
	usermessage.Hook("CW_KK_INS2_C4_SECONDARY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		
		wep:SecondaryAttack()
	end)
end