
SWEP._kk_active_ounter = true

if CLIENT then	
	SWEP._generator_1337 = {}
	SWEP._generator_1337.frames = {1337,13370,133700,13370}
	SWEP._generator_1337.frameStr = {"001337","013370","133700","013370"}
	SWEP._generator_1337.frameCount = table.Count(SWEP._generator_1337.frames)
	SWEP._generator_1337.i = 0
	SWEP._generator_1337.nextFrame = 0
	
	function SWEP._generator_1337:Think() 
		if UnPredictedCurTime() > self.nextFrame then
			self.nextFrame = UnPredictedCurTime() + 0.1
			
			if self.i == self.frameCount then
				self.i = 1
			else
				self.i = self.i + 1
			end
		end
	end
	
	function SWEP._generator_1337:GetInt()
		self:Think()
		return self.frames[self.i]
	end
	
	function SWEP._generator_1337:GetString() 
		self:Think()
		return self.frameStr[self.i]
	end
	
	SWEP._generator_boobies = {}
	SWEP._generator_boobies.frames = {000000,000008,000080,000800,008008,080081,800813,0081350,0813500,813500,135000,350000,500000,000000}
	SWEP._generator_boobies.frameStr = {"000000","000008","000080","000800","008008","080081","800813","0081350","0813500","813500","135000","350000","500000","000000"}
	SWEP._generator_boobies.frameCount = table.Count(SWEP._generator_boobies.frames)
	SWEP._generator_boobies.i = 0
	SWEP._generator_boobies.nextFrame = 0
	
	function SWEP._generator_boobies:Think() 
		if UnPredictedCurTime() > self.nextFrame then
			self.nextFrame = UnPredictedCurTime() + 0.075
			
			if self.i == self.frameCount then
				self.i = 1
			else
				self.i = self.i + 1
			end
		end
	end
	
	function SWEP._generator_boobies:GetInt()
		self:Think()
		return self.frames[self.i]
	end
	
	function SWEP._generator_boobies:GetString() 
		self:Think()
		return self.frameStr[self.i]
	end
	
	local cyc, p
	
	function SWEP:updateOtherParts()
		cyc = self.CW_VM:GetCycle()
		
		if self.Sequence == self.Animations.base_pickup and cyc < 0.99 then
			p = 1 - ((1 - math.Clamp(cyc, 0.5, 1)) / 0.5)
			
			self.AttachmentModelsVM.kk_counter_back.pos.z = p * 2.131
		else
			self.AttachmentModelsVM.kk_counter_back.pos.z = 2.131
		end
	end
	
	local ent, raw
	
	function SWEP:drawCounter(num, id)
		ent = self.AttachmentModelsVM[id].ent
		
		if num then
			raw = num:GetInt()
			
			ent:SetBodygroup(1,0)
			
			ent._KKCSGONUM = raw
			
			ent:DrawModel()
		else
			ent:SetBodygroup(1,1)
		end
	end
end

function SWEP:IndividualInitialize()
	CustomizableWeaponry_KK.stattrack.createCvar(self)
	CustomizableWeaponry.actionSequence.new(self, 3, nil, function()
		self.kk_counter_kills = self.Owner:GetInfoNum(self.kk_counter_cvar, -1)
	end)

	if CLIENT then
		self._generator_counter = {}
		
		local cvar = self.kk_counter_cvar
		local cvarObj = GetConVar(cvar)
		
		function self._generator_counter:GetString()
			return cvarObj and string.format("%06d", cvarObj:GetInt())
		end
		
		function self._generator_counter:GetInt()
			return cvarObj and cvarObj:GetInt()
		end
		
		function self.elementRender:kk_counter()
			self:drawCounter(self._generator_counter, "kk_counter_mid")
			self:drawCounter(self._generator_1337, "kk_counter_front")
			self:drawCounter(self._generator_boobies, "kk_counter_back")
		end
	end
end
