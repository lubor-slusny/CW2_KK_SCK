if not CustomizableWeaponry then return end

AddCSLuaFile()

local WS_PACK_REVISION = 7

CW_KK_ACTION = 11
CW_KK_QNADE = 12
CW_KK_QKNIFE = 13

KK_INS2_SHOTGUN_LOAD_FIRST = 1
KK_INS2_SHOTGUN_UNLOAD_ONE = 2
KK_INS2_STRIPPERCLIP_UNLOAD_ONE = 3
KK_INS2_RIFLEGL_UNLOAD_ONE = 4

CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.ins2 = CustomizableWeaponry_KK.ins2 or {}

CustomizableWeaponry_KK.ins2.firstDeployEnabled = true
CustomizableWeaponry_KK.ins2.holsterTransitionsEnabled = true

CustomizableWeaponry_KK.ins2.magnifierDependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies or {}
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true

local SP = game.SinglePlayer()

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

CustomizableWeaponry_KK.ins2.baseContentMounted = function()
	return baseContentOK
end

CustomizableWeaponry_KK.ins2.wsContentMounted = function()
	return (baseContentOK and (CustomizableWeaponry_KK.ins2.ws == WS_PACK_REVISION))
end

CustomizableWeaponry_KK.ins2.ww2ContentMounted = function()
	return false
end

CustomizableWeaponry_KK.ins2.doiContentMounted = function()
	return (baseContentOK and doigameContentOK)
end

if CLIENT then
	CreateClientConVar("cw_kk_freeze_reticles", 0, false, false)
	
	local cvXH = CreateClientConVar("cw_kk_gm_xhair", 0, false, false)
	local cvLA = CreateClientConVar("cw_kk_sck_lock_ads", 0, false, false)

	local ply, wep
	
	hook.Add("Think", "cw_kk_gm_xhair_think", function()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()
		
		if !wep.CW20Weapon then return end
		
		wep.DrawCrosshair = cvXH:GetInt() == 1
	end)

	local _ADS_LAST, cur
	hook.Add("Think", "cw_kk_sck_lock_ads_think", function() 
		cur = cvLA:GetInt()
		if cur != _ADS_LAST and _ADS_LAST != nil then
			if cur == 0 then
				RunConsoleCommand("-attack2")
			else
				RunConsoleCommand("+attack2")
			end
		end
		_ADS_LAST = cur
	end)
end

