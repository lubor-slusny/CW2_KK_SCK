
local SP = game.SinglePlayer()
local MP = !SP

CustomizableWeaponry_KK.ins2.hotPotato = CustomizableWeaponry_KK.ins2.hotPotato or {}
CustomizableWeaponry_KK.ins2.hotPotato.held = CustomizableWeaponry_KK.ins2.hotPotato.held or {}
CustomizableWeaponry_KK.ins2.hotPotato.IsValid = function() return true end

function CustomizableWeaponry_KK.ins2.hotPotato:pickUp(ply, nade)
	if self.held[ply] then
		return
	end
	
	local wep = ply:GetActiveWeapon()
	
	if !IsValid(wep) or !wep.KKINS2Wep then
		return
	end
	
	if wep.GlobalDelay > CurTime() then
		return
	end
	
	self.held[ply] = nade
	
	nade:SetOwner(ply)
	
	if SP and SERVER then
		umsg.Start("CW_KK_INS2_HOTPOTATO_PICKUP", wep.Owner)
			umsg.Entity(nade)
		umsg.End()
	end
	
	wep.Animations["_potato_pickup"] = "throwback"
	wep.Animations["_potato_throw"] = "bakethrow"
	
	wep.dt.State = CW_ACTION
	
	CustomizableWeaponry.actionSequence.new(wep, 0.1, nil, function()
		wep.dt.State = CW_KK_QNADE
		
		if CLIENT then
			wep.grenadeTime = CurTime() + 1.5
			wep.CW_VM:SetModel(wep.CW_GREN_TWEAK.vm)
			
			wep:playAnim("_potato_pickup", 1, 0)
		end
	end)
end

if CLIENT then
	usermessage.Hook("CW_KK_INS2_HOTPOTATO_PICKUP", function(um)
		CustomizableWeaponry_KK.ins2.hotPotato:pickUp(
			LocalPlayer(), 
			um:ReadEntity()
		)
	end)
end

function CustomizableWeaponry_KK.ins2.hotPotato:think()
	for ply, nade in pairs(self.held) do
		if IsValid(nade) then
			if ply:Alive() then
				nade:SetPos(ply:EyePos())
			end
		else
			self.held[ply] = nil
		end
	end
end

hook.Add("Think", CustomizableWeaponry_KK.ins2.hotPotato, CustomizableWeaponry_KK.ins2.hotPotato.think)

function CustomizableWeaponry_KK.ins2.hotPotato:throw(wep)
	if SP and SERVER then
		SendUserMessage("CW_KK_INS2_HOTPOTATO_THROW", wep.Owner)
	end
	
	local nade = self.held[wep.Owner]
	
	if !IsValid(nade) then
		return
	end
	
	self.held[wep.Owner] = nil
	
	wep.Animations["_potato_pickup"] = "throwback"
	wep.Animations["_potato_throw"] = "bakethrow"
	
	if CLIENT then
		wep:playAnim("_potato_throw", 1, 0)
		
		CustomizableWeaponry.actionSequence.new(wep, 1, nil, function()
			wep.CW_VM:SetModel(wep.ViewModel)
			wep:idleAnimFunc()
		end)
	end
	
	if SERVER then
		timer.Simple(0.2, function()
			if !IsValid(nade) then
				return 
			end
			
			local velocity = CustomizableWeaponry.quickGrenade:getThrowVelocity(wep.Owner)
			local phys = nade:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(velocity)
				phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
			else
				nade:SetVelocity(velocity)
			end
			
			nade:SetOwner(wep.Owner)
		end)
	end
end

if CLIENT then
	usermessage.Hook("CW_KK_INS2_HOTPOTATO_THROW", function()
		local wep = LocalPlayer():GetActiveWeapon()
		
		if !IsValid(wep) or !wep.KKINS2Wep then
			return
		end
		
		CustomizableWeaponry_KK.ins2.hotPotato:throw(wep)
	end)
end

function CustomizableWeaponry_KK.ins2.hotPotato:getPotato(wep)
	return self.held[wep.Owner]
end
