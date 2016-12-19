
local down = Vector(0,0,-10)

local function shell(wep)
	if SERVER then return end
	
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
		{time = 22/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 20/31, sound = "CW_KK_INS2_M45_MAGRELEASE"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
		{time = 14/34, sound = "CW_KK_INS2_M45_MAGRELEASE"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M203_EMPTY"},
	},

	base_reload = {
		{time = 0/30, sound = "CW_KK_INS2_GL_BEGINRELOAD"},
		{time = 14/30, sound = "CW_KK_INS2_M203_OPENBARREL"},
		{time = 40/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 55/30, sound = "", callback = shell},
		{time = 83/30, sound = "CW_KK_INS2_M203_INSERTGRENADE"},
		{time = 119/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	base_reload2 = {
		{time = 0/30, sound = "CW_KK_INS2_GL_BEGINRELOAD"},
		{time = 14/30, sound = "CW_KK_INS2_M203_OPENBARREL"},
		{time = 40/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 55/30, sound = "", callback = shell},
		{time = 83/30, sound = "CW_KK_INS2_M203_INSERTGRENADE"},
		{time = 121/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	base_reload3 = {
		{time = 0/30, sound = "CW_KK_INS2_GL_BEGINRELOAD"},
		{time = 14/30, sound = "CW_KK_INS2_M203_OPENBARREL"},
		{time = 40/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 55/30, sound = "", callback = shell},
		{time = 83/30, sound = "CW_KK_INS2_M203_INSERTGRENADE"},
		{time = 119/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M203_EMPTY"},
	},
}
