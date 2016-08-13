
local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.quickKnives = CustomizableWeaponry_KK.ins2.quickKnives or {}

// funny idea

hook.Add("InitPostEntity", "CW_KK_INS2_MELEE_ICON", function()
	if SERVER then
		CustomizableWeaponry_KK.ins2.quickKnives.inflictor = ents.Create("cw_kk_ins2_damage_melee")
	end
end)

// lets see if it works

CustomizableWeaponry_KK.ins2.quickKnives.models = {}

CustomizableWeaponry_KK.ins2.quickKnives.models.gurkha = {
	vm = "models/weapons/v_gurkha.mdl",
	a_attack = "hitcenter3"
}

CustomizableWeaponry_KK.ins2.quickKnives.models.bayonet = {
	vm = "models/weapons/v_marinebayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnives.models.ninjato = {
	vm = "models/weapons/v_cw_kk_ins2_ninjato.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnives.models.ww2de = {
	vm = "models/weapons/v_k98kbayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnives.models.ww2us = {
	vm = "models/weapons/v_garand_bayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnives.models.ww2gb = {
	vm = "models/weapons/v_garand_bayonet.mdl",
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

CustomizableWeaponry_KK.ins2.quickKnives.categories = {}

CustomizableWeaponry_KK.ins2.quickKnives.categories.knife = {
	td = {mins = Vector(-6, -6, -6), maxs = Vector(6, 6, 6)},
	range = 60,
	dmgBase = 30,
	dmgAddRnd = 10,
	dmgTime = 0.37,
	npcForceMult = 2000,
}

CustomizableWeaponry_KK.ins2.quickKnives.categories.bayonet = {
	td = {mins = Vector(-5, -5, -5), maxs = Vector(5, 5, 5)},
	range = 100,
	dmgBase = 55,
	dmgAddRnd = 10,
	dmgTime = 0,
	npcForceMult = 1500,
}

if SERVER then
	function CustomizableWeaponry_KK.ins2.quickKnives:_createDamage(wep, category)
		// Ill just count on wep and wep.Owner being Valid here 
	
		local setup = category and self.categories[category]
	
		if not setup then 
			print("[CustomizableWeaponry_KK.ins2.quickKnives:_createDamage]: invalid category")
			return 
		end
		
		local td = setup.td
		local tr
	
		CustomizableWeaponry.actionSequence.new(wep, setup.dmgTime, nil, function()			
			td.start = wep.Owner:GetShootPos()
			td.endpos = td.start + wep.Owner:GetAimVector() * setup.range
			td.filter = wep.Owner
			
			tr = util.TraceHull(td)
		
			if tr.Hit then
				wep.Owner:EmitSound("CW_KK_INS2_KNIFE")
				
				local ent = tr.Entity
				
				if IsValid(ent) then
					local d = DamageInfo()
					
					d:SetAttacker(wep.Owner)
					-- d:SetInflictor(wep)
					d:SetInflictor(self.inflictor or wep)
					
					d:SetDamage(setup.dmgBase + math.random(setup.dmgAddRnd))
					
					-- local dir = wep.Owner:GetAimVector() - td.start
					-- d:SetDamageForce((tr.HitPos + dir) * 200)
					d:SetDamageType(DMG_SLASH)
					d:SetDamagePosition(tr.HitPos)
					d:SetReportedPosition(td.start)
					
					ent:TakeDamageInfo(d)

					if ent:IsNPC() then
						ent:SetVelocity(wep.Owner:GetForward() * setup.npcForceMult)
					end
				end
				
				wep.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			else
				wep.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			end
		end)
		
	end
end

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
		local category
		
		self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2, true)
		-- self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND, true)
		-- self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true)
		
		if self.ActiveAttachments.kk_ins2_ww2_knife then			
			if CLIENT then
				self:meleeAnimFunc()
			end
			
			self:setGlobalDelay(0.7)
			self:SetNextPrimaryFire(CT + 1)
			
			category = "bayonet"
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
					
					self.CW_KK_HANDS:SetParent(self.CW_KK_KNIFE)
					
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
			
			category = "knife"
		end
	
		if SERVER then
			CustomizableWeaponry_KK.ins2.quickKnives:_createDamage(self, category)
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
	
	local EyePos = EyePos
	local EyeAngles = EyeAngles
	local CurTime = CurTime
	local Lerp = Lerp
	local FrameTime = FrameTime
	
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
		
		self.CW_KK_HANDS:AddEffects(EF_BONEMERGE_FASTCULL)
		
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
