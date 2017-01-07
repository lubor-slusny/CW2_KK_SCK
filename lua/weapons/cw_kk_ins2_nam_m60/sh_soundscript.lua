
local function shell(wep) 
	if SERVER then return end
	
	wep:shellEvent() 
end

local function link(wep)
	if SERVER then return end
	
	wep:shellEvent2() 
end

SWEP.Sounds = {
	base_fire_1 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	base_fire_2 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	base_fire_3 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	iron_fire_1 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	iron_fire_2 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	iron_fire_3 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	iron_fire_4 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	deployed_fire_1 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	deployed_fire_2 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	deployed_iron_fire_1 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},

	deployed_iron_fire_2 = {
		{time = 0.02, sound = "", callback = link},
		{time = 0.05, sound = "", callback = shell},
	},
}
