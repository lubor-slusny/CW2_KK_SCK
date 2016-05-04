
// kek version

-- if true then return end

if not CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT then
	-- local lastButtNotLeast = table.Count(CustomizableWeaponry.colorableParts.colors) + 1
	CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT = "KK_FL" // fuck numerical ids

	CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = {
		{name = "kk_fl_white",	display = "White",		color = Color(255,255,255,255)},
		{name = "kk_fl_whitew",	display = "Warm White",	color = Color(255,255,150,255)},
		{name = "kk_fl_whitec",	display = "Cold White",	color = Color(150,255,255,255)},
	}

	CustomizableWeaponry.colorableParts.colorText[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = " (HOLD - change light color)"
	CustomizableWeaponry.colorableParts.defaultColors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][1]
end

local att = {}
att.name = "kk_ins2_flashlight3"
att.displayName = "Light Emitting Module v3"
att.displayNameShort = "LEM"
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Less files, less ents.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		{t = "Shitty like first one.", c = CustomizableWeaponry.textColors.VNEGATIVE},
		{t = "Now works in MP.", c = CustomizableWeaponry.textColors.VPOSITIVE},
	}
	
	att.reticle = "cw2/reticles/aim_reticule"
	
	CreateClientConVar("_cw_kk_ins2_flashlight3_x", "0", false, true)	// x
	CreateClientConVar("_cw_kk_ins2_flashlight3_y", "0", false, true)	// y
	CreateClientConVar("_cw_kk_ins2_flashlight3_z", "0", false, true)	// z
	CreateClientConVar("_cw_kk_ins2_flashlight3_p", "0", false, true)	// p
	CreateClientConVar("_cw_kk_ins2_flashlight3_j", "0", false, true)	// yaw
	CreateClientConVar("_cw_kk_ins2_flashlight3_r", "0", false, true)	// roll
	CreateClientConVar("_cw_kk_ins2_flashlight3_c", "0", false, true)	// color
	CreateClientConVar("_cw_kk_ins2_flashlight3_t", "0", false, true)	// ttl
	
	local model, beamAtt, pos, ang, col
	
	function att:elementRender()
		beamAtt = nil
		
		if self.KKINS_FL_ATT_OVERRIDE then
			beamAtt = self:KKINS_FL_ATT_OVERRIDE()
		end
		
		if beamAtt == nil and self.AttachmentModelsVM[att.name] then
			model = self.AttachmentModelsVM[att.name].ent
			beamAtt = model:GetAttachment(model:LookupAttachment("Laser"))
		end
		
		if beamAtt == nil then
			model = self.CW_VM
			beamAtt = model:GetAttachment(model:LookupAttachment("Laser"))
		end

		if beamAtt == nil then
			return
		end
		
		if !self.dt.Safe then
			self._KK_INS_FL_turnOffWhenSafe = CurTime() + 0.1
		end
		
		if self._KK_INS_FL_turnOffWhenSafe and self._KK_INS_FL_turnOffWhenSafe < CurTime() then return end
		
		pos = beamAtt.Pos
		ang = beamAtt.Ang
		col = self.SightColors[att.name].last
		
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

function att:attachFunc()
	if SERVER then
		if !IsValid(self.Owner._KK_INS_FL) then
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
			ply._KK_INS_FL = ent
			
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

function att:detachFunc()
	if SERVER then
		if IsValid(self.Owner._KK_INS_FL) then
			self.Owner._KK_INS_FL._KK_Owner = nil
		end
	end
end
	
CustomizableWeaponry:registerAttachment(att)
