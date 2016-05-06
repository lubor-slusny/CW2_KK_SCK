local att = {}
att.name = "kk_ins2_gl_m203"
att.displayName = "M203"
att.displayNameShort = "M203"
att.isGrenadeLauncher = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	DrawSpeedMult = -0.2,
	OverallMouseSensMult = -0.2,
	RecoilMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
	
	local down = Vector(0,0,10)
	
	function att:elementRender()
		if not self.AttachmentModelsVM then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		local ent = self.AttachmentModelsVM[att.name].ent
		
		if !IsValid(ent) then return end
		
		// grenade skin
		if self.Grenade40MM == 2 then
			ent:SetSkin(1)
		else
			ent:SetSkin(0)
		end
		
		// grenade shell
		local cyc = self.CW_VM:GetCycle()
		
		if self.Sequence == self.Animations.gl_on_reload and cyc > 0.3 and cyc < 0.7 then
			if self._shellCoolDown and self._shellCoolDown > CurTime() then
				return
			end
			
			self._shellCoolDown = CurTime() + 3
			
			local att = ent:GetAttachment(2)
			local dir = att.Ang:Forward()
			local pos = att.Pos + dir * 10
			local ang = self.Owner:EyeAngles()
			ang:RotateAroundAxis(ang:Up(), 180)
			
			self._shellTable = CustomizableWeaponry.shells:getShell("KK_INS2_40mm")
				CustomizableWeaponry_KK.ins2.makeShell(self, pos, ang, down, 0.6, 10)
			self._shellTable = self._shellTable1
		end
	end
end

function att:attachFunc()
end

function att:detachFunc()
	self.dt.INS2GLActive = false
end
	
CustomizableWeaponry:registerAttachment(att)
