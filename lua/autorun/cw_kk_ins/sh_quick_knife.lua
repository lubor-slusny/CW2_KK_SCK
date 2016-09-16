
local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.quickKnife = CustomizableWeaponry_KK.ins2.quickKnife or {}

// only purpose of this entity is to give melee attack knife killicon
hook.Add("InitPostEntity", "CW_KK_INS2_MELEE_ICON", function()
	if SERVER then
		CustomizableWeaponry_KK.ins2.quickKnife._inflictor = ents.Create("cw_kk_ins2_damage_melee")
	end
end)

CustomizableWeaponry_KK.ins2.quickKnife.models = {}

CustomizableWeaponry_KK.ins2.quickKnife.models.gurkha = {
	vm = "models/weapons/v_gurkha.mdl",
	a_attack = "hitcenter3"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.bayonet = {
	vm = "models/weapons/v_marinebayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ninjato = {
	vm = "models/weapons/v_cw_kk_ins2_ninjato.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ww2de = {
	vm = "models/weapons/v_k98kbayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ww2us = {
	vm = "models/weapons/v_garand_bayonet.mdl",
	a_attack = "hitcenter1"
}

CustomizableWeaponry_KK.ins2.quickKnife.models.ww2gb = {
	vm = "models/weapons/v_garand_bayonet.mdl",
	a_attack = "hitcenter1"
}

function CustomizableWeaponry_KK.ins2.quickKnife.canAttack(wep)
	if CustomizableWeaponry.quickGrenade.restrictedStates[wep.dt.State] then
		return false
	end
	
	if wep.dt.PinPulled then 
		return
	end
	
	if wep.dt.BipodDeployed then
		return false
	end
	
	if wep.HolsterDelay then
		return false
	end
	
	return true
end

CustomizableWeaponry_KK.ins2.quickKnife.categories = {}

CustomizableWeaponry_KK.ins2.quickKnife.categories.knife = {
	td = {mins = Vector(-6, -6, -6), maxs = Vector(6, 6, 6)},
	range = 60,
	dmgBase = 30,
	dmgAddRnd = 10,
	dmgTime = 0.37,
	npcForceMult = 2000,
}

CustomizableWeaponry_KK.ins2.quickKnife.categories.bayonet = {
	td = {mins = Vector(-5, -5, -5), maxs = Vector(5, 5, 5)},
	range = 100,
	dmgBase = 55,
	dmgAddRnd = 10,
	dmgTime = 0,
	npcForceMult = 1500,
}

if SERVER then
	function CustomizableWeaponry_KK.ins2.quickKnife:_createDamage(wep, category)
		// Ill just count on wep and wep.Owner being Valid here 
	
		local setup = category and self.categories[category]
	
		if not setup then 
			print("[CustomizableWeaponry_KK.ins2.quickKnife:_createDamage]: invalid category")
			return 
		end
		
		local td = setup.td
		local tr, ang
	
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
					d:SetInflictor(self._inflictor or wep)
					
					d:SetDamage(setup.dmgBase + math.random(setup.dmgAddRnd))
					
					-- local dir = wep.Owner:GetAimVector() - td.start
					-- d:SetDamageForce((tr.HitPos + dir) * 200)
					d:SetDamageType(DMG_SLASH)
					d:SetDamagePosition(tr.HitPos)
					d:SetReportedPosition(td.start)
					
					ent:TakeDamageInfo(d)

					if ent:IsNPC() then
						ang = wep.Owner:GetAngles()
						ang.p = 0
						ent:SetVelocity(ang:Forward() * setup.npcForceMult)
					end
				end
				
				wep.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			else
				wep.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			end
		end)
		
	end
end

