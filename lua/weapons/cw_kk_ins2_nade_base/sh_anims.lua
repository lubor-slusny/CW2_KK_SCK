
local SP = game.SinglePlayer()
local cycle, anim, rate

if CLIENT then
	function SWEP:playSwitchBipod()
		//no need
	end
	
	function SWEP:sprintAnimFunc()
		if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
			self:playAnim("base_draw", -1, 0)
		else
			self:playAnim("base_sprint", self.SprintAnimSpeed or 1, 0)
		end
	end

	function SWEP:safetyAnimFunc()
		//no need
	end

	function SWEP:firemodeAnimFunc()
		//no need
	end
		
	function SWEP:idleAnimFunc()
		if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
			self:playAnim("base_draw", -1, 0)
		else
			self:playAnim("base_idle", 0, 0)
		end
	end
end

function SWEP:pickupAnimFunc(mode)
	self:drawAnimFunc()
end

function SWEP:drawAnimFunc()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
		self:sendWeaponAnim("base_draw", -1, 0)
	else
		self:sendWeaponAnim("base_draw", self.DrawSpeed, 0)
	end
end

function SWEP:meleeAnimFunc()
	//no need
end
	
function SWEP:fireAnimFunc()
	//no need
end

function SWEP:holsterAnimFunc()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
		self:sendWeaponAnim("base_draw", -1, 0)
	else
		self:sendWeaponAnim("base_holster", self.HolsterSpeed, 0)
	end
end

if SP then
	function SWEP:holsterAnimFunc()
		self:holsterAnimFunc()
	end
end
