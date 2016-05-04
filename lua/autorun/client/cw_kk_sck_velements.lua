
local PANEL

local function updatePanel()
	if not PANEL then return end
	
	PANEL:ClearControls()

	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end
	
	if not wep.CW20Weapon or not wep.AttachmentModelsVM then return end
	
	for key,data in pairs(wep.AttachmentModelsVM) do
		local vPanel = vgui.Create("DPanel", PANEL)
			
			label = vgui.Create("DLabel", vPanel)
			label:SetText(key)
			label:SetDark(true)
			label:SizeToContents()
			label:Dock(TOP)
		
		vPanel:DockPadding(8,0,8,0)
		vPanel:SizeToContents()
		PANEL:AddItem(vPanel)
	end
end

local _LAST_WEP

function KK_SCK_VELEMENTS_Think()
	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local wep = ply:GetActiveWeapon()
	
	if wep != _LAST_WEP then 
		updatePanel()
	end
	_LAST_WEP = wep
end

hook.Add("PopulateToolMenu", "KK_SCK_VELEMENTS", function()
	if GetConVarNumber("cw_kk_dev_menu") != 0 then 
		spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", "KK_SCK_VELEMENTS", "VElements", "", "", function(panel)
			PANEL = panel
			updatePanel()
			
			hook.Add("Think", "KK_SCK_VELEMENTS_Think", KK_SCK_VELEMENTS_Think)
		end)
	end
end)

hook.Add("PostReloadToolsMenu", "KK_SCK_VELEMENTS_Remove", function()
	hook.Remove("Think", "KK_SCK_VELEMENTS_Think")
end)

// DELETE BELOW // debug code
RunConsoleCommand("spawnmenu_reload")
