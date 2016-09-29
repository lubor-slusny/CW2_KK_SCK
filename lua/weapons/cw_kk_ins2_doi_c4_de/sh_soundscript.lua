
local function pcf(wep)
	if SERVER then return end
	
	local vm = wep.AttachmentModelsVM.pcf.ent
	
	ParticleEffectAttach("muzzleflash_pistol", PATTACH_POINT_FOLLOW, vm, 0)
	
	wep._pcfStop = wep.Sequence
end

SWEP.Sounds = {
	base_plant = {
		{time = 0/30, sound = "CW_KK_INS2_DOI_C4_PLANTARMMOVEMENT"},
		{time = 12/30, sound = "CW_KK_INS2_DOI_C4_PLANTPLACE"},
		{time = 31/30, sound = "CW_KK_INS2_DOI_C4_PRIME", callback = pcf},
		// 35/30
	},

	base_draw = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0/35, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 10/29, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/29, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	base_pullback = {
		{time = 19/33, sound = "CW_KK_INS2_DOI_C4_PRIME", callback = pcf},
		// { event 3900 29 ""},
	},

	secondary_pullback = {
		{time = 19/33, sound = "CW_KK_INS2_DOI_C4_PRIME", callback = pcf},
		// { event 3900 29 ""},
	},

	low_pullback = {
		{time = 19/33, sound = "CW_KK_INS2_DOI_C4_PRIME", callback = pcf},
		// { event 3900 32 ""},
	},

	base_throw = {
		{time = 6/33, sound = "CW_KK_INS2_DOI_C4_THROW"},
		// { event 3005 7 ""},
	},

	secondary_throw = {
		{time = 6/33, sound = "CW_KK_INS2_DOI_C4_THROW"},
		// { event 3005 7 ""},
	},

	low_throw = {
		{time = 6/30, sound = "CW_KK_INS2_DOI_C4_THROW"},
		// { event 3005 7 ""},
	},
}
