
//-----------------------------------------------------------------------------
// getMuzzlePosition edited to be usable in third person
//-----------------------------------------------------------------------------

local att, vm

local muz = {}

function SWEP:getMuzzlePosition()
	if self.Owner:ShouldDrawLocalPlayer() then
		muz.Pos = self.WMEnt:GetAttachment(1).Pos
		muz.Ang = EyeAngles()
		return muz
	end
	
	if self.MuzzleAttachment != 0 then
		return self.CW_VM:GetAttachment(self.MuzzleAttachment)
	end
	
	muz.Pos = self.Owner:EyePos()
	muz.Ang = self.Owner:EyeAngles()
	return muz
end

//-----------------------------------------------------------------------------
// LookupBone("[__INVALIDBONE__]") returns nil 
// so I store int that I used with GetBoneName
//-----------------------------------------------------------------------------

function SWEP:buildBoneTable()
	local vm = self.CW_VM
	
	for i = 0, vm:GetBoneCount() - 1 do
		local boneName = vm:GetBoneName(i)
		local bone
		
		if boneName then
			bone = vm:LookupBone(boneName)
		end
		
		-- some ins models have [__INVALIDBONE__]s so to prevent nilpointerexceptions bone = 1
		self.vmBones[i + 1] = {boneName = boneName, bone = i, curPos = Vector(0, 0, 0), curAng = Angle(0, 0, 0), targetPos = Vector(0, 0, 0), targetAng = Angle(0, 0, 0)}
	end
end

//-----------------------------------------------------------------------------
// createCustomVM edited to initialize additional models
//-----------------------------------------------------------------------------

function SWEP:createCustomVM(mdl)
	self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
	self.CW_VM:SetNoDraw(true)
	self.CW_VM:SetupBones()
	
	self.CW_VM:SelectWeightedSequence(ACT_VM_HOLSTER)
	self.CW_VM:SetCycle(1)
	
	self.CW_KK_HANDS = self:createManagedCModel(self.CW_KK_HANDS_MDL, RENDERGROUP_BOTH)
	self.CW_KK_HANDS:SetNoDraw(true)
	self.CW_KK_HANDS:SetupBones()
	
	self.CW_KK_HANDS:SetParent(self.CW_VM)
	self.CW_KK_HANDS:AddEffects(EF_BONEMERGE)
	-- self.CW_KK_HANDS:AddEffects(EF_BONEMERGE_FASTCULL)
	
	self.CW_GREN = self:createManagedCModel(self.CW_GREN_TWEAK.vm, RENDERGROUP_BOTH)
	self.CW_GREN:SetNoDraw(true)
	self.CW_GREN:SetupBones()
	
	self.CW_KK_KNIFE = self:createManagedCModel(self.CW_KK_KNIFE_TWEAK.vm, RENDERGROUP_BOTH)
	self.CW_KK_KNIFE:SetNoDraw(true)
	self.CW_KK_KNIFE:SetupBones()
	
	// not rly a viewmodel but still need to stick it somewhere
	
	self.WMEnt = self:createManagedCModel(self.WorldModel, RENDERGROUP_BOTH)
	self.WMEnt:SetNoDraw(true)
end

//-----------------------------------------------------------------------------
// drawViewModel edited to draw quick knife viewmodel
//-----------------------------------------------------------------------------

local FT

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
	
	self:drawGrenade()
	self:drawKKKnife()
end

//-----------------------------------------------------------------------------
// _drawViewModel edited to draw hands-model entity and viewmodel shells
//-----------------------------------------------------------------------------

local cvAmmoHud = GetConVar("cw_customhud_ammo")
local cvSVM = GetConVar("cw_kk_ins2_shell_vm")

function SWEP:_drawViewModel()
	self.CW_VM:FrameAdvance(FrameTime())
	self.CW_VM:SetupBones()
	self.CW_VM:DrawModel()
	
	local CT = CurTime()
	
	if CT > self.grenadeTime and CT > self.knifeTime then
		self.CW_KK_HANDS:SetPos(self.CW_VM:GetPos())
		
		self.CW_KK_HANDS:SetParent(self.CW_VM)
		self.CW_KK_HANDS:DrawModel()
	end
			
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

//-----------------------------------------------------------------------------
// createGrenadeModel contents moved to createCustomVM
//-----------------------------------------------------------------------------

function SWEP:createGrenadeModel() end

//-----------------------------------------------------------------------------
// drawGrenade edited to draw hands-model entity
//-----------------------------------------------------------------------------

local pos, ang

function SWEP:drawGrenade()
	if CurTime() > self.grenadeTime then
		return
	end
	
	if self.CW_GREN:GetCycle() >= 0.98 then
		return
	end
	
	pos, ang = EyePos(), EyeAngles()
	
	self.GrenadePos.z = Lerp(FrameTime() * 10, self.GrenadePos.z, 0)
	
	pos = pos + ang:Up() * self.GrenadePos.z
	pos = pos + ang:Forward() * 2
	
	self.CW_GREN:SetPos(pos)
	self.CW_GREN:SetAngles(ang)
	self.CW_GREN:FrameAdvance(FrameTime())
	
	cam.IgnoreZ(true)
		self.CW_GREN:DrawModel()
		self.CW_KK_HANDS:DrawModel()
	cam.IgnoreZ(false)
