local origInflictor, origAttacker

local isProjectile = {
	cw_kk_ins2_projectile_at4 = true,
	cw_kk_ins2_projectile_m6a1 = true,
	cw_kk_ins2_projectile_pf60 = true,
	cw_kk_ins2_projectile_rpg = true,
	cw_kk_ins2_projectile_rpg_2 = true,
}

local function takeDmg(ent, d)
	origInflictor = d:GetInflictor()
	
	if IsValid(origInflictor) then
		if origInflictor:GetClass() == "env_explosion" then 
			if IsValid(origInflictor.CW_KK_INS2_inflictor) then
				d:SetInflictor(origInflictor.CW_KK_INS2_inflictor)
			end
		end
	end	
	
	origAttacker = d:GetAttacker()
	
	if IsValid(origAttacker) then
		if isProjectile[origAttacker:GetClass()] then
			if IsValid(origAttacker:GetOwner()) then
				d:SetAttacker(origAttacker:GetOwner())
				d:SetInflictor(origAttacker)
			end
		end
	end
end

hook.Add("EntityTakeDamage", "CW_KK_INS2_RPGS", takeDmg)