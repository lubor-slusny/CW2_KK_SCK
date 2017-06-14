
// SP ONLY
if !game.SinglePlayer() or true then return end

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
att.displayName = "Light Emitting Module"
att.displayNameShort = "LEM"
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Secksy as phuck.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		{t = "Laggin as phuck", c = CustomizableWeaponry.textColors.VNEGATIVE}
	}
	local beam = Material("cw2/reticles/aim_reticule")
	local laserDot = Material("cw2/reticles/aim_reticule")
	
	att.reticle = "cw2/reticles/aim_reticule"
	local td = {}
	
	local turnOffWhenSafe
	
	function att:elementRender()
		local model, beamAtt, pos, ang, col
		
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
		
		-- pos = beamAtt.Pos - (20 * beamAtt.Ang:Forward())
		pos = beamAtt.Pos
		ang = beamAtt.Ang
		col = self.SightColors[att.name].last
		
		if !self.dt.Safe then
			turnOffWhenSafe = CurTime() + 0.1
		end
		
		if self.KKINS_FLEnt and turnOffWhenSafe > CurTime() then
			self.KKINS_FLEnt:send(pos, ang, col)
		end
	end
end

function att:attachFunc()
	if SERVER then
		local ent = ents.Create("cw_kk_ins2_flashlight")
		ent.parentWep = self
		
		local ply = self.Owner
		
		ent:SetPos(ply:EyePos())
		ent:Spawn()
		ent:Activate()
		
		self.KKINS_FLEnt = ent
		ply:SendLua("LocalPlayer():GetActiveWeapon().KKINS_FLEnt = ents.GetByIndex(" .. self.KKINS_FLEnt:EntIndex() .. ")")
	end
end

function att:detachFunc()
	if SERVER then
		SafeRemoveEntity(self.KKINS_FLEnt)
	end
end
	
CustomizableWeaponry:registerAttachment(att)
