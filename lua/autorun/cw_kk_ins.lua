AddCSLuaFile()

CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.ins2 = CustomizableWeaponry_KK.ins2 or {}

CustomizableWeaponry_KK.ins2.magnifierDependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies or {}
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true

local SP = game.SinglePlayer()

CustomizableWeaponry_KK.ins2.baseContentMounted = function()
	return true
end

CustomizableWeaponry_KK.ins2.wsContentMounted = function()
	return 
		CustomizableWeaponry_KK.ins2.baseContentMounted() and
		CustomizableWeaponry_KK.ins2.ws
end

CustomizableWeaponry_KK.ins2.ww2ContentMounted = function()
	return 
		CustomizableWeaponry_KK.ins2.baseContentMounted() and
		true
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

if CLIENT then
	CreateClientConVar("cw_kk_add_epilepsy", 0, true, false) // for mental sickness
	
	local onceStarted
	
	hook.Add("RenderScene", "CW20_KK_Epilepsy-ator", function()
		if (GetConVarNumber("cw_kk_add_epilepsy") == 0) and not onceStarted then return end
		
		onceStarted = true
		
		for _,a in pairs(CustomizableWeaponry.registeredAttachments) do
			if a.description then
				for __,line in pairs(a.description) do
					line.c = Color(
						math.random(255),
						math.random(255),
						math.random(255),
						math.random(255) + 155
					)	
				end
			end
		end
	end)
end

if CLIENT then
	CustomizableWeaponry_KK.ins2.nodrawMat = CustomizableWeaponry_KK.ins2.nodrawMat or {}
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/4x_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/elcan_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/po4x_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mosin_crosshair"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mk4_crosshair"] = true
	
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/attachments/cw_kk_ins2_cstm_eotechxps/4x_reticule"] = true
end
