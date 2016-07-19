if not CustomizableWeaponry then return end

AddCSLuaFile()

SWEP.Base = "cw_kk_ins2_base_main"

local SP = game.SinglePlayer()

function SWEP:setPickedUp(val)
	if SERVER then
		umsg.Start("CW_KK_INS2_PICKUP_v2")
			umsg.Entity(self)
			umsg.Bool(val)
		umsg.End()
	end
	
	self._KK_INS2_PickedUp = val	
end

if CLIENT then
	local wep, state
	
	usermessage.Hook("CW_KK_INS2_PICKUP_v2", function(um)
		wep = um:ReadEntity()
		
		if IsValid(wep) and wep.setPickedUp then
			wep:setPickedUp(um:ReadBool())
		end
	end)
end

function SWEP:PrepareForPickup(drop)
	self:setPickedUp(false)
end

function SWEP:drawAnimFunc()
	prefix = self:getForegripMode()
	
	if not self._KK_INS2_PickedUp then
		if !(clip == 0 and self.KK_INS2_EmptyIdle) and IsValid(self.Owner) then // wtf owner?
			
			CustomizableWeaponry.actionSequence.new(self, 0, nil, function()
				self:pickupAnimFunc(prefix)
				self:setPickedUp(true)
			end)
			
			return
		end
	end
	
	clip = self:Clip1()
	suffix = ""
	
	if self.dt.INS2GLActive then
		if !self.M203Chamber and self.KK_INS2_EmptyIdleGL then
			suffix = "_empty"
		end
	else
		if clip == 0 and self.KK_INS2_EmptyIdle then
			suffix = "_empty"
		end
	end
	
	self:sendWeaponAnim(prefix .. "draw" .. suffix,self.DrawSpeed,0)
end

function SWEP:GetDeployTime()
	return self._KK_INS2_PickedUp and self.DeployTime or self.FirstDeployTime
end