end

//-----------------------------------------------------------------------------
// drawKKKnife contents temporarily stored in global table
//-----------------------------------------------------------------------------

function SWEP:drawKKKnife()
	CustomizableWeaponry_KK.ins2.quickKnife.drawVM(self)
end

//-----------------------------------------------------------------------------
// setupAttachmentModels edited to support 
// - custom attach points
// - globally pre-set sub-material override
// - individually set material override
// - WElement init
//-----------------------------------------------------------------------------

function SWEP:setupAttachmentModels()
	if self.AttachmentModelsVM then
		for k, v in pairs(self.AttachmentModelsVM) do
			v.ent = self:createManagedCModel(v.model, RENDERGROUP_BOTH)
			v.ent:SetNoDraw(true)
			
			v.active = v.active or false
			v.nodraw = v.nodraw or false
			
			v.matrix = Matrix()
			
			-- v.pos.y = -v.pos.y
			-- v.matrix:Translate(v.pos)
			-- v.matrix:Rotate(v.angle)
				
			if v.size then
				v.matrix:Scale(v.size)
			end
			
			v.ent:EnableMatrix("RenderMultiply", v.matrix)
			
			if v.bodygroups then
				for main, sec in pairs(v.bodygroups) do
					v.ent:SetBodygroup(main, sec)
				end
			end
			
			if v.skin then
				v:SetSkin(v.skin)
			end
			
			v.ent:SetupBones()
		
			if v.merge then
				v.ent:SetParent(self.CW_VM)
				v.ent:AddEffects(EF_BONEMERGE)
			end
			
			if v.attachment then
				v._attachment = self.CW_VM:LookupAttachment(v.attachment)
			end
			
			if v.bone then
				v._bone = self.CW_VM:LookupBone(v.bone)
			end
			
			for i,mat in pairs(v.ent:GetMaterials()) do
				if CustomizableWeaponry_KK.ins2.nodrawMat[mat] then
					v.ent:SetSubMaterial(i - 1, "models/weapons/attachments/cw_kk_ins2_shared/nodraw")
				end
			end
			
			if v.material then 
				v.ent:SetMaterial(v.material)
			end
		end
	end
	
	self:setupAttachmentWModels()
end

//-----------------------------------------------------------------------------
// drawAttachments edited to support custom attach points
//-----------------------------------------------------------------------------

local active, pos, ang, m, vma, model

function SWEP:drawAttachments()
	if not self.AttachmentModelsVM then
		return false
	end
	
	for k, v in pairs(self.AttachmentModelsVM) do
		-- if type(v.active) == "function" then
			-- active = v.active(self)
		-- else
			active = v.active
		-- end
	
		if v.ent and active then
			if v.merge then				// this was an attempt to unfuck lighting on certain velements
				-- pos = EyePos()		// css rig now seem to be working fine witout it 
				-- ang = EyeAngles()	// aimpoint2x was always messed up
			elseif v._attachment then
				vma = self.CW_VM:GetAttachment(v._attachment)
				pos = vma.Pos
				ang = vma.Ang
			elseif v._bone then
				m = self.CW_VM:GetBoneMatrix(v._bone)
				pos = m:GetTranslation()
				ang = m:GetAngles()
			end
			
			model = v.ent
			
			if not v.merge then			// FOR STENCILS, EVERYTHING
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
				
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				
				-- model:SetPos(pos)
				-- model:SetAngles(ang)
			end
			
			if v.animated then
				model:FrameAdvance(FrameTime())
				model:SetupBones()
			end
			
			if !v.nodraw then
				model:DrawModel()
			end
		end
	end
	
	for k, v in pairs(self.elementRender) do
		v(self)
	end
	
	return true
end

//-----------------------------------------------------------------------------
// DrawWorldModel edited to support
// - attachment world models (WElements)
// - 3rd person 3D2D HUD
//-----------------------------------------------------------------------------

local GetBonePosition = debug.getregistry().Entity.GetBonePosition
local LookupBone = debug.getregistry().Entity.LookupBone

