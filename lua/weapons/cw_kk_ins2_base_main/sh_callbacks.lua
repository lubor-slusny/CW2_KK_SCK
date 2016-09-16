
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
	["PG-7VM Grenade"] = CustomizableWeaponry_KK.ins2.rpgs.fireRPG, 
	["AT4 Launcher"] = CustomizableWeaponry_KK.ins2.rpgs.fireAT4, 
	["M6A1 Rocket"] = CustomizableWeaponry_KK.ins2.rpgs.fireM6A1, 
	["Panzerfaust"] = CustomizableWeaponry_KK.ins2.rpgs.firePF60, 
}

CustomizableWeaponry.callbacks:addNew("initialize", "KK_INS2_BASE", function(wep)
	if CLIENT then
		-- wep.ReticleInactivityPostFire = wep.ReticleInactivityPostFire or wep.FireDelay
		
		// moved shell table getters here so they dont have to be called every createShell time
		if wep.Shell then
			wep._shellTable1 = CustomizableWeaponry.shells:getShell(wep.Shell)
		end
		
		if wep.Shell2 then
			wep._shellTable2 = CustomizableWeaponry.shells:getShell(wep.Shell2)
		end
		
		// fastest way to setup sights from Workshop sight contract
		for k, v in pairs(copyPaste) do
			for _, x in pairs(copyPasteSx) do
				if not wep[k .. x] then
					wep[k .. x] = wep[v .. x]
				end
			end
		end
		
		// reducing lookup calls
		if wep.MuzzleAttachmentName then
			wep.MuzzleAttachment = wep.CW_VM:LookupAttachment(wep.MuzzleAttachmentName)
		end
		if wep.ShellViewAttachmentName then
			wep.ShellViewAttachmentID = wep.CW_VM:LookupAttachment(wep.ShellViewAttachmentName)
		end
		
		// sth sth darqside
		wep._deployedShells = {}
		
		// inactivity anims
		wep:setupReticleInactivityCallbacks() // sh_anims.lua
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

local CW2_ATTS = CustomizableWeaponry.registeredAttachmentsSKey

local function sharedAttachDetach(wep, att)
	local prim, sec = wep:getPrimarySight(), wep:getSecondarySight()
	
	if CLIENT then
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
		
		// shared standard parts
		wep:setElementActive("kk_ins2_optic_iron", prim == nil)
		wep:setElementActive("kk_ins2_optic_rail", prim != nil)
		
		// individual standard parts
		wep:updateStandardParts()
	end
	
end

local att

CustomizableWeaponry.callbacks:addNew("postAttachAttachment", "KK_INS2_BASE", function(wep, catId, attId)
	if !wep.KKINS2Wep then return end
	
	att = CW2_ATTS[wep.Attachments[catId].atts[attId]]
	
	if att.isSight then
		wep._currentPrimarySight = att
	end
	
	if att.isSecondarySight then
		wep._currentSecondarySight = att
	end
	
	if att.isGrenadeLauncher and att.name != "kk_ins2_gp25_ammo" then
		wep._currentGrenadeLauncher = att
	end
	
	if CLIENT then
		if att.KK_INS2_playIdle then
			if wep.dt.State == CW_CUSTOMIZE then
				wep:idleAnimFunc()
			else
				wep:pickupAnimFunc()
			end
		end
		
		wep:setElementActive(att.name, true)
		wep:setElementActive(att.name .. "_rail", true)
	end
	
	if SERVER then
		wep:_KK_INS2_NWAttach(att)
	end
	
	sharedAttachDetach(wep, att)
end)

CustomizableWeaponry.callbacks:addNew("postDetachAttachment", "KK_INS2_BASE", function(wep, attTable, CWMenuCategory)
	if !wep.KKINS2Wep then return end
	
	att = attTable
	
	if att.isSight then
		wep._currentPrimarySight = nil
	end
	
	if att.isSecondarySight then
		wep._currentSecondarySight = nil
	end
	
	if att.isGrenadeLauncher then
		wep._currentGrenadeLauncher = nil
	end
	
	if CLIENT then
		if att.KK_INS2_playIdle then
			wep:idleAnimFunc()
		end
		
		wep:setElementActive(att.name, false)
		wep:setElementActive(att.name .. "_rail", false)
	end
	
	if SERVER then
		wep:_KK_INS2_NWDetach(att)
	end
	
	sharedAttachDetach(wep, att)
end)

if CLIENT then
	CustomizableWeaponry.callbacks:addNew("adjustViewmodelPosition", "KK_INS2_BASE", function(wep, TargetPos, TargetAng)
		if !wep.KKINS2Wep then return end
		
		if wep.dt.State == CW_HOLSTER_START or wep.dt.State == CW_HOLSTER_END then
			return wep.AlternativePos, wep.AlternativeAng
		end
		
		if wep.dt.INS2GLActive and wep:isAiming() then
			return wep.M203Pos, wep.M203Ang
		end
	end)
end
