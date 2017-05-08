AddCSLuaFile()

local PANEL
local LOCK

local VM_ENT
local RIG_ENT
local WM_ENT

local typeNames = {
	"Weapon View Model: ",
	"Hands View Model: ",
	"Weapon World Model: ",
}

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()

	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:SetTooltip("Loads changes made outside of this tool.")
	butt:DockMargin(0, 0, 8, 8)	
	butt:SetText("Refresh")
	butt.DoClick = updatePanel
	PANEL:AddItem(butt)
	
	for entType,ent in pairs({VM_ENT, RIG_ENT, WM_ENT}) do
		if not IsValid(ent) then
			-- PANEL:AddControl("Label", {text = "INVALID ENTITY"}):DockMargin(0, 0, 0, 0)
			continue 
		end
		
		local label = vgui.Create("DLabel", PANEL)
		label:SetWrap(true)
		label:SetTextInset(0, 0)
		label:SetText(typeNames[entType])
		label:SetContentAlignment(7)
		label:SetAutoStretchVertical(true)
		label:DockMargin(0, 0, 0, 0)
		label:SetDark(true)
		label:SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
		PANEL:AddItem(label)
		
		if not ent:GetModel() then
			PANEL:AddControl("Label", {text = "GetModel ERROR"}):DockMargin(0, 0, 0, 0)
			continue
		end
		
		local mdlTxt = vgui.Create("DLabel", PANEL)
		mdlTxt:SetWrap(true)
		mdlTxt:SetTextInset(0, 0)
		mdlTxt:SetText("[" .. ent:GetModel() .. "]")
		mdlTxt:SetContentAlignment(7)
		mdlTxt:SetAutoStretchVertical(true)
		mdlTxt:DockMargin(0, 0, 0, 0)
		mdlTxt:SetDark(true)
		mdlTxt:SetMouseInputEnabled(true)
		function mdlTxt:DoClick() SetClipboardText(ent:GetModel()) end
		PANEL:AddItem(mdlTxt)
		
		if not ent:SkinCount() then
			PANEL:AddControl("Label", {text = "SkinCount ERROR"}):DockMargin(0, 0, 0, 0)
			continue
		end
		
		if not ent:GetSkin() then
			PANEL:AddControl("Label", {text = "GetSkin ERROR"}):DockMargin(0, 0, 0, 0)
			continue
		end
		
		local slider
		local skinCount = ent:SkinCount() - 1
		
		slider = vgui.Create("DNumSlider", PANEL)
		slider:DockMargin(8, 0, 0, 0)
		slider:SetDecimals(0)
		slider:SetMinMax(0, skinCount)
		slider:SetValue(ent:GetSkin())
		slider:SetText("Skin")
		
		if skinCount > 0 then slider:SetDark(true) end
		
		function slider:OnValueChanged(val)
			if IsValid(ent) then
				ent:SetSkin(math.Round(val, 0))
			end
		end	
		
		PANEL:AddItem(slider)
		
		local bgTit = vgui.Create("DLabel", PANEL)
		bgTit:SetWrap(true)
		bgTit:SetTextInset(0, 0)
		bgTit:SetText("Bodygroups")
		bgTit:SetContentAlignment(7)
		bgTit:SetAutoStretchVertical(true)
		bgTit:DockMargin(8, 0, 0, 0)
		PANEL:AddItem(bgTit)
		
		if not ent:GetNumBodyGroups() then
			PANEL:AddControl("Label", {text = "GetNumBodyGroups ERROR"}):DockMargin(0, 0, 0, 0)
			continue
		end
		
		local bgCount = ent:GetNumBodyGroups()
			
		for i = 0, bgCount - 1 do
			if not ent:GetBodygroupName(i) then
				PANEL:AddControl("Label", {text = "GetBodygroupName ERROR"}):DockMargin(0, 0, 0, 0)
				continue
			end
			
			if not ent:GetBodygroupCount(i) then
				PANEL:AddControl("Label", {text = "GetBodygroupCount ERROR"}):DockMargin(0, 0, 0, 0)
				continue
			end
			
			if not ent:GetBodygroup(i) then
				PANEL:AddControl("Label", {text = "GetBodygroup ERROR"}):DockMargin(0, 0, 0, 0)
				continue
			end
			
			local bgText = i .. "# " .. ent:GetBodygroupName(i)
			local bgCount = ent:GetBodygroupCount(i) - 1
			
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8, 0, 0, 0)
			slider:SetDecimals(0)
			slider:SetMinMax(0, bgCount)
			slider:SetValue(ent:GetBodygroup(i))
			slider:SetText(bgText)
			
			function slider:OnValueChanged(val)
				if IsValid(ent) then
					ent:SetBodygroup(i, math.Round(val, 0))
				end
			end
			
			PANEL:AddItem(slider)
			
			if bgCount > 0 then 
				slider:SetDark(true) 
				bgTit:SetDark(true)
				bgTit:InvalidateLayout()
			end
		end
	end
	
end

local LAST_SETUP

local function KK_SCK_BGS_Think()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local wep = ply:GetActiveWeapon()
	
	VM_ENT = ply:GetViewModel()
	RIG_ENT = ply:GetHands()
	WM_ENT = wep
	
	if IsValid(wep) then		
		VM_ENT = wep.CW_VM or wep.Wep or VM_ENT
		RIG_ENT = (wep.UseHands and RIG_ENT) or wep.CW_KK_HANDS or wep.CW_HANDS_VM or RIG_ENT
		WM_ENT = wep.WMEnt or WM_ENT
	end
	
	local curSetup = tostring(IsValid(wep) and wep:GetClass()) .. "|" .. tostring(IsValid(VM_ENT) and VM_ENT:GetModel())
	
	if curSetup != LAST_SETUP then 
		updatePanel()
	end
	
	LAST_SETUP = curSetup
end

hook.Add("PopulateToolMenu", "KK_SCK_BGS", function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_BGS", "Bodygroups", "", "", function(panel)
		PANEL = panel
		updatePanel()
		
		hook.Add("Think", "KK_SCK_BGS_Think", KK_SCK_BGS_Think)
	end)
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_BGS_Remove", function()
	hook.Remove("Think", "KK_SCK_BGS_Think")
end)

-- RunConsoleCommand("spawnmenu_reload")
