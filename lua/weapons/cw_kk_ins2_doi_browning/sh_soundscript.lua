
local function shell(wep) 
	if SERVER then return end
	
	wep:shellEvent() 
end

local function link(wep)
	if SERVER then return end
	
	wep:shellEvent2() 
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 30/34.2, sound = "CW_KK_INS2_DOI_BROWNING_BOLTBACK"},
		{time = 42/34.2, sound = "CW_KK_INS2_DOI_BROWNING_BOLTRELEASE"},
		{time = 65/34.2, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 15/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 38/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	base_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	base_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_BROWNING_EMPTY"},
	},

	base_reload = {
		{time = 18/34.8, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 35/34.8, sound = "CW_KK_INS2_DOI_BROWNING_LIDOPEN"},
		{time = 75/34.8, sound = "CW_KK_INS2_DOI_BROWNING_LINKRATTLE"},
		{time = 81/34.8, sound = "CW_KK_INS2_DOI_BROWNING_FETCHMAG"},
		{time = 110/34.8, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve},
		{time = 140/34.8, sound = "CW_KK_INS2_DOI_BROWNING_BELTJINGLE"},
		{time = 150/34.8, sound = "CW_KK_INS2_DOI_BROWNING_BELTALIGN"},
		{time = 197/34.8, sound = "CW_KK_INS2_DOI_BROWNING_LIDCLOSE"},
		{time = 230/34.8, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 264/34.8, sound = "CW_KK_INS2_DOI_BROWNING_SHOULDER"},
	},

	base_reload_empty = {
		{time = 18/34.8, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 35/34.8, sound = "CW_KK_INS2_DOI_BROWNING_LIDOPEN"},
		{time = 70/34.8, sound = "CW_KK_INS2_DOI_BROWNING_FETCHMAG"},
		{time = 100/34.8, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve},
		{time = 110/34.8, sound = "CW_KK_INS2_DOI_BROWNING_BELTJINGLE"},
		{time = 120/34.8, sound = "CW_KK_INS2_DOI_BROWNING_BELTALIGN"},
		{time = 160/34.8, sound = "CW_KK_INS2_DOI_BROWNING_LIDCLOSE"},
		{time = 200/34.8, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 210/34.8, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 234/34.8, sound = "CW_KK_INS2_DOI_BROWNING_BOLTBACK"},
		{time = 245/34.8, sound = "CW_KK_INS2_DOI_BROWNING_BOLTRELEASE"},
		{time = 272/34.8, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 294/34.8, sound = "CW_KK_INS2_DOI_BROWNING_SHOULDER"},
	},

	iron_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	iron_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_BROWNING_EMPTY"},
	},

	deployed_in = {
		{time = 1/32.5, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 19/32.5, sound = "CW_KK_INS2_DOI_BROWNING_BipodGroundHit"},
		{time = 32/32.5, sound = "CW_KK_INS2_DOI_BROWNING_BELTJINGLE"},
		{time = 46/32.5, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 65/32.5, sound = "CW_KK_INS2_DOI_BROWNING_SHOULDER"},
	},

	deployed_out = {
		{time = 1/33, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 15/33, sound = "CW_KK_INS2_DOI_BROWNING_BELTJINGLE"},
		{time = 22/33, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 39/33, sound = "CW_KK_INS2_DOI_BROWNING_SHOULDER"},
	},

	deployed_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_BROWNING_EMPTY"},
	},

	deployed_reload = {
		{time = 18/36, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 35/36, sound = "CW_KK_INS2_DOI_BROWNING_LIDOPEN"},
		{time = 75/36, sound = "CW_KK_INS2_DOI_BROWNING_LINKRATTLE"},
		{time = 81/36, sound = "CW_KK_INS2_DOI_BROWNING_FETCHMAG"},
		{time = 110/36, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve},
		{time = 140/36, sound = "CW_KK_INS2_DOI_BROWNING_BELTJINGLE"},
		{time = 150/36, sound = "CW_KK_INS2_DOI_BROWNING_BELTALIGN"},
		{time = 197/36, sound = "CW_KK_INS2_DOI_BROWNING_LIDCLOSE"},
		{time = 222/36, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 249/36, sound = "CW_KK_INS2_DOI_BROWNING_SHOULDER"},
	},

	deployed_reload_empty = {
		{time = 18/36, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 35/36, sound = "CW_KK_INS2_DOI_BROWNING_LIDOPEN"},
		{time = 70/36, sound = "CW_KK_INS2_DOI_BROWNING_FETCHMAG"},
		{time = 100/36, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bulletsToReserve},
		{time = 110/36, sound = "CW_KK_INS2_DOI_BROWNING_BELTJINGLE"},
		{time = 120/36, sound = "CW_KK_INS2_DOI_BROWNING_BELTALIGN"},
		{time = 160/36, sound = "CW_KK_INS2_DOI_BROWNING_LIDCLOSE"},
		{time = 194/36, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 210/36, sound = "CW_KK_INS2_DOI_BROWNING_FOLEY"},
		{time = 234/36, sound = "CW_KK_INS2_DOI_BROWNING_BOLTBACK"},
		{time = 245/36, sound = "CW_KK_INS2_DOI_BROWNING_BOLTRELEASE"},
		{time = 283/36, sound = "CW_KK_INS2_DOI_BROWNING_RATTLE"},
		{time = 293/36, sound = "CW_KK_INS2_DOI_BROWNING_SHOULDER"},
	},

	deployed_iron_idle = {
		{time = 0, sound = "Universal_IronIdle"},
	},

	deployed_iron_fire_1 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_iron_fire_2 = {
		{time = 0, sound = "", callback = link},
		{time = 0.02, sound = "", callback = shell},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_DOI_BROWNING_EMPTY"},
	},
}
