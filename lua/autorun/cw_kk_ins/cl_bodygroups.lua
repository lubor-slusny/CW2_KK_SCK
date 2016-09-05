
CustomizableWeaponry_KK.ins2.bulletBgs = {}
	
if CLIENT then
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
			
			local ammo
			
			if wep.getFullestMag then
				ammo = math.max(wep:Clip1(), wep:getFullestMag(), -1)
			else
				ammo = wep.Owner:GetAmmoCount(wep.Primary.Ammo) + clip
			end
			
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
		local ammo
		
		if wep.getFullestMag then
			ammo = math.max(wep:Clip1(), wep:getFullestMag(), -1)
		else
			ammo = wep.Owner:GetAmmoCount(wep.Primary.Ammo) + clip
		end
		
		wep:setBodygroup(wep._shellsBGID, math.Clamp(ammo, 0, wep._shellsBGMax))
	end
	
	CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip = function(wep)
		wep:setBodygroup(wep._shellsBGID, math.Clamp(wep:Clip1(), 0, wep._shellsBGMax))
	end
end
