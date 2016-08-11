
// ActiveAttachments broadcast

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWAA")
	
	// only send active(The Really Active) atts
	local function makeTable(self)
		local out = {}
		
		for k,v in pairs(self.ActiveAttachments) do
			if v then
				out[k] = v
			end
		end
		
		return out
	end
	
	local function sendMessage(self)
		net.Start("CW_KK_INS2_NWAA")
		net.WriteEntity(self)
		net.WriteFloat(CurTime())
		net.WriteTable(makeTable(self))
		-- net.Broadcast()
		net.SendOmit(self.Owner)
	end
	
	function SWEP:_KK_INS2_NWAttach(att)
		sendMessage(self)
	end
	
	function SWEP:_KK_INS2_NWDetach(att)
		sendMessage(self)
	end
end

if CLIENT then
	local function receive()
		local wep, t, tab = net.ReadEntity(), net.ReadFloat(), net.ReadTable()
		
		if IsValid(wep) then
			if wep._last_CW_KK_INS2_NWAA and wep._last_CW_KK_INS2_NWAA > t then 
				return 
			end
			
			wep._last_CW_KK_INS2_NWAA = t
			
			// wtf?
			for k,v in pairs(wep.ActiveAttachments) do 
				wep.ActiveAttachments[k] = tab[k] == true
			end
			
			for k,v in pairs(tab) do 
				wep.ActiveAttachments[k] = true
			end
		end
	end
		
	net.Receive("CW_KK_INS2_NWAA", receive)
end

// WElements

if SERVER then
	util.AddNetworkString("CW_KK_INS2_NWWE")
end

if CLIENT then
	function SWEP:setWElementActive(k,v)
		if self.AttachmentModelsWM and self.AttachmentModelsWM[k] then
			self.AttachmentModelsWM[k].active = v
				
			net.Start("CW_KK_INS2_NWWE")
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
		net.Start("CW_KK_INS2_NWWE")
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
	
net.Receive("CW_KK_INS2_NWWE", receive)
