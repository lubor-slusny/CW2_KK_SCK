
local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.quickKnives = CustomizableWeaponry_KK.ins2.quickKnives or {}

// funny idea

hook.Add("InitPostEntity", "CW_KK_INS2_MELEE_ICON", function()
	if SERVER then
		CustomizableWeaponry_KK.ins2.quickKnives._inflictor = ents.Create("cw_kk_ins2_damage_melee")
	end
end)

// lets see if it works

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

CustomizableWeaponry_KK.ins2.quickKnives.ww2de = {
	vm = "models/weapons/v_k98kbayonet.mdl",
	a_attack = "hitcenter1"
}
CustomizableWeaponry_KK.ins2.quickKnives.ww2us = {
	vm = "models/weapons/v_k98kbayonet.mdl",
	a_attack = "hitcenter1"
}

function CustomizableWeaponry_KK.ins2:canKnife()
	// can't throw if we're within a restricted state
	if CustomizableWeaponry.quickGrenade.restrictedStates[self.dt.State] then
		return false
	end
	
	-- // can't throw while reloading
	-- if self.ReloadDelay then
		-- return false
	-- end
	
	// can't throw with an active bipod
	if self.dt.BipodDeployed then
		return false
	end
	
	// can't throw while changing weapons
	if self.HolsterDelay then
		return false
	end
	
	// everything passes, can throw, woo!
	return true
end

local knifeRange = 60
local knifeTD = {
	mins = Vector(-6, -6, -6),
	maxs = Vector(6, 6, 6)
}

local bayonetRange = 100
local bayonetTD = {
	mins = Vector(-5, -5, -5),
	maxs = Vector(5, 5, 5)
}

function CustomizableWeaponry_KK.ins2:meleeKnife()
	local CT = CurTime()
	
	self.ReloadDelay = nil
	self.ReloadWait = CT
	self.ShotgunReloadState = 0
	if self.dt.AT4ReloadEnd then
		self.dt.AT4ReloadEnd = 0
	end
	
	if CLIENT then
		self:idleAnimFunc()
	end
	
	self.meleeAttackDelay = CT + 0.6
	
	if SERVER then
		SendUserMessage("CW_KK_INS2_QUICKKNIFE", self.Owner)
	end
	
	if SP or (!SP and SERVER) or (!SP and CLIENT/* and IsFirstTimePredicted()*/) then
		local tr, td, range, dmgTime, dmg, npcForceMult
		
		if self.ActiveAttachments.kk_ins2_ww2_knife then
			self.Owner:SetAnimation(PLAYER_ATTACK1)
			
			if CLIENT then
				self:meleeAnimFunc()
			end
			
			self:setGlobalDelay(0.7)
			self:SetNextPrimaryFire(CT + 1)
		
			td = bayonetTD
			range = bayonetRange
			dmgTime = 0
			dmg = math.random(10) + 45
			npcForceMult = 1500
		else
			self:setGlobalDelay(1.2)
			self:SetNextPrimaryFire(CT + 1.2)
			
			self.dt.State = CW_ACTION
		
			if self:filterPrediction() then
				self:EmitSound("CW_HOLSTER")
			end
			
			if CLIENT then
				CustomizableWeaponry.actionSequence.new(self, 0.1, nil, function()
					self:EmitSound("weapons/knife/knife_deploy1.wav")
				end)
				
				CustomizableWeaponry.actionSequence.new(self, 0.1, nil, function()
					self.GrenadePos.z = -15
					self.knifeTime = CurTime() + 1
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
			
			td = knifeTD
			range = knifeRange
			dmgTime = 0.37
			dmg = math.random(10) + 25
			npcForceMult = 2000
		end
		
		if SERVER then
			CustomizableWeaponry.actionSequence.new(self, dmgTime, nil, function()			
				td.start = self.Owner:GetShootPos()
				td.endpos = td.start + self.Owner:GetAimVector() * range
				td.filter = self.Owner
				
				tr = util.TraceHull(td)
			
				if tr.Hit then
					self.Owner:EmitSound("CW_KK_INS2_KNIFE")
					
					local ent = tr.Entity
					
					if IsValid(ent) then
						local d = DamageInfo()
						
						d:SetAttacker(self.Owner)
						-- d:SetInflictor(self)
						d:SetInflictor(CustomizableWeaponry_KK.ins2.quickKnives._inflictor or self)
						
						d:SetDamage(dmg)
						
						-- local dir = self.Owner:GetAimVector() - td.start
						-- d:SetDamageForce((tr.HitPos + dir) * 200)
						d:SetDamageType(DMG_SLASH)
						d:SetDamagePosition(tr.HitPos)
						d:SetReportedPosition(td.start)
						
						ent:TakeDamageInfo(d)

						if ent:IsNPC() then
							ent:SetVelocity(self.Owner:GetForward() * npcForceMult)
						end
					end
					
					self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
				else
					self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
				end
			end)
		end
	end
end

if CLIENT then
	local ply, wep
	
	usermessage.Hook("CW_KK_INS2_QUICKKNIFE", function()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon then 
			CustomizableWeaponry_KK.ins2.meleeKnife(wep)
		end
	end)

	local pos, ang
	
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
		-- self.CW_KK_HANDS:AddEffects(EF_BONEMERGE_FASTCULL)
		self.CW_KK_HANDS:AddEffects(EF_BONEMERGE)
		
		cam.IgnoreZ(true)
			self.CW_KK_KNIFE:DrawModel()
			self.CW_KK_HANDS:DrawModel()
		cam.IgnoreZ(false)
	end
end

// concommand

if SERVER then
	local wep
	
	concommand.Add("cw_kk_melee", function(ply)
		if !IsValid(ply) then return end
		
		wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end
		
		if wep.CW_KK_MELEE then 
			wep:CW_KK_MELEE()
		end
	end)
end
