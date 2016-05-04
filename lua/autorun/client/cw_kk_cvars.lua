AddCSLuaFile()

CreateClientConVar("cw_kk_gm_xhair", 0, false, false)
CreateClientConVar("cw_kk_freeze_reticles", 0, false, false)
CreateClientConVar("cw_kk_sck_lock_ads", 0, false, false)
CreateClientConVar("cw_kk_dev_menu", 0, true, false)

hook.Add("Think", "CW_KK_ThinkWithCrosshairs", function()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	
	if GetConVarNumber("cw_kk_gm_xhair") == 0 then
		wep.DrawCrosshair = false
	else
		wep.DrawCrosshair = true
	end
end)

local _ADS_LAST
hook.Add("Think", "CW_KK_LockAiming", function() 
	local cur = GetConVarNumber("cw_kk_sck_lock_ads")
	if cur != _ADS_LAST and _ADS_LAST != nil then
		if cur == 0 then
			RunConsoleCommand("-attack2")
		else
			RunConsoleCommand("+attack2")
		end
	end
	_ADS_LAST = cur
end)

cvars.AddChangeCallback("cw_kk_dev_menu", function(name, old, new)
	if old != new then
		RunConsoleCommand("spawnmenu_reload")
	end
end, "cw_kk_dev_menu_callback")
