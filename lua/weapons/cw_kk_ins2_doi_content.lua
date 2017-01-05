if not CustomizableWeaponry then return end

AddCSLuaFile()

// SOUNDS
	CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_SHOVEL", {"weapons/entrenchingtool/ent_tool_melee_01.wav", "weapons/entrenchingtool/ent_tool_melee_02.wav", "weapons/entrenchingtool/ent_tool_melee_03.wav", "weapons/entrenchingtool/ent_tool_melee_04.wav", "weapons/entrenchingtool/ent_tool_melee_05.wav", "weapons/entrenchingtool/ent_tool_melee_06.wav"})

	CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MELEE", {"weapons/universal/weapon_melee_01.wav", "weapons/universal/weapon_melee_02.wav", "weapons/universal/weapon_melee_03.wav", "weapons/universal/weapon_melee_04.wav", "weapons/universal/weapon_melee_05.wav", "weapons/universal/weapon_melee_06.wav"})
	CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MELEE_HITPLY", {"weapons/universal/weapon_melee_hitflesh_01.wav", "weapons/universal/weapon_melee_hitflesh_02.wav", "weapons/universal/weapon_melee_hitflesh_03.wav", "weapons/universal/weapon_melee_hitflesh_04.wav"})
	CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MELEE_HITWORLD", {"weapons/universal/weapon_melee_hitworld_01.wav", "weapons/universal/weapon_melee_hitworld_02.wav"})
	
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_DOI_BAYONET_DRAW", {"weapons/universal/bayonet_draw_01.wav", "weapons/universal/bayonet_draw_02.wav", "weapons/universal/bayonet_draw_03.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_DOI_BAYONET_HOLSTER", {"weapons/universal/bayonet_holster_01.wav", "weapons/universal/bayonet_holster_02.wav", "weapons/universal/bayonet_holster_03.wav"})

// AMMO
	CustomizableWeaponry:registerAmmo(".380/200", "9x20MMR Rounds", 9, 19.7)
	CustomizableWeaponry:registerAmmo(".303 British", "7.7x56MMR Rounds", 7.7, 56)
	CustomizableWeaponry:registerAmmo("PIAT Bomb", "PIAT Bombs", 0, 0)
	CustomizableWeaponry:registerAmmo("88MM Rocket", "88MM Rockets", 0, 0)

// FIREMODES
	CustomizableWeaponry.firemodes:registerFiremode("barfast", "FAST-AUTO", true, 0, 5)
	CustomizableWeaponry.firemodes:registerFiremode("barslow", "SLOW-AUTO", true, 0, 4)

// KILLSTUFFS
if CLIENT then
	local killCol = Color(255, 80, 0, 150)
	local white = Color(255, 255, 255, 150)

	killicon.AddFont("cw_kk_ins2_doi_mel_brass",		"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mel_garand",		"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mel_k98k",			"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mel_kabar",		"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mel_shovel_de",	"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mel_shovel_gb",	"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mel_shovel_us",	"CW_KillIcons", "j", killCol)

	killicon.AddFont("cw_kk_ins2_doi_browninghp",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_c96",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_luger",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m1911",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m1917",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_p38",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_ppk",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_webley",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_welrod",			"CW_KillIcons", "a", killCol)

	killicon.AddFont("cw_kk_ins2_doi_c96_c",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m3",				"CW_KillIcons", "q", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m3a1",				"CW_KillIcons", "q", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mp40",				"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_doi_sten_mk2",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_doi_sten_mk5",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_doi_thom_1928",		"CW_KillIcons", "q", killCol)
	killicon.AddFont("cw_kk_ins2_doi_thom_m1a1",		"CW_KillIcons", "q", killCol)

	killicon.AddFont("cw_kk_ins2_doi_bar",				"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_bren",				"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_browning",			"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_enfield",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_doi_fg42",				"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_doi_g43",				"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_garand",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_ithaca",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_doi_k98k",				"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_doi_lewis",			"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m1",				"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m1a1",				"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m1912",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mg34",				"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mg42",				"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_spring",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_doi_stg44",			"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_doi_wicked",			"CW_KillIcons", "z", killCol)

	killicon.AddFont("cw_kk_ins2_doi_flame_gb",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_flame_gb",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_flame_us",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_molotov",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_c4_de",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_c4_us",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_m24",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_mk2",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_n36",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_n39",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_n69",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_n76",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_nade_n77",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_piat",				"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_doi_tankfist",			"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_doi_tankshrek",		"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_doi_zooka",			"HL2MPTypeDeath", "3", killCol)
	
	killicon.AddFont("cw_kk_ins2_doi_bino_de",			"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_doi_bino_gb",			"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_doi_bino_us",			"HL2MPTypeDeath", "3", killCol)
	
	// but w8, theres more
	
	language.Add("cw_kk_ins2_projectile_m10", "M10A1 smoke rocket")
	language.Add("cw_kk_ins2_projectile_m6a1", "M6A1 rocket")
	language.Add("cw_kk_ins2_projectile_pf60", "Panzerfaust projectile")
	language.Add("cw_kk_ins2_projectile_shrek", "Panzerschreck projectile")
	language.Add("cw_kk_ins2_projectile_piat", "PIAT projectile")
	
	language.Add("cw_kk_ins2_projectile_n69", "No. 69 Frag. Grenade")
	language.Add("cw_kk_ins2_projectile_n76", "No. 76 WP Grenade")
	language.Add("cw_kk_ins2_projectile_n77", "No. 77 Smoke Grenade")
	
	language.Add("cw_kk_ins2_projectile_ww2_c4_de", "Thrown Satchel Charge")
	language.Add("cw_kk_ins2_projectile_ww2_c4_us", "Thrown Satchel Charge")
	
	killicon.AddFont("cw_kk_ins2_projectile_n69",	"CW_KillIcons", "O", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_n76",	"CW_KillIcons", "P", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_n77",	"CW_KillIcons", "P", killCol)
	-- killicon.AddFont("cw_kk_ins2_projectile_n77",	"CW_KillIcons", "h", killCol)
end
