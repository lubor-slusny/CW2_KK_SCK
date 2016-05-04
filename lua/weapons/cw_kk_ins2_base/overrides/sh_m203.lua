
local SP = game.SinglePlayer()

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local GetAimVector = reg.Player.GetAimVector

function SWEP:fireM203(firstTimePrediction)
	if SERVER and SP then
		SendUserMessage("CW20_FIREM203", self.Owner)
	end
	
	self:delayEverything(0.6)
	self:setGlobalDelay(0.6)
	
	CustomizableWeaponry.grenadeTypes.selectFireFunc(self, firstTimePrediction)
	
	if self:filterPrediction() then
		self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
	end
	
	local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(wep, "shouldSuppressAmmoUsage")

	if not suppressAmmoUsage then
		self.M203Chamber = false
		
		CustomizableWeaponry.callbacks.processCategory(wep, "postConsumeAmmo")
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if CLIENT then
		self:makeVMRecoil(5)
		
		local vm = self.CW_VM
		local attId = vm:LookupAttachment("muzzle_gl")
		
		if attId == 0 then
			if self.AttachmentModelsVM.kk_ins2_gl_gp25 then
				vm = self.AttachmentModelsVM.kk_ins2_gl_gp25.ent
			elseif self.AttachmentModelsVM.kk_ins2_gl_m203 then
				vm = self.AttachmentModelsVM.kk_ins2_gl_m203.ent
			end
			
			attId = 1
		end
		
		-- ParticleEffectAttach("muzzleflash_m3", PATTACH_POINT_FOLLOW, vm, attId)
		
		if self.AttachmentModelsVM.kk_ins2_gl_gp25 then
			ParticleEffectAttach("muzzleflash_pistol", PATTACH_POINT_FOLLOW, self.AttachmentModelsWM.kk_ins2_gl_gp25.ent, 1)
		elseif self.AttachmentModelsVM.kk_ins2_gl_m203 then
			ParticleEffectAttach("muzzleflash_pistol", PATTACH_POINT_FOLLOW, self.AttachmentModelsWM.kk_ins2_gl_m203.ent, 1)
		end
	end
end

CW_KK_INS_M203_RELOAD = {}

function CW_KK_INS_M203_RELOAD:doIt()
	if SERVER and SP then
		SendUserMessage("CW20_RELOADM203", self.Owner)
	end
	
	self:setGlobalDelay(self.gl_on_ReloadHalt or 2.6)
	
	if CLIENT and self.ActiveAttachments.kk_ins2_gl_m203 then
		CustomizableWeaponry.actionSequence.new(self, 1.18, nil, function()
			local att = self.AttachmentModelsVM.kk_ins2_gl_m203.ent:GetAttachment(2)
		
			local dir = att.Ang:Forward()
			local pos = att.Pos + dir * 10
		
			local ang = self.Owner:EyeAngles()
			ang:RotateAroundAxis(ang:Up(), 180)
			
			self._shellTable = CustomizableWeaponry.shells:getShell("KK_INS2_40mm")
				CustomizableWeaponry.shells.make(self, pos, ang, Vector(0,0,1), 0.6, 10)
			self._shellTable = CustomizableWeaponry.shells:getShell(self.Shell)
		end)
	end
	
	CustomizableWeaponry.actionSequence.new(self, self.gl_on_ReloadTime or 2, nil, function()
		if SERVER then
			self.Owner:RemoveAmmo(1, "40MM")
		end
		
		self.M203Chamber = true
	end)
end

function SWEP:reloadM203()
	CW_KK_INS_M203_RELOAD.doIt(self)
end

// GL unloading upon changing ammo

function SWEP:unloadM203()
	if not self.M203Chamber then return end

	self.M203Chamber = false
	
	if SERVER then
		self.Owner:GiveAmmo(1, "40MM", true)
		SendUserMessage("CWKK_UNLOADM203", self.Owner)
	end	
end

if CLIENT then
	usermessage.Hook("CWKK_UNLOADM203", function()
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) or not wep.CW20Weapon then return end
			
		wep:unloadM203()
	end)
end

if SERVER then
	function SWEP:cycle40MMGrenades()
		CustomizableWeaponry.grenadeTypes.cycleGrenades(self)
		
		self:unloadM203()
		
		umsg.Start("CW20_GRENADETYPE", self.Owner)
			umsg.Short(self.Grenade40MM)
		umsg.End()
	end
end
