
// shell VM Render

local cvarSVM = GetConVar("cw_kk_ins2_shell_vm") or {GetInt = function() return 1 end}

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

// terifying destination

local makeShell = CustomizableWeaponry_KK.ins2.makeShell
local dir, ang, tweak, att, velocity, shellEnt

function SWEP:CreateShell()
	if self.Owner:ShouldDrawLocalPlayer() then
		return
	end
	
	att = self.CW_VM:GetAttachment(self.ViewShellAttachmentID)
	
	if att then
		if self.ShellDelay then
			CustomizableWeaponry.actionSequence.new(self, self.ShellDelay, nil, function()
				if self.NoShells then return end
				
				att = self.CW_VM:GetAttachment(self.ViewShellAttachmentID)
				
				if self.InvertShellEjectAngle then
					dir = -att.Ang:Forward()
				else
					dir = att.Ang:Forward()
				end
				
				if self.ShellPosOffset then
					att.Pos = att.Pos + (self.ShellPosOffset.x) * att.Ang:Right()
					att.Pos = att.Pos + (self.ShellPosOffset.y) * att.Ang:Forward()
					att.Pos = att.Pos + (self.ShellPosOffset.z) * att.Ang:Up()
				end
		
				ang = att.Ang
				tweak = self.ViewShellAngleTweak
				ang:RotateAroundAxis(ang:Right(), tweak.Right)
				ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
				ang:RotateAroundAxis(ang:Up(), tweak.Up)
				
				velocity = self.Owner:GetVelocity() + dir * (self.ShellEjectVelocity or 200)
				
				shellEnt = makeShell(
					att.Pos + dir * self.ShellOffsetMul, 
					ang, 
					velocity,
					self._shellTable1, 
					self.ShellScale
				)
				
				self:_registerVMShell(shellEnt)
			end)
		else
			if self.NoShells then return end
			
			att = self.CW_VM:GetAttachment(self.ViewShellAttachmentID)
			
			if self.InvertShellEjectAngle then
				dir = -att.Ang:Forward()
			else
				dir = att.Ang:Forward()
			end
			
			if self.ShellPosOffset then
				att.Pos = att.Pos + (self.ShellPosOffset.x) * att.Ang:Right()
				att.Pos = att.Pos + (self.ShellPosOffset.y) * att.Ang:Forward()
				att.Pos = att.Pos + (self.ShellPosOffset.z) * att.Ang:Up()
			end
			
			ang = att.Ang
			tweak = self.ViewShellAngleTweak
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
			
			velocity = self.Owner:GetVelocity() + dir * (self.ShellEjectVelocity or 200)
			
			shellEnt = makeShell(
				att.Pos + dir * self.ShellOffsetMul, 
				ang, 
				velocity,
				self._shellTable1, 
				self.ShellScale
			)
			
			self:_registerVMShell(shellEnt)
		end
	end
end

local vm, att, dir, ang, tweak

function SWEP:shellEvent()
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		att = vm:GetAttachment(self.WorldShellEjectionAttachmentID)
		local ejectVelocity = self.Owner:GetVelocity() + att.Ang:Forward() * (self.ShellEjectVelocity or 200)
		
		ang = att.Ang
		tweak = self.WorldShellAngleTweak
		
		ang:RotateAroundAxis(ang:Right(), tweak.Right)
		ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
		ang:RotateAroundAxis(ang:Up(), tweak.Up)
		
		makeShell(
			att.Pos, 
			ang, 
			ejectVelocity, 
			self._shellTable1, 
			self.ShellScale
		)
	else
		vm = self.CW_VM
		att = vm:GetAttachment(self.ViewShellAttachmentID)
		
		if self.InvertShellEjectAngle then
			dir = -att.Ang:Forward()
		else
			dir = att.Ang:Forward()
		end
		
		if self.ShellPosOffset then
			att.Pos = att.Pos + (self.ShellPosOffset.x) * att.Ang:Right()
			att.Pos = att.Pos + (self.ShellPosOffset.y) * att.Ang:Forward()
			att.Pos = att.Pos + (self.ShellPosOffset.z) * att.Ang:Up()
		end

		ang = att.Ang
		tweak = self.ViewShellAngleTweak
		
		ang:RotateAroundAxis(ang:Right(), tweak.Right)
		ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
		ang:RotateAroundAxis(ang:Up(), tweak.Up)
		
		shellEnt = makeShell(
			att.Pos + dir * self.ShellOffsetMul, 
			ang, 
			self.Owner:GetVelocity() + dir * (self.ShellEjectVelocity or 200), 
			self._shellTable1, 
			self.ShellScale
		)
		
		self:_registerVMShell(shellEnt)
	end
end

function SWEP:shellEvent2()
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		att = vm:GetAttachment(self.WorldShellEjectionAttachmentID)
		local ejectVelocity = self.Owner:GetVelocity() + att.Ang:Forward() * 50
		
		ang = att.Ang
		tweak = self.WorldShellAngleTweak
		
		ang:RotateAroundAxis(ang:Right(), tweak.Right)
		ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
		ang:RotateAroundAxis(ang:Up(), tweak.Up)
		
		makeShell(
			att.Pos, 
			ang, 
			ejectVelocity, 
			self._shellTable2, 
			self.ShellScale
		)
	else
		vm = self.CW_VM
		att = vm:GetAttachment(4)
		
		if self.InvertShellEjectAngle then
			dir = -att.Ang:Forward()
		else
			dir = att.Ang:Forward()
		end
		
		if self.ShellPosOffset then
			att.Pos = att.Pos + (self.ShellPosOffset.x) * att.Ang:Right()
			att.Pos = att.Pos + (self.ShellPosOffset.y) * att.Ang:Forward()
			att.Pos = att.Pos + (self.ShellPosOffset.z) * att.Ang:Up()
		end

		ang = att.Ang
		tweak = self.ViewShellAngleTweak2
		
		ang:RotateAroundAxis(ang:Right(), tweak.Right)
		ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
		ang:RotateAroundAxis(ang:Up(), tweak.Up)
		
		shellEnt = makeShell(
			att.Pos + dir * self.ShellOffsetMul, 
			ang, 
			self.Owner:GetVelocity() + dir * 50, 
			self._shellTable2, 
			self.ShellScale
		)
		
		self:_registerVMShell(shellEnt)
	end
end
