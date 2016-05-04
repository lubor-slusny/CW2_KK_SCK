AddCSLuaFile()

local cvXH = CreateClientConVar("cw_kk_gm_xhair", 0, false, false)
local cvFR = CreateClientConVar("cw_kk_freeze_reticles", 0, false, false)
local cvLA = CreateClientConVar("cw_kk_sck_lock_ads", 0, false, false)

hook.Add("Think", "cw_kk_gm_xhair_think", function()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	
	if cvXH:GetInt() == 1 then
		wep.DrawCrosshair = true
	else
		wep.DrawCrosshair = false
	end
end)

local _ADS_LAST
hook.Add("Think", "cw_kk_sck_lock_ads_think", function() 
	local cur = cvLA:GetInt()
	if cur != _ADS_LAST and _ADS_LAST != nil then
		if cur == 0 then
			RunConsoleCommand("-attack2")
		else
			RunConsoleCommand("+attack2")
		end
	end
	_ADS_LAST = cur
end)
