AddCSLuaFile()

local PANEL
local LOCK

local VM_ENT
local RIG_ENT
local WM_ENT

local typeNames = {
	"Weapon ViewModel: ",
	"Hands ViewModel: ",
	"Weapon WolrdModel: ",
}

local function isReallyValid(ent)
	return IsValid(ent) and (ent:GetModel() != nil) and (ent:SkinCount() != nil) and (ent:GetSkin() != nil) and (ent:GetNumBodyGroups() != nil)
end

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
	
	for i,ent in pairs({VM_ENT, RIG_ENT, WM_ENT}) do
		if !isReallyValid(ent) then continue end
		
		local label = vgui.Create("DLabel", PANEL)
		label:SetWrap(true)
		label:SetTextInset(0, 0)
		label:SetText(typeNames[i])
		label:SetContentAlignment(7)
		label:SetAutoStretchVertical(true)
		label:DockMargin(0, 0, 0, 0)
		label:SetDark(true)
		label:SetTextColor(PANEL:GetSkin().Colours.Tree.Hover)
		
		PANEL:AddItem(label)
		
		local mdlTxt = vgui.Create("DLabel", PANEL)
		mdlTxt:SetWrap(true)
		mdlTxt:SetTextInset(0, 0)
		mdlTxt:SetText("[" .. ent:GetModel() .. "]")
		mdlTxt:SetContentAlignment(7)
		mdlTxt:SetAutoStretchVertical(true)
		mdlTxt:DockMargin(0, 0, 0, 0)
		mdlTxt:SetDark(true)
		PANEL:AddItem(mdlTxt)
		
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
			if LOCK or !isReallyValid(ent) then return end
			ent:SetSkin(math.Round(val, 0))
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
		
		local bgCount = ent:GetNumBodyGroups()
			
		for i = 0, bgCount - 1 do
			local bgText = i .. "# " .. ent:GetBodygroupName(i)
			local bgCount = ent:GetBodygroupCount(i) - 1
			
			slider = vgui.Create("DNumSlider", PANEL)
			slider:DockMargin(8, 0, 0, 0)
			slider:SetDecimals(0)
			slider:SetMinMax(0, bgCount)
			slider:SetValue(ent:GetBodygroup(i))
			slider:SetText(bgText)
			
			function slider:OnValueChanged(val)
				if LOCK or !isReallyValid(ent) then return end
				ent:SetBodygroup(i, math.Round(val, 0))
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

local LAST_MDL

local function KK_SCK_BGS_Think()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	VM_ENT = ply:GetViewModel()
	
	local wep = ply:GetActiveWeapon()
	
	if IsValid(wep) then		
		if wep.CW20Weapon and IsValid(wep.CW_VM) then
			VM_ENT = wep.CW_VM
			RIG_ENT = wep.CW_KK_HANDS or wep.Owner:GetHands()
		elseif IsValid(wep.Wep) then
			VM_ENT = wep.Wep
		end
		
		WM_ENT = wep.WMEnt
	end
	
	if !isReallyValid(VM_ENT) then return end
	
	local vm = VM_ENT:GetModel()
	if vm != LAST_MDL then 
		updatePanel()
	end
	LAST_MDL = vm
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
