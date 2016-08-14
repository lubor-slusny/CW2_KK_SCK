
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

	// funcs
		CustomizableWeaponry_KK.ins2.welementThink._funcs = {}

	// atts
		local function bipod(wep, welement)
			welement:SetSequence(wep.dt.BipodDeployed and 1 or 0)
		end
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.kk_ins2_bipod = bipod
		
		local att = {}
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.kk_ins2_lam = function(wep, welement)
			if IsValid(welement) then
				att.Pos = welement:GetPos()
				att.Ang = welement:GetAngles()
				-- CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"]._elementRender(wep, att)
			end
		end
	
	// perma bipods
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_rpk = bipod
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_m249 = bipod
	
	// warheads
		local function warhead(wep, welement)
			welement:SetBodygroup(1, (wep:Clip1() == 1) and 0 or 1)
		end
		
		-- CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_at4 = warhead
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_rpg = warhead
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_doi_piat = warhead
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_doi_tankfist = warhead
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_doi_zooka = warhead
		
	// grenade spoons and pins
		local function grenade(wep, welement)
			welement:SetBodygroup(1, 1)
		end
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_anm14 = grenade
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_f1 = grenade
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_m18 = grenade
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_m67 = grenade
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_m84 = grenade
		
		-- CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_molotov = grenade
		
		-- CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_doi_frag_de = grenade
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_doi_frag_gb = grenade
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_doi_frag_us = grenade
	
	// rcex detonators
		local function rcex(wep, welement)
			local own = IsValid(wep.Owner)
			welement:SetBodygroup(1, own and 0 or 1)
		end
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_c4 = rcex
		
		CustomizableWeaponry_KK.ins2.welementThink._funcs.cw_kk_ins2_nade_ied = rcex
end
