
CustomizableWeaponry_KK.ins2.flashlight = {}

// V6 FLASHLIGHT

CustomizableWeaponry_KK.ins2.flashlight.v6 = {}

if CLIENT then
	local white = Color(255,255,255)
	local texture = "effects/flashlight001"
	
	function CustomizableWeaponry_KK.ins2.flashlight.v6:elementRender(attBeamSource, bOn)
		if not ProjectedTexture then return end
		if not attBeamSource then return end
		
		if not self._KK_INS2_CL_FL then
			-- print("CLPT INIT")
			local pt = ProjectedTexture()
			pt:SetTexture(texture)
			pt:SetEnableShadows(true)
			pt:SetFarZ(2048)
			pt:SetFOV(60)
			
			local wep = self
			
			hook.Add("Think", pt, function()
				if !IsValid(wep) then
					pt:Remove()
					return
				end
				
				if !IsValid(wep.Owner) then
					pt:SetAngles(wep:GetAngles())
					pt:SetPos(wep:GetPos())
					pt:Update()
					return
				end
				
				if wep.Owner:GetActiveWeapon() != wep then
					pt:SetNearZ(0)
					pt:Update()
				end
			end)
			
			self._KK_INS2_CL_FL = pt
		end
		
		if bOn then
			self._KK_INS2_CL_FL:SetNearZ(1)
			
			local col = self:getSightColor("kk_ins2_flashlight") or white
			
			self._KK_INS2_CL_FL:SetColor(col)
			self._KK_INS2_CL_FL:SetAngles(attBeamSource.Ang)
			self._KK_INS2_CL_FL:SetPos(attBeamSource.Pos)
		else
			self._KK_INS2_CL_FL:SetNearZ(0)
		end
		
		self._KK_INS2_CL_FL:Update()
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v6:attach()
	if CLIENT then
		self._KK_INS2_LAM_MODE = 0
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v6:detach()
end

// V5 FLASHLIGHT

CustomizableWeaponry_KK.ins2.flashlight.v5 = {}

if CLIENT then
	local retPos, retAng, retNorm, size
	
	local white = Color(255,255,255,10)
	local ret = Material("cw2/reticles/aim_reticule")

	local td = {}
	local tr, dist
	
	function CustomizableWeaponry_KK.ins2.flashlight.v5:elementRender(beamAtt)
		if not beamAtt then return end
		
		td.start = beamAtt.Pos
		td.endpos = td.start + beamAtt.Ang:Forward() * 60000
		td.filter = self.Owner
		
		tr = util.TraceLine(td)
		
		if !tr.Hit then return end
		
		dist = tr.HitPos:Distance(td.start)
		
		retPos = tr.HitPos
		retAng = -90 - beamAtt.Ang.z
		retNorm = -beamAtt.Ang:Forward() + tr.HitNormal
		-- retNorm = tr.HitNormal
		
		cam.IgnoreZ(true)
			size = dist * dist * 0.02
			
			render.SetMaterial(ret)
			render.DrawQuadEasy(retPos, retNorm, size, size, white, retAng)
		cam.IgnoreZ(false)	
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v5:attach()
end

function CustomizableWeaponry_KK.ins2.flashlight.v5:detach()
end

// [IMPULSE 100] BIND PRESS

