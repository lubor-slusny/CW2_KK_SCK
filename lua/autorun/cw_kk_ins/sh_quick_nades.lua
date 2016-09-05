
local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.quickGrenade = {}

if CLIENT then
	CustomizableWeaponry_KK.ins2.quickGrenade.cvarType = CreateClientConVar("_cw_kk_ins2_qnadetype", 1, false, true)
end

CustomizableWeaponry_KK.ins2.quickGrenade.models = {}

CustomizableWeaponry_KK.ins2.quickGrenade.models.m67 = {
	vm = "models/weapons/v_cw_kk_ins2_m67.mdl",
	wm = "models/weapons/w_cw_kk_ins2_m67.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.f1 = {
	vm = "models/weapons/v_f1.mdl",
	wm = "models/weapons/w_f1.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.m18 = {
	vm = "models/weapons/v_m18.mdl",
	wm = "models/weapons/w_m18.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.m84 = {
	vm = "models/weapons/v_m84.mdl",
	wm = "models/weapons/w_m84.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2us = {
	vm = "models/weapons/v_mk2.mdl",
	wm = "models/weapons/w_mk2.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2de = {
	vm = "models/weapons/v_stielhandgranate.mdl",
	wm = "models/weapons/w_stielhandgranate.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "bakethrow"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.ww2gb = {
	vm = "models/weapons/v_mills.mdl",
	wm = "models/weapons/w_mills.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.n69 = {
	vm = "models/weapons/v_no69.mdl",
	wm = "models/weapons/w_no69.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.models.n77 = {
	vm = "models/weapons/v_no77.mdl",
	wm = "models/weapons/w_no77.mdl",
	a_pinpull = "pullbackhigh",
	a_throw = "throw"
}

CustomizableWeaponry_KK.ins2.quickGrenade.categories = {}

local function add(tab)
	table.insert(CustomizableWeaponry_KK.ins2.quickGrenade.categories, tab)
end

add({text = "FRAG", ammo = "Frag Grenades", class = "cw_grenade_thrown"})
add({text = "FLASH", ammo = "Flash Grenades", class = "cw_flash_thrown", default = "m84"})
add({text = "SMOKE", ammo = "Smoke Grenades", class = "cw_smoke_thrown", default = "m18"})
	
if CustomizableWeaponry_KK.HOME then
	add({text = "STRI", /*ammo = "Frag Grenades", */class = "weapon_striderbuster", default = "n69"})
	add({text = "BUG", /*ammo = "9x19MM", */class = "npc_grenade_bugbait", default = "n77"})
	add({text = "HL2", /*ammo = "Frag Grenades", */class = "npc_grenade_frag", default = "m18"})
	-- add({text = "N69", ammo = "Frag Grenades", class = "cw_kk_ins2_projectile_n69", default = "n69"})
end

function CustomizableWeaponry_KK.ins2.quickGrenade.getAmmo(wep)
	local nadeType
	
	if SERVER then
		nadeType = wep.Owner:GetInfoNum("_cw_kk_ins2_qnadetype", 1)
	else
		nadeType = CustomizableWeaponry_KK.ins2.quickGrenade.cvarType:GetInt() or 1
	end
	
	nadeType = math.Clamp(nadeType, 1, #CustomizableWeaponry_KK.ins2.quickGrenade.categories)
	
	return CustomizableWeaponry_KK.ins2.quickGrenade.categories[nadeType]
end

local td = {}

function CustomizableWeaponry_KK.ins2.quickGrenade.canThrow(wep)
	// it's disabled, can't throw
	if not CustomizableWeaponry.quickGrenade.enabled then
		return false
	end
	
	// can't throw if we're within a restricted state
	if CustomizableWeaponry.quickGrenade.restrictedStates[wep.dt.State] then
		return false
	end
	
	-- // can't throw while reloading
	-- if wep.ReloadDelay then
		-- return false
	-- end
	
	// can't throw with an active bipod
	if wep.dt.BipodDeployed then
		return false
	end
	
	// can't throw while changing weapons
	if wep.HolsterDelay then
		return false
	end
	
	// can't throw with no grenades
	local ammo = CustomizableWeaponry_KK.ins2.quickGrenade.getAmmo(wep).ammo
	if ammo and wep.Owner:GetAmmoCount(ammo) <= 0 then
		return false
	end
	
	-- // can't throw the grenade if we're really close to an object
	-- td.start = wep.Owner:GetShootPos()
	-- td.endpos = td.start + CustomizableWeaponry.quickGrenade:getThrowOffset(wep.Owner)
	-- td.filter = wep.Owner
	
	-- local tr = util.TraceLine(td)
	
	-- // something in front of us, can't throw
	-- if tr.Hit then
		-- return false
	-- end
	
	// everything passes, can throw, woo!
	return true
end

function CustomizableWeaponry_KK.ins2.quickGrenade.throw(wep, IFTP)
	local CT = CurTime()
	
	wep:setGlobalDelay(1.9)
	wep:SetNextPrimaryFire(CT + 1.9)
	
	if SERVER and SP then
		SendUserMessage("CW_KK_INS2_THROWGRENADE", wep.Owner)
	end
	
	wep.dt.State = CW_ACTION
	
	IFTP = IFTP or IsFirstTimePredicted()
	
	if (not SP and IFTP) or SP then
		if wep:filterPrediction() then
			wep:EmitSound("CW_HOLSTER")
		end
		
		CustomizableWeaponry.callbacks.processCategory(wep, "beginThrowGrenade")
		
		local curSetup = CustomizableWeaponry_KK.ins2.quickGrenade.getAmmo(wep)
		
		local quickNadeTweak = curSetup.default and CustomizableWeaponry_KK.ins2.quickGrenade.models[curSetup.default] or wep.CW_GREN_TWEAK
		local nadeAmmo = curSetup.ammo
		local entClass = curSetup.class
		
		if CLIENT then
			wep.CW_GREN:SetModel(quickNadeTweak.vm)
		
			CustomizableWeaponry.actionSequence.new(wep, 0.45, nil, function()
				wep.GrenadePos.z = -10
				wep.grenadeTime = CurTime() + 1.5
				
				wep.CW_KK_HANDS:SetParent(wep.CW_GREN)
				
				wep:playAnim(quickNadeTweak.a_pinpull, 1, 0, wep.CW_GREN)
			end)
			
			CustomizableWeaponry.actionSequence.new(wep, 0.7, nil, function()
				surface.PlaySound("weapons/pinpull.wav")
			end)
			
			CustomizableWeaponry.actionSequence.new(wep, 1, nil, function()
				wep:playAnim(quickNadeTweak.a_throw, 1.1, 0, wep.CW_GREN)
			end)
		end
		
		if SERVER then
			CustomizableWeaponry.actionSequence.new(wep, 0.4, nil, function()
				net.Start("CW_KK_INS2_NWGQN")
				net.WriteEntity(wep.Owner)
				net.Broadcast()
			end)

			CustomizableWeaponry.actionSequence.new(wep, 0.3, nil, function()
				wep.canDropGrenade = true
			end)
		
			CustomizableWeaponry.actionSequence.new(wep, 0.9, nil, function()
				wep.liveGrenade = true
			end)
		
			CustomizableWeaponry.actionSequence.new(wep, 1.2, nil, function()
				// create and setup
				local nade = ents.Create(entClass)
				
				if not IsValid(nade) then return end
				
				local pos = wep.Owner:GetShootPos()
				local eyeAng = wep.Owner:EyeAngles()
				local forward = eyeAng:Forward()
				
				nade.Model = quickNadeTweak.wm
				nade:SetPos(pos)
				nade:SetAngles(eyeAng)
				
				nade:Spawn()
				nade:Activate()
				
				nade:SetOwner(wep.Owner)
				nade:SetModel(quickNadeTweak.wm)
				
				// add velocity
				local velocity = CustomizableWeaponry.quickGrenade:getThrowVelocity(wep.Owner, throwVelocity, addVelocity)
				local phys = nade:GetPhysicsObject()
				
				if IsValid(phys) then
					phys:SetVelocity(velocity)
					phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
				else
					nade:SetVelocity(velocity)
				end
				
				// fuse
				if nade.Fuse then
					nade:Fuse(3)
				end
				
				nade:Fire("ExplodeIn", 3)
				nade:Fire("sETtIMER", 3)
				
				-- for i = 1, 6 do
					-- timer.Simple(i/2, function()
						-- if IsValid(nade) then
							-- nade:Fire("ConstraintBroken", 3)
						-- end
					-- end)
				-- end
				
				-- nade:SetKeyValue("dud", "1")
				
				// consume owners ammo
				local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage")
				
				if nadeAmmo and not suppressAmmoUsage then
					wep.Owner:RemoveAmmo(1, nadeAmmo)
				end
				
				// ease on martyrdom
				wep.liveGrenade = false
				wep.canDropGrenade = false
			end)
		end
		
		CustomizableWeaponry.actionSequence.new(wep, 2, nil, function()
			local delay = CustomizableWeaponry.quickGrenade.postGrenadeWeaponDelay
			wep:SetNextPrimaryFire(CT + delay)
			wep:SetNextSecondaryFire(CT + delay)
		end)
	end
end

if CLIENT then
	local ply, wep
	
	usermessage.Hook("CW_KK_INS2_THROWGRENADE", function()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon then
			CustomizableWeaponry_KK.ins2.quickGrenade.throw(wep)
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
			
			if CustomizableWeaponry_KK.ins2.quickGrenade.canThrow(wep) then
				CustomizableWeaponry_KK.ins2.quickGrenade.throw(wep, true)
				SendUserMessage("CW_KK_INS2_THROWGRENADE", ply)
			end
		else
			if wep.Base == "cw_grenade_base" then
				wep:PrimaryAttack()
				return
			end
			
			if CustomizableWeaponry.quickGrenade.canThrow(wep) then
				CustomizableWeaponry.quickGrenade.throw(wep, true)
				SendUserMessage("CW20_THROWGRENADE", ply)
			end
		end
	end

	concommand.Add("cw_kk_throwfrag", cw_kk_throwfrag)
end

// concommand for cycling type

if CLIENT then
	local cats = CustomizableWeaponry_KK.ins2.quickGrenade.categories
	
	local function cw_kk_cyclefrag(ply)
		if !IsValid(ply) then return end
		
		local set = CustomizableWeaponry_KK.ins2.quickGrenade.cvarType:GetInt() + 1
		
		for _ = 1, (#cats - 1) do
			if set > #cats then
				set = 1
			end
			
			if cats[set].ammo and ply:GetAmmoCount(cats[set].ammo) < 1 then
				set = set + 1
			end
		end
		
		if set > #cats then
			set = 1
		end
		
		RunConsoleCommand("_cw_kk_ins2_qnadetype", set)
	end
	
	concommand.Add("cw_kk_ins2_cyclenadetype", cw_kk_cyclefrag)
	
	local function think()
		local cur = CustomizableWeaponry_KK.ins2.quickGrenade.cvarType:GetInt()
		
		if cats[cur] and cats[cur].ammo and LocalPlayer():GetAmmoCount(cats[cur].ammo) < 1 then
			RunConsoleCommand("cw_kk_ins2_cyclenadetype")
		end
	end
	
	hook.Add("Think", "CW_KK_INS2_QNADEAMMOWATCH", think)
end

// gesture

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWGQN")
end

local function receive(len, ply)	
	if SERVER then
		net.Start("CW_KK_INS2_NWGQN")
		net.WriteEntity(ply)
		net.Broadcast()
	else
		local ply = net.ReadEntity()
		
		if IsValid(ply) then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)
		end
	end
end
	
net.Receive("CW_KK_INS2_NWGQN", receive)
