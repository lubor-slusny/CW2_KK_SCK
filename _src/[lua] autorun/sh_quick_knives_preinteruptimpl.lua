
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

function CustomizableWeaponry_KK.ins2:canKnife()
	-- can't throw if we're within a restricted state
	if CustomizableWeaponry.quickGrenade.restrictedStates[self.dt.State] then
		return false
	end
	
	-- can't throw while reloading
	-- if self.ReloadDelay then
		-- return false
	-- end
	
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

local knifeRange = 60

local knifeTD = {
	mins = Vector(-6, -6, -6),
	maxs = Vector(6, 6, 6)
}

local knifeTR

function CustomizableWeaponry_KK.ins2:meleeKnife()
	local CT = CurTime()
	
	if !self.ShotgunReload then
		self.ReloadDelay = nil
		
		if CLIENT then
			self:idleAnimFunc()
		end
	end
	
	self.meleeAttackDelay = CT + 1.5
	
	self:setGlobalDelay(1.2)
	self:SetNextPrimaryFire(CT + 1.2)
	
	if SERVER and SP then
		SendUserMessage("CW_KK_INS2_QUICKKNIFE", self.Owner)
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
			knifeTD.start = self.Owner:GetShootPos()
			knifeTD.endpos = knifeTD.start + self.Owner:GetAimVector() * knifeRange
			knifeTD.filter = self.Owner
			
			knifeTR = util.TraceHull(knifeTD)
			
			if knifeTR.Hit then
				self:EmitSound("CW_KK_INS2_KNIFE")
				
				local ent = knifeTR.Entity
				
				if IsValid(ent) then
					if SERVER then
						local d = DamageInfo()
						
						d:SetAttacker(self.Owner)
						-- d:SetInflictor(self)
						d:SetInflictor(CustomizableWeaponry_KK.ins2.quickKnives._inflictor)
						
						d:SetDamage(math.random(10) + 25)
						
						local dir = self.Owner:GetAimVector() - knifeTD.start
						d:SetDamageForce((knifeTR.HitPos + dir) * 200)
						d:SetDamageType(DMG_SLASH)
						d:SetDamagePosition(knifeTR.HitPos)
						d:SetReportedPosition(knifeTD.start)
						
						ent:TakeDamageInfo(d)

						if ent:IsNPC() then
							ent:SetVelocity(self.Owner:GetForward() * 2000)
						end
					end
				end
				
				self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
			end
			
			self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
		end)
	end
end

usermessage.Hook("CW_KK_INS2_QUICKKNIFE", function()
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

local bayonetRange = 100

local bayonetTD = {
	mins = Vector(-5, -5, -5),
	maxs = Vector(5, 5, 5)
}

local bayonetTR

function CustomizableWeaponry_KK.ins2:meleeWW2()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if !self.ShotgunReload then
		self.ReloadDelay = nil
		
		if CLIENT then
			self:idleAnimFunc()
		end
	end
	
	self.meleeAttackDelay = CT + 1.5
	
	if IsFirstTimePredicted() then
		self:meleeAnimFunc()
		
		self:setGlobalDelay(1)
		self:SetNextPrimaryFire(CurTime() + 1)
	
		if SERVER and SP then
			SendUserMessage("CW_KK_INS2_RETICLEINACTIVITY", self.Owner)
		end
		
		bayonetTD.start = self.Owner:GetShootPos()
		bayonetTD.endpos = bayonetTD.start + self.Owner:GetAimVector() * bayonetRange
		bayonetTD.filter = self.Owner
		
		bayonetTR = util.TraceHull(bayonetTD)
		
		if bayonetTR.Hit then
			self:EmitSound("CW_KK_INS2_KNIFE")
			local ent = bayonetTR.Entity
			
			if IsValid(ent) then
				if SERVER then
					local d = DamageInfo()
					
					d:SetAttacker(self.Owner)
					-- d:SetInflictor(self)
					d:SetInflictor(CustomizableWeaponry_KK.ins2.quickKnives._inflictor)
					
					d:SetDamage(math.random(10) + 45)
					
					local dir = self.Owner:GetAimVector() - bayonetTD.start
					d:SetDamageType(DMG_SLASH)
					d:SetDamagePosition(bayonetTR.HitPos)
					d:SetReportedPosition(bayonetTD.start)
					
					ent:TakeDamageInfo(d)

					if ent:IsNPC() and ent:Health() > 0 then
						ent:SetVelocity(self.Owner:GetForward() * 1500)
					end
				end
			end
			
			self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
		else
			self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
		end
		
	end
end

// concommand

local function cw_kk_melee(ply)
	-- print("Qnife call;", ply)
	
	if !IsValid(ply) then return end
	
	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end
	if !wep.CW20Weapon then return end
	if !wep.KKINS2Wep then return end
	
	-- if CurTime() < wep:GetNextPrimaryFire() then return end
	-- if not wep:canFireWeapon(1) then return end
	
	if wep.meleeAttackDelay and wep.meleeAttackDelay > CurTime() then return end
	
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

concommand.Add(
	"cw_kk_melee",
	cw_kk_melee,
	nil, 
	"CW2 KK INS2 Melee attack"
	-- ,{FCVAR_REPLICATED}
	-- ,{FCVAR_CLIENTCMD_CAN_EXECUTE}
	,{FCVAR_REPLICATED, FCVAR_CLIENTCMD_CAN_EXECUTE}
)
