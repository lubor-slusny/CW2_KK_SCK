AddCSLuaFile()

if not CustomizableWeaponry_KK then
	CustomizableWeaponry_KK = {}
end

if not CustomizableWeaponry_KK.ins2 then
	CustomizableWeaponry_KK.ins2 = {}
end

if not CustomizableWeaponry_KK.ins2.magnifierDependencies then
	CustomizableWeaponry_KK.ins2.magnifierDependencies = {}
	
	CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
	CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
	CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true
end

local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.contentMounted = function() // IsMounted("ins2") wont work, well fuck
	if !SP then 
		return CustomizableWeaponry and true
	else
		// read mount.cfg if possible
		// add some random file.exists checks mayb
		// steel bgo3 vmt reading - fopen; stringsub
		return CustomizableWeaponry and true
	end
end

if CLIENT then
	if not CustomizableWeaponry_KK.rts then
		CustomizableWeaponry_KK.rts = {}
	end

	CustomizableWeaponry_KK.rts.ins2_scope = GetRenderTarget("cw_kk_ins2_scope", 512, 512, false)
	CustomizableWeaponry_KK.rts.ins2_scope_init = true
end

AddCSLuaFile("cw_kk_ins/rigs.lua")
AddCSLuaFile("cw_kk_ins/rpgs.lua")
AddCSLuaFile("cw_kk_ins/stencil_sights.lua")
AddCSLuaFile("cw_kk_ins/quick_nades.lua")
AddCSLuaFile("cw_kk_ins/quick_knives.lua")
include("cw_kk_ins/rigs.lua")
include("cw_kk_ins/rpgs.lua")
include("cw_kk_ins/stencil_sights.lua")
include("cw_kk_ins/quick_nades.lua")
include("cw_kk_ins/quick_knives.lua")
