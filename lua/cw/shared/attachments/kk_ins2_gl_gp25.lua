local att = {}
att.name = "kk_ins2_gl_gp25"
att.displayName = "GP30"
att.displayNameShort = "GP30"
att.isGrenadeLauncher = true
att.KK_INS2_playIdle = true

att.statModifiers = {
	DrawSpeedMult = -0.2,
	OverallMouseSensMult = -0.2,
	RecoilMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		{t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE},
		{t = "And other bullshit.", c = CustomizableWeaponry.textColors.POSITIVE}
	}

	local v0 = Vector(0.01, 0.01, 0.01)
	local v1 = Vector(1, 1, 1)
	
	local nadeTypes = CustomizableWeaponry.grenadeTypes.registered
	
	att.AttachmentModelsVM = {
		["40mm_kk_1337"] = {model = "models/weapons/w_at4_projectile.mdl", bone = "GL_Round", pos = Vector(1.75,0,0), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85),
			active = function(self)
				local correctAmmo = nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_1337"
				local nadeVisible = self.AttachmentModelsVM.kk_ins2_gl_gp25.active and self.M203Chamber or (self.Sequence == self.Animations.gl_on_reload and self.CW_VM:GetCycle() > 0.2)
				return correctAmmo and nadeVisible
			end
		},
		["40mm_kk_1338"] = {model = "models/weapons/w_cw_fraggrenade_thrown.mdl", bone = "GL_Round", pos = Vector(-0.267, 0.052, -0.015), angle = Angle(90, 0, 0), size = Vector(0.5, 0.5, 0.5),
			active = function(self)
				return nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_1338"
			end
		},
		["40mm_kk_1339"] = {model = "models/weapons/w_magnade.mdl", bone = "GL_Round", pos = Vector(-1.18, 0, 0), angle = Angle(0, 90, 0), size = Vector(0.15, 0.15, 0.15),
			active = function(self)
				return nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_1339"
			end
		},
		["40mm_kk_13399"] = { type = "Model", model = "models/effects/combineball.mdl", bone = "GL_Round", pos = Vector(-0.3, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.065, 0.065, 0.065),
			active = function(self)
				return nadeTypes[self.Grenade40MM] and nadeTypes[self.Grenade40MM].name == "40mm_kk_13399"
			end
		},
	}
	
	function att:elementRender()
		att.CW_VM = self.AttachmentModelsVM[att.name].ent
		
		if self.Grenade40MM > 2 then
			att.CW_VM:ManipulateBoneScale(att.CW_VM:LookupBone("GL_Round"), v0)
		else
			att.CW_VM:ManipulateBoneScale(att.CW_VM:LookupBone("GL_Round"), v1)
		end
		
		if self.Grenade40MM == 2 then
			att.CW_VM:SetSkin(1)
		else
			att.CW_VM:SetSkin(0)
		end
				
		for k, v in pairs(att.AttachmentModelsVM) do
			if type(v.active) == "function" then
				active = v.active(self)
			else
				active = v.active
			end
		
			if v.ent and active then
				if v.merge then				// this was an attempt to unfuck lighting on certain velements
					-- pos = EyePos()		// css rig now seem to be working fine witout it 
					-- ang = EyeAngles()	// aimpoint2x was always messed up
				elseif v._attachment then
					vma = att.CW_VM:GetAttachment(v._attachment)
					pos = vma.Pos
					ang = vma.Ang
				elseif v._bone then
					m = att.CW_VM:GetBoneMatrix(v._bone)
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
				end
				
				if !v.nodraw then
					model:DrawModel()
				end
			end
		end
	end

	function att:IsValid() return true end
	function att:createManagedCModel(...)
		local ent = ClientsideModel(...)
		CustomizableWeaponry.cmodels:add(ent, self)
		return ent
	end
	
	function att:attachFunc()
		att.CW_VM = self.AttachmentModelsVM[att.name].ent
		
		for k, v in pairs(att.AttachmentModelsVM) do
			if not v.ent then
				v.ent = att:createManagedCModel(v.model, RENDERGROUP_BOTH)
			end

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
		
			if v.merge then
				v.ent:SetParent(att.CW_VM)
				v.ent:AddEffects(EF_BONEMERGE)
			end
			
			if v.attachment then
				v._attachment = att.CW_VM:LookupAttachment(v.attachment)
			end
			
			if v.bone then
				v._bone = att.CW_VM:LookupBone(v.bone)
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
end

function att:detachFunc()
	self.dt.INS2GLActive = false
end
	
CustomizableWeaponry:registerAttachment(att)
