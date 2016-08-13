
// ActiveAttachments postInit

	if SERVER then
		util.AddNetworkString("CW_KK_INS2_NWAA_single")
		
		local function sendMessage(self, k, v)
			net.Start("CW_KK_INS2_NWAA_single")
			net.WriteEntity(self)
			net.WriteString(k)
			net.WriteBool(v)
			
			if IsValid(self.Owner) then
				net.SendOmit(self.Owner)
			else
				net.Broadcast()
			end
		end
		
		function SWEP:_KK_INS2_NWAttach(att)
			sendMessage(self, att.name, true)
		end
		
		function SWEP:_KK_INS2_NWDetach(att)
			sendMessage(self, att.name, false)
		end
	end

	if CLIENT then
		local function receive()
			local wep, k, v = net.ReadEntity(), net.ReadString(), net.ReadBool()
			
			if IsValid(wep) then
				wep.ActiveAttachments[k] = v
			end
		end
			
		net.Receive("CW_KK_INS2_NWAA_single", receive)
	end

// WElements postInit

	if SERVER then
		util.AddNetworkString("CW_KK_INS2_NWWE_single")
	end

	if CLIENT then
		function SWEP:setWElementActive(k,v)
			if self.AttachmentModelsWM and self.AttachmentModelsWM[k] then
				self.AttachmentModelsWM[k].active = v
					
				net.Start("CW_KK_INS2_NWWE_single")
				net.WriteEntity(self)
				net.WriteString(k)
				net.WriteBool(v)
				net.SendToServer()
			end
		end
	end

	local function receive(len, ply)
		local wep, k, v = net.ReadEntity(), net.ReadString(), net.ReadBool()
		
		if SERVER then
			if IsValid(wep) then
				wep.ActiveWElements = wep.ActiveWElements or {}
				wep.ActiveWElements[k] = v
			end
			
			net.Start("CW_KK_INS2_NWWE_single")
			net.WriteEntity(wep)
			net.WriteString(k)
			net.WriteBool(v)
			net.SendOmit(ply)
		else
			
			if IsValid(wep) and wep.AttachmentModelsWM and wep.AttachmentModelsWM[k] then
				wep.AttachmentModelsWM[k].active = v
			end
		end
	end
		
	net.Receive("CW_KK_INS2_NWWE_single", receive)

// ActiveAttachments postInit

	if SERVER then
		util.AddNetworkString("CW_KK_INS2_NWAA_full")
	end

	if CLIENT then
		function SWEP:initNWAA()
			net.Start("CW_KK_INS2_NWAA_full")
			net.WriteEntity(self)
			net.SendToServer()
		end
	end

	local function receive(len, ply)
		local wep = net.ReadEntity()
		
		if IsValid(wep) then
			if SERVER then		
				net.Start("CW_KK_INS2_NWAA_full")
				net.WriteEntity(wep)
				net.WriteTable(wep.ActiveAttachments)
				net.Send(ply)
			else
				wep.ActiveAttachments = net.ReadTable()
			end
		end
	end
		
	net.Receive("CW_KK_INS2_NWAA_full", receive)

// WElements init

	if SERVER then
		util.AddNetworkString("CW_KK_INS2_NWWE_full")
	end

	if CLIENT then
		function SWEP:initNWWE()
			net.Start("CW_KK_INS2_NWWE_full")
			net.WriteEntity(self)
			net.SendToServer()
		end
	end

	local function receive(len, ply)
		local wep = net.ReadEntity()
		
		if IsValid(wep) then
			if SERVER then		
				net.Start("CW_KK_INS2_NWWE_full")
				net.WriteEntity(wep)
				net.WriteTable(wep.ActiveAttachments)
				net.Send(ply)
			else
				if wep.AttachmentModelsWM then
					local tab = net.ReadTable()
					for k,v in pairs(tab) do 
						if wep.AttachmentModelsWM[k] then
							wep.AttachmentModelsWM[k].active = v
						end
					end
				end
			end
		end
	end
		
	net.Receive("CW_KK_INS2_NWWE_full", receive)

//=================================
// old msgs 
//=================================

	-- // ActiveAttachments broadcast

	-- if SERVER then
		-- util.AddNetworkString("CW_KK_INS2_NWAA")
		
		-- // only send active(The Really Active) atts
		-- local function makeTable(self)
			-- local out = {}
			
			-- for k,v in pairs(self.ActiveAttachments) do
				-- if v then
					-- out[k] = v
				-- end
			-- end
			
			-- print("[NWAA BC]", self)
			-- PrintTable(out)
			-- return out
		-- end
		
		-- local function sendMessage(self)
			-- net.Start("CW_KK_INS2_NWAA")
			-- net.WriteEntity(self)
			-- net.WriteFloat(CurTime())
			-- net.WriteTable(makeTable(self))
			
			-- if IsValid(self.Owner) then
				-- net.SendOmit(self.Owner)
			-- else
				-- net.Broadcast()
			-- end
		-- end
		
		-- function SWEP:_KK_INS2_NWAttach(att)
			-- sendMessage(self)
		-- end
		
		-- function SWEP:_KK_INS2_NWDetach(att)
			-- sendMessage(self)
		-- end
	-- end

	-- if CLIENT then
		-- local function receive()
			-- local wep, t, tab = net.ReadEntity(), net.ReadFloat(), net.ReadTable()
			
			-- if IsValid(wep) then
				-- if wep._last_CW_KK_INS2_NWAA and wep._last_CW_KK_INS2_NWAA > t then 
					-- return 
				-- end
				
				-- wep._last_CW_KK_INS2_NWAA = t
				
				-- // wtf?
				-- for k,v in pairs(wep.ActiveAttachments) do 
					-- wep.ActiveAttachments[k] = tab[k] == true
				-- end
				
				-- for k,v in pairs(tab) do 
					-- wep.ActiveAttachments[k] = true
				-- end
			-- end
		-- end
			
		-- net.Receive("CW_KK_INS2_NWAA", receive)
	-- end

	-- // WElements

	-- if SERVER then
		-- util.AddNetworkString("CW_KK_INS2_NWWE")
	-- end

	-- if CLIENT then
		-- function SWEP:setWElementActive(k,v)
			-- if self.AttachmentModelsWM and self.AttachmentModelsWM[k] then
				-- self.AttachmentModelsWM[k].active = v
					
				-- net.Start("CW_KK_INS2_NWWE")
				-- net.WriteEntity(self)
				-- net.WriteString(k)
				-- net.WriteBool(v)
				-- net.SendToServer()
			-- end
		-- end
	-- end

	-- local function receive(len, ply)
		-- local wep, k, v = net.ReadEntity(), net.ReadString(), net.ReadBool()
		
		-- if SERVER then
			-- net.Start("CW_KK_INS2_NWWE")
			-- net.WriteEntity(wep)
			-- net.WriteString(k)
			-- net.WriteBool(v)
			-- net.SendOmit(ply)
		-- else
			
			-- if IsValid(wep) and wep.AttachmentModelsWM and wep.AttachmentModelsWM[k] then
				-- wep.AttachmentModelsWM[k].active = v
			-- end
		-- end
	-- end
		
	-- net.Receive("CW_KK_INS2_NWWE", receive)
