
//-----------------------------------------------------------------------------
// AdjustMouseSensitivity edited to take dt.INS2GLActive into account
//-----------------------------------------------------------------------------

function SWEP:AdjustMouseSensitivity()
	local sensitivity = 1
	local mod = math.Clamp(self.OverallMouseSens, 0.1, 1) -- not lower than 10% and not higher than 100% (in case someone uses atts that increase handling)
	local freeAimMod = 1
	
	if self.freeAimOn and not self.dt.BipodDeployed then
		local dist = math.abs(self:getFreeAimDotToCenter())
		
		local mouseImpendance = GetConVarNumber("cw_freeaim_center_mouse_impendance")
		freeAimMod = 1 - (mouseImpendance - mouseImpendance * dist)
	end
	
	if self.dt.State == CW_RUNNING then
		if self.RunMouseSensMod then
			return self.RunMouseSensMod * mod
		end
	end
	
	if self.dt.State == CW_AIMING then
		-- if we're aiming and our aiming position is that of the sight we have installed - decrease our mouse sensitivity
		if (self.OverrideAimMouseSens and self.AimPos == self.ActualSightPos) and not (self.dt.INS2GLActive) then
			--return self.OverrideAimMouseSens * mod
			sensitivity = self.OverrideAimMouseSens
		end
		
		--return math.Clamp(1 - self.ZoomAmount / 100, 0.1, 1) * mod 
		sensitivity = math.Clamp(sensitivity - self.ZoomAmount / 100, 0.1, 1) 
	end
	
	sensitivity = sensitivity * mod
	sensitivity = sensitivity * freeAimMod
	
	return sensitivity --1 * self.OverallMouseSens
end