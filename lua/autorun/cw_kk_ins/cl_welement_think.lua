
if CLIENT then
	CustomizableWeaponry_KK.ins2.welementThink = CustomizableWeaponry_KK.ins2.welementThink or {}

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

	CustomizableWeaponry_KK.ins2.welementThink.templates = {
		bipod = function(wep, welement)
			welement:SetSequence(wep.dt.BipodDeployed and 1 or 0)
		end,
		
		launcher = function(wep, welement)
			welement:SetBodygroup(1, (wep:Clip1() == 1) and 0 or 1)
		end,
		
		grenade = function(wep, welement)
			welement:SetBodygroup(1, wep.dt.PinPulled and 0 or 1)
		end,

		rcex = function(wep, welement)
			welement:SetBodygroup(1, IsValid(wep.Owner) and 0 or 1)
		end,
	}
	
	function CustomizableWeaponry_KK.ins2.welementThink:add(id, func)
		if not id then return end
		
		func = self.templates[func] or func // if template exists, use it
		
		self._funcs = self._funcs or {}
		self._funcs[id] = func // if nil is passed, remove existing
	end
		
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_rpg", "launcher")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_piat", "launcher")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_tankfist", "launcher")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_tankshrek", "launcher")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_zooka", "launcher")
	
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_anm14", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_f1", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_m18", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_m67", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_m84", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_frag_gb", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_frag_gb_n69", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_frag_gb_n77", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_frag_us", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_c4_de", "grenade")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_doi_c4_us", "grenade")
	
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_c4", "rcex")
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_ied", "rcex")
	
	CustomizableWeaponry_KK.ins2.welementThink:add("kk_ins2_bipod", "bipod")
	
	local att = {}
	CustomizableWeaponry_KK.ins2.welementThink:add("kk_ins2_lam", function(wep, welement)
		if IsValid(welement) then
			att.Pos = welement:GetPos()
			att.Ang = welement:GetAngles()
			-- CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_lam"]._elementRender(wep, att)
		end
	end)
end
