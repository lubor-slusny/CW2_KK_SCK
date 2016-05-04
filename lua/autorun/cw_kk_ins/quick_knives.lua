
local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.quickKnives = {}

CustomizableWeaponry_KK.ins2.quickKnives.gurkha = {
	vm = "models/weapons/v_gurkha.mdl",
	a_attack = "hitcenter3"
}

CustomizableWeaponry_KK.ins2.quickKnives.bayonet = {
	vm = "models/weapons/v_marinebayonet.mdl",
	a_attack = "hitcenter3"
}

CustomizableWeaponry_KK.ins2.quickKnives.ninjato = {
	vm = "models/weapons/v_cw_kk_ins2_ninjato.mdl",
	a_attack = "hitcenter1"
}

function CustomizableWeaponry_KK.ins2:canKnife()
	-- can't throw if we're within a restricted state
	if CustomizableWeaponry.quickGrenade.restrictedStates[self.dt.State] then
		return false
	end
	
	-- can't throw while reloading
	if self.ReloadDelay then
		return false
	end
	
	-- can't throw with an active bipod
	if self.dt.BipodDeployed then
		return false
	end
	
	-- can't throw while changing weapons
	if self.HolsterDelay then
		return false
	end
	
	-- everything passes, can throw, woo!
	return true
end

function CustomizableWeaponry_KK.ins2:meleeKnife()
	local CT = CurTime()
	
	self:setGlobalDelay(1.2)
	self:SetNextPrimaryFire(CT + 1.2)
	
	if SERVER and SP then
		SendUserMessage("CW20_KK_INS_KNIFE_MELEE", self.Owner)
	end
	
	self.dt.State = CW_ACTION
	
	if (not SP and IsFirstTimePredicted()) or SP then
		if self:filterPrediction() then
			self:EmitSound("CW_HOLSTER")
		end
		
		if CLIENT then
			CustomizableWeaponry.actionSequence.new(self, 0.2, nil, function()
				self:EmitSound("weapons/knife/knife_deploy1.wav")
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.45, nil, function()
				self.GrenadePos.z = -10
				self.knifeTime = CurTime() + 0.5
				self:playAnim(self.CW_KK_KNIFE_TWEAK.a_attack, 1, 0, self.CW_KK_KNIFE)
				self:EmitSound("weapons/knife/knife_slash" .. math.random(1,2) .. ".wav")
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.8, nil, function()
				self:playAnim("holster", 1, 0, self.CW_KK_KNIFE)
			end)
		end
		
		CustomizableWeaponry.actionSequence.new(self, 0.4, nil, function() 
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
						d:SetDamageForce((tr.HitPos + dir) * 200)
						d:SetDamageType(DMG_SLASH)
						d:SetDamagePosition(tr.HitPos)
						d:SetReportedPosition(start)
						
						ent:TakeDamageInfo(d)
					end
				end
				
				self:MakeRecoil(math.random(20,40) / 10 * math.pow(-1,math.random(2,3)))
			end
			
			self:MakeRecoil(math.random(5,10) / 10 * math.pow(-1,math.random(2,3)))
		end)
		
		CustomizableWeaponry.actionSequence.new(self, 2, nil, function()
			local delay = 3
			self:SetNextPrimaryFire(CT + delay)
			self:SetNextSecondaryFire(CT + delay)
		end)
	end
end

usermessage.Hook("CW20_KK_INS_KNIFE_MELEE", function()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		CustomizableWeaponry_KK.ins2.meleeKnife(wep)
	end
end)
