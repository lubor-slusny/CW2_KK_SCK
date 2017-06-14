include("shared.lua")

function ENT:send(pos, ang, col)
	net.Start("cw_kk_ins_flashlight_use")
	net.WriteEntity(self)
	net.WriteVector(pos)
	net.WriteAngle(ang)
	net.WriteInt(col, 3)
	net.SendToServer()
end

net.Receive("cw_kk_ins_flashlight_init", function()
	
end)