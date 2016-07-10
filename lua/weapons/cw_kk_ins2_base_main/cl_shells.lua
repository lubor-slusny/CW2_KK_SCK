
local makeShell = CustomizableWeaponry_KK.ins2.makeShell
local dir, ang, tweak

function SWEP:CreateShell(sh)
	if self.Owner:ShouldDrawLocalPlayer() then
		return
	end
	
	sh = self.Shell or sh
	vm = self.CW_VM
	
	att = vm:GetAttachment(self.ViewShellAttachmentID)
	
	if att then
		if self.ShellDelay then
			CustomizableWeaponry.actionSequence.new(self, self.ShellDelay, nil, function()
				if self.NoShells then return end
				
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
		
				ang = EyeAngles()
				tweak = self._shellTable.rv
				
				if tweak then
					ang:RotateAroundAxis(ang:Right(), tweak.Right)
					ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
					ang:RotateAroundAxis(ang:Up(), tweak.Up)
				end
				
				-- makeShell(self, att.Pos + dir * self.ShellOffsetMul, ang, dir * 200, 0.6, 10)
				makeShell(self, att.Pos + dir * self.ShellOffsetMul, att.Ang, dir * 200, 0.6, 10)
			end)
		else
			if self.NoShells then return end
			
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
			
			ang = EyeAngles()
			tweak = self._shellTable.rv
				
			if tweak then
				ang:RotateAroundAxis(ang:Right(), tweak.Right)
				ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
				ang:RotateAroundAxis(ang:Up(), tweak.Up)
			end
			
			-- makeShell(self, att.Pos + dir * self.ShellOffsetMul, ang, dir * 200, 0.6, 10)
			makeShell(self, att.Pos + dir * self.ShellOffsetMul, att.Ang, dir * 200, 0.6, 10)
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

local makeShell = CustomizableWeaponry_KK.ins2.makeShell
local vm, att, dir, ang, tweak

function SWEP:shellEvent(sh)	
	sh = sh or self._shellTable
	
	if self.Owner:ShouldDrawLocalPlayer() then
		vm = self:getMuzzleModel()
		att = vm:GetAttachment(self.WorldShellEjectionAttachmentID)
		local ejectVelocity = att.Ang:Forward() * (self.ShellEjectVelocity or 200)
		
		ang = att.Ang
		tweak = self._shellTable.rw
		if tweak then
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
		end
		
		makeShell(self, att.Pos, ang, ejectVelocity, 0.5, 10, sh)
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
		
		ang = EyeAngles()
		tweak = self._shellTable.rv
		
		if tweak then
			ang:RotateAroundAxis(ang:Right(), tweak.Right)
			ang:RotateAroundAxis(ang:Forward(), tweak.Forward)
			ang:RotateAroundAxis(ang:Up(), tweak.Up)
		end
		
		-- makeShell(self, att.Pos + dir * self.ShellOffsetMul, ang, dir * (self.ShellEjectVelocity or 200), 0.6, 10, sh)
		makeShell(self, att.Pos + dir * self.ShellOffsetMul, att.Ang, dir * (self.ShellEjectVelocity or 200), 0.6, 10, sh)
	end
end

function SWEP:shellEvent2()
	self:shellEvent(self._shellTable2)
end
