
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

CustomizableWeaponry.callbacks:addNew("initialize", "KK_INS2_BASE", function(self)
	if CLIENT then
		// SWEP parent for client side models - for lense cubemap proxy
		self.CW_VM._SWEP = self
		if self.AttachmentModelsVM then
			for _, v in pairs(self.AttachmentModelsVM) do
				if IsValid(v.ent) then
					v.ent._SWEP = self
				end
			end
		end
		
		-- self.ReticleInactivityPostFire = self.ReticleInactivityPostFire or self.FireDelay
		
		// moved shell table getters here so they dont have to be called every createShell time
		if self.Shell then
			self._shellTable1 = CustomizableWeaponry.shells:getShell(self.Shell)
		end
		
		if self.Shell2 then
			self._shellTable2 = CustomizableWeaponry.shells:getShell(self.Shell2)
		end
		
		// fastest way to setup sights from Workshop sight contract
		for k,v in pairs(copyPaste) do
			for _,x in pairs(copyPasteSx) do
				if not self[k .. x] then
					self[k .. x] = self[v .. x]
				end
			end
		end
	end
	
	// Ive never really used ammo crate before so here s quickfix for explosives
	if self.KKINS2RCE or self.KKINS2Nade then
		self.Primary.ClipSize_Orig = 1
	end
	
	// bullet-firing-weapons really shouldnt do these checks every time theyre about to fire a bullet
	local fireFunc = customFireFuncs[self.Primary.Ammo]
	
	if fireFunc then
		self.FireBullet = function(self)
			local IFTP = IsFirstTimePredicted()
			
			fireFunc(self, IFTP, true)
		end
	end
end)

if CLIENT then
	usermessage.Hook("CW_KK_INS2_RETICLEINACTIVITY", function(um)
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) or wep.Base != "cw_kk_ins2_base" then return end
			
		-- wep.reticleInactivity = UnPredictedCurTime() + um:ReadFloat()
		wep.reticleInactivity = UnPredictedCurTime() + (wep.CW_VM:SequenceDuration())
	end)
end

local att

CustomizableWeaponry.callbacks:addNew("postAttachAttachment", "KK_INS2_BASE", function(wep,catId,attId)
	if !wep.KKINS2Wep then return end
	
	att = CustomizableWeaponry.registeredAttachmentsSKey[wep.Attachments[catId].atts[attId]]
	
	if CLIENT then
		if att.KK_INS2_playIdle then
			if wep.dt.State == CW_CUSTOMIZE then
				wep:idleAnimFunc()
			else
				wep:pickupAnimFunc()
			end
		end
		
		local prim, sec = wep:getPrimarySight(), wep:getSecondarySight()
		local a
		
		if sec then
			a = CustomizableWeaponry.registeredAttachmentsSKey[sec]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		elseif prim then
			a = CustomizableWeaponry.registeredAttachmentsSKey[prim]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		else
			wep.AimPos = wep.IronsightPos
			wep.AimAng = wep.IronsightAng
			wep.AimViewModelFOV = wep.AimViewModelFOV_Orig
		end
	end
end)

CustomizableWeaponry.callbacks:addNew("postDetachAttachment", "KK_INS2_BASE", function(wep,attTable,CWMenuCategory)
	if !wep.KKINS2Wep then return end
	
	att = attTable
	
	if CLIENT then
		if att.KK_INS2_playIdle then
			wep:idleAnimFunc()
		end
		
		local prim, sec = wep:getPrimarySight(), wep:getSecondarySight()
		local a
		
		if sec then
			a = CustomizableWeaponry.registeredAttachmentsSKey[sec]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		elseif prim then
			a = CustomizableWeaponry.registeredAttachmentsSKey[prim]
			wep.AimPos = wep[a.aimPos[1]]
			wep.AimAng = wep[a.aimPos[2]]
			wep.AimViewModelFOV = a.AimViewModelFOV or wep.AimViewModelFOV_Orig
		else
			wep.AimPos = wep.IronsightPos
			wep.AimAng = wep.IronsightAng
			wep.AimViewModelFOV = wep.AimViewModelFOV_Orig
		end
	end
end)

-- CustomizableWeaponry.callbacks:addNew("droppedWeapon", "KK_INS2_BASE", function(ent)
	-- if CLIENT then
		-- function ent:Draw()
			
		-- end
	-- end
-- end)

-- if CLIENT then
	-- CustomizableWeaponry.callbacks:addNew("overrideReserveAmmoText", "KK_INS2_BASE", function(wep)
		
	-- end)
-- end
