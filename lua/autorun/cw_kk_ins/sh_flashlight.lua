
CustomizableWeaponry_KK.ins2.flashlight = {}

// V6 FLASHLIGHT

CustomizableWeaponry_KK.ins2.flashlight.v6 = {}

local white = Color(255,255,255)
local texture = "effects/flashlight001"

if CLIENT then
	function CustomizableWeaponry_KK.ins2.flashlight.v6:elementRender(attBeamSource)
		if not attBeamSource then return end
		if !IsValid(self._KK_INS2_CL_FL) then return end
		
		self._KK_INS2_CL_FL:SetAngles(attBeamSource.Ang)
		self._KK_INS2_CL_FL:SetPos(attBeamSource.Pos)
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v6:attach(att)
	if CLIENT then
		self._KK_INS2_LAM_MODE = 0
		
		local pt
		
		if IsValid(self._KK_INS2_CL_FL) then
			pt = self._KK_INS2_CL_FL
		else
			pt = ProjectedTexture()
			pt:SetTexture(texture)
			pt:SetEnableShadows(true)
			pt:SetFarZ(2048)
			pt:SetFOV(60)
		end
		
		local wep = self
		
		hook.Add("Think", pt, function()
			// garbage-collect-self
			if !IsValid(wep) then
				pt:Remove()
				return
			end
			
			// SetNearZ - ON/OFF
			local wepOK = wep.ActiveAttachments[att.name] and att.getLEMState(wep)
			local ownOK = !IsValid(wep.Owner) or (IsValid(wep.Owner) and wep.Owner:GetActiveWeapon() == wep)
			
			if wepOK and ownOK then
				pt:SetNearZ(1)
			else
				pt:SetNearZ(0)
			end
			
			// if dropped or in 3rd person, update pos 
			if !IsValid(wep.Owner) or wep.Owner:ShouldDrawLocalPlayer() then
				pt:SetAngles(wep:GetAngles())
				pt:SetPos(wep:GetPos())
			end
			
			// SetColor - CW2 SightColor setting
			local col = wep:getSightColor("kk_ins2_flashlight") or white
			pt:SetColor(col)
			
			// if in fps, position will be updated from ElementRender
			pt:Update()
		end)
		
		self._KK_INS2_CL_FL = pt
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v6:detach()
end

// V2 FLASHLIGHT

CustomizableWeaponry_KK.ins2.flashlight.v2 = {}
CustomizableWeaponry_KK.ins2.flashlight.v2.NWString = "CW_KK_INS2_FLASHLIGHT"

if CLIENT then
	function CustomizableWeaponry_KK.ins2.flashlight.v2:elementRender(beamAtt)
		if not beamAtt then return end
		
		pos = beamAtt.Pos
		ang = beamAtt.Ang
		col = (self.SightColors["kk_ins2_flashlight"] and self.SightColors["kk_ins2_flashlight"].last) or 1
		
		net.Start(CustomizableWeaponry_KK.ins2.flashlight.v2.NWString)
			net.WriteEntity(self)
			net.WriteVector(pos)
			net.WriteAngle(ang)
			net.WriteInt(col, 3)
		net.SendToServer()
	end
end

if SERVER then
	hook.Add("Initialize", CustomizableWeaponry_KK.ins2.flashlight.v2.NWString, function()
		util.AddNetworkString(CustomizableWeaponry_KK.ins2.flashlight.v2.NWString)
	end)

	net.Receive(CustomizableWeaponry_KK.ins2.flashlight.v2.NWString, function()
		local wep = net.ReadEntity()
		if IsValid(wep) and IsValid(wep._KK_INS2_SV_FL) then
			wep._KK_INS2_SV_FL:SetPos(net.ReadVector() or Vector(0, 0, 0))
			wep._KK_INS2_SV_FL:SetAngles(net.ReadAngle() or Angle(0, 0, 0))
			
			wep._KK_INS2_SV_FL._KK_COL = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][net.ReadInt(3)].color or Color(0,255,255,255)
			wep._KK_INS2_SV_FL._KK_TTL = CurTime() + 0.1
		end
	end)
end

