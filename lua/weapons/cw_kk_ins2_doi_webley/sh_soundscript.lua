
local function prepareShells(self)
	self._numShells = self.CW_VM:GetBodygroup(self._shellsBGID) - self:Clip1()
end

local function shells(self)
	for _ = 1, self._numShells do 
		self:shellEventWebley()
	end
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
		{time = 23/30, sound = "CW_KK_INS2_DOI_WEBLEY_CLOSECHAMBER"},
	},

	base_ready_rare = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
		{time = 15/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire = {
		{time = 0, sound = "CW_KK_INS2_DOI_WEBLEY_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	base_fire2 = {
		{time = 0, sound = "CW_KK_INS2_DOI_WEBLEY_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	base_fire3 = {
		{time = 0, sound = "CW_KK_INS2_DOI_WEBLEY_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_WEBLEY_COCKHAMMER"},
		{time = 4/30, sound = "CW_KK_INS2_DOI_WEBLEY_EMPTY"},
	},

	base_reload_start = {
		{time = 0/35, sound = "", callback = prepareShells},
		{time = 1/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 15/35, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
		{time = 19/35, sound = "CW_KK_INS2_DOI_WEBLEY_OPENCHAMBER"},
		{time = 22/35, sound = "", callback = shells},
		{time = 24/35, sound = "CW_KK_INS2_DOI_WEBLEY_DUMPROUNDS"},
	},

	base_reload_insert = {
		{time = 2/40, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
		{time = 13/40, sound = "CW_KK_INS2_DOI_WEBLEY_INSERTSINGLE"},
		// { event 46 0 ""},
		{time = 26/40, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_reload_end = {
		{time = 7/34.5, sound = "CW_KK_INS2_UNIVERSAL_LEANOUT"},
		{time = 24/34.5, sound = "CW_KK_INS2_DOI_WEBLEY_CLOSECHAMBER"},
	},

	base_reload_speed = {
		{time = 0/33, sound = "", callback = prepareShells},
		{time = 1/33, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 15/33, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
		{time = 19/33, sound = "CW_KK_INS2_DOI_WEBLEY_OPENCHAMBER"},
		{time = 22/33, sound = "", callback = shells},
		{time = 24/33, sound = "CW_KK_INS2_DOI_WEBLEY_DUMPROUNDS"},
		{time = 40/33, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToReserve},
		{time = 57/33, sound = "CW_KK_INS2_DOI_WEBLEY_SPEEDLOADERINSERT"},
		// { event 46 60 ""},
		{time = 88/33, sound = "CW_KK_INS2_DOI_WEBLEY_CLOSECHAMBER"},
	},

	iron_fire_1 = {
		{time = 0, sound = "CW_KK_INS2_DOI_WEBLEY_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	iron_fire_2 = {
		{time = 0, sound = "CW_KK_INS2_DOI_WEBLEY_COCKHAMMER"},
		// { event AE_MUZZLEFLASH 0 ""},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_WEBLEY_COCKHAMMER"},
		{time = 4/30, sound = "CW_KK_INS2_DOI_WEBLEY_EMPTY"},
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
