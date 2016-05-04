
local SP = game.SinglePlayer()

CustomizableWeaponry.callbacks:addNew("initialize", "KK_INS2_BASE", function(self)
	if CLIENT then
		if self.AttachmentModelsVM then
			for _, v in pairs(self.AttachmentModelsVM) do
				if IsValid(v.ent) then
					v.ent._SWEP = self
				end
			end
		end
	end
end)

-- CustomizableWeaponry.callbacks:addNew("canReload", "KK_INS2_BASE", function(wep)

-- end)

-- CustomizableWeaponry.callbacks:addNew("preFire", "KK_INS2_BASE", function(wep)
	
-- end)

-- if CLIENT then
	-- usermessage.Hook("CW20_KK_INS_RETICLEINACTIVITY", function(um)
		-- local ply = LocalPlayer()
		-- if !IsValid(ply) then return end
		
		-- local wep = ply:GetActiveWeapon()
		-- if !IsValid(wep) or wep.Base != "cw_kk_ins2_base" then return end
			
		-- wep.reticleInactivity = UnPredictedCurTime() + um:ReadFloat()
	-- end)
-- end

local tab

CustomizableWeaponry.callbacks:addNew("postAttachAttachment", "KK_INS2_BASE", function(wep,catId,attId)
	if wep.Base != "cw_kk_ins2_base" then return end
	
	tab = CustomizableWeaponry.registeredAttachmentsSKey[wep.Attachments[catId].atts[attId]]
	
	if CLIENT then
		if tab.KK_INS2_playIdle then
			wep:idleAnimFunc()
		end
	end
end)

CustomizableWeaponry.callbacks:addNew("postDetachAttachment", "KK_INS2_BASE", function(wep,attTable,CWMenuCategory)
	if wep.Base != "cw_kk_ins2_base" then return end
	
	tab = attTable
	
	if CLIENT then
		if tab.KK_INS2_playIdle then
			wep:idleAnimFunc()
		end
	end
end)

-- if CLIENT then
	-- local gradient = surface.GetTextureID("cw2/gui/gradient")
		
	-- local cwhud24 = "CW_HUD24"
	-- local cwhud22 = "CW_HUD22"

	-- CustomizableWeaponry.callbacks:addNew("overrideReserveAmmoText", "KK_INS2_BASE", function(wep)
		-- if (CurTime() % 2) > 1 then
			-- return false, "lolo", Color(255,100,255,255)
		-- else
			-- return false, "lolo", Color(200,255,0,255)
		-- end
	-- end)

	-- CustomizableWeaponry.callbacks:addNew("drawTo3D2DHUD", "KK_INS2_BASE", function(wep)
		
	-- end)
		
	-- CustomizableWeaponry.callbacks:addNew("suppressHUDElements", "KK_INS2_BASE", function(wep, cwHudEnabled)
		-- return false, false, false
	-- end)

	-- CustomizableWeaponry.callbacks:addNew("drawToHUD", "KK_INS2_BASE", function(wep, cwHudEnabled)
		
	-- end)
-- end