function SWEP:DrawWorldModel()
	if self.dt.Safe then
		if self.CHoldType != self.RunHoldType then
			self:SetHoldType(self.RunHoldType)
			self.CHoldType = self.RunHoldType
		end
	else
		if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.CHoldType != self.NormalHoldType then
				self:SetHoldType(self.NormalHoldType)
				self.CHoldType = self.NormalHoldType
			end
		end
	end
	
	pos, ang = self:GetPos(), self:GetAngles()
	
	if IsValid(self.Owner) then
		self:DrawShadow(false)
		-- self:RemoveEffects(EF_BONEMERGE) // probably needs to be called on server
		
		pos, ang = GetBonePosition(self.Owner, LookupBone(self.Owner, "ValveBiped.Bip01_R_Hand"))
		
		pos = (pos + ang:Forward() * self.WMPos.x + ang:Right() * self.WMPos.y + ang:Up() * self.WMPos.z)
		ang:RotateAroundAxis(ang:Up(), self.WMAng.y)
		ang:RotateAroundAxis(ang:Right(), self.WMAng.x)
		ang:RotateAroundAxis(ang:Forward(), self.WMAng.z)
	
		-- self:SetPos(pos)			
		-- self:SetAngles(ang)
	end
	
	if !IsValid(self.WMEnt) then
		return
	end
	
	self.WMEnt:SetPos(pos)			// kept for cw_muzzleflash effect 	
	self.WMEnt:SetAngles(ang)		// even if I keep calling RemoveBoneMerge - get:attachment still returns crotchpos
	
	-- if !self.DrawCustomWM then
		-- self:RemoveEffects(EF_BONEMERGE)
		-- self:DrawModel()
		-- self:drawAttachmentsWorld(self)
	-- else
		self.WMEnt:DrawModel()
		self.WMEnt:DrawShadow(true)
		self:drawAttachmentsWorld(self.WMEnt)
	-- end
	
	self.HUD_3D2DScale = self.HUD_3D2DScale * 1.5
	self.CustomizationMenuScale = self.CustomizationMenuScale * 1.5
	
	if IsValid(self.Owner) and self.Owner == LocalPlayer() then
		cam.IgnoreZ(true)
		self:drawInteractionMenu()
		if cvAmmoHud:GetInt() >= 1 then
			self:draw3D2DHUD()
		end
		cam.IgnoreZ(false)
	end
	
	self.HUD_3D2DScale = self.HUD_3D2DScale / 1.5
	self.CustomizationMenuScale = self.CustomizationMenuScale / 1.5
end

//-----------------------------------------------------------------------------
// initialize attachment world models (WElements) 
//-----------------------------------------------------------------------------

function SWEP:setupAttachmentWModels()
	if self.AttachmentModelsWM then
		self:SetupBones()
		
		for k, v in pairs(self.AttachmentModelsWM) do
			v.ent = self:createManagedCModel(v.model, RENDERGROUP_BOTH)
			v.ent:SetNoDraw(true)
			
			v.active = v.active or false
			
			if v.size then
				v.matrix = Matrix()
				
				v.matrix:Scale(v.size)
				v.ent:EnableMatrix("RenderMultiply", v.matrix)
			end
			
			if v.bodygroups then
				for main, sec in pairs(v.bodygroups) do
					v.ent:SetBodygroup(main, sec)
				end
			end
			
			if v.skin then
				v:SetSkin(v.skin)
			end
			
			v.ent:SetupBones()
		end
	end
end

//-----------------------------------------------------------------------------
// draw attachment world models (WElements) 
//-----------------------------------------------------------------------------

function SWEP:drawAttachmentsWorld(parent)	
	if self.AttachmentModelsWM then
		-- if self.AttachmentModelsVM then
			-- for k,v in pairs(self.AttachmentModelsVM) do
				-- if self.AttachmentModelsWM[k] then
					-- self.AttachmentModelsWM[k].active = v.active
				-- end
			-- end
		-- end
		
		for k, v in pairs(self.AttachmentModelsWM) do
			if v.ent and v.active then
				model = v.ent
				
				if v.merge then
					model:SetParent(parent)
					model:AddEffects(EF_BONEMERGE)
					pos = parent:GetPos()
					ang = parent:GetAngles()
				elseif v.attachment then
					vma = parent:GetAttachment(parent:LookupAttachment(v.attachment)) // fuck savings
					pos = vma.Pos
					ang = vma.Ang
				elseif v.bone then
					m = parent:GetBoneMatrix(parent:LookupBone(v.bone)) // especially when bones doesnt seem to get set up when you dont spawn weapon on the ground first
					pos = m:GetTranslation()
					ang = m:GetAngles()
				end
				
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
				
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				
				if !v.nodraw then
					model:DrawModel()
				end
			end
		end
	end
end

//-----------------------------------------------------------------------------
// processFOVChanges edited to take dt.INS2GLActive into account
//-----------------------------------------------------------------------------

function SWEP:processFOVChanges(deltaTime)
	if self.dt.State == CW_AIMING then
		if self.dt.INS2GLActive then
			self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, 60)
		else
			if self.AimPos == self.SightBackUpPos and self.AimAng == self.SightBackUpAng then
				self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.AimViewModelFOV_Orig)
			else
				self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.AimViewModelFOV)
			end
		end
	else
		self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.ViewModelFOV_Orig)
	end
	
	self.ViewModelFOV = self.CurVMFOV
end

//-----------------------------------------------------------------------------
// scaleMovement edited to use sprint state dependent base values 
//-----------------------------------------------------------------------------

function SWEP:scaleMovement(val, mod)
	local scale = self.ViewModelMovementScale
	
	if self.Slot != 2 and self.Slot != 3 then
		if self.Sequence:find("sprint") then
			scale = self.ViewModelMovementScale_sprint
		else
			scale = self.ViewModelMovementScale_base
		end
	end
	
	return val * scale * mod
end
