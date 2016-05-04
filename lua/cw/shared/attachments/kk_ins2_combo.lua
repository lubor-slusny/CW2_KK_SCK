
local att = {}
att.name = "kk_ins2_combo"
att.displayName = "Combined Lightning Module"
att.displayNameShort = "KOMBO"

att.statModifiers = {
	VelocitySensitivityMult = -0.2,
	OverallMouseSensMult = -0.2,
	HipSpreadMult = -0.2,
	DrawSpeedMult = -0.1,
	MaxSpreadIncMult = -0.25
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Combines... things.", c = Color(0,255,0,255)},
		{t = "[impulse 100] cycles through modes.", c = CustomizableWeaponry.textColors.REGULAR},
		{t = "Mode resets on re-attach.", c = CustomizableWeaponry.textColors.REGULAR},
		{t = "Colors are determined by previous atts in category.", c = CustomizableWeaponry.textColors.REGULAR},
	}
	
	local rgb = {"r","g","b","a"}
	
	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end
		
		att.description[1].c[rgb[math.random(1,3)]] = math.random(255)
		
		local mode = self._KK_INS2_LAM_MODE
		local mdlAtt
		
		if mode > 1 then
			mdlAtt = self.AttachmentModelsVM["kk_ins2_flashlight"].ent:GetAttachment(1)
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_flashlight"]._elementRender(self, mdlAtt)
		end
		
		if (mode % 2) == 1 then
			mdlAtt = self.AttachmentModelsVM["kk_ins2_lam"].ent:GetAttachment(1)
			CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"]._elementRender(self, mdlAtt)
		else
			self.lastLaserPos = nil
		end		
	end
end

function att:attachFunc()
	CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_flashlight"].attachFunc(self)
	
	if CLIENT then
		self._KK_INS2_LAM_MODE = 0
		if not self.AttachmentModelsVM[att.name] then
			self.AttachmentModelsVM["kk_ins2_flashlight"].active = true
			self.AttachmentModelsVM["kk_ins2_lam"].active = true
		end
	end
end

function att:detachFunc()	
	if CLIENT then
		if not self.AttachmentModelsVM[att.name] then
			self.AttachmentModelsVM["kk_ins2_flashlight"].active = false
			self.AttachmentModelsVM["kk_ins2_lam"].active = false
		end
	end
end

local switchableAttachments = {
	[att.name] = 2,
	["kk_ins2_flashlight"] = 1,
	["kk_ins2_lam"] = 1,
}

if CLIENT then
	function att.PlayerBindPress(ply, bind, pressed)
		if !pressed then return end
		if !bind:find("impulse 100") then return end
		
		local wep = ply:GetActiveWeapon()
		
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end
		
		local hasFL = false
		local max
		for k,v in pairs(switchableAttachments) do
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
		
		-- if wep.ActiveAttachments[att.name] then
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

	hook.Add("PlayerBindPress", att.name, att.PlayerBindPress)
end

if SERVER then
	function att.Think()
		for _,ply in pairs(player.GetAll()) do
			local wep = ply:GetActiveWeapon()
				
			if !IsValid(wep) then return end
			if !wep.CW20Weapon then return end
			
			local hasFL = false
			for k,v in pairs(switchableAttachments) do
				hasFL = hasFL or wep.ActiveAttachments[k]
			end
			if !hasFL then return end
			
			if ply:FlashlightIsOn() then
				ply:Flashlight(false)
			end
		end
	end
	
	hook.Add("Think", att.name, att.Think)
end

CustomizableWeaponry:registerAttachment(att)
