
CustomizableWeaponry_KK.ins2.bulletBgs = CustomizableWeaponry_KK.ins2.bulletBgs or {}
	
if CLIENT then
	CustomizableWeaponry_KK.ins2.bulletBgs._getReserve = function(wep)
		if wep.getFullestMag then
			return math.max(wep:Clip1(), wep:getFullestMag(), -1)
		end
		
		return wep.Owner:GetAmmoCount(wep.Primary.Ammo) + wep:Clip1()
	end
	
	local _getReserve = CustomizableWeaponry_KK.ins2.bulletBgs._getReserve
	
	// main think
	CustomizableWeaponry_KK.ins2.bulletBgs.think = function(wep)
		local clip = wep:Clip1()
		
		local setBG = clip
		
		if wep._bulletsToClip then
			wep._bulletsToClip = false
		else
			local prefix = wep:getForegripMode()
		
			if wep.Sequence == wep.Animations[prefix .. "reload_start_empty"] then
				return
			end
			
			if wep.Sequence == wep.Animations[prefix .. "reload_start"] then
				return
			end
			
			if wep.Sequence == wep.Animations[prefix .. "insert"] then
				return
			end
			
			local ammo = _getReserve(wep)
			
			local cycle = wep.CW_VM:GetCycle()
			
			if wep._loadingNewBelt != wep.Sequence or cycle >= 1 or (wep.Owner:ShouldDrawLocalPlayer() and cycle <= 0) then
				wep._loadingNewBelt = false
			end
			
			setBG = wep._loadingNewBelt and ammo or clip
		end
		
		setBG = math.Clamp(setBG, 0, wep._beltBGMax)
		
		wep:setBodygroup(wep._beltBGID, setBG)
	end
	
	// big guns
	CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve = function(wep)
		wep._loadingNewBelt = wep.Sequence
	end
	
	CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToClip = function(wep)
		wep._bulletsToClip = true
	end
	
	// revolvers
	CustomizableWeaponry_KK.ins2.bulletBgs.shellsToReserve = function(wep)
		local ammo = _getReserve(wep)
		wep:setBodygroup(wep._shellsBGID, math.Clamp(ammo, 0, wep._shellsBGMax))
	end
	
	CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip = function(wep)
		wep:setBodygroup(wep._shellsBGID, math.Clamp(wep:Clip1(), 0, wep._shellsBGMax))
	end
end
