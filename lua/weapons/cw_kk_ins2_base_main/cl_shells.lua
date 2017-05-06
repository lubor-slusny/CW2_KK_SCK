
//-----------------------------------------------------------------------------
// _registerVMShell adds passed entity to SWEPs table of active shells
//-----------------------------------------------------------------------------

local cvarSVM = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_shell_vm"]

function SWEP:_registerVMShell(ent)
	if cvarSVM:GetInt() == 1 then
		ent:SetNoDraw(true)
		ent._drawAsVM = CurTime() + 0.2
		
		table.insert(self._deployedShells, ent)
		
		local i = 1

		for _ = 1, #self._deployedShells do
			if !IsValid(self._deployedShells[i]) then
				table.remove(self._deployedShells, i)
			else
				i = i + 1
			end
		end
	end
end

//-----------------------------------------------------------------------------
// drawVMShells iterates SWEPs table of active shells and draws them
//-----------------------------------------------------------------------------

function SWEP:drawVMShells()
	for _,v in pairs(self._deployedShells) do
		if IsValid(v) then
			if v._drawAsVM > CurTime() then
				v:DrawModel()
			else
				v:SetNoDraw(false)
			end
		end
	end
end

//-----------------------------------------------------------------------------
// CreateShell edited to use 
// - custom makeShell function
// - registerVMShell
//-----------------------------------------------------------------------------

local vm, att, pos, ang, velocity, align, shellEnt

function SWEP:CreateShell()
	if self.NoShells or self.Owner:ShouldDrawLocalPlayer() then
		return
	end
	
	vm = self.CW_VM
	att = vm:GetAttachment(self.ShellViewAttachmentID)
	
	if att then
		if self.ShellDelay then
			CustomizableWeaponry.actionSequence.new(self, self.ShellDelay, nil, function()
				att = vm:GetAttachment(self.ShellViewAttachmentID)
				
				pos = att.Pos
				ang = att.Ang
				velocity = self.Owner:GetVelocity() + ang:Forward() * (self.ShellEjectVelocity or 200)
				
				align = self.ShellViewAngleAlign
				ang:RotateAroundAxis(ang:Forward(), align.Forward)
				ang:RotateAroundAxis(ang:Right(), align.Right)
				ang:RotateAroundAxis(ang:Up(), align.Up)
				
				shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
					pos,
					ang,
					velocity,
					self._shellTable1,
					self.ShellScale
				)
				
				self:_registerVMShell(shellEnt)
			end)
		else
			att = vm:GetAttachment(self.ShellViewAttachmentID)
			
			pos = att.Pos
			ang = att.Ang
			velocity = self.Owner:GetVelocity() + ang:Forward() * (self.ShellEjectVelocity or 200)
			
			align = self.ShellViewAngleAlign
			ang:RotateAroundAxis(ang:Forward(), align.Forward)
			ang:RotateAroundAxis(ang:Right(), align.Right)
			ang:RotateAroundAxis(ang:Up(), align.Up)
			
			shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
				pos,
				ang,
				velocity,
				self._shellTable1,
				self.ShellScale
			)
			
			self:_registerVMShell(shellEnt)
		end
	end
end

//-----------------------------------------------------------------------------
// CreateShell versions used as sound table callbacks
//-----------------------------------------------------------------------------

function SWEP:shellEvent()
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		
		att = vm:GetAttachment(self.ShellWorldAttachmentID)
		
		pos = att.Pos
		ang = att.Ang
		velocity = self.Owner:GetVelocity() + ang:Forward() * (self.ShellEjectVelocity or 200)
		
		align = self.ShellWorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			self._shellTable1,
			self.ShellScale
		)
	else
		vm = self.CW_VM
		
		att = vm:GetAttachment(self.ShellViewAttachmentID)
		
		pos = att.Pos
		ang = att.Ang
		velocity = self.Owner:GetVelocity() + ang:Forward() * (self.ShellEjectVelocity or 200)
		
		align = self.ShellViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			self._shellTable1,
			self.ShellScale
		)
		
		self:_registerVMShell(shellEnt)
	end
end

function SWEP:shellEvent2()
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		
		att = vm:GetAttachment(self.ShellWorldAttachmentID)
		
		pos = att.Pos
		ang = att.Ang
		velocity = self.Owner:GetVelocity() + ang:Forward() * (self.Shell2EjectVelocity or 200)
		
		align = self.Shell2WorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			self._shellTable2,
			self.Shell2Scale
		)
	else
		vm = self.CW_VM
		
		att = vm:GetAttachment(self.Shell2ViewAttachmentID)
		
		pos = att.Pos
		ang = att.Ang
		velocity = self.Owner:GetVelocity() + ang:Forward() * (self.Shell2EjectVelocity or 200)
		
		align = self.Shell2ViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		shellEnt = CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			velocity,
			self._shellTable2,
			self.Shell2Scale
		)
		
		self:_registerVMShell(shellEnt)
	end
end

local m203 = CustomizableWeaponry.shells:getShell("KK_INS2_40mm")
local down = Vector(0,0,-10)

function SWEP:shellEvent203()
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		
		att = vm:GetAttachment(8)
		
		pos = att.Pos
		ang = att.Ang
		
		align = self.Shell2WorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			m203,
			1
		)
	else
		local glAtt = self._currentGrenadeLauncher and self._currentGrenadeLauncher.name
		vm = glAtt and self.AttachmentModelsVM[glAtt] and self.AttachmentModelsVM[glAtt].ent
		
		if not vm then
			return
		end
		
		att = vm:GetAttachment(2)
		
		if att then
			pos = att.Pos
			ang = att.Ang
		else
			-- local e = self.AttachmentModelsVM[glAtt].shellEject
			-- local m = e and vm:GetBoneMatrix(e)
			
			-- if m then
				-- pos = m:GetTranslation()
				-- ang = m:GetAngles()
			-- else
				ang = self.Owner:EyeAngles()
				pos = self.Owner:EyePos() - (15 * ang:Up())
			-- end
		end
		
		align = self.Shell2ViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			m203,
			1
		)
	end
end

local m

function SWEP:shellEventRev()
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		
		m = vm:GetBoneMatrix(0)
		
		pos = m:GetTranslation()
		ang = m:GetAngles()
		
		align = self.ShellWorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			self._shellTable,
			self.ShellScale
		)
	else
		vm = self.CW_VM
		
		att = vm:GetAttachment(2)
		
		pos = att.Pos
		ang = att.Ang
		
		align = self.ShellViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			self._shellTable,
			self.ShellScale
		)
	end
end

function SWEP:shellEventRev2()
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		
		m = vm:GetBoneMatrix(0)
		
		pos = m:GetTranslation()
		ang = m:GetAngles()
		
		align = self.ShellWorldAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			self._shellTable2,
			self.ShellScale
		)
	else
		vm = self.CW_VM
		
		att = vm:GetAttachment(2)
		
		pos = att.Pos
		ang = att.Ang
		
		align = self.ShellViewAngleAlign
		ang:RotateAroundAxis(ang:Forward(), align.Forward)
		ang:RotateAroundAxis(ang:Right(), align.Right)
		ang:RotateAroundAxis(ang:Up(), align.Up)
		
		CustomizableWeaponry_KK.ins2.shells:make(
			pos,
			ang,
			down,
			self._shellTable2,
			self.ShellScale
		)
	end
end

function SWEP:shellEventWebley()
	// move here once done :P
end
