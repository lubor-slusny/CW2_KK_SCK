
if CLIENT then
	CustomizableWeaponry_KK.ins2.welementThink = {}

	function CustomizableWeaponry_KK.ins2.welementThink:process(wep)
		if wep.AttachmentModelsWM then 
			for k,v in pairs(wep.AttachmentModelsWM) do
				local f = self._funcs[k]
				if v.active and f then
					f(wep, v.ent)
				end
			end
		end
		
		local f = self._funcs[wep:GetClass()]
		if f then
			f(wep, wep.WMEnt)
		end
	end

	hook.Add("Think", "CW_KK_INS2_WElementThink", function()
		for _,wep in pairs(ents.GetAll()) do
			if wep.CW20Weapon then
				CustomizableWeaponry_KK.ins2.welementThink:process(wep)
			end
		end
	end)

	CustomizableWeaponry_KK.ins2.welementThink._funcs = {}

	CustomizableWeaponry_KK.ins2.welementThink._funcs.kk_ins2_bipod = function(wep, welement)
		if IsValid(welement) then
			welement:SetSequence(wep.dt.BipodDeployed and 1 or 0)
		end
	end
	
	CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_rpk = function(wep, welement)
		welement:SetSequence(wep.dt.BipodDeployed and 1 or 0)
	end
	
	CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_m249 = function(wep, welement)
		welement:SetSequence(wep.dt.BipodDeployed and 1 or 0)
	end
	
	CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_doi_zooka = function(wep, welement)
		welement:SetBodygroup(1, (wep:Clip1() == 1) and 0 or 1)
	end
	
	local att = {}
	
	CustomizableWeaponry_KK.ins2.welementThink._funcs.kk_ins2_lam = function(wep, welement)
		if IsValid(welement) then
			att.Pos = welement:GetPos()
			att.Ang = welement:GetAngles()
			-- CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"]._elementRender(wep, att)
		end
	end
end
