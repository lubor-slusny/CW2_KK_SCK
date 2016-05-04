
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

CustomizableWeaponry.callbacks:addNew("initialize", "KK_INS2_BASE", function(self)
	if CLIENT then
		self.CW_VM._SWEP = self
		if self.AttachmentModelsVM then
			for _, v in pairs(self.AttachmentModelsVM) do
				if IsValid(v.ent) then
					v.ent._SWEP = self
				end
			end
		end
		
		-- self.ReticleInactivityPostFire = self.ReticleInactivityPostFire or self.FireDelay
		
		if self.Shell then
			self._shellTable1 = CustomizableWeaponry.shells:getShell(self.Shell)
		end
		
		if self.Shell2 then
			self._shellTable2 = CustomizableWeaponry.shells:getShell(self.Shell2)
		end
		
		for k,v in pairs(copyPaste) do
			for _,x in pairs(copyPasteSx) do
				if not self[k .. x] then
					self[k .. x] = self[v .. x]
				end
			end
		end
	end
end)

if CLIENT then
	usermessage.Hook("CW20_KK_INS_RETICLEINACTIVITY", function(um)
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

CustomizableWeaponry.callbacks:addNew("droppedWeapon", "KK_INS2_BASE", function(ent)
	if CLIENT then
		-- function ent:Draw()
			
		-- end
	end
end)

if CLIENT then
	CustomizableWeaponry.callbacks:addNew("overrideReserveAmmoText", "KK_INS2_BASE", function(wep)
		if !wep.KKINS2Wep then return end
		if !wep.KKINS2RCE then return end
		
		return true, wep.Owner:GetAmmoCount(wep.Primary.Ammo) - 1
	end)
end
