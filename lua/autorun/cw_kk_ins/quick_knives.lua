
// melee bind
local meta = FindMetaTable("Player")

if meta then 
	function meta:cwkkmelee()
		local wep = self:GetActiveWeapon()
		
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end
		if !wep.KKINS2Wep then return end
		
		if CurTime() < wep:GetNextPrimaryFire() then return end
		
		if wep.KKINS2Melee then 
			wep:PrimaryAttack()
			return
		end
		
		if CustomizableWeaponry_KK.ins2.canKnife(wep) then
			if wep.ActiveAttachments.kk_ins2_ww2_knife then
				CustomizableWeaponry_KK.ins2.meleeWW2(wep)
			else
				CustomizableWeaponry_KK.ins2.meleeKnife(wep)
			end
		end
	end

	concommand.Add("cw_kk_melee", meta.cwkkmelee)
end

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

local function aimAssist(self)
	if SERVER then
		local dir = self.Owner:GetAimVector()
		local targets = ents.FindInCone(self.Owner:GetShootPos(), dir, 100, 30)
		local nearestDist = 200
		local nearestEnt = nil
		
		for _,v in pairs(targets) do
			if (v.IsNPC and v:IsNPC()) or (v.IsPlayer and v:IsPlayer() and v != self.Owner) then
				local d = self.Owner:EyePos():Distance(v:EyePos())
				if d <= nearestDist then
					nearestDist = d
					nearestEnt = v
				end
			end
		end
			
		if nearestEnt then
			local target = nearestEnt:GetShootPos()
			local src = self.Owner:GetShootPos()
			
			local ang = (target - src):Angle()
			self.Owner:SetEyeAngles(ang)
		end
	end
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
			CustomizableWeaponry.actionSequence.new(self, 0.1, nil, function()
				self:EmitSound("weapons/knife/knife_deploy1.wav")
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.1, nil, function()
				self.GrenadePos.z = -15
				self.knifeTime = CurTime() + 1.2
				self:playAnim(self.CW_KK_KNIFE_TWEAK.a_attack, 0, 0.1, self.CW_KK_KNIFE)
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.3, nil, function()
				self:playAnim(self.CW_KK_KNIFE_TWEAK.a_attack, 1, 0.1, self.CW_KK_KNIFE)
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.9, nil, function()
				self:playAnim("holster", 1, 0, self.CW_KK_KNIFE)
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 1, nil, function()
				self:idleAnimFunc()
			end)
		end
		
		CustomizableWeaponry.actionSequence.new(self, 0.37, nil, function() 
			local start = self.Owner:GetShootPos()

			-- aimAssist(self)
			
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
	end
end

usermessage.Hook("CW20_KK_INS_KNIFE_MELEE", function()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		CustomizableWeaponry_KK.ins2.meleeKnife(wep)
	end
end)

if CLIENT then
	function CustomizableWeaponry_KK.ins2:drawKKKnife()
		if CurTime() > self.knifeTime then
			return
		end
		
		pos, ang = EyePos(), EyeAngles()
		
		self.GrenadePos.z = Lerp(FrameTime() * 10, self.GrenadePos.z, 0)
		
		pos = pos + ang:Up() * self.GrenadePos.z
		pos = pos + ang:Forward() * 2
		
		self.CW_KK_KNIFE:SetPos(pos)
		self.CW_KK_KNIFE:SetAngles(ang)
		self.CW_KK_KNIFE:FrameAdvance(FrameTime())

		self.CW_KK_HANDS:SetPos(pos)
		self.CW_KK_HANDS:SetParent(self.CW_KK_KNIFE)
		self.CW_KK_HANDS:AddEffects(EF_BONEMERGE_FASTCULL)
		
		cam.IgnoreZ(true)
			self.CW_KK_KNIFE:DrawModel()
			self.CW_KK_HANDS:DrawModel()
		cam.IgnoreZ(false)
	end
end

function CustomizableWeaponry_KK.ins2:meleeWW2()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if IsFirstTimePredicted() then
		self:meleeAnimFunc()
		
		self:setGlobalDelay(1)
		self:SetNextPrimaryFire(CurTime() + 1)
	
		if SERVER and SP then
			SendUserMessage("CW20_KK_INS_RETICLEINACTIVITY", self.Owner)
		end
		
		local start = self.Owner:GetShootPos()
		
		-- aimAssist(self)
		
		local tr = util.TraceLine({
			start = start,
			endpos = start + self.Owner:GetAimVector() * 80,
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
					
					d:SetDamage(math.random(10) + 45)
					
					local dir = self.Owner:GetAimVector() - start
					d:SetDamageType(DMG_SLASH)
					d:SetDamagePosition(tr.HitPos)
					d:SetReportedPosition(start)
					
					ent:TakeDamageInfo(d)
				end
			end
			
			self:MakeRecoil(math.random(20,40) / 10 * math.pow(-1,math.random(2,3)))
		else
			self:MakeRecoil(math.random(5,10) / 10 * math.pow(-1,math.random(2,3)))				
		end
		
	end
end


