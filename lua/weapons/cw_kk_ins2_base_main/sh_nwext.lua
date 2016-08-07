
// ActiveAttachments broadcast

if SERVER then
	function SWEP:_KK_INS2_NWAttach(att)
		local att, k = CustomizableWeaponry:findAttachment(att.name)
		
		if att then
			if self.dt.INS2SyncAA0 == k then
				self.dt.INS2SyncAA0 = -1
			end
			
			self.dt.INS2SyncAA1 = k
		end
	end
	
	function SWEP:_KK_INS2_NWDetach(att)
		local att, k = CustomizableWeaponry:findAttachment(att.name)
		
		if att then
			if self.dt.INS2SyncAA1 == k then
				self.dt.INS2SyncAA1 = -1
			end
			
			self.dt.INS2SyncAA0 = k
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
			if wep.CW20Weapon then
				local a = wep.dt.INS2SyncAA1
				if a then
					local atbl = CW2_ATTS[a]
					
					if atbl then
						wep.ActiveAttachments[atbl.name] = true
					end
				end
				
				local d = wep.dt.INS2SyncAA0
				if d then
					local dtbl = CW2_ATTS[d]
					
					if btbl then
						wep.ActiveAttachments[btbl.name] = false
					end
				end
			end
		end
	end)
end

// WElements

if SERVER then
	function SWEP:_KK_INS2_NWAttachWE(k)
		if self.dt.INS2SyncWE0 == k then
			self.dt.INS2SyncWE0 = ""
		end
		
		self.dt.INS2SyncWE1 = k
	end
	
	function SWEP:_KK_INS2_NWDetachWE(k)
		if self.dt.INS2SyncWE1 == k then
			self.dt.INS2SyncWE1 = ""
		end
		
		self.dt.INS2SyncWE0 = k
	end
end

if CLIENT then // all clients
	hook.Add("Think", "CW_KK_INS2_NWWE", function()
		for _,wep in pairs(ents.GetAll()) do
			if wep.CW20Weapon then
				local atts = string.Split(wep.dt.INS2SyncWE1 or "", "|")
				local dets = string.Split(wep.dt.INS2SyncWE0 or "", "|")
				
				if wep.AttachmentModelsWM then
					for _,k in pairs(atts) do 
						if wep.AttachmentModelsWM[k] then
							wep.AttachmentModelsWM[k].active = true
						end
					end
					
					for _,k in pairs(dets) do 
						if wep.AttachmentModelsWM[k] then
							wep.AttachmentModelsWM[k].active = false
						end
					end
				end
			end
		end
	end)
end
