
local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.quickGrenades = {}

if CLIENT then
	CustomizableWeaponry_KK.ins2.quickGrenades.cvarType = CreateClientConVar("_cw_kk_ins2_qnadetype", 0, false, true)
end

CustomizableWeaponry_KK.ins2.quickGrenades.models = {}

CustomizableWeaponry_KK.ins2.quickGrenades.models.m67 = {
	vm = "models/weapons/v_cw_kk_ins2_m67.mdl",
	wm = "models/weapons/w_cw_kk_ins2_m67.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.models.f1 = {
	vm = "models/weapons/v_f1.mdl",
	wm = "models/weapons/w_f1.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.models.m18 = {
	vm = "models/weapons/v_m18.mdl",
	wm = "models/weapons/w_m18.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.models.m84 = {
	vm = "models/weapons/v_m84.mdl",
	wm = "models/weapons/w_m84.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.models.ww2us = {
	vm = "models/weapons/v_mk2.mdl",
	wm = "models/weapons/w_mk2.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.models.ww2de = {
	vm = "models/weapons/v_stielhandgranate.mdl",
	wm = "models/weapons/w_stielhandgranate.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}
CustomizableWeaponry_KK.ins2.quickGrenades.models.ww2gb = {
	vm = "models/weapons/v_mills.mdl",
	wm = "models/weapons/w_mills.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenades.categories = {
	{text = "FRAG", ammo = "Frag Grenades", class = "cw_grenade_thrown"},
	{text = "FLASH", ammo = "Flash Grenades", class = "cw_flash_thrown", default = "m84"},
	{text = "SMOKE", ammo = "Smoke Grenades", class = "cw_smoke_thrown", default = "m18"},
}

if CustomizableWeaponry_KK.HOME then
	CustomizableWeaponry_KK.ins2.quickGrenades.categories[4] = {text = "BUG", ammo = "9x19MM", class = "npc_grenade_bugbait"}
end

function CustomizableWeaponry_KK.ins2:getNadeAmmo()
	local nadeType
	
	if SERVER then
		nadeType = self.Owner:GetInfoNum("_cw_kk_ins2_qnadetype", 1)
	else
		nadeType = CustomizableWeaponry_KK.ins2.quickGrenades.cvarType:GetInt() or 1
	end
	
	nadeType = math.Clamp(nadeType, 1, #CustomizableWeaponry_KK.ins2.quickGrenades.categories)
	
	return CustomizableWeaponry_KK.ins2.quickGrenades.categories[nadeType]
end

local td = {}

function CustomizableWeaponry_KK.ins2:canThrow()
	// it's disabled, can't throw
	if not CustomizableWeaponry.quickGrenade.enabled then
		return false
	end
	
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
	
	// can't throw with no grenades
	local curSetup = CustomizableWeaponry_KK.ins2.getNadeAmmo(self)
	if self.Owner:GetAmmoCount(curSetup.ammo) <= 0 then
		return false
	end
	
	-- // can't throw the grenade if we're really close to an object
	-- td.start = self.Owner:GetShootPos()
	-- td.endpos = td.start + CustomizableWeaponry.quickGrenade:getThrowOffset(self.Owner)
	-- td.filter = self.Owner
	
	-- local tr = util.TraceLine(td)
	
	-- // something in front of us, can't throw
	-- if tr.Hit then
		-- return false
	-- end
	
	// everything passes, can throw, woo!
	return true
end

function CustomizableWeaponry_KK.ins2:throwGrenade(IFTP)
	local CT = CurTime()
	
	self:setGlobalDelay(1.9)
	self:SetNextPrimaryFire(CT + 1.9)
	
	if SERVER and SP then
		SendUserMessage("CW_KK_INS2_THROWGRENADE", self.Owner)
	end
	
	self.dt.State = CW_ACTION
	
	IFTP = IFTP or IsFirstTimePredicted()
	
	if (not SP and IFTP) or SP then
		if self:filterPrediction() then
			self:EmitSound("CW_HOLSTER")
		end
		
		CustomizableWeaponry.callbacks.processCategory(self, "beginThrowGrenade")
		
		local curSetup = CustomizableWeaponry_KK.ins2.getNadeAmmo(self)
		
		local quickNadeTweak = curSetup.default and CustomizableWeaponry_KK.ins2.quickGrenades.models[curSetup.default] or self.CW_GREN_TWEAK
		local nadeAmmo = curSetup.ammo
		local entClass = curSetup.class
		
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
			// needs cleanup
		
			CustomizableWeaponry.actionSequence.new(self, 1.2, nil, function()
				local pos = self.Owner:GetShootPos()
				-- local offset = CustomizableWeaponry.quickGrenade.getThrowOffset(self.Owner)
				local eyeAng = self.Owner:EyeAngles()
				local forward = eyeAng:Forward()
				
				local nade = ents.Create(entClass)
				
				if not IsValid(nade) then return end
				
				nade.Model = quickNadeTweak.wm
				
				-- nade:SetPos(pos + offset)
				nade:SetPos(pos)
				nade:SetAngles(eyeAng)
				
				nade:Spawn()
				nade:Activate()
				
				if nade.Fuse then
					nade:Fuse(3)
				end
				
				nade:SetOwner(self.Owner)
				
				
				
				
				local overallSideMod = self.Owner:KeyDown(IN_SPEED) and 2 or 1

				-- take the velocity into account
				local addMod = math.Clamp(self.Owner:GetVelocity():Length() / self.Owner:GetRunSpeed(), 0, 1)
				
				local velocity = forward * CustomizableWeaponry.quickGrenade.throwVelocity + CustomizableWeaponry.quickGrenade.addVelocity
				local velNorm = self.Owner:GetVelocity():GetNormal()
				velNorm.z = 0
				
				-- add velocity based on player velocity normal
				local velocity = velocity + velNorm * CustomizableWeaponry.quickGrenade.movementAddVelocity * addMod
				
				
				
				
				local phys = nade:GetPhysicsObject()
				
				if IsValid(phys) then
					phys:SetVelocity(velocity)
					phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
				else
					nade:SetVelocity(velocity)
					-- nade:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
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

if CLIENT then
	local ply, wep
	
	usermessage.Hook("CW_KK_INS2_THROWGRENADE", function()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon then
			CustomizableWeaponry_KK.ins2.throwGrenade(wep)
		end
	end)
end

// concommand

if SERVER then
	local wep
	
	local function cw_kk_throwfrag(ply)
		-- print("Qnade call;", ply)
		
		if !IsValid(ply) then return end
		
		wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end
		
		if CurTime() < wep:GetNextPrimaryFire() then return end
		if not wep:canFireWeapon(1) then return end
		
		if wep.KKINS2Wep then
			if wep.KKINS2Nade then
				wep:PrimaryAttack()
				return
			end
			
			if CustomizableWeaponry_KK.ins2.canThrow(wep) then
				CustomizableWeaponry_KK.ins2.throwGrenade(wep, true)
			end
		else
			if wep.Base == "cw_grenade_base" then
				wep:PrimaryAttack()
				return
			end
			
			if CustomizableWeaponry.quickGrenade.canThrow(wep) then
				CustomizableWeaponry.quickGrenade.throw(wep)
			end
		end
	end

	concommand.Add("cw_kk_throwfrag", cw_kk_throwfrag)
end

// concommand for cycling type

if CLIENT then
	local function cw_kk_throwfrag(ply)
		local set = CustomizableWeaponry_KK.ins2.quickGrenades.cvarType:GetInt() + 1
		
		if set > #CustomizableWeaponry_KK.ins2.quickGrenades.categories then
			set = 1
		end
		
		RunConsoleCommand("_cw_kk_ins2_qnadetype", set)
	end
	
	concommand.Add("cw_kk_ins2_cyclenadetype", cw_kk_throwfrag)
end

