AddCSLuaFile()

if not CustomizableWeaponry then return end

if SERVER then
	-- resource.AddWorkshop("657241323")
end

// for the best

CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.ins2 = CustomizableWeaponry_KK.ins2 or {}

CustomizableWeaponry_KK.ins2.magnifierDependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies or {}
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true

// for noobs

local SP = game.SinglePlayer()

local baseFiles = {
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
}

local baseOk

CustomizableWeaponry_KK.ins2.baseContentMounted = function()
	if baseOk == nil then
		local res = true
		
		for _,f in pairs(baseFiles) do
			res = res and file.Exists(f, "GAME")
		end
		
		baseOk = res
	end
	
	return baseOk
end

CustomizableWeaponry_KK.ins2.wsContentMounted = function()
	return 
		CustomizableWeaponry_KK.ins2.baseContentMounted() and
		CustomizableWeaponry_KK.ins2.ws
end

local DOIFiles = {
	"models/weapons/w_panzerfaust_projectile.mdl",
	"models/weapons/w_stielhandgranate.phy",
	"models/weapons/shells/garand_clip.phy",
	"models/weapons/upgrades/w_thompson_foregrip.mdl",
	"models/weapons/upgrades/a_standard_garand.mdl",
}

local DOIOk

CustomizableWeaponry_KK.ins2.ww2ContentMounted = function()
	if DOIOk == nil then
		local res = true
		
		for _,f in pairs(DOIFiles) do
			res = res and file.Exists(f, "GAME")
		end
		
		DOIOk = res
	end
	
	return 
		CustomizableWeaponry_KK.ins2.baseContentMounted() and
		DOIOk
end

// for me

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

	if not CustomizableWeaponry_KK.panels then
		CustomizableWeaponry_KK.panels = {}
	end
	
	local sslabeltxt = {
		"^^ [Cheapest] physmaterial sound",
		"^^ [CW2 Base] timer, custom sound",
		"^^ [KK INS2] callback, custom sound",
		-- "^^ [KK INS2] custom physmaterial"
	}
	
	CustomizableWeaponry_KK.panels.ins2 = function(panel)
		panel:AddControl("Label", {Text = "INS2 Pack:"}):DockMargin(0, 0, 8, 0)
				
		// hands model slider
		panel:AddControl("Slider", {
			Label = "Rig:",
			Type = "Integer",
			Min = "1",
			Max = #CustomizableWeaponry_KK.ins2.hands,
			Command = "cw_kk_ins2_rig"
		}):DockMargin(8, 0, 8, 0)
		
		// shell sound function slider
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
		
		// shell life time slider
		panel:AddControl("Slider", {
			Label = "Shell life time:",
			Type = "Float",
			Min = "5",
			Max = "60",
			Command = "cw_kk_ins2_shell_time"
		}):DockMargin(8, 0, 8, 0)

		// shell cleanup button		
		local cusbutt = panel:AddControl("Button", {Text = "meh"})
		
		cusbutt:DockMargin(8, 0, 8, 0)
		
		function cusbutt:DoClick()
			for _,v in pairs(CustomizableWeaponry_KK.ins2.deployedShells) do
				SafeRemoveEntity(v)
			end
			
			self:updateLabel()
		end
		
		function cusbutt:updateLabel()
			local i, t = 1, CustomizableWeaponry_KK.ins2.deployedShells
		
			for _ = 1, #t do
				if !IsValid(t[i]) then
					table.remove(t, i)
				else
					i = i + 1
				end
			end
			
			cusbutt:SetText("Clean up shells [" .. #CustomizableWeaponry_KK.ins2.deployedShells .. "]")
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
		
		// tickbox for always animated reticles
		panel:AddControl("CheckBox", {
			Label = "Always animate stencil sight reticle", 
			Command = "cw_kk_ins2_animate_reticle"
		}):DockMargin(8, 8, 8, 0)
		
		if not CustomizableWeaponry_KK.HOME then return end
		
		// cam3d experiments
		panel:AddControl("CheckBox", {
			Label = "Draw viewmodels in render target scopes", 
			Command = "cw_kk_ins2_draw_vm_in_rt"
		}):DockMargin(8, 8, 8, 0)
	end
end

for k, v in pairs(file.Find("autorun/cw_kk_ins/*", "LUA")) do
	AddCSLuaFile("autorun/cw_kk_ins/" .. v)
	include("autorun/cw_kk_ins/" .. v)
end

// for secsky lenses

if CLIENT then
	matproxy.Add({
		name = "IronsightVectorResult",
		
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
			self.ResultBase = Vector(values.resultdefault)
			self.ResultAdd = Vector(values.resultzoomed) - self.ResultBase
		end,
		
		bind = function(self, mat, ent)
			if !IsValid(ent) then return end
			
			local mul = ent._KK_INS2_lenseProxyMul or 0.5
			
			if IsValid(ent._SWEP) and ent._SWEP.CW20Weapon and ent._SWEP:isAiming() then
				mul = math.Approach(mul, 1, FrameTime() * 2)
			else
				mul = math.Approach(mul, 0, FrameTime() * 2)
			end
			
			ent._KK_INS2_lenseProxyMul = mul
			mat:SetVector(self.ResultTo, self.ResultBase + mul * self.ResultAdd)
		end
	})
end

// for mental sickness

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

// for... stuff

if CLIENT then
	CustomizableWeaponry_KK.ins2.nodrawMat = CustomizableWeaponry_KK.ins2.nodrawMat or {}
	-- CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/4x_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/elcan_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/po4x_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mosin_crosshair"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mk4_crosshair"] = true
	
	-- CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/attachments/cw_kk_ins2_cstm_eotechxps/4x_reticule"] = true
end
