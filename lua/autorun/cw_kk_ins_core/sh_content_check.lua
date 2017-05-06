
local WS_PACK_REVISION = 12

local baseContentOK = true
for _,f in pairs({
		"models/weapons/v_marinebayonet.mdl",
		"models/weapons/v_mp5kpdw.mdl",
		"models/weapons/w_flare_projectile.mdl",
		"models/weapons/w_p2a1.mdl",
		"models/weapons/shells/40mm.mdl",
		"models/weapons/shells/556x45_link.phy",
		"models/weapons/upgrades/a_modkit_mosin.mdl",
		"models/weapons/upgrades/a_projectile_gp25.phy",
		"models/weapons/upgrades/a_projectile_gp25.phy",
		"models/weapons/upgrades/w_standard_ak74.mdl",
	}) do
	
	baseContentOK = baseContentOK and file.Exists(f, "GAME")
end

local doimodContentOK = true
for _,f in pairs({
		"models/weapons/w_panzerfaust_projectile.mdl",
		"models/weapons/w_stielhandgranate.phy",
		"models/weapons/shells/garand_clip.phy",
		"models/weapons/upgrades/w_thompson_foregrip.mdl",
	}) do
	
	doimodContentOK = doimodContentOK and file.Exists(f, "GAME")
end

local doigameContentOK = true
for _,f in pairs({
		"models/weapons/v_etool_brit.mdl",
		"models/weapons/w_bren.phy",
		"models/weapons/upgrades/a_bolt_springfield_ext.mdl",
		"models/weapons/upgrades/a_warhead_bazooka_2.mdl",
		"models/weapons/upgrades/w_enfield_gl.mdl",
	}) do
	
	doigameContentOK = doigameContentOK and file.Exists(f, "GAME")
end

local ao5ContentOK = true
for _,f in pairs({
		"models/weapons/w_snub.mdl",
		"models/weapons/aof/v_flashgun.mdl",
		"models/weapons/aof/v_m79.mdl",
		"models/weapons/aof/w_machete.phy",
		"models/weapons/upgrades/w_flipup_br99.mdl",
	}) do
	
	ao5ContentOK = ao5ContentOK and file.Exists(f, "GAME")
end

local arseContentOK = true
for _,f in pairs({
		"models/weapons/beretta/insguns_v_beretta.mdl",
		"models/weapons/l85/w_l85sight.mdl",
		"models/weapons/scar/a_scar_standardbarrel.mdl",
		"models/weapons/usp/w_uspmag.mdl",
		"models/weapons/upgrades/w_ugl.mdl",
	}) do
	
	arseContentOK = arseContentOK and file.Exists(f, "GAME")
end

local namContentOK = true
for _,f in pairs({
		"models/weapons/v_nam_geballteladung.mdl",
		"models/weapons/v_nam_ithaca37.mdl",
		"models/weapons/v_nam_m26a2.mdl",
		"models/weapons/v_nam_m79.mdl",
		"models/weapons/v_nam_tokarev.mdl",
	}) do
	
	namContentOK = namContentOK and file.Exists(f, "GAME")
end

local subs
local sub = string.sub
local starts = string.StartWith

function CustomizableWeaponry_KK.ins2:isContentMounted4()
	subs = subs or {
		["cw_kk_ins2_cstm"] = function() return (baseContentOK and (CustomizableWeaponry_KK.ins2.ws == WS_PACK_REVISION)) end,
		["cw_kk_ins2_doi"] = function() return (doigameContentOK) and (CustomizableWeaponry_KK.ins2.ws == WS_PACK_REVISION) end,
		["cw_kk_ins2_ao5"] = function() return (baseContentOK and ao5ContentOK) end,
		["cw_kk_ins2_arse"] = function() return (baseContentOK and arseContentOK and CustomizableWeaponry_KK.HOME) end,
		["cw_kk_ins2_nam"] = function() return (doigameContentOK and namContentOK) end,
		
		["doigameContentOK"] = function() return doigameContentOK end
	}
	
	local class = sub(self.Folder, 9)
	
	for k,f in pairs(subs) do
		if starts(class, k) then
			return f()
		end
	end
	
	return baseContentOK
end

if CLIENT then
	local pos
	
	hook.Add("Think", "CW_KK_INS2_WS_UPDATE_NOTIFY", function()
		if not pos then 
			pos = LocalPlayer():GetPos()
			return
		end
		
		if LocalPlayer():GetPos():Distance(pos) > 100 then
			hook.Remove("Think", "CW_KK_INS2_WS_UPDATE_NOTIFY")
			
			if not baseContentOK then
				chat.AddText(
					Color(200, 157, 96),
					"[KK INS2 SWEPS] ",
					Color(255, 255, 255),
					"Hi, required files are missing. Make sure you mount INS2 content properly (according to guide on addon`s workshop page)."
				)
				
				return
			end
			
			if baseContentOK and CustomizableWeaponry_KK.ins2.ws != nil and CustomizableWeaponry_KK.ins2.ws < WS_PACK_REVISION then
				chat.AddText(
					Color(200, 157, 96),
					"[KK INS2 SWEPS] ",
					Color(255, 255, 255),
					"Hi, you seem to be using outdated WS content. Make sure you download updated version from GitHub."
				)
				
				return
			end
			
			if doigameContentOK and (CustomizableWeaponry_KK.ins2.ws == nil or CustomizableWeaponry_KK.ins2.ws < WS_PACK_REVISION) then
				chat.AddText(
					Color(200, 157, 96),
					"[KK INS2 SWEPS] ",
					Color(255, 255, 255),
					"Hi, Day Of Infamy sub-pack now requires EXT sub-pack in addition to standalone game. EXT pack installation is covered in guide on addon`s workshop page."
				)
				
				return
			end
		end
	end)
end
