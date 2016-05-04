AddCSLuaFile()

--[[

Custom Viewmodel Tools
By Spy (LEETNOOB on FP)
Made mainly for easier reload sound script set up

]]--

local dst = draw.SimpleText
CreateClientConVar("cvmt_enabled", 0, true, true)
CreateClientConVar("cvmt_animlist", 0, true, true)
CreateClientConVar("cvmt_animlist_numbers", 0, true, true)

surface.CreateFont("CVMT_24", {font = "Default", size = 24, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CVMT_12", {font = "Default", size = 12, weight = 700, blursize = 0, antialias = true, shadow = false})

function draw.ShadowText(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
	dst(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
	dst(text, font, x, y, colortext, xalign, yalign)
end

local ShadowText = draw.ShadowText

local ply, wep, ent, cyc, seqdur, x, y, seqlist, amt
local White, Black = Color(255, 255, 255, 255), Color(0, 0, 0, 255)

local function CVMT_GetClientsideViewmodel(wep)
	if IsValid(wep.Wep) then -- FA:S 2.0 SWEPs
		return wep.Wep
	elseif IsValid(wep.LeftMdl) then -- Dual Weapons
		return wep.LeftMdl
	elseif IsValid(wep.CW_VM) then -- CW 2.0
		return wep.CW_VM
	end
	
	return nil
end

local function CVMT_HUDPaint()
	if GetConVarNumber("cvmt_enabled") > 0 then
		ply = LocalPlayer()
		
		if ply:Alive() then
			wep = ply:GetActiveWeapon()
			x, y = ScrW(), ScrH()
			
			if IsValid(wep) then
				ent = CVMT_GetClientsideViewmodel(wep)
				
				if ent then
					cyc = ent:GetCycle()
					seqdur = ent:SequenceDuration()
					
					ShadowText("Animation: " .. ent:GetSequenceName(ent:GetSequence()), "CVMT_24", x * 0.5, y * 0.5 - 250, White, Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					ShadowText("Playback rate: " .. ent:GetPlaybackRate() .. "x", "CVMT_24", x * 0.5, y * 0.5 - 225, White, Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					ShadowText("Cycle: " .. math.Round(cyc, 3), "CVMT_24", x * 0.5, y * 0.5 - 200, White, Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					ShadowText("Duration: " .. math.Round(seqdur, 2) .. " seconds", "CVMT_24", x * 0.5, y * 0.5 - 175, White, Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					ShadowText("Seek: " .. math.Round(seqdur * cyc, 2) .. " seconds", "CVMT_24", x * 0.5, y * 0.5 - 150, White, Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					
					if GetConVarNumber("cvmt_animlist") > 0 then
						seqlist = ent:GetSequenceList()
						amt = #seqlist

						for k, v in pairs(seqlist) do
							k = k - 1
							if GetConVarNumber("cvmt_animlist_numbers") > 0 then
								ShadowText(k + 1 .. "#  " .. v, "CVMT_12", x * 0.5 - 300, y * 0.5 - k * 12 + amt * 6, White, Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
							else	
								ShadowText(v, "CVMT_12", x * 0.5 - 300, y * 0.5 - k * 12 + amt * 6, White, Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
							end
						end
					end
				end
			end
		end
	end
end

hook.Add("HUDPaint", "CVMT_HUDPaint", CVMT_HUDPaint)

local Blue, Green = Color(100, 200, 255, 255), Color(200, 255, 200, 255)

local function CVMT_Freeze(ply, com, args)
	ply = LocalPlayer()
	
	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		x, y = ScrW(), ScrH()
		
		if IsValid(wep) then
			ent = CVMT_GetClientsideViewmodel(wep)
			
			if ent then
				if ent.LastPlaybackRate then
					ent:SetPlaybackRate(ent.LastPlaybackRate)
					ent.LastPlaybackRate = nil
				else
					ent.LastPlaybackRate = ent:GetPlaybackRate()
					ent:SetPlaybackRate(0)
				end
			end
		end
	end
end

concommand.Add("cvmt_freeze", CVMT_Freeze)

local function CVMT_SetCycle(ply, com, args)
	if not args[1] then
		chat.AddText(
			Green, "Sets the animation cycle to the desired value.\n\nUsage:\n", 
			Blue, "first argument - ", White, "animation cycle (0 is 0%, 0.5 is 50%, 1 is 100%)"
		)
	end
	
	ply = LocalPlayer()
	
	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		x, y = ScrW(), ScrH()
		
		if IsValid(wep) then
			ent = CVMT_GetClientsideViewmodel(wep)
			
			if ent then
				ent:SetCycle((args[1] and tonumber(args[1]) or 0))
			end
		end
	end
end

concommand.Add("cvmt_setcycle", CVMT_SetCycle)

local function CVMT_Seek(ply, com, args)
	if not args[1] then
		chat.AddText(
			Green, "Seeks to the desired second of the animation\n\nUsage:\n", 
			Blue, "first argument - ", White, "second to seek to"
		)
	end
	
	ply = LocalPlayer()
	
	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		x, y = ScrW(), ScrH()
		
		if IsValid(wep) then
			if IsValid(wep.Wep) then
				ent = wep.Wep
			elseif IsValid(wep.LeftMdl) then
				ent = wep.LeftMdl
			end
			
			if ent then
				ent:SetPlaybackRate((args[1] and tonumber(args[1]) or 1))
				
				local seqDur = ent:SequenceDuration()
				ent:SetCycle(math.Clamp(args[1] / seqDur, 0, 1))
			end
		end
	end
end

concommand.Add("cvmt_seek", CVMT_Seek)

local function CVMT_SetPlaybackRate(ply, com, args)
	if not args[1] then
		chat.AddText(
			Green, "Sets the animation's playback rate (speed)\n\nUsage:\n", 
			Blue, "first argument - ", White, "playback rate to set to, in percentage (0 is 0%, 1 is 100%)"
		)
	end
	
	ply = LocalPlayer()
	
	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		x, y = ScrW(), ScrH()
		
		if IsValid(wep) then
			if IsValid(wep.Wep) then
				ent = wep.Wep
			elseif IsValid(wep.LeftMdl) then
				ent = wep.LeftMdl
			end
			
			if ent then
				ent:SetPlaybackRate((args[1] and tonumber(args[1]) or 1))
			end
		end
	end
end

concommand.Add("cvmt_setplaybackrate", CVMT_SetPlaybackRate)

local function CVMT_PlayAnimation(ply, com, args)
	if not args[1] then
		chat.AddText(
			Green, "Sets the animation along with optional desired animation cycle and playback rates.\n\nUsage:\n", 
			Blue, "first argument - ", White, "animation name",
			Blue, "\n(OPTIONAL) second argument - ", White, "animation cycle",
			Blue, "\n(OPTIONAL) third argument - ", White, "playback rate"
		)
	end
	
	ply = LocalPlayer()
	
	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		x, y = ScrW(), ScrH()
		
		if IsValid(wep) then
			if IsValid(wep.Wep) then
				ent = wep.Wep
			elseif IsValid(wep.LeftMdl) then
				ent = wep.LeftMdl
			end
			
			if ent then
				ent:SetCycle((args[2] and tonumber(args[2]) or 0))
				ent:SetSequence(args[1])
				ent:SetPlaybackRate((args[3] and tonumber(args[3]) or 1))
			end
		end
	end
end

concommand.Add("cvmt_playanim", CVMT_PlayAnimation)

local function CVMT_PlayAnimation_Freeze(ply, com, args)
	if not args[1] then
		chat.AddText(
			Green, "Freezes and plays the desired animation.\n\nUsage:\n", 
			Blue, "first argument - ", White, "animation name",
			Blue, "\n(OPTIONAL) second argument - ", White, "animation cycle"
		)
	end
	
	ply = LocalPlayer()
	
	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		x, y = ScrW(), ScrH()
		
		if IsValid(wep) then
			if IsValid(wep.Wep) then
				ent = wep.Wep
			elseif IsValid(wep.LeftMdl) then
				ent = wep.LeftMdl
			end
			
			if ent then
				ent:SetCycle((args[2] and tonumber(args[2]) or 0))
				ent:SetSequence(args[1])
				ent:SetPlaybackRate(0)
			end
		end
	end
end

concommand.Add("cvmt_playanim_freeze", CVMT_PlayAnimation_Freeze)