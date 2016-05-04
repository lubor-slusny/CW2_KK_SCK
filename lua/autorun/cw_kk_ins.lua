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

AddCSLuaFile("cw_kk_ins/rigs.lua")
AddCSLuaFile("cw_kk_ins/rpgs.lua")
AddCSLuaFile("cw_kk_ins/stencil_sights.lua")
AddCSLuaFile("cw_kk_ins/render_targets.lua")
AddCSLuaFile("cw_kk_ins/quick_nades.lua")
AddCSLuaFile("cw_kk_ins/quick_knives.lua")
include("cw_kk_ins/rigs.lua")
include("cw_kk_ins/rpgs.lua")
include("cw_kk_ins/stencil_sights.lua")
include("cw_kk_ins/render_targets.lua")
include("cw_kk_ins/quick_nades.lua")
include("cw_kk_ins/quick_knives.lua")

if CLIENT then
	matproxy.Add({
		name = "IronsightVectorResult",
		
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
			self.ResultBase = Vector(values.resultdefault)
			self.ResultAdd = Vector(values.resultzoomed) - self.ResultBase
		end,
		
		bind = function(self, mat, ent)
			if !IsValid(ent) then return end
			
			local mul = ent._cw_kk_ins2_matproxy_mul or 0.5
			
			if IsValid(ent._SWEP) and ent._SWEP.CW20Weapon and ent._SWEP:isAiming() then
				mul = math.Approach(mul, 1, FrameTime() * 2)
			else
				mul = math.Approach(mul, 0, FrameTime() * 2)
			end
			
			ent._cw_kk_ins2_matproxy_mul = mul
			mat:SetVector(self.ResultTo, self.ResultBase + mul * self.ResultAdd)
		end
	})
end