if CLIENT then
	CreateClientConVar("cw_kk_ins2_rig", 1, true, true)
	CreateClientConVar("cw_kk_ins2_animate_reticle", 0, true, false)
	CreateClientConVar("cw_kk_ins2_draw_vm_in_rt", 0, true, false)
	CreateClientConVar("cw_kk_ins2_shell_sound", 3, true, false)
	CreateClientConVar("cw_kk_ins2_shell_time", 10, true, false)
	CreateClientConVar("cw_kk_ins2_shell_vm", 0, true, false)

	if not CustomizableWeaponry_KK.panels then
		CustomizableWeaponry_KK.panels = {}
	end
	
	local sslabeltxt = {
		"^^ [Cheapest] physmaterial sound",
		"^^ [CW2 Base] timer, custom sound",
		"^^ [KK INS2] callback, custom sound"
	}
	
	if CustomizableWeaponry_KK.HOME then
		table.insert(sslabeltxt, "^^ [KK INS2] custom physmaterial")
	end
	
	CustomizableWeaponry_KK.panels.ins2 = function(panel)
		panel:AddControl("Label", {Text = "INS2 Pack:"}):DockMargin(0, 0, 8, 0)
		
		// rigs
		panel:AddControl("Slider", {
			Label = "Rig:",
			Type = "Integer",
			Min = "1",
			Max = #CustomizableWeaponry_KK.ins2.hands,
			Command = "cw_kk_ins2_rig"
		}):DockMargin(8, 0, 8, 0)
		
		// shell sound function
		local ssslider = panel:AddControl("Slider", {
			Label = "Shell sound function:",
			Type = "Integer",
			Min = "1",
			Max = #sslabeltxt,
			Command = "cw_kk_ins2_shell_sound"
		})
		
		ssslider:SetDecimals(0)
		ssslider:DockMargin(8, 0, 8, 0)
		
		local sslabel = panel:AddControl("Label", {Text = "meh"})
		sslabel:DockMargin(8, 0, 8, 16)
		
		function ssslider:OnValueChanged(v)
			sslabel:SetText(sslabeltxt[math.Clamp(math.Round(v or 1), 1, #sslabeltxt)] or "meh")
		end
		
		// shell life time
		panel:AddControl("Slider", {
			Label = "Shell life time:",
			Type = "Float",
			Min = "5",
			Max = "60",
			Command = "cw_kk_ins2_shell_time"
		}):DockMargin(8, 0, 8, 0)

		// shell cleanup		
		local cusbutt = panel:AddControl("Button", {Text = "meh"})
		
		cusbutt:DockMargin(8, 0, 8, 0)
		
		function cusbutt:DoClick()
			CustomizableWeaponry_KK.ins2.shells:cleanUp()
			self:updateLabel()
		end
		
		function cusbutt:updateLabel()
			local num = CustomizableWeaponry_KK.ins2.shells:getDeployedCount()
			cusbutt:SetText("Clean up shells [" .. num .. "]")
		end
		
		cusbutt:updateLabel()
		
		timer.Create("CW_KK_INS2_SHELL_COUNTER", 3, 0, function()
			if IsValid(cusbutt) then
				cusbutt:updateLabel()
			end
		end)
		
		hook.Add("PostReloadToolsMenu", "CW_KK_INS2_SHELL_COUNTER_REMOVER", function()
			timer.Remove("CW_KK_INS2_SHELL_COUNTER")
		end)
		
		// VM shells
		panel:AddControl("CheckBox", {
			Label = "Alternative shell rendering function", 
			Command = "cw_kk_ins2_shell_vm"
		}):DockMargin(8, 8, 8, 0)
		
		// always animated reticles
		panel:AddControl("CheckBox", {
			Label = "Always animate stencil sight reticle", 
			Command = "cw_kk_ins2_animate_reticle"
		}):DockMargin(8, 8, 8, 0)
		
		// slow grenade attack swap
		panel:AddControl("CheckBox", {
			Label = "INS2-style slow grenade attacks (primary = cook)", 
			Command = "cw_kk_ins2_ins_nade_ctrls"
		}):DockMargin(8, 8, 8, 0)
		
		if not CustomizableWeaponry_KK.HOME then return end
		
		// cam3d experiments
		panel:AddControl("CheckBox", {
			Label = "Draw viewmodels in render target scopes", 
			Command = "cw_kk_ins2_draw_vm_in_rt"
		}):DockMargin(8, 8, 8, 0)
	end
	
	local pos
	
	hook.Add("Think", "CW_KK_INS2_WS_UPDATE_NOTIFY", function()
		if not pos then 
			pos = LocalPlayer():GetPos()
			return
		end
		
		if LocalPlayer():GetPos():Distance(pos) > 100 then
			hook.Remove("Think", "CW_KK_INS2_WS_UPDATE_NOTIFY")
			
			if not CustomizableWeaponry_KK.ins2.baseContentMounted() then
				chat.AddText(
					Color(200, 157, 96),
					"[KK INS2 SWEPS] ",
					Color(255, 255, 255),
					"Hi, required files are missing. Make sure you mount INS2 content properly (according to guide on addon`s workshop page)."
				)
				
				return
			end
			
			if CustomizableWeaponry_KK.ins2.baseContentMounted() and (CustomizableWeaponry_KK.ins2.ws != nil) and not CustomizableWeaponry_KK.ins2.wsContentMounted() then
				chat.AddText(
					Color(200, 157, 96),
					"[KK INS2 SWEPS] ",
					Color(255, 255, 255),
					"Hi, you seem to be using outdated WS content. Make sure you download updated version from GitHub."
				)
			end
		end
	end)
end

for k, v in pairs(file.Find("autorun/cw_kk_ins/*", "LUA")) do
	AddCSLuaFile("autorun/cw_kk_ins/" .. v)
	include("autorun/cw_kk_ins/" .. v)
end

local math_approach = math.Approach

if CLIENT then
	CustomizableWeaponry_KK.ins2.matproxy = CustomizableWeaponry_KK.ins2.matproxy or {}
	
	CustomizableWeaponry_KK.ins2.matproxy.lense = CustomizableWeaponry_KK.ins2.matproxy.lense or {}
	
	CustomizableWeaponry_KK.ins2.matproxy.lense.name = "IronsightVectorResult"
	
	function CustomizableWeaponry_KK.ins2.matproxy.lense:init(mat, values)
		self.mults = {}
		
		self.ResultTo = values.resultvar
		self.ResultBase = Vector(values.resultdefault)
		self.ResultAdd = Vector(values.resultzoomed) - self.ResultBase
	end
	
	function CustomizableWeaponry_KK.ins2.matproxy.lense:bind(mat, ent)
		if !IsValid(ent) then return end
		
		local mul = self.mults[ent] or 0.5
		
		if IsValid(ent.wepParent) and ent.wepParent.CW20Weapon and ent.wepParent:isAiming() then
			mul = math_approach(mul, 1, FrameTime() * 2)
		else
			mul = math_approach(mul, 0, FrameTime() * 2)
		end
		
		mat:SetVector(self.ResultTo, self.ResultBase + mul * self.ResultAdd)
		self.mults[ent] = mul
	end
	
	matproxy.Add(CustomizableWeaponry_KK.ins2.matproxy.lense)
end

if CLIENT then
	local cvEp = CreateClientConVar("cw_kk_add_epilepsy", 0, true, false)
	
	local onceStarted
	
	hook.Add("RenderScene", "CW20_KK_Epilepsy-ator", function()
		if (cvEp:GetInt() == 0) and not onceStarted then return end
		
		onceStarted = true
		
		for _,a in pairs(CustomizableWeaponry.registeredAttachments) do
			if a.description then
				for __,line in pairs(a.description) do
					line.c = Color(
						math.random(255),
						math.random(255),
						math.random(255),
						math.random(255) + 155
					)	
				end
			end
		end
	end)
end

if CLIENT then
	CustomizableWeaponry_KK.ins2.nodrawMat = CustomizableWeaponry_KK.ins2.nodrawMat or {}
	-- CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/4x_reticule"] = true
	
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/elcan_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/po4x_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mosin_crosshair"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mk4_crosshair"] = true
	
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/enfield_crosshair"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/kar98k_crosshair"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/weaver_crosshair"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/zf4_crosshair"] = true
	
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/l85a2/susat_reticle"] = true
	
	-- CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/attachments/cw_kk_ins2_cstm_eotechxps/4x_reticule"] = true
end
