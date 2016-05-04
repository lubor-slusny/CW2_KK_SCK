if not CustomizableWeaponry then return end


if CLIENT then
	SWEP.SprintAnimSpeed = 1.2
	SWEP.ViewModelMovementScale_sprint = 0.5
	SWEP.ViewModelMovementScale_base = 0.6
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.IconLetter = "j"
end

SWEP.WeaponLength = 0

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

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0.001
SWEP.MaxSpreadInc = 0.001
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.001
SWEP.Shots = 1
SWEP.Damage = 56

SWEP.Attachments = {}

SWEP.SpeedDec = 0
SWEP.Recoil = 3

SWEP.FireDelay = 0.6
SWEP.ReticleInactivityPostFire = 0.6

SWEP.FirstDeployTime = 0.6
SWEP.DeployTime = 0.6

SWEP.Animations = {
	draw = "draw",

	base_pickup = "draw",
	base_draw = "draw",
	base_fire = {"hitcenter1","hitcenter2","hitcenter3"},
	base_idle = "idle",
	base_holster = "holster",
	base_sprint = "sprint",
}

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
	local att, m

	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			-- m = self:GetBoneMatrix(0)
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		else
			-- print(self.CW_VM:LookupBone("R Hand")) // 29
			-- m = self.CW_VM:GetBoneMatrix(57) // weapon
			m = self.CW_VM:GetBoneMatrix(32)
		end
		
		return {Pos = m:GetTranslation(), Ang = m:GetAngles()}
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
				
				self:MakeRecoil(math.random(20,40) / 10 * math.pow(-1,math.random(2,3)))
			else
				self:MakeRecoil(math.random(5,10) / 10 * math.pow(-1,math.random(2,3)))				
			end
		end)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end
