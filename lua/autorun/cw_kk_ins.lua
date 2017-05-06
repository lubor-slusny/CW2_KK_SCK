if not CustomizableWeaponry then return end

AddCSLuaFile()

CW_KK_ACTION = 11
CW_KK_QNADE = 12
CW_KK_QKNIFE = 13

KK_INS2_NO_ACTION = 0
KK_INS2_SHOTGUN_LOAD_FIRST = 1			// [1] = delay before SetClip1(+1)
KK_INS2_SHOTGUN_UNLOAD_ONE = 2			// [1] = delay before SetClip1(-1)
KK_INS2_RIFLEGL_UNLOAD_ONE = 3			// [4] = delay before SetClip1(-1)
KK_INS2_REVOLVER_SLOW_UNLOAD = 4		// [1] = delay before SetClip1(0)
KK_INS2_REVOLVER_SPEED_UNLOAD = 5		// [4] = delay before SetClip1(0)
KK_INS2_STRIPPERCLIP_UNLOAD_ONE = 3		// [4] = delay before SetClip1(-1)

CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.ins2 = CustomizableWeaponry_KK.ins2 or {}

CustomizableWeaponry_KK.ins2.firstDeployEnabled = true			// 2do
CustomizableWeaponry_KK.ins2.firstDeploySkip = -1				// 2do // -1 dont, n>0 - skip after n seconds of wep waiting in inventory
CustomizableWeaponry_KK.ins2.holsterTransitionsEnabled = true
CustomizableWeaponry_KK.ins2.discardEjectedAmmo = false

CustomizableWeaponry_KK.ins2.magnifierDependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies or {}
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true

CustomizableWeaponry_KK.ins2.slowGrenadeMenu = {{header = "CSGO", offset = {1000, -500}, atts = {"kk_counter"}, dependencies = {aintgonnahappen = true}, nadestuff = true}}

local SP = game.SinglePlayer()

local folder = "autorun/cw_kk_ins_core/"
for _,v in pairs({
	[1] = "sh_content_check",
}) do
	AddCSLuaFile(folder .. v .. ".lua")
	include(folder .. v .. ".lua")
end

if CLIENT then
	CreateClientConVar("cw_kk_freeze_reticles", 0, false, false)
	
	if SP then
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
end

if CLIENT then
	CreateClientConVar("cw_kk_ins2_rig", 1, true, true)
	local cvRigSkin = CreateClientConVar("cw_kk_ins2_rigskin", 0, true, true)
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
	
	local function updateRigSkinSlider(slider)
		slider:SetMinMax(0, 0)
		slider:SetDark(false)
		slider:SetText("^^ Skin")
	
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		
		if !IsValid(wep) then
			slider:SetText("Equip INS SWEP.")
			return
		end
		
		if !wep.KKINS2Wep then
			slider:SetText("Equip INS SWEP.")
			return
		end
		
		local max = wep:getRigSkinMax()
		slider:SetMax(max)
		slider:SetDark(max > 0)
		slider:SetText("^^ Skin (" .. ((max == 0) and "none" or (max + 1) .. " found)"))
		slider:SetValue(max > 0 and 0 or 1)
	end
	
	CustomizableWeaponry_KK.panels.ins2 = function(panel)
		panel:AddControl("Label", {Text = "INS2 Pack:"}):DockMargin(0, 0, 8, 0)
		
		-- // cfg
		-- panel:AddControl("ComboBox", { 
			-- MenuButton = 1, 
			-- Folder = txt7, 
			-- Options = presetbox_options, 
			-- CVars = presetbox_cvars
		-- }):DockMargin(8, 0, 8, 8)

		// rigs
		local numRigs = CustomizableWeaponry_KK.ins2.hands.cacheSize
		
		local rslider = panel:AddControl("Slider", {
			Label = "Rig:",
			Type = "Integer",
			Min = "1",
			Max = numRigs,
			Command = "cw_kk_ins2_rig"
		})
		
		rslider:DockMargin(8, 0, 8, 0)
		
		local rlabel = panel:AddControl("Label", {Text = "meh"})
		rlabel:DockMargin(8, 0, 8, 16)
		
		local rigSkinSlider = panel:AddControl("Slider", {
			Label = "^^ Skin:",
			Type = "Integer",
			Min = "0",
			Max = "0",
			Command = "cw_kk_ins2_rigskin"
		})
		
		rigSkinSlider:DockMargin(8, 0, 8, 0)
		
		updateRigSkinSlider(rigSkinSlider)
		
		function rslider:OnValueChanged(v)
			rlabel:SetText("^^ " .. (CustomizableWeaponry_KK.ins2.hands:_get(v)[2]))
			updateRigSkinSlider(rigSkinSlider)
		end
		
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
		
		// scope experiments - lighting
		panel:AddControl("CheckBox", {
			Label = "Fix shadows + break phong on RT Scopes.", 
			Command = "cw_kk_ins2_scopelightingfix"
		}):DockMargin(8, 8, 8, 0)
		
		// sprint anims vs sprint codeims
		panel:AddControl("CheckBox", {
			Label = "Use model sprint anims instead of coded movement.", 
			Command = "cw_kk_ins2_sprint"
		}):DockMargin(8, 8, 8, 0)
		
		if not CustomizableWeaponry_KK.HOME then return end
		
		// cam3d experiments
		panel:AddControl("CheckBox", {
			Label = "Draw viewmodels in render target scopes", 
			Command = "cw_kk_ins2_draw_vm_in_rt"
		}):DockMargin(8, 8, 8, 0)
	end
end

// load main plugins
local folder = "autorun/cw_kk_ins/"
for k, v in pairs(file.Find(folder .. "*", "LUA")) do
	AddCSLuaFile(folder .. v)
	include(folder .. v)
end

// load main plugins
local folder = "autorun/cw_kk_ins_ext/"
for k, v in pairs(file.Find(folder .. "*", "LUA")) do
	AddCSLuaFile(folder .. v)
	include(folder .. v)
end