function CustomizableWeaponry_KK.ins2.flashlight.v2:attach()
	if SERVER then
		if !IsValid(self._KK_INS2_SV_FL) then
			
			// constructor
			
			local ent = ents.Create("env_projectedtexture")
			-- if !IsValid(ent) then return end
			
			local ply = self.Owner
			
			ent.KKINS_parentWep = self
	
			ent:SetLocalPos(Vector(0, 0, 0))
			ent:SetLocalAngles(Angle(0, 0, 0))
			
			ent:SetKeyValue("enableshadows", 1)
			ent:SetKeyValue("texture", "")
			ent:SetKeyValue("farz", 2048)
			ent:SetKeyValue("nearz", 12)
			ent:SetKeyValue("lightfov", "60")
			ent:SetKeyValue("AlwaysUpdateOn", 1)
			
			ent:SetPos(ply:EyePos())
			ent:SetAngles(ply:EyeAngles())
			
			ent:Spawn()
			
			self._KK_INS2_SV_FL = ent
			
			// thinking
			
			hook.Add("Tick", ent, function()
				if ent._KK_TTL and ent._KK_TTL > CurTime() then
					local c = ent._KK_COL
					ent:SetKeyValue("lightcolor", Format("%i %i %i %i", c.r, c.g, c.b, 255))
				else
					ent:SetKeyValue("lightcolor", Format("%i %i %i %i", 0, 0, 0, 0))
				end
			end)
			
			// destructor
			
			self._KK_INS_onRemove = function()
				SafeRemoveEntity(self._KK_INS2_SV_FL)
			end
			
			if not self.OnRemove then
				self.OnRemove = self._KK_INS_onRemove
			else
				self._KK_INS_legacyOnRemove = self.OnRemove
				
				self.OnRemove = function()
					self:_KK_INS_onRemove()
					self:_KK_INS_legacyOnRemove()
				end
			end
			
		end
	end
	
	if CLIENT then
		self._KK_INS2_LAM_MODE = 0
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v2:detach()
end

// [IMPULSE 100] BIND PRESS

CustomizableWeaponry_KK.ins2.flashlight.atts = {
	["kk_ins2_anpeq15"] = 2,
	["kk_ins2_m6x"] = 2,
	["kk_ins2_flashlight"] = 1,
	["kk_ins2_flashlight1"] = 1,
	["kk_ins2_flashlight2"] = 1,
	["kk_ins2_flashlight3"] = 1,
	["kk_ins2_flashlight4"] = 1,
	["kk_ins2_flashlight5"] = 1,
	["kk_ins2_flashlight6"] = 1,
	["kk_ins2_lam"] = 1,
}

if CLIENT then
	function CustomizableWeaponry_KK.ins2.flashlight.PlayerBindPress(ply, bind, pressed)
		if !pressed then return end
		if !bind:find("impulse 100") then return end
		
		local wep = ply:GetActiveWeapon()
		
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end
		
		local hasFL = false
		local max
		for k,v in pairs(CustomizableWeaponry_KK.ins2.flashlight.atts) do
			if wep.ActiveAttachments[k] then max = v end
			hasFL = hasFL or wep.ActiveAttachments[k]
		end
		if !hasFL then return end
		
		if wep.Owner:KeyDown(IN_USE) then
			wep._KK_INS2_LAM_MODE = wep._KK_INS2_LAM_MODE - 1
		else
			wep._KK_INS2_LAM_MODE = wep._KK_INS2_LAM_MODE + 1
		end
		
		if wep._KK_INS2_LAM_MODE > max then
			wep._KK_INS2_LAM_MODE = 0
		elseif wep._KK_INS2_LAM_MODE < 0 then
			wep._KK_INS2_LAM_MODE = max
		end
		
		wep:EmitSound("CW_KK_INS2_UMP45_FIRESELECT")
			
		return true
	end

	hook.Add("PlayerBindPress", "CW_KK_INS2_FLASHLIGHT_BINDPRESS", CustomizableWeaponry_KK.ins2.flashlight.PlayerBindPress)
end

if SERVER then
	local wep, hasFL
	
	function Think()
		for _,ply in pairs(player.GetAll()) do
			wep = ply:GetActiveWeapon()
				
			if !IsValid(wep) then return end
			if !wep.CW20Weapon then return end
			
			hasFL = false
			for k,v in pairs(CustomizableWeaponry_KK.ins2.flashlight.atts) do
				hasFL = hasFL or wep.ActiveAttachments[k]
			end
			if !hasFL then return end
			
			if ply:FlashlightIsOn() then
				ply:Flashlight(false)
			end
		end
	end
	
	hook.Add("Think", "CW_KK_INS2_FLASHLIGHT", Think)
end