CustomizableWeaponry_KK.ins2.flashlight.atts = {
	["kk_ins2_anpeq15"] = 2,
	["kk_ins2_m6x"] = 2,
	["kk_ins2_flashlight"] = 1,
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
		
		-- if wep.ActiveAttachments["kk_ins2_anpeq15"] then
			wep:EmitSound("CW_KK_INS2_UMP45_FIRESELECT")
		-- else			
			-- if (wep._KK_INS2_LAM_MODE % 2) == 1 then
				-- wep:EmitSound("player/flashlight_on.wav")
			-- else
				-- wep:EmitSound("player/flashlight_off.wav")
			-- end
		-- end
	
		return true
	end

	hook.Add("PlayerBindPress", "CW_KK_INS2_FLASHLIGHT_BINDPRESS", CustomizableWeaponry_KK.ins2.flashlight.PlayerBindPress)
end

if SERVER then
	function Think()
		for _,ply in pairs(player.GetAll()) do
			local wep = ply:GetActiveWeapon()
				
			if !IsValid(wep) then return end
			if !wep.CW20Weapon then return end
			
			local hasFL = false
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

// V3 FLASHLIGHT

CustomizableWeaponry_KK.ins2.flashlight.v3 = {}

if CLIENT then
	CreateClientConVar("_cw_kk_ins2_flashlight3_x", "0", false, true)	// x
	CreateClientConVar("_cw_kk_ins2_flashlight3_y", "0", false, true)	// y
	CreateClientConVar("_cw_kk_ins2_flashlight3_z", "0", false, true)	// z
	CreateClientConVar("_cw_kk_ins2_flashlight3_p", "0", false, true)	// p
	CreateClientConVar("_cw_kk_ins2_flashlight3_j", "0", false, true)	// yaw
	CreateClientConVar("_cw_kk_ins2_flashlight3_r", "0", false, true)	// roll
	CreateClientConVar("_cw_kk_ins2_flashlight3_c", "0", false, true)	// color
	CreateClientConVar("_cw_kk_ins2_flashlight3_t", "0", false, true)	// ttl
	
	function CustomizableWeaponry_KK.ins2.flashlight.v3:elementRender(beamAtt)
		if not beamAtt then return end
		
		pos = beamAtt.Pos
		ang = beamAtt.Ang
		col = self.SightColors["kk_ins2_flashlight3"].last
		
		RunConsoleCommand("_cw_kk_ins2_flashlight3_x", pos.x)
		RunConsoleCommand("_cw_kk_ins2_flashlight3_y", pos.y)
		RunConsoleCommand("_cw_kk_ins2_flashlight3_z", pos.z)
		RunConsoleCommand("_cw_kk_ins2_flashlight3_p", ang.p)
		RunConsoleCommand("_cw_kk_ins2_flashlight3_j", ang.y)
		RunConsoleCommand("_cw_kk_ins2_flashlight3_r", ang.r)
		RunConsoleCommand("_cw_kk_ins2_flashlight3_c", col)
		-- RunConsoleCommand("_cw_kk_ins2_flashlight3_t", CurTime())
		RunConsoleCommand("_cw_kk_ins2_flashlight3_t", CurTime() + 1)
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v3:attach()
	if SERVER then
		if !IsValid(self.Owner._KK_INS2_SV_FL) then
			// make ept ent
			
			local ent = ents.Create("env_projectedtexture")
			local ply = self.Owner
			
			ent.KKINS_parentWep = self
	
			ent:SetLocalPos(Vector(0, 0, 0))
			ent:SetLocalAngles(Angle(0, 0, 0))
			
			ent:SetKeyValue("enableshadows", 1)
			ent:SetKeyValue("texture", "")
			ent:SetKeyValue("farz", 2048)
			ent:SetKeyValue("nearz", 0.01)
			ent:SetKeyValue("lightfov", "60")
			ent:SetKeyValue("AlwaysUpdateOn", 1)
			
			ent:SetPos(ply:EyePos())
			ent:SetAngles(ply:EyeAngles())
			
			ent:Spawn()
			
			// link them
			
			ent._KK_Owner = ply
			ply._KK_INS2_SV_FL = ent
			
			// thinking
			
			hook.Add("Think", ent, function()
				local ply = ent._KK_Owner
				
				if not IsValid(ply) then
					SafeRemoveEntity(ent)
					return
				end
				
				ent:SetPos(Vector(
					ply:GetInfoNum("_cw_kk_ins2_flashlight3_x", 0),
					ply:GetInfoNum("_cw_kk_ins2_flashlight3_y", 0),
					ply:GetInfoNum("_cw_kk_ins2_flashlight3_z", 0)
				))
				
				ent:SetAngles(Angle(
					ply:GetInfoNum("_cw_kk_ins2_flashlight3_p", 0),
					ply:GetInfoNum("_cw_kk_ins2_flashlight3_j", 0),
					ply:GetInfoNum("_cw_kk_ins2_flashlight3_r", 0)
				))
				
				local t = ply:GetInfoNum("_cw_kk_ins2_flashlight3_t", 0)
				
				-- if t != ent._KK_lastT then
				if t > CurTime() then
					local c = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][
						ply:GetInfoNum("_cw_kk_ins2_flashlight3_c", 1)
					].color
					
					ent:SetKeyValue("lightcolor", Format("%i %i %i %i", c.r, c.g, c.b, 255))
				else
					ent:SetKeyValue("lightcolor", Format("%i %i %i %i", 0, 0, 0, 0))
				end
				
				-- ent._KK_lastT = t
			end)
		end
	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v3:detach()
	if SERVER then
		if IsValid(self.Owner._KK_INS2_SV_FL) then
			self.Owner._KK_INS2_SV_FL._KK_Owner = nil
		end
	end
end

// V2 FLASHLIGHT

CustomizableWeaponry_KK.ins2.flashlight.v2 = {}
CustomizableWeaponry_KK.ins2.flashlight.v2.NWString = "CW_KK_INS2_FLASHLIGHT"

if CLIENT then
	function CustomizableWeaponry_KK.ins2.flashlight.v2:elementRender(beamAtt)
		if not beamAtt then return end
		
		pos = beamAtt.Pos
		ang = beamAtt.Ang
		col = self.SightColors["kk_ins2_flashlight"].last
		
		net.Start("CW_KK_INS2_FLASHLIGHT")
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
			ent:SetKeyValue("nearz", 0.01)
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