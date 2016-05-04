AddCSLuaFile()

if not CustomizableWeaponry then return end

// for the best

CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.ins2 = CustomizableWeaponry_KK.ins2 or {}

CustomizableWeaponry_KK.ins2.magnifierDependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies or {}
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true

// for noobs

local SP = game.SinglePlayer()

local baseFiles = {
	"models/weapons/v_marinebayonet.mdl",
	"models/weapons/v_mp5kpdw.mdl",
	"models/weapons/w_flare_projectile.mdl",
	"models/weapons/w_p2a1.mdl",
	"models/weapons/shells/40mm.mdl",
	"models/weapons/shells/556x45_link.phy",
	"models/weapons/upgrades/a_modkit_mosin.mdl",
	"models/weapons/upgrades/a_projectile_gp25.phy",
	"models/weapons/upgrades/a_projectile_gp25.phy",
	"models/weapons/upgrades/w_standard_ak74.mdl",
}

local baseOk

CustomizableWeaponry_KK.ins2.baseContentMounted = function()
	if baseOk == nil then
		local res = true
		
		for _,f in pairs(baseFiles) do
			res = res and file.Exists(f, "GAME")
		end
		
		baseOk = res
	end
	
	return baseOk
end

CustomizableWeaponry_KK.ins2.wsContentMounted = function()
	return 
		CustomizableWeaponry_KK.ins2.baseContentMounted() and
		CustomizableWeaponry_KK.ins2.ws
end

local DOIFiles = {
	"models/weapons/w_panzerfaust_projectile.mdl",
	"models/weapons/w_stielhandgranate.phy",
	"models/weapons/shells/garand_clip.phy",
	"models/weapons/upgrades/w_thompson_foregrip.mdl",
	"models/weapons/upgrades/a_standard_garand.mdl",
}

local DOIOk

CustomizableWeaponry_KK.ins2.ww2ContentMounted = function()
	if DOIOk == nil then
		local res = true
		
		for _,f in pairs(DOIFiles) do
			res = res and file.Exists(f, "GAME")
		end
		
		DOIOk = res
	end
	
	return 
		CustomizableWeaponry_KK.ins2.baseContentMounted() and
		DOIOk
end

// for me

for k, v in pairs(file.Find("autorun/cw_kk_ins/*", "LUA")) do
	AddCSLuaFile("autorun/cw_kk_ins/" .. v)
	include("autorun/cw_kk_ins/" .. v)
end

// for secsky lenses

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

// for mental sickness

if CLIENT then
	CreateClientConVar("cw_kk_add_epilepsy", 0, true, false)
	
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

// for... stuff

if CLIENT then
	CustomizableWeaponry_KK.ins2.nodrawMat = CustomizableWeaponry_KK.ins2.nodrawMat or {}
	-- CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/4x_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/elcan_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/po4x_reticule"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mosin_crosshair"] = true
	CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/optics/mk4_crosshair"] = true
	
	-- CustomizableWeaponry_KK.ins2.nodrawMat["models/weapons/attachments/cw_kk_ins2_cstm_eotechxps/4x_reticule"] = true
end
