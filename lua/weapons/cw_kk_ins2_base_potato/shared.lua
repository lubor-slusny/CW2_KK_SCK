if not CustomizableWeaponry then return end

AddCSLuaFile()

SWEP.Base = "cw_kk_ins2_base_main"

SWEP.KKINS2Potato = true

local SP = game.SinglePlayer()
local MP = !SP

local cvarFA = GetConVar("cw_freeaim")
local cvarFAAC = GetConVar("cw_freeaim_autocenter")

local shouldDrawCrosshair, fa

function SWEP:IndividualThink()
	self.lastOwner = self.Owner

	self:IndividualThink_INS2()
	
	self:DrawShadow(false)
	
	self:doBoltAction()
	
	if CustomizableWeaponry_KK.ins2.hotPotato:getPotato(self) then
		if !self.Owner:KeyDown(IN_USE) then
			print(self.Owner, "throws", CustomizableWeaponry_KK.ins2.hotPotato:getPotato(self))
			
			CustomizableWeaponry_KK.ins2.hotPotato:throw(self)
		else
			local t = 0.5
			
			if CLIENT then
				self.GrenadePos.z = 0
				self.grenadeTime = CurTime() + t
			end
			
			self:forceState(CW_KK_QNADE, t, SP)
		end
	end
	
	if SERVER then
		self:checkProneStatus()
	end
	
	if CLIENT then
		fa = cvarFA:GetInt()
		fa = (fa == 1) and cvarFAAC:SetInt(fa)
		
		shouldDrawCrosshair = self.Owner:ShouldDrawLocalPlayer()
		self.CrosshairEnabled = shouldDrawCrosshair
		self.FadeCrosshairOnAim = !shouldDrawCrosshair
		
		if MP and not IsFirstTimePredicted() then return end
		
		self:updateReloadTimes()
		
		self:updateHands()
		self:updateBelt()
		self:updateOtherParts()
		
		self:playSwitchBipod()
		self:playHolsterTransitions()
	end
end

if CLIENT then
	
	function SWEP:createCustomVM(mdl)
		self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
		self.CW_VM:SetNoDraw(true)
		self.CW_VM:SetupBones()
		
		self.CW_KK_HANDS = self:createManagedCModel(self.CW_KK_HANDS_MDL, RENDERGROUP_BOTH)
		self.CW_KK_HANDS:SetNoDraw(true)
		self.CW_KK_HANDS:SetupBones()
		
		self.CW_KK_HANDS:SetParent(self.CW_VM)
		self.CW_KK_HANDS:AddEffects(EF_BONEMERGE)
		
		self.WMEnt = self:createManagedCModel(self.WorldModel, RENDERGROUP_BOTH)
		self.WMEnt:SetNoDraw(true)
	end

	function SWEP:drawViewModel()
		if not self.CW_VM then
			return
		end
		
		self:offsetBones()
		
		FT = FrameTime()
		
		self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 0, FT * 10 * self.LuaVMRecoilLowerSpeed)
		self.LuaVMRecoilLowerSpeed = math.Approach(self.LuaVMRecoilLowerSpeed, 1, FT * 2)
		
		self:applyOffsetToVM()
		self:_drawViewModel()
	end

	local cvAmmoHud = GetConVar("cw_customhud_ammo")
	local cvSVM = GetConVar("cw_kk_ins2_shell_vm")

	function SWEP:_drawViewModel()
		self.CW_VM:FrameAdvance(FrameTime())
		self.CW_VM:SetupBones()
		self.CW_VM:DrawModel()
		
		self.CW_KK_HANDS:SetPos(self.CW_VM:GetPos())
		self.CW_KK_HANDS:DrawModel()
		
		local CT = CurTime()
		
		if CT > self.grenadeTime and CT > self.knifeTime then
			if cvSVM:GetInt() == 1 then
				self:drawVMShells()
			end
			
			self:drawAttachments()
			self:drawInteractionMenu()
			
			if self.reticleFunc then
				self.reticleFunc(self)
			end
			
			if cvAmmoHud:GetInt() >= 1 then
				self:draw3D2DHUD()
			end
		end
	end
	
	
end
