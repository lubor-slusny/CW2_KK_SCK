AddCSLuaFile()

if not CustomizableWeaponry_KK then
	CustomizableWeaponry_KK = {}
end

if not CustomizableWeaponry_KK.ins2 then
	CustomizableWeaponry_KK.ins2 = {}
end

if not CustomizableWeaponry_KK.ins2.magnifierDependencies then
	CustomizableWeaponry_KK.ins2.magnifierDependencies = {}
	
	CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
	CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
	CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true
end

local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.baseContentMounted = function() // IsMounted("ins2") wont work, well fuck
	if !SP then 
		return CustomizableWeaponry and true
	else
		// read mount.cfg if possible
		// add some random file.exists checks mayb
		// steel bgo3 vmt reading - fopen; stringsub
		return CustomizableWeaponry and true
	end
end

if CLIENT then
	if not CustomizableWeaponry_KK.rts then
		CustomizableWeaponry_KK.rts = {}
	end

	CustomizableWeaponry_KK.rts.ins2_scope = GetRenderTarget("cw_kk_ins2_scope", 512, 512, false)
	CustomizableWeaponry_KK.rts.ins2_scope_init = true
	
	CreateClientConVar("cw_kk_ins2_rig", 1, true, true)
	CreateClientConVar("cw_kk_ins2_qnadetype", 0, false, true)
	
	CustomizableWeaponry_KK.ins2.hands = {
		"models/weapons/v_hands_ins_h.mdl",
		"models/weapons/v_hands_ins_l.mdl",
		"models/weapons/v_hands_ins_m.mdl",
		"models/weapons/v_hands_sec_h.mdl",
		"models/weapons/v_hands_sec_l.mdl",
		"models/weapons/v_hands_sec_m.mdl",
		"models/weapons/v_hands_vip.mdl",
		"models/weapons/v_cw_kk_ins2_hands_css.mdl",
	}
	
	if not CustomizableWeaponry_KK.panels then
		CustomizableWeaponry_KK.panels = {}
	end
	
	CustomizableWeaponry_KK.panels.ins2 = function(panel)
		panel:AddControl("Label", {Text = "INS2 Pack:"}):DockMargin( 0, 0, 8, 8 )
		
		panel:AddControl("Slider", {
			Label = "Rig:",
			Type = "Integer",
			Min = "1",
			Max = table.Count(CustomizableWeaponry_KK.ins2.hands),
			Command = "cw_kk_ins2_rig"
		}):DockMargin( 8, 0, 8, 8 )
	end	
end

// Stencil sights
if CLIENT then
	local dot = Material("cw2/reticles/aim_reticule")
	local stencilMat = Material("models/weapons/attachments/cw_kk_ins2_stencil/stencil")
	local size, rc, isAiming, freeze, isScopePos, attachmEnt, statt, sizeMult, pos, EA
	
	function CustomizableWeaponry_KK.ins2:stencilSight(att)
		if not self.ActiveAttachments[att.name] then return end
		if self.ActiveAttachments.kk_ins2_magnifier then return end
		
		if not self.AttachmentModelsVM then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		size = att._reticleSize
		rc = self:getSightColor(att.name)
		isAiming = self:isAiming()
		freeze = GetConVarNumber("cw_kk_freeze_reticles") != 0
		isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		
		self.AttachmentModelsVM[att.name].nodraw = true
		attachmEnt = self.AttachmentModelsVM[att.name].ent
		
		if not freeze then
			-- if not (isScopePos and (isAiming or self.dt.BipodDeployed)) then
				-- attachmEnt:DrawModel()
				-- return
			-- end
		end
		
		/*stencil stuff*/
		render.ClearStencil()
		render.SetStencilEnable(true)
			
		render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilReferenceValue(1)
		
		/*"canvas" for reticle*/
		render.MaterialOverride(stencilMat)
			attachmEnt:DrawModel()
		render.MaterialOverride(nil)
		
		/*stencil stuff*/
		render.SetStencilReferenceValue(2)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilReferenceValue(1)
		
		/*prepare reticle pos*/
		statt = attachmEnt:GetAttachment(1)
		sizeMult = (statt.Pos:Distance(EyePos())) * 50 
		pos = statt.Pos + statt.Ang:Forward() * sizeMult
		
		/*debug reticle*/
		render.SetMaterial(dot)
		
		if freeze then
			cam.IgnoreZ(true)
			
			render.DrawSprite(pos, size/2, size/2, Color(0,255,0))
			render.DrawSprite(pos, size/2, size/2, Color(0,255,0))
			render.DrawSprite(pos, size/6, size/6, Color(255,255,255))
			render.DrawSprite(pos, size/6, size/6, Color(255,255,255))
			
			cam.IgnoreZ(false)
		end
		
		/*main reticle*/
		if self:isReticleActive() and isAiming then 
			EA = self:getReticleAngles()
			pos = EyePos() + EA:Forward() * sizeMult
		end
		
		render.SetMaterial(att._reticle)
		
		cam.IgnoreZ(true)
			render.DrawSprite(pos, size, size, Color(255,255,255))
			render.DrawSprite(pos, size, size, Color(255,255,255))
			render.DrawSprite(pos, size, size, Color(255,255,255))
		
			attachmEnt:DrawModel()
		cam.IgnoreZ(false)
		
		/*disable stencils*/
		render.SetStencilEnable(false)
	end
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

function CustomizableWeaponry_KK.ins2:fireRPG(IFTP, legit)
	if IFTP then
		if SERVER then
			local pos = self.Owner:GetShootPos()
			local eyeAng = self.Owner:EyeAngles()
			
			local fwdAng = eyeAng
			fwdAng:RotateAroundAxis(fwdAng:Right(), 1.8)
			local forward = fwdAng:Forward()
			
			local offset = /*forward * 30 +*/ eyeAng:Right() * 4 - eyeAng:Up() * 3
			
			local nade = ents.Create("cw_kk_ins2_projectile_rpg")
			nade:SetPos(pos + offset)
			nade:SetAngles(fwdAng)
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(self.Owner)
			
			if not legit then
				nade.safetyBypass = true
				-- nade.doAClusterFuck = true
			end
			
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				-- phys:SetVelocity(forward * 4527.55) // 115 m/s coz wiki
				phys:SetVelocity(forward * 3395.6625)
				-- phys:SetVelocity(forward * 2263.775)
			end
		end
	end
end

// ===============================
// Now, shameless copy-pastas
// ===============================

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

local pinPullAnims = {"pullpin", "pullpin2", "pullpin3", "pullpin4"}

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
