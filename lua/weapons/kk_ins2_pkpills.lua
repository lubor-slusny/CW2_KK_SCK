
if not pk_pills then return end

pk_pills.packStart("Insurgency 2","base","icon16/rainbow.png")

pk_pills.register("kk_ins2_f1",{
	printName="F1 grenade",
	type="phys",
	side="harmless",
	model="models/weapons/w_f1.mdl",
	default_rp_cost=1000,
	health=50,
	driveType="roll",
	driveOptions={
		power=300,
		jump=5000,
		burrow=6
	},
	attack={
		mode="trigger",
		func= function(ply,ent)
			ent:PillDie()
		end
	},
	diesOnExplode=true,
	die=function(ply,ent)
		local explode = ents.Create("env_explosion")
		explode:SetPos(ent:GetPos())
		explode:Spawn()
		explode:SetOwner(ply)
		explode:SetKeyValue("iMagnitude","100")
		explode:Fire("Explode",0,0)
	end,
})

pk_pills.register("kk_ins2_m67",{
	printName="M67 grenade",
	type="phys",
	side="harmless",
	model="models/weapons/w_m67.mdl",
	default_rp_cost=1000,
	health=50,
	driveType="roll",
	driveOptions={
		power=300,
		jump=5000,
		burrow=6
	},
	attack={
		mode="trigger",
		func= function(ply,ent)
			ent:PillDie()
		end
	},
	diesOnExplode=true,
	die=function(ply,ent)
		local explode = ents.Create("env_explosion")
		explode:SetPos(ent:GetPos())
		explode:Spawn()
		explode:SetOwner(ply)
		explode:SetKeyValue("iMagnitude","100")
		explode:Fire("Explode",0,0)
	end,
})
