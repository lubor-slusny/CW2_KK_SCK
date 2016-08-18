
SWEP.Sounds = {
	base_draw = {
		-- {time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 0/30, sound = "CW_KK_INS2_MOLOTOV_DRAW"},
	},

	base_holster = {
		-- {time = 0/35, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
		{time = 0/35, sound = "CW_KK_INS2_MOLOTOV_HOLSTER"},
	},

	base_crawl = {
		{time = 10/29, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/29, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	pullback_high = {
		{time = 6/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 14/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE"},
		{time = 17/30, sound = "CW_KK_INS2_MOLOTOV_IGNITE"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 17 "molotov_lighter follow_attachment lighter"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 30 "molotov_rag follow_attachment rag"},
		{time = 34/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
		{time = 35/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE"},
		// { event 3900 52 ""},
	},

	pullback_highbake = {
		{time = 6/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 14/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE"},
		{time = 17/30, sound = "CW_KK_INS2_MOLOTOV_IGNITE"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 17 "molotov_lighter follow_attachment lighter"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 30 "molotov_rag follow_attachment rag"},
		{time = 34/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
		{time = 35/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE"},
		// { event 3900 52 ""},
	},

	pullback_low = {
		{time = 6/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 14/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE"},
		{time = 17/30, sound = "CW_KK_INS2_MOLOTOV_IGNITE"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 17 "molotov_lighter follow_attachment lighter"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 30 "molotov_rag follow_attachment rag"},
		{time = 34/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
		{time = 35/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE"},
		// { event 3900 52 ""},
	},

	throw = {
		{time = 3/31.5, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		// { event 3005 3 ""},
	},

	bakethrow = {
		{time = 3/31.5, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		// { event 3013 3 ""},
	},

	lowthrow = {
		{time = 6/31.5, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		// { event 3016 6 ""},
	},
}
