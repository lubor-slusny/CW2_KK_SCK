if not CustomizableWeaponry then return end

AddCSLuaFile()

CustomizableWeaponry:registerAmmo(".380/200", "9x20MMR Rounds", 9, 19.7)
CustomizableWeaponry:registerAmmo(".303 British", "7.7x56MMR Rounds", 7.7, 56)

CustomizableWeaponry.firemodes:registerFiremode("barfast", "FAST-AUTO", true, 0, 5)
CustomizableWeaponry.firemodes:registerFiremode("barslow", "SLOW-AUTO", true, 0, 4)

if CLIENT then
	local killCol = Color(255, 80, 0, 150)
	local white = Color(255, 255, 255, 150)

	killicon.AddFont("cw_kk_ins2_doi_k98kknife",	"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_garandknife",	"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_shovel_de",	"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_shovel_gb",	"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_doi_shovel_us",	"CW_KillIcons", "j", killCol)

	killicon.AddFont("cw_kk_ins2_doi_luger",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m1911",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_p38",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_ppk",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_webley",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_doi_welrod",		"CW_KillIcons", "a", killCol)

	killicon.AddFont("cw_kk_ins2_doi_mp40",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_doi_sten",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_doi_thom",			"CW_KillIcons", "q", killCol)

	killicon.AddFont("cw_kk_ins2_doi_bar",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_bren",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_browning",		"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_enfield",		"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_doi_g43",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_garand",		"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_doi_ithaca",		"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_doi_k98k",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_doi_lewis",		"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_m1",			"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mg34",			"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_mg42",			"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_doi_pump",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_doi_spring",		"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_doi_stg44",		"CW_KillIcons", "w", killCol)

	killicon.AddFont("cw_kk_ins2_doi_flame_de",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_flame_gb",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_flame_us",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_frag_de",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_frag_gb",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_frag_gb_n69",	"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_frag_gb_n77",	"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_frag_us",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_doi_piat",			"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_doi_tankfist",		"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_doi_zooka",		"HL2MPTypeDeath", "3", killCol)
	
	killicon.AddFont("cw_kk_ins2_doi_bino",			"HL2MPTypeDeath", "3", killCol)
	
	// but w8, theres more
	
	language.Add("cw_kk_ins2_projectile_m6a1", "M6A1 rocket")
	language.Add("cw_kk_ins2_projectile_pf60", "Panzerfaust projectile")
	
	language.Add("cw_kk_ins2_projectile_n69", "No. 69 Frag. Grenade")
	language.Add("cw_kk_ins2_projectile_n77", "No. 77 Smoke Grenade")
	
	killicon.AddFont("cw_kk_ins2_projectile_n69",	"CW_KillIcons", "O", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_n77",	"CW_KillIcons", "P", killCol)
	-- killicon.AddFont("cw_kk_ins2_projectile_n77",	"CW_KillIcons", "h", killCol)
end
