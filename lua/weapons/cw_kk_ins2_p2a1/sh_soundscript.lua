
local down = Vector(0,0,-10)

local function shell(wep)
	local att = wep.CW_VM:GetAttachment(2)
	local dir = att.Ang:Forward()
	local pos = att.Pos + dir * 10
	local ang = wep.Owner:EyeAngles()
	ang:RotateAroundAxis(ang:Up(), 180)
	
	CustomizableWeaponry_KK.ins2.shells:make(pos, ang, down, wep._shellTable, 1)
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},

	base_reload = {
		{time = 18/30, sound = "CW_KK_INS2_P2A1_OPENBARREL"},
		{time = 39/30, sound = "CW_KK_INS2_P2A1_REMOVEFLARE"},
		{time = 45/30, sound = "", callback = shell},
		-- {time = 61/30, sound = "CW_KK_INS2_P2A1_FlareDrop"},
		{time = 75/30, sound = "CW_KK_INS2_P2A1_INSERTFLARESTART"},
		{time = 90/30, sound = "CW_KK_INS2_P2A1_INSERTFLARE"},
		{time = 113/30, sound = "CW_KK_INS2_P2A1_CLOSEBARREL"},
		{time = 129/30, sound = "CW_KK_INS2_P2A1_COCKHAMMER"},
	},

	empty_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	empty_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	empty_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},
}
