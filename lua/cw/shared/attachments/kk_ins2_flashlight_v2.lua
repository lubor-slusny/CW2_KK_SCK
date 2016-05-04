
// MP OR SP

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
att.name = "kk_ins2_flashlight"
att.displayName = "Light Emitting Module v2.1"
att.displayNameShort = "LEM"
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Less files, less ents.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		{t = "Shitty like first one.", c = CustomizableWeaponry.textColors.VNEGATIVE},
		{t = "Now works in MP.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		{t = "[impulse 100] toggles on/off.", c = CustomizableWeaponry.textColors.REGULAR},
	}
	
	att.reticle = "cw2/reticles/aim_reticule"
	
	function att:_elementRender(beamAtt)
		if not beamAtt then return end
		
		pos = beamAtt.Pos
		ang = beamAtt.Ang
		col = self.SightColors[att.name].last
		
		net.Start(att.name)
			net.WriteEntity(self)
			net.WriteVector(pos)
			net.WriteAngle(ang)
			net.WriteInt(col, 3)
		net.SendToServer()
	end
	
	local model, beamAtt, pos, ang, col
	
	function att:elementRender()
		beamAtt = nil
		
		if (self._KK_INS2_LAM_MODE % 2) == 0 then return end
		
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

		att._elementRender(self, beamAtt)
	end
end

function att:attachFunc()
	if SERVER then
		if !IsValid(self._KK_INS_FL) then
			
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
			
			self._KK_INS_FL = ent
			
			// thinking
			
			hook.Add("Think", ent, function()
				if ent._KK_TTL and ent._KK_TTL > CurTime() then
					local c = ent._KK_COL
					ent:SetKeyValue("lightcolor", Format("%i %i %i %i", c.r, c.g, c.b, 255))
				else
					ent:SetKeyValue("lightcolor", Format("%i %i %i %i", 0, 0, 0, 0))
				end
			end)
			
			// destructor
			
			self._KK_INS_onRemove = function()
				SafeRemoveEntity(self._KK_INS_FL)
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

function att:detachFunc()

end
	
CustomizableWeaponry:registerAttachment(att)

if SERVER then
	hook.Add("Initialize", att.name, function()
		util.AddNetworkString(att.name)
	end)

	net.Receive(att.name, function()
		local wep = net.ReadEntity()
		if IsValid(wep) and IsValid(wep._KK_INS_FL) then
			wep._KK_INS_FL:SetPos(net.ReadVector() or Vector(0, 0, 0))
			wep._KK_INS_FL:SetAngles(net.ReadAngle() or Angle(0, 0, 0))
			
			wep._KK_INS_FL._KK_COL = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][net.ReadInt(3)].color or Color(0,255,255,255)
			wep._KK_INS_FL._KK_TTL = CurTime() + 0.1
		end
	end)
end
