if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "IED"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "I"
	
	SWEP.AttachmentModelsVM = {}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
	SWEP.HUD_MagText = "PLANTED: "
end

SWEP.Animations = {
	throw = "base_throw",
	plant = "plant",
	pullpin = "base_pullback",
	
	base_pickup = "draw",
	base_idle = "idle",
	base_draw = "draw",
	base_holster = "holster",
	base_sprint = "base_sprint",
	base_crawl = "crawl",
	
	det_boom = "det_detonate",
	det_draw = "det_draw",
	det_holster = "det_holster",
	det_idle = "det_idle",
	det_sprint = "det_sprint",
	det_crawl = "det_crawl",
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

	crawl = {
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
		{time = 10/30, sound = "CW_KK_INS2_C4_TRIGGERINS"},
		{time = 20/30, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},
}

SWEP.CanRestOnObjects = false
	
-- SWEP.SprintingEnabled = false
SWEP.AimingEnabled = false
SWEP.CanCustomize = false
SWEP.AccuracyEnabled = false

SWEP.SpeedDec = 5

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "slam"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base_nade"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_ied_ins.mdl"
SWEP.WorldModel		= "models/weapons/w_ied.mdl"

SWEP.WMPos = Vector(3.891, 2.295, -1.765)
SWEP.WMAng = Angle(-28.962, 155.365, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "IED"

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001

SWEP.SpeedDec = 0
SWEP.Recoil = 1

SWEP.WeaponLength = 40

SWEP.KKINS2RCE = true

if SERVER then	
	function SWEP:EquipAmmo(ply)
		local owned = ply:GetWeapon(self:GetClass())
		local remove = self:Clip1()
			
		if IsValid(owned) then
			remove = table.Count(self.PlantedCharges)
			
			for k,v in pairs(self.PlantedCharges) do
				if IsValid(v) then
					v:SetDetonator(owned)
					owned.PlantedCharges[v] = v
				end
			end
		end
		
		if self._fresh then
			ply:GiveAmmo(1, self.Primary.Ammo)
		else
			ply:RemoveAmmo(remove, self.Primary.Ammo)
		end
	end
	
	function SWEP:equipFunc()
		local ply = self.Owner
		
		if self._fresh then
			self._fresh = false
			ply:GiveAmmo(1, self.Primary.Ammo)
		else
			ply:RemoveAmmo(0, self.Primary.Ammo)
		end
	end
	
	function SWEP:IndividualInitialize()
		self._fresh = true
		self.PlantedCharges = {}
	end
	
	function SWEP:OnDrop() end
end

function SWEP:ShouldDropOnDie()
	return true
end

local SP = game.SinglePlayer()

function SWEP:IndividualThink()
	if SERVER then
		self.Owner:ShouldDropWeapon(true)
		
		if self.PlantedCharges then
			for k,v in pairs(self.PlantedCharges) do
				if !IsValid(v) then
					self.PlantedCharges[v] = nil
				end
			end
			
			self:SetClip1(table.Count(self.PlantedCharges))
		end
			
		// for 0-to-1-ammo draw-anim
		local cur = self.Owner:GetAmmoCount(self.Primary.Ammo)
		local last = self._lastPrimaryAmmoCount
		if last and last < cur and cur == 1 then
			self:drawAnimFunc()
			self:SetNextPrimaryFire(CurTime() + self.DeployTime)
			self:SetNextSecondaryFire(CurTime() + self.DeployTime)
		end
		self._lastPrimaryAmmoCount = cur
	end
	
	-- weapons.GetStored("cw_kk_ins2_base").IndividualThink(self)
	weapons.GetStored("cw_kk_ins2_base_main").IndividualThink(self)
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
			
			local nade = ents.Create("cw_kk_ins2_projectile_ied")
			
			nade:SetDetonator(self)
			self.PlantedCharges[nade] = nade
			
			nade:SetPos(pos + offset)
			nade:SetAngles(eyeAng)
			nade:Spawn()
			nade:Activate()
			
			nade:SetOwner(self.Owner)
			
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
		CustomizableWeaponry.actionSequence.new(self, 0.2, nil, function()
			local hit, tr = self:isNearWall()
			local ang, pos
			
			if hit then
				ang = tr.HitNormal:Angle()
				pos = tr.HitPos + ang:Right() * 3 + ang:Forward() * 1.5 + ang:Up() * -1.5
				ang:RotateAroundAxis(ang:Up(), 90)
				ang:RotateAroundAxis(ang:Right(), -90)
				
				local nade = ents.Create("cw_kk_ins2_projectile_ied")
				
				nade:SetDetonator(self)
				self.PlantedCharges[nade] = nade
				
				nade:SetPos(pos)
				nade:SetAngles(ang)
				nade:Spawn()
				nade:Activate()
				
				nade:SetOwner(self.Owner)
				
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

function SWEP:PrimaryAttack()
	if not self:canFireWeapon(1) then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then		
		if CustomizableWeaponry_KK.ins2.quickGrenade:canThrow(self) then
			CustomizableWeaponry_KK.ins2.quickGrenade:throw(self)
			return
		end
	end
	
	if not self:canFireWeapon(2) then
		return
	end
	
	if self.InactiveWeaponStates[self.dt.State] then
		return
	end
	
	if SP and SERVER then
		SendUserMessage("CW_KK_INS2_IED_PRIMARY", self.Owner)
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		self.reticleInactivity = UnPredictedCurTime() + 2
		
		if self:isNearWall() then
			self:plantC4()
		else
			self:throwC4()
			-- self:plantC4()
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
		SendUserMessage("CW_KK_INS2_IED_SECONDARY", self.Owner)
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		if CLIENT then
			self.reticleInactivity = UnPredictedCurTime() + 2.5
		end
		
		if self:canAnimate() then
			self:holsterAnimFunc()
			
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
		self:SetNextSecondaryFire(CurTime() + 2)
	else
		self:detonateLast()
	end
end

function SWEP:detonateLast()
	if CLIENT then
		self.reticleInactivity = UnPredictedCurTime() + 1.5
	end
	
	if self:canAnimate() then
		self:sendWeaponAnim("det_boom", 1, 0)
		
		CustomizableWeaponry.actionSequence.new(self, 0.61, nil, function()
			self:sendWeaponAnim("det_idle", 1, 0)
		end)
	end
	
	CustomizableWeaponry.actionSequence.new(self, 0.5, nil, function()
		self:detonateC4()
	end)
	
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
end

-- function SWEP:updateReloadTimes() end

function SWEP:getForegripMode()
	if IsValid(self.Owner) and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then 
		return "base_"
	end
	
	return "det_"
end

function SWEP:drawAnimFunc()
	local prefix = self:getForegripMode()
	
	self:sendWeaponAnim(prefix .. "draw", 1, 0)
end

function SWEP:idleAnimFunc()
	local prefix = self:getForegripMode()
	
	self:sendWeaponAnim(prefix .. "idle", 1, 0)
end

function SWEP:sprintAnimFunc()
	local prefix = self:getForegripMode()
	
	self:sendWeaponAnim(prefix .. "sprint", 1, 0)
end

if CLIENT then
	local m
	local muz = {}
	
	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		else
			if string.StartWith(self.Sequence, "det_") then
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
	usermessage.Hook("CW_KK_INS2_IED_PRIMARY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		
		wep:PrimaryAttack()
	end)
	
	usermessage.Hook("CW_KK_INS2_IED_SECONDARY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		
		wep:SecondaryAttack()
	end)
end
