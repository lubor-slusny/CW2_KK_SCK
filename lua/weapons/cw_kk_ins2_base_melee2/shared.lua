if not CustomizableWeaponry then return end

AddCSLuaFile()

AddCSLuaFile("weapons/cw_extrema_ratio_official/shared.lua")
AddCSLuaFile("weapons/cw_melee_base/shared.lua")

include("weapons/cw_extrema_ratio_official/shared.lua")
include("weapons/cw_melee_base/shared.lua")

SWEP.Base = "cw_kk_ins2_base_main"

SWEP.SpeedDec = 0
SWEP.WeaponLength = 0

function SWEP:IndividualThink()	
	-- weapons.GetStored("cw_kk_ins2_base").IndividualThink(self)
	weapons.GetStored("cw_kk_ins2_base_main").IndividualThink(self)
	
	weapons.GetStored("cw_melee_base").IndividualThink(self)
end
