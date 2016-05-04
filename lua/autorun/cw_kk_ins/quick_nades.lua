
local SP = game.SinglePlayer()

if CLIENT then
	CreateClientConVar("cw_kk_ins2_qnadetype", 0, false, true)
end

CustomizableWeaponry_KK.ins2.quickGrenades = {}

CustomizableWeaponry_KK.ins2.quickGrenades.m67 = {
	vm = "models/weapons/v_cw_kk_ins2_m67.mdl",
	wm = "models/weapons/w_cw_kk_ins2_m67.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.f1 = {
	vm = "models/weapons/v_f1.mdl",
	wm = "models/weapons/w_f1.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.m18 = {
	vm = "models/weapons/v_m18.mdl",
	wm = "models/weapons/w_m18.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.m84 = {
	vm = "models/weapons/v_m84.mdl",
	wm = "models/weapons/w_m84.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenades.ww2us = {
	vm = "models/weapons/v_mk2.mdl",
	wm = "models/weapons/w_mk2.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.ww2de = {
	vm = "models/weapons/v_stielhandgranate.mdl",
	wm = "models/weapons/w_stielhandgranate.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

local nadeEnt = {
	[0] = "cw_grenade_thrown",
	[1] = "cw_flash_thrown",
	[2] = "cw_smoke_thrown",
}

local nadeAmmo = {
	[0] = "Frag Grenades",
	[1] = "Flash Grenades",
	[2] = "Smoke Grenades",
}

function CustomizableWeaponry_KK.ins2:getNadeAmmo()
	local nadeType
	
	if SERVER then
		nadeType = self.Owner:GetInfoNum("cw_kk_ins2_qnadetype", 0)
	else
		nadeType = GetConVarNumber("cw_kk_ins2_qnadetype") or 0
	end
	
	return nadeAmmo[nadeType], nadeEnt[nadeType]
end

local td = {}

function CustomizableWeaponry_KK.ins2:canThrow()
	-- it's disabled, can't throw
	if not CustomizableWeaponry.quickGrenade.enabled then
		return false
	end
	
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
	
	-- can't throw with no grenades
	if self.Owner:GetAmmoCount(CustomizableWeaponry_KK.ins2.getNadeAmmo(self)) <= 0 then
		return false
	end
	
	-- can't throw the grenade if we're really close to an object
	td.start = self.Owner:GetShootPos()
	td.endpos = td.start + CustomizableWeaponry.quickGrenade.getThrowOffset(self)
	td.filter = self.Owner
	
	local tr = util.TraceLine(td)
	
	-- something in front of us, can't throw
	if tr.Hit then
		return false
	end
	
	-- everything passes, can throw, woo!
	return true
end

function CustomizableWeaponry_KK.ins2:throwGrenade()
	local CT = CurTime()
	
	self:setGlobalDelay(1.9)
	self:SetNextPrimaryFire(CT + 1.9)
	
	if SERVER and SP then
		SendUserMessage("CW20_THROWGRENADE_KK_INS", self.Owner)
	end
	
	self.dt.State = CW_ACTION
	
	if (not SP and IsFirstTimePredicted()) or SP then
		if self:filterPrediction() then
			self:EmitSound("CW_HOLSTER")
		end
		
		CustomizableWeaponry.callbacks.processCategory(self, "beginThrowGrenade")
		
		local quickNadeTweakID = GetConVarNumber("cw_kk_ins2_qnadetype")
		local quickNadeTweak
		
		if quickNadeTweakID == 1 then
			quickNadeTweak = CustomizableWeaponry_KK.ins2.quickGrenades.m84
		elseif quickNadeTweakID == 2 then
			quickNadeTweak = CustomizableWeaponry_KK.ins2.quickGrenades.m18
		else
			quickNadeTweak = self.CW_GREN_TWEAK
		end
		
		local nadeAmmo, entClass = CustomizableWeaponry_KK.ins2.getNadeAmmo(self)
		
		if CLIENT then
			self.CW_GREN:SetModel(quickNadeTweak.vm)
		
			CustomizableWeaponry.actionSequence.new(self, 0.45, nil, function()
				self.GrenadePos.z = -10
				self.grenadeTime = CurTime() + 1.5
				self:playAnim(quickNadeTweak.a_pinpull, 1, 0, self.CW_GREN)
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 0.7, nil, function()
				surface.PlaySound("weapons/pinpull.wav")
			end)
			
			CustomizableWeaponry.actionSequence.new(self, 1, nil, function()
				self:playAnim(quickNadeTweak.a_throw, 1.1, 0, self.CW_GREN)
			end)
		end
		
		if SERVER then
			CustomizableWeaponry.actionSequence.new(self, 1.2, nil, function()
				local pos = self.Owner:GetShootPos()
				local offset = CustomizableWeaponry.quickGrenade.getThrowOffset(self)
				local eyeAng = self.Owner:EyeAngles()
				local forward = eyeAng:Forward()
				
				local nade = ents.Create(entClass)
				nade:SetPos(pos + offset)
				nade:SetAngles(eyeAng)
				
				nade:Spawn()
				nade:Activate()
				
				nade:Fuse(3)
				nade:SetOwner(self.Owner)
				nade:SetModel(quickNadeTweak.wm)
				
				local phys = nade:GetPhysicsObject()
				
				if IsValid(phys) then
					local overallSideMod = self.Owner:KeyDown(IN_SPEED) and 2 or 1

					-- take the velocity into account
					addMod = math.Clamp(self.Owner:GetVelocity():Length() / self.Owner:GetRunSpeed(), 0, 1)
					
					local velocity = forward * CustomizableWeaponry.quickGrenade.throwVelocity + CustomizableWeaponry.quickGrenade.addVelocity
					local velNorm = self.Owner:GetVelocity():GetNormal()
					velNorm.z = 0
					
					-- add velocity based on player velocity normal
					velocity = velocity + velNorm * CustomizableWeaponry.quickGrenade.movementAddVelocity * addMod
					
					phys:SetVelocity(velocity)
					phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
				end
				
				local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
				
				if not suppressAmmoUsage then
					self.Owner:RemoveAmmo(1, nadeAmmo)
				end
			end)
		end
		
		CustomizableWeaponry.actionSequence.new(self, 2, nil, function()
			local delay = CustomizableWeaponry.quickGrenade.postGrenadeWeaponDelay
			self:SetNextPrimaryFire(CT + delay)
			self:SetNextSecondaryFire(CT + delay)
		end)
	end
end

usermessage.Hook("CW20_THROWGRENADE_KK_INS", function()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		CustomizableWeaponry_KK.ins2.throwGrenade(wep)
	end
end)

-- for _,v in pairs(CustomizableWeaponry_KK.ins2.quickGrenades) do
	-- util.PrecacheModel(v.vm)
	-- util.PrecacheModel(v.wm)
-- end