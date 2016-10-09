if not CustomizableWeaponry then return end

AddCSLuaFile()

if CustomizableWeaponry_KK.HOME then
	SWEP.Base = "cw_kk_ins2_base_potato"
else
	SWEP.Base = "cw_kk_ins2_base_main"
end
