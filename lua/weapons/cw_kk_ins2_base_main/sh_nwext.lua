
// ActiveAttachments broadcast

if SERVER then
	function SWEP:_KK_INS2_NWAttach(att)
		local att, k = CustomizableWeaponry:findAttachment(att.name)
		
		if att then
			if self.dt.INS2DetachSync == k then
				self.dt.INS2DetachSync = -1
			end
			
			self.dt.INS2AttachSync = k
		end
	end
	
	function SWEP:_KK_INS2_NWDetach(att)
		local att, k = CustomizableWeaponry:findAttachment(att.name)
		
		if att then
			if self.dt.INS2AttachSync == k then
				self.dt.INS2AttachSync = -1
			end
			
			self.dt.INS2DetachSync = k
		end
	end
end

if CLIENT then
	local CW2_ATTS = CustomizableWeaponry.registeredAttachments
	-- // if these indexes arent same for all clients, plan b:
	-- // fk savings, forget ints, send strings over dt
	-- local CW2_ATTS = CustomizableWeaponry.registeredAttachmentsSKey
	
	hook.Add("Think", "CW_KK_INS2_NWAA", function()
		for _,wep in pairs(ents.GetAll()) do
			if wep.CW20Weapon and wep.Owner != LocalPlayer() then
				local a = wep.dt.INS2AttachSync
				if a then
					local atbl = CW2_ATTS[a]
					
					if atbl then
						wep.ActiveAttachments[atbl.name] = true
					end
				end
				
				local b = wep.dt.INS2DetachSync
				if b then
					local btbl = CW2_ATTS[b]
					
					if btbl then
						wep.ActiveAttachments[btbl.name] = false
					end
				end
			end
		end
	end)
end

// WElements

if CLIENT then // actor client
	function SWEP:setWElementActive(k,v)
		local nwbool
		
		if v then nwbool = 1 else nwbool = 0 end
		
		RunConsoleCommand("_cw_kk_ins2_nwwe", self:EntIndex(), k, nwbool)
	end
end

if SERVER then // broadcast server
	local function receive(ply, cmd, args, argStr)
		local wep = ents.GetByIndex(tonumber(args[1]))
		
		if IsValid(wep) then
			wep.dt.INS2WESyncKey = args[2]
			wep.dt.INS2WESyncVal = tonumber(args[3]) == 1
		end
	end
	
	concommand.Add("_cw_kk_ins2_nwwe", receive)
end

if CLIENT then // all clients
	hook.Add("Think", "CW_KK_INS2_NWWE", function()
		for _,wep in pairs(ents.GetAll()) do
			if wep.CW20Weapon and wep.Owner != LocalPlayer() then
				local k, v = wep.dt.INS2WESyncKey, wep.dt.INS2WESyncVal
				
				if k and wep.AttachmentModelsWM and wep.AttachmentModelsWM[k] then
					wep.AttachmentModelsWM[k].active = v
				end
			end
		end
	end)
end
