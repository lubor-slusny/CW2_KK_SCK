
local SKIN_SLIDER
local BG_SLIDERS = {}

local LAST_VM
local LOCK

local function menuThink()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local vmEnt = ply:GetViewModel()
	if !IsValid(vmEnt) then return end
	
	local vm = vmEnt:GetModel()
	
	if vm != LAST_VM then 
		LOCK = true
	
		SKIN_SLIDER:SetMinMax(0, vmEnt:SkinCount() - 1)
		SKIN_SLIDER:SetValue(vmEnt:GetSkin())
		
		local bgCount = vmEnt:GetNumBodyGroups()
		
		for i = 1, bgCount - 1 do
			BG_SLIDERS[i]:SetText(i .. "# " .. vmEnt:GetBodygroupName(i))
			BG_SLIDERS[i]:SetMinMax(0, vmEnt:GetBodygroupCount(i) - 1)
			BG_SLIDERS[i]:SetValue(vmEnt:GetBodygroup(i))
		end
		
		for i = bgCount, 10 do
			BG_SLIDERS[i]:SetText("[none]")
			BG_SLIDERS[i]:SetMinMax(0, 0)
			BG_SLIDERS[i]:SetValue(0)
		end
		
		LOCK = false
	end
	
	LAST_VM = vm
end

local function skinChanged(val)
	if LOCK then return end
	
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	
	vm:SetSkin(math.Round(val:GetValue(), 0))
end

local function bodygroupChanged(val)
	if LOCK then return end
	
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	
	vm:SetBodygroup(val.KKSCK_id, math.Round(val:GetValue(), 0))
end

hook.Add("PopulateToolMenu", "PopulateMyMenu_SCKVMBG_20", function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "SCK VM Bodygroups", "SCK VM Bodygroups", "", "", function(panel)
		panel:ClearControls()
		
		SKIN_SLIDER = vgui.Create("DNumSlider", panel)
		SKIN_SLIDER:SetDecimals(0)
		SKIN_SLIDER:SetMinMax(0, 10)
		SKIN_SLIDER:SetValue(0)
		SKIN_SLIDER:SetText("Skin")
		SKIN_SLIDER:SetDark(true)
		SKIN_SLIDER.OnValueChanged = skinChanged
		panel:AddItem(SKIN_SLIDER)
		
		panel:AddControl("Label", {Text = "Bodygroups"})
		
		for i = 1, 10 do
			BG_SLIDERS[i] = vgui.Create("DNumSlider", panel)
			BG_SLIDERS[i]:SetDecimals(0)
			BG_SLIDERS[i]:SetMinMax(0, 10)
			BG_SLIDERS[i]:SetValue(0)
			BG_SLIDERS[i]:SetText("BG(" .. i .. ", x)")
			BG_SLIDERS[i]:SetDark(true)
			BG_SLIDERS[i].KKSCK_id = i
			BG_SLIDERS[i].OnValueChanged = bodygroupChanged
			panel:AddItem(BG_SLIDERS[i])
		end
		
		hook.Add("Think", "KK_SCK_EDIT_20", menuThink)
	end)
end)

// DELETE BELOW // debug code

hook.Remove("Think", "KK_SCK_EDIT_20")
RunConsoleCommand("spawnmenu_reload")
