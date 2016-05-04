
local switchableAttachments = {
	["kk_ins2_anpeq15"] = 2,
	["kk_ins2_combo"] = 2,
	["kk_ins2_flashlight"] = 1,
	["kk_ins2_lam"] = 1,
}

if CLIENT then
	function PlayerBindPress(ply, bind, pressed)
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

	hook.Add("PlayerBindPress", "CW_KK_INS2_FLASHLIGHT", PlayerBindPress)
end

if SERVER then
	function Think()
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
	
	hook.Add("Think", "CW_KK_INS2_FLASHLIGHT", Think)
end
