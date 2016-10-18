
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
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},

	base_reload = {
		{time = 9/30, sound = "CW_KK_INS2_P2A1_OPENBARREL"},
		{time = 40/30, sound = "CW_KK_INS2_P2A1_REMOVEFLARE"},
		{time = 45/30, sound = "", callback = shell},
		-- {time = 62/30, sound = "CW_KK_INS2_m203_GrenadeDrop"},
		{time = 92/30, sound = "CW_KK_INS2_P2A1_INSERTFLARESTART"},
		{time = 94/30, sound = "CW_KK_INS2_M203_INSERTGRENADE"},
		{time = 133/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	empty_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	empty_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	empty_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},
}