function CustomizableWeaponry_KK.ins2.quickKnife.attack(wep)
	local CT = CurTime()
	
	// reset reload delays to interrupt reload (if any)
	wep.ReloadDelay = nil
	wep.ReloadWait = CT
	wep.ShotgunReloadState = 0
	if wep.dt.AT4ReloadEnd then
		wep.dt.AT4ReloadEnd = 0
	end
	
	// reset VM anim
	if CLIENT then
		wep:idleAnimFunc()
	end
	
	// since we are ignoring base delays, lets add our own
	// btw why dont I check for this in quickKnife.canAttack?
	wep.meleeAttackDelay = CT + 0.6
	
	// tell client to do stuff since we are triggered using concommand, not PrimaryAttack
	// prubly should replace this with net.Send
	if SERVER then
		SendUserMessage("CW_KK_INS2_QUICKKNIFE", wep.Owner)
	end
	
	// looking back on this check few months later, it doesnt make any sense
	if SP or (!SP and SERVER) or (!SP and CLIENT/* and IsFirstTimePredicted()*/) then
		local category
		
		-- if CLIENT then
			-- wep.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2, true)
			-- wep.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND, true)
			-- wep.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true)
		-- end
		
		// why didnt I just broadcast this from server directly? why am I sending it to server first?
		if CLIENT then
			net.Start("CW_KK_INS2_NWGQK")
			net.SendToServer()
		end
		
		// this will make adding hands (DOI Thompson) fun
		if wep.ActiveAttachments.kk_ins2_ww2_knife then			
			if CLIENT then
				wep:meleeAnimFunc()
			end
			
			wep:setGlobalDelay(0.7)
			wep:SetNextPrimaryFire(CT + 1)
			
			category = "bayonet"
		else
			wep:setGlobalDelay(1.2)
			wep:SetNextPrimaryFire(CT + 1.2)
			
			wep.dt.State = CW_ACTION
		
			if wep:filterPrediction() then
				wep:EmitSound("CW_HOLSTER")
			end
			
			if CLIENT then
				CustomizableWeaponry.actionSequence.new(wep, 0.1, nil, function()
					wep:EmitSound("weapons/knife/knife_deploy1.wav")
				end)
				
				CustomizableWeaponry.actionSequence.new(wep, 0.1, nil, function()
					wep.GrenadePos.z = -15
					wep.knifeTime = CurTime() + 1
					
					wep.CW_KK_HANDS:SetParent(wep.CW_KK_KNIFE)
					
					wep:playAnim(wep.CW_KK_KNIFE_TWEAK.a_attack, 0, 0.1, wep.CW_KK_KNIFE)
				end)
				
				CustomizableWeaponry.actionSequence.new(wep, 0.3, nil, function()
					wep:playAnim(wep.CW_KK_KNIFE_TWEAK.a_attack, 1, 0.1, wep.CW_KK_KNIFE)
				end)
				
				CustomizableWeaponry.actionSequence.new(wep, 0.9, nil, function()
					wep:playAnim("holster", 2, 0, wep.CW_KK_KNIFE)
				end)
				
				CustomizableWeaponry.actionSequence.new(wep, 1, nil, function()
					wep.reticleInactivity = 0
					wep:idleAnimFunc()
				end)
			end
			
			category = "knife"
		end
	
		if SERVER then
			CustomizableWeaponry_KK.ins2.quickKnife:_createDamage(wep, category)
		end
	end
end

if CLIENT then
	local ply, wep
	
	usermessage.Hook("CW_KK_INS2_QUICKKNIFE", function()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon then 
			CustomizableWeaponry_KK.ins2.quickKnife.attack(wep)
		end
	end)

	local pos, ang
	
	local EyePos = EyePos
	local EyeAngles = EyeAngles
	local CurTime = CurTime
	local Lerp = Lerp
	local FrameTime = FrameTime
	
	function CustomizableWeaponry_KK.ins2.quickKnife.drawVM(wep)
		if CurTime() > wep.knifeTime then
			return
		end
		
		pos, ang = EyePos(), EyeAngles()
		
		wep.GrenadePos.z = Lerp(FrameTime() * 10, wep.GrenadePos.z, 0)
		
		pos = pos + ang:Up() * wep.GrenadePos.z
		pos = pos + ang:Forward() * 2
		
		wep.CW_KK_KNIFE:SetPos(pos)
		wep.CW_KK_KNIFE:SetAngles(ang)
		wep.CW_KK_KNIFE:FrameAdvance(FrameTime())
		
		wep.CW_KK_HANDS:AddEffects(EF_BONEMERGE_FASTCULL)
		
		cam.IgnoreZ(true)
			wep.CW_KK_KNIFE:DrawModel()
			wep.CW_KK_HANDS:DrawModel()
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

// gesture

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWGQK")
end

local function receive(len, ply)	
	if SERVER then
		net.Start("CW_KK_INS2_NWGQK")
		net.WriteEntity(ply)
		net.Broadcast()
	else
		local ply = net.ReadEntity()
		
		if IsValid(ply) then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2, true)
		end
	end
end
	
net.Receive("CW_KK_INS2_NWGQK", receive)
