
local PANEL
local VM_ENT
local LOCK

local function skinChanged(slider, val)
	if LOCK or !IsValid(VM_ENT) then return end
	VM_ENT:SetSkin(math.Round(val, 0))
end

local function bodygroupChanged(slider, val)
	if LOCK or !IsValid(VM_ENT) then return end
	VM_ENT:SetBodygroup(slider.KKSCK_id, math.Round(val, 0))
end

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()

	if !IsValid(VM_ENT) then return end
	
	LOCK = true
	
	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:SetTooltip("Loads changes made outside of this tool.")
	butt:DockMargin(0, 0, 8, 8)	
	butt:SetText("Refresh")
	butt.DoClick = updatePanel
	PANEL:AddItem(butt)
	
	local model = vgui.Create("DLabel", PANEL)
	model:SetWrap(true)
	model:SetTextInset(0, 0)
	model:SetText("[" .. VM_ENT:GetModel() .. "]")
	model:SetContentAlignment(7)
	model:SetAutoStretchVertical(true)
	model:DockMargin(0, 0, 0, 0)
	model:SetDark(true)
	PANEL:AddItem(model)
	
	local slider
	local skinCount = VM_ENT:SkinCount() - 1
	
	slider = vgui.Create("DNumSlider", PANEL)
	slider:DockMargin(0, 0, 0, 0)
	slider:SetDecimals(0)
	slider:SetMinMax(0, skinCount)
	slider:SetValue(VM_ENT:GetSkin())
	slider:SetText("Skin")
	if skinCount > 0 then slider:SetDark(true) end
	slider.OnValueChanged = skinChanged
	PANEL:AddItem(slider)
	
	local bgTit = vgui.Create("DLabel", PANEL)
	bgTit:SetWrap(true)
	bgTit:SetTextInset(0, 0)
	bgTit:SetText("Bodygroups")
	bgTit:SetContentAlignment(7)
	bgTit:SetAutoStretchVertical(true)
	bgTit:DockMargin(0, 0, 0, 0)
	PANEL:AddItem(bgTit)
	
	local bgCount = VM_ENT:GetNumBodyGroups()
		
	for i = 0, bgCount - 1 do
		local bgText = i .. "# " .. VM_ENT:GetBodygroupName(i)
		local bgCount = VM_ENT:GetBodygroupCount(i) - 1
		
		slider = vgui.Create("DNumSlider", PANEL)
		slider:DockMargin(8, 0, 0, 0)
		slider:SetDecimals(0)
		slider:SetMinMax(0, bgCount)
		slider:SetValue(VM_ENT:GetBodygroup(i))
		slider:SetText(bgText)
		slider.KKSCK_id = i
		slider.OnValueChanged = bodygroupChanged
		PANEL:AddItem(slider)
		
		if bgCount > 0 then 
			slider:SetDark(true) 
			bgTit:SetDark(true)
			bgTit:InvalidateLayout()
		end
	end
	
	LOCK = false
end

local LAST_MDL

function KK_SCK_BGS_Think()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local wep = ply:GetActiveWeapon()
	
	VM_ENT = ply:GetViewModel()
	
	if IsValid(wep) then		
		if wep.CW20Weapon and IsValid(wep.CW_VM) then
			VM_ENT = wep.CW_VM
		elseif IsValid(wep.Wep) then
			VM_ENT = wep.Wep
		end
	end
	
	if !IsValid(VM_ENT) then return end
	
	local vm = VM_ENT:GetModel()
	if vm != LAST_MDL then 
		updatePanel()
	end
	LAST_MDL = vm
end

hook.Add("PopulateToolMenu", "KK_SCK_BGS", function()
	if GetConVarNumber("cw_kk_dev_menu") != 0 then 
		spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_BGS", "Bodygroups", "", "", function(panel)
			PANEL = panel
			updatePanel()
			
			hook.Add("Think", "KK_SCK_BGS_Think", KK_SCK_BGS_Think)
		end)
	end
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_BGS_Remove", function()
	hook.Remove("Think", "KK_SCK_BGS_Think")
end)

// DELETE BELOW // debug code
RunConsoleCommand("spawnmenu_reload")
