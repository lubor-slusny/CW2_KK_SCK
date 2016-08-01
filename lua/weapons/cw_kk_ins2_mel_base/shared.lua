if not CustomizableWeaponry then return end
AddCSLuaFile()

SWEP.KKINS2Melee = true

if CLIENT then
	SWEP.SprintAnimSpeed = 1.2
	SWEP.ViewModelMovementScale_sprint = 0.5
	SWEP.ViewModelMovementScale_base = 0.6
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.IconLetter = "j"
	
	SWEP.HUD_3D2DBone = 32
end

SWEP.Attachments = {}

SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.Author			= "Knife Kitty"
SWEP.Contact		= "http://steamcommunity.com/profiles/76561198012236670/"
SWEP.Purpose		= "detaching shared functions"
SWEP.Instructions	= "dont spawn this directly"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.AimingEnabled = false
SWEP.CanCustomize = false
SWEP.HolsterUnderwater = false
SWEP.AccuracyEnabled = false
SWEP.AddSafeMode = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001
SWEP.Recoil = 3

SWEP.FireDelay = 0.6
SWEP.ReticleInactivityPostFire = 0.6

SWEP.FirstDeployTime = 0.6
SWEP.DeployTime = 0.6

SWEP.SpeedDec = 0
SWEP.WeaponLength = 0

CustomizableWeaponry:addFireSound("CW_KK_INS2_KNIFE", "weapons/knife/knife_slash_01.wav", 1, 70, CHAN_STATIC)

SWEP.Sounds = {
	draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	}
}

if CLIENT then
	local m
	local muz = {}
	
	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		else
			m = self.CW_VM:GetBoneMatrix(self.HUD_3D2DBone)
		end
		
		muz.Pos = m:GetTranslation()
		muz.Ang = m:GetAngles()
		return muz
	end
end

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry.quickGrenade.canThrow(self) then
			CustomizableWeaponry_KK.ins2.throwGrenade(self)
			return
		end
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if IsFirstTimePredicted() then
		self:sendWeaponAnim("base_fire",1,0)
		self:SetNextPrimaryFire(CurTime() + self.FireDelay)
		
		if CLIENT then 
			if self.ReticleInactivityPostFire then
				self.reticleInactivity = UnPredictedCurTime() + self.ReticleInactivityPostFire
			end
		end
		
		CustomizableWeaponry.actionSequence.new(self, 0.2, nil, function() 
			local start = self.Owner:GetShootPos()
			
			local tr = util.TraceLine({
				start = start,
				endpos = start + self.Owner:GetAimVector() * 60,
				filter = self.Owner
			})
		
			if tr.Hit then
				self:EmitSound("CW_KK_INS2_KNIFE")
				local ent = tr.Entity
				
				if IsValid(ent) then
					if SERVER then
						local d = DamageInfo()
						
						d:SetAttacker(self.Owner)
						d:SetInflictor(self)
						
						d:SetDamage(math.random(10) + 25)
						
						local dir = self.Owner:GetAimVector() - start
						-- d:SetDamageForce((tr.HitPos + dir) * 200)
						d:SetDamageType(DMG_SLASH)
						d:SetDamagePosition(tr.HitPos)
						d:SetReportedPosition(start)
						
						ent:TakeDamageInfo(d)
					end
					
					-- if tr.MatType == MAT_METAL or tr.MatType == MAT_CONCRETE then
						-- local ed = EffectData()
						-- local dir = start - tr.HitPos
						-- ed:SetOrigin(tr.HitPos + (dir))
						-- util.Effect("StunstickImpact", ed)
					-- end
				end
				
				self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			else
				self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			end
		end)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end
