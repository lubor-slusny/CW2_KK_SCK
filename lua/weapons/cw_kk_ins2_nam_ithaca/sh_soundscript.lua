
local function shell(wep) 
	if SERVER then return end
	
	wep:shellEvent() 
end

SWEP.Sounds = {}
