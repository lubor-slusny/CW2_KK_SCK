
local SP = game.SinglePlayer()

//yea im layzeeee
local copyPaste = {
	["KKINS2CSTMCMore"] = "KKINS2Aimpoint",
	["KKINS2CSTMBarska"] = "KKINS2EoTech",
	["KKINS2CSTMMicroT1"] = "KKINS2Aimpoint",
	["KKINS2CSTMEoTechXPS"] = "KKINS2EoTech",
	["KKINS2CSTMCompM4S"] = "KKINS2Aimpoint",
	["KKINS2CSTMACOG"] = "KKINS2Elcan",
}
local copyPasteSx = {
	"Pos", "Ang"
}

// this might help
local customFireFuncs = {
	["PG-7VM Grenade"] = CustomizableWeaponry_KK.ins2.fireRPG,
	["AT4 Launcher"] = CustomizableWeaponry_KK.ins2.fireAT4,
	["M6A1 Rocket"] = CustomizableWeaponry_KK.ins2.fireM6A1,
	["Panzerfaust"] = CustomizableWeaponry_KK.ins2.firePF60,
}

CustomizableWeaponry.callbacks:addNew("initialize", "KK_INS2_BASE", function(wep)
	if CLIENT then
		// SWEP parent for client side models - for lense cubemap proxy
		wep.CW_VM._SWEP = wep
		if wep.AttachmentModelsVM then
			for _, v in pairs(wep.AttachmentModelsVM) do
				if IsValid(v.ent) then
					v.ent._SWEP = wep
				end
			end
		end
		
		-- wep.ReticleInactivityPostFire = wep.ReticleInactivityPostFire or wep.FireDelay
		
		// moved shell table getters here so they dont have to be called every createShell time
		if wep.Shell then
			wep._shellTable1 = CustomizableWeaponry.shells:getShell(wep.Shell)
		end
		
		if wep.Shell2 then
			wep._shellTable2 = CustomizableWeaponry.shells:getShell(wep.Shell2)
		end
		
		// fastest way to setup sights from Workshop sight contract
		for k,v in pairs(copyPaste) do
			for _,x in pairs(copyPasteSx) do
				if not wep[k .. x] then
					wep[k .. x] = wep[v .. x]
				end
			end
		end
		
		// reducing lookup calls
		if wep.MuzzleAttachmentName then
			wep.ViewMuzzleAttachmentID = wep.CW_VM:LookupAttachment(wep.MuzzleAttachmentName)
		end
		if wep.ShellAttachmentName then
			wep.ViewShellAttachmentID = wep.CW_VM:LookupAttachment(wep.ShellAttachmentName)
		end
	end
	
	// Ive never really used ammo crate before so here s quickfix for explosives
	if wep.KKINS2RCE or wep.KKINS2Nade then
		wep.Primary.ClipSize_Orig = 1
	end
	
	// bullet-firing-weapons really shouldnt do these checks every time theyre about to fire a bullet
	local fireFunc = customFireFuncs[wep.Primary.Ammo]
	
	if fireFunc then
		wep.FireBullet = function(wep)
			local IFTP = IsFirstTimePredicted()
			
			fireFunc(wep, IFTP, true)
		end
	end
end)

if CLIENT then
	local wep
	
	usermessage.Hook("CW_KK_INS2_RETICLEINACTIVITY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		wep = ply:GetActiveWeapon()
		if !IsValid(wep) or wep.Base != "cw_kk_ins2_base" then return end
			
		-- wep.reticleInactivity = UnPredictedCurTime() + um:ReadFloat()
		wep.reticleInactivity = UnPredictedCurTime() + (wep.CW_VM:SequenceDuration())
	end)
end

local CW2_ATTS = CustomizableWeaponry.registeredAttachmentsSKey

local function sharedAttachDetach(wep)
	if CLIENT then
		local prim, sec = wep:getPrimarySight(), wep:getSecondarySight()
		
		// magnifier scope		
		if sec then
			local a = CW2_ATTS[sec]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		elseif prim then
			local a = CW2_ATTS[prim]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		else
			wep.AimPos = wep.IronsightPos
			wep.AimAng = wep.IronsightAng
			wep.AimViewModelFOV = wep.AimViewModelFOV_Orig
		end
		
		// previously standard parts update called every Think
		if wep.AttachmentModelsVM then
			if prim != nil then
				if wep.AttachmentModelsVM.kk_ins2_optic_iron then
					wep.AttachmentModelsVM.kk_ins2_optic_iron.active = false
				end
				if wep.AttachmentModelsVM.kk_ins2_optic_rail then
					wep.AttachmentModelsVM.kk_ins2_optic_rail.active = true
				end
			else
				if wep.AttachmentModelsVM.kk_ins2_optic_iron then
					wep.AttachmentModelsVM.kk_ins2_optic_iron.active = true
				end
				if wep.AttachmentModelsVM.kk_ins2_optic_rail then
					wep.AttachmentModelsVM.kk_ins2_optic_rail.active = false
				end
			end
		end
	end
end

local att

CustomizableWeaponry.callbacks:addNew("postAttachAttachment", "KK_INS2_BASE", function(wep,catId,attId)
	if !wep.KKINS2Wep then return end
	
	att = CW2_ATTS[wep.Attachments[catId].atts[attId]]
	
	if CLIENT then
		if att.KK_INS2_playIdle then
			if wep.dt.State == CW_CUSTOMIZE then
				wep:idleAnimFunc()
			else
				wep:pickupAnimFunc()
			end
		end
	end
	
	sharedAttachDetach(wep)
end)

CustomizableWeaponry.callbacks:addNew("postDetachAttachment", "KK_INS2_BASE", function(wep,attTable,CWMenuCategory)
	if !wep.KKINS2Wep then return end
	
	att = attTable
	
	if CLIENT then
		if att.KK_INS2_playIdle then
			wep:idleAnimFunc()
		end
	end
	
	sharedAttachDetach(wep)
end)

if CLIENT then
	local orig = Color(255, 167, 112, 255)
	local red = Color(255, 100, 100, 255)
	local green = Color(100, 255, 100, 255)
	local blu = Color(255, 255, 100, 255)

	CustomizableWeaponry.callbacks:addNew("finalizePhysicalBullet", "KK_INS2_BASE", function(wep, data)
		-- if type(wep) == "Weapon" and IsValid(wep) then
			-- if !wep.KKINS2Wep then return end
			
			-- local clip = wep:Clip1()
			
			-- print(clip)
			
			-- data.isTracer = clip % 3 == 0 or clip < 6
			
			-- if clip < 6 then
				-- data.clr = red
			-- elseif clip > (wep.Primary.ClipSize / 2) then
				-- data.clr = green
			-- else
				-- data.clr = blu
			-- end
		-- end
	end)
end

