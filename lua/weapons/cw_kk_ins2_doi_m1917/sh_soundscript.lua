
local function prepareShells(self)
	if SERVER then return end
	
	self._numShells = self.CW_VM:GetBodygroup(self._shellsBGID) - self:Clip1()
end

local function shells(self)
	if SERVER then return end
	
	for _ = 1, self._numShells do 
		self:shellEventWebley()
	end
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_draw_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_holster_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_crawl_empty = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire = {
		{time = 22/35, sound = "CW_KK_INS2_DOI_M1917_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	base_fire2 = {
		{time = 22/35, sound = "CW_KK_INS2_DOI_M1917_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_M1917_COCKHAMMER"},
		{time = 4/30, sound = "CW_KK_INS2_DOI_M1917_EMPTY"},
	},

	base_reload_start = {
		{time = 0/34, sound = "", callback = prepareShells},
		{time = 1/34, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 18/34, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
		{time = 22/34, sound = "CW_KK_INS2_DOI_M1917_OPENCHAMBER"},
		{time = 44/34, sound = "", callback = shells},
		{time = 46/34, sound = "CW_KK_INS2_DOI_M1917_DUMPROUNDS"},
	},

	base_reload_start_empty = {
		{time = 0/34, sound = "", callback = prepareShells},
		{time = 1/34, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 12/34, sound = "CW_KK_INS2_DOI_M1917_COCKHAMMER"},
		{time = 42/34, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
		{time = 46/34, sound = "CW_KK_INS2_DOI_M1917_OPENCHAMBER"},
		{time = 68/34, sound = "", callback = shells},
		{time = 70/34, sound = "CW_KK_INS2_DOI_M1917_DUMPROUNDS"},
	},

	base_reload_insert = {
		{time = 2/40, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
		{time = 13/40, sound = "CW_KK_INS2_DOI_M1917_INSERTSINGLE"},
		// { event 46 0 ""},
		{time = 26/40, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_reload_end = {
		{time = 7/34.5, sound = "CW_KK_INS2_UNIVERSAL_LEANOUT"},
		{time = 29/34.5, sound = "CW_KK_INS2_DOI_M1917_CLOSECHAMBER"},
	},

	iron_fire_1 = {
		{time = 22/35, sound = "CW_KK_INS2_DOI_M1917_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_M1917_COCKHAMMER"},
		{time = 4/30, sound = "CW_KK_INS2_DOI_M1917_EMPTY"},
	},
}

local vm, att, m, pos, ang, align, velocity, shellEnt

function SWEP:shellEventWebley()
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
		
		pos = att.Pos + att.Ang:Forward() * -7
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
			self._shellTable,
			self.ShellScale
		)
		
		self:_registerVMShell(shellEnt)
	end
end
