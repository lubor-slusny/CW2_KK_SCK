
local presetFastest = {
	["cw_kk_ins2_animate_reticle"] = 1,
	["cw_kk_ins2_draw_vm_in_rt"] = 0,
	["cw_kk_ins2_ins_nade_ctrls"] = 1,
	["cw_kk_ins2_rig"] = 2,
	["cw_kk_ins2_rigskin"] = 0,
	["cw_kk_ins2_scopelightingfix"] = 0,
	["cw_kk_ins2_shell_sound"] = 1,
	["cw_kk_ins2_shell_time"] = 5,
	["cw_kk_ins2_shell_vm"] = 0,
	["cw_kk_ins2_sprint"] = 1
}

CustomizableWeaponry_KK.panels =
	CustomizableWeaponry_KK.panels or
	{}

local function addSettingsPresetSection(panel)
	local cvarKeys = table.GetKeys(CustomizableWeaponry_KK.ins2.conVars.main)
	local defaults = {}
	
	for _,k in pairs(cvarKeys) do
		defaults[k] = CustomizableWeaponry_KK.ins2.conVars.main[k]:GetDefault()
	end

	panel:AddControl("ComboBox", { 
		MenuButton = 1, 
		Folder = "cw_kk_ins2_cfg", 
		Options = {
			["Default"] = defaults,
			["Fastest"] = presetFastest,
		}, 
		CVars = cvarKeys
	}):DockMargin(8, 0, 8, 8)
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

local function addRigsSection(panel)
	local rslider = panel:AddControl("Slider", {
		Label = "Rig:",
		Type = "Integer",
		Min = "1",
		Max = CustomizableWeaponry_KK.ins2.hands.cacheSize,
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
end

local sslabeltxt = {
	"^^ [Cheapest] physmaterial sound",
	"^^ [CW2 Base] timer, custom sound",
	"^^ [KK INS2] callback, custom sound"
}

if CustomizableWeaponry_KK.HOME then
	table.insert(sslabeltxt, "^^ [KK INS2] custom physmaterial")
end

local function addShellSoundSection(panel)
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
end

local function addShellCleanupSection(panel)
	local cusbutt = panel:AddControl("Button", {Text = "meh"})
	
	cusbutt:DockMargin(8, 0, 8, 0)
	
	function cusbutt:DoClick()
		CustomizableWeaponry_KK.ins2.shells:cleanUpShells()
		self:updateLabel()
	end
	
	function cusbutt:updateLabel()
		local num = CustomizableWeaponry_KK.ins2.shells.cacheSize
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
end

CustomizableWeaponry_KK.panels.ins2 = function(panel)
	panel:AddControl("Label", {Text = "INS2/DOI Pack:"}):DockMargin(0, 0, 8, 0)
	
	// cfg
	addSettingsPresetSection(panel)
	
	// rigs
	addRigsSection(panel)
	
	// shell sound function
	addShellSoundSection(panel)
	
	// shell life time
	panel:AddControl("Slider", {
		Label = "Shell life time:",
		Type = "Float",
		Min = "5",
		Max = "60",
		Command = "cw_kk_ins2_shell_time"
	}):DockMargin(8, 0, 8, 0)

	// shell cleanup
	addShellCleanupSection(panel)
	
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
