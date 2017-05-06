
local math_approach = math.Approach

if CLIENT then
	CustomizableWeaponry_KK.ins2.matproxy = CustomizableWeaponry_KK.ins2.matproxy or {}
	
	CustomizableWeaponry_KK.ins2.matproxy.lense = CustomizableWeaponry_KK.ins2.matproxy.lense or {}
	
	CustomizableWeaponry_KK.ins2.matproxy.lense.name = "IronsightVectorResult"
	
	function CustomizableWeaponry_KK.ins2.matproxy.lense:init(mat, values)
		self.mults = {}
		
		self.ResultTo = values.resultvar
		self.ResultBase = Vector(values.resultdefault)
		self.ResultAdd = Vector(values.resultzoomed) - self.ResultBase
	end
	
	function CustomizableWeaponry_KK.ins2.matproxy.lense:bind(mat, ent)
		if !IsValid(ent) then return end
		
		local mul = self.mults[ent] or 0.5
		
		if IsValid(ent.wepParent) and ent.wepParent.CW20Weapon and ent.wepParent:isAiming() then
			mul = math_approach(mul, 1, FrameTime() * 2)
		else
			mul = math_approach(mul, 0, FrameTime() * 2)
		end
		
		mat:SetVector(self.ResultTo, self.ResultBase + mul * self.ResultAdd)
		self.mults[ent] = mul
	end
	
	matproxy.Add(CustomizableWeaponry_KK.ins2.matproxy.lense)
end
