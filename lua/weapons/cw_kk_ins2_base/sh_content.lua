
-- // particles // if u know how 2 convert, CONVERT, NOT REMAKE, CONVERT them to good old gmod shitengine lemme know

-- game.AddParticles("particles/ammo_cache_ins.pcf")
-- game.AddParticles("particles/explosion_fx_ins.pcf")
-- game.AddParticles("particles/explosion_fx_ins_b.pcf")
-- game.AddParticles("particles/impact_fx_ins.pcf")
-- game.AddParticles("particles/light_fx.pcf")
-- game.AddParticles("particles/screen_fx.pcf")
-- game.AddParticles("particles/fire_01_ins.pcf")
-- game.AddParticles("particles/world_fx_ins.pcf")
-- game.AddParticles("particles/blood_fx.pcf")
-- game.AddParticles("particles/footstep_fx.pcf")
-- game.AddParticles("particles/weapon_fx_tracers.pcf")
-- game.AddParticles("particles/flashlight.pcf")
-- game.AddParticles("particles/ins_light_fx.pcf")
-- game.AddParticles("particles/ins_rockettrail.pcf")
-- game.AddParticles("particles/ins_smokegrenade.pcf")
-- game.AddParticles("particles/jonny_light_rigs.pcf")	
-- game.AddParticles("!particles/menu.pcf")
	
// SHARED SOUNDS

	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_DRAW", {"weapons/universal/uni_weapon_draw_01.wav", "weapons/universal/uni_weapon_draw_02.wav", "weapons/universal/uni_weapon_draw_03.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_HOLSTER", "weapons/universal/uni_weapon_holster.wav")
	
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_PISTOL_DRAW", {"weapons/universal/uni_pistol_draw_01.wav", "weapons/universal/uni_pistol_draw_02.wav", "weapons/universal/uni_pistol_draw_03.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER", "weapons/universal/uni_pistol_holster.wav")
	
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_GRENADE_DRAW", {"weapons/universal/uni_grenade_draw_01.wav", "weapons/universal/uni_grenade_draw_02.wav", "weapons/universal/uni_grenade_draw_03.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_GRENADE_HOLSTER", "weapons/universal/uni_grenade_holster.wav")
	
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART", "weapons/universal/uni_bipoddeploy_start.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND", "weapons/universal/uni_bipoddeploy_end.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT", "weapons/universal/uni_bipodretract.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_BIPOD_SWIVEL", {"weapons/universal/uni_bipod_swivel_01.wav", "weapons/universal/uni_bipod_swivel_02.wav", "weapons/universal/uni_bipod_swivel_03.wav", "weapons/universal/uni_bipod_swivel_04.wav", "weapons/universal/uni_bipod_swivel_05.wav"})
	
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_LEFTCRAWL", {"weapons/universal/uni_crawl_l_01.wav", "weapons/universal/uni_crawl_l_02.wav", "weapons/universal/uni_crawl_l_02.wav", "weapons/universal/uni_crawl_l_04.wav", "weapons/universal/uni_crawl_l_05.wav", "weapons/universal/uni_crawl_l_06.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_RIGHTCRAWL", {"weapons/universal/uni_crawl_r_01.wav", "weapons/universal/uni_crawl_r_02.wav", "weapons/universal/uni_crawl_r_03.wav", "weapons/universal/uni_crawl_r_04.wav", "weapons/universal/uni_crawl_r_05.wav", "weapons/universal/uni_crawl_r_06.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_LEANIN", { "weapons/universal/uni_lean_in_01.wav", "weapons/universal/uni_lean_in_02.wav", "weapons/universal/uni_lean_in_03.wav", "weapons/universal/uni_lean_in_04.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_LEANOUT", { "weapons/universal/uni_lean_out_01.wav", "weapons/universal/uni_lean_out_02.wav", "weapons/universal/uni_lean_out_03.wav", "weapons/universal/uni_lean_out_04.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_UNIVERSAL_WEAPONLOWER", "weapons/universal/uni_weapon_lower_01.wav")
	
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GL_BEGINRELOAD", {"weapons/universal/uni_gl_beginreload_01.wav", "weapons/universal/uni_gl_beginreload_02.wav", "weapons/universal/uni_gl_beginreload_03.wav"})
	
	// M203
	CustomizableWeaponry:addFireSound("CW_KK_INS2_M203_FIRE", "weapons/m203/m203_fp.wav", 1, 105, CHAN_STATIC)
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_CLOSEBARREL", "weapons/m203/handling/m203_closebarrel.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_DESELECT", "weapons/m203/handling/m203_deselect.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_EMPTY", "weapons/m203/handling/m203_empty.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_INSERTGRENADE", {"weapons/m203/handling/m203_insertgrenade_01.wav", "weapons/m203/handling/m203_insertgrenade_02.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_OPENBARREL", "weapons/m203/handling/m203_openbarrel.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_SELECT", "weapons/m203/handling/m203_select.wav")

	// GP30
	CustomizableWeaponry:addFireSound("CW_KK_INS2_GP30_FIRE", "weapons/gp30/gp30_fp.wav", 1, 105, CHAN_STATIC)
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_DESELECT", "weapons/gp30/handling/gp30_deselect.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_EMPTY", "weapons/gp30/handling/gp30_empty.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_INSERTGRENADE", {"weapons/gp30/handling/gp30_insertgrenade_01.wav", "weapons/gp30/handling/gp30_insertgrenade_02.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_INSERTGRENADECLICK", "weapons/gp30/handling/gp30_insertgrenade_click.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_SELECT", "weapons/gp30/handling/gp30_select.wav")

// SHELLS
	
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_38", {"weapons/bullets/shells/concrete/38_shell_concrete_01.wav", "weapons/bullets/shells/concrete/38_shell_concrete_02.wav", "weapons/bullets/shells/concrete/38_shell_concrete_03.wav", "weapons/bullets/shells/concrete/38_shell_concrete_04.wav", "weapons/bullets/shells/concrete/38_shell_concrete_05.wav", "weapons/bullets/shells/concrete/38_shell_concrete_06.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_9MM", {"weapons/bullets/shells/concrete/9mm_shell_concrete_01.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_02.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_03.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_04.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_05.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_06.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_FLARE", {"weapons/bullets/shells/concrete/flare_shell_concrete_01.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_02.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_03.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_04.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_M203", {"weapons/bullets/shells/concrete/m203_shell_concrete_01.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_02.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_03.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_04.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_LINK", {"weapons/bullets/shells/concrete/m249_link_concrete_01.wav", "weapons/bullets/shells/concrete/m249_link_concrete_02.wav", "weapons/bullets/shells/concrete/m249_link_concrete_03.wav", "weapons/bullets/shells/concrete/m249_link_concrete_04.wav", "weapons/bullets/shells/concrete/m249_link_concrete_05.wav", "weapons/bullets/shells/concrete/m249_link_concrete_06.wav", "weapons/bullets/shells/concrete/m249_link_concrete_07.wav", "weapons/bullets/shells/concrete/m249_link_concrete_08.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_12G", {"weapons/bullets/shells/concrete/shotgun_shell_concrete_01.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_02.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_03.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_04.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_05.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_06.wav"}, 65)
	
	function CustomizableWeaponry.shells:addNew_KKINS2(name, model, collideSound, angleTweak, angleTweakWorld)
		self.cache[name] = {m = model, s = collideSound, angleTweak = angleTweak, angleTweakWorld = angleTweakWorld}
	end

	local noTweak = {Forward = 0, Right = 0, Up = 0}
	local up90 = {Forward = 0, Right = 0, Up = 90}
	local upneg90 = {Forward = 0, Right = 0, Up = -90}
	local up180 = {Forward = 0, Right = 0, Up = 180}
	
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_9x19", "models/weapons/shells/9x19.mdl", "CW_KK_INS2_SHELL_38", up90, up180)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_12guage", "models/weapons/shells/12guage.mdl", "CW_KK_INS2_SHELL_12G", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_40mm", "models/weapons/shells/40mm.mdl", "CW_KK_INS2_SHELL_M203", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_45apc", "models/weapons/shells/45apc.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_545x39", "models/weapons/shells/545x39.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_556x45", "models/weapons/shells/556x45.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_556x45_link", "models/weapons/shells/556x45_link.mdl", "CW_KK_INS2_SHELL_LINK", up180, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x33", "models/weapons/shells/762x33.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x39", "models/weapons/shells/762x39.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x51", "models/weapons/shells/762x51.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x54", "models/weapons/shells/762x54.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak)
	CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_THROWABLE", "models/weapons/w_gren_spoon.mdl", "", noTweak, noTweak)
	
// AMMO
	
	CustomizableWeaponry:registerAmmo(".30 Carbine", ".30 Carbine Rounds", 7.62, 32.76)
	CustomizableWeaponry:registerAmmo(".38 Special", ".38 Special Rounds", 9.1, 29.3)
	CustomizableWeaponry:registerAmmo("RPG 40MM", "40MM Rocket Propelled Grenades", 0, 0)
	CustomizableWeaponry:registerAmmo("Flare", "Flares for flare gun", 0, 0)
	CustomizableWeaponry:registerAmmo("C4", "C4 explosives", 0, 0)
	CustomizableWeaponry:registerAmmo("IED", "Improvised explosives", 0, 0)
	CustomizableWeaponry:registerAmmo("Incediary", "Incendiary explosives", 0, 0)

// FIREMODES

	CustomizableWeaponry.firemodes:registerFiremode("single", "SINGLE-SHOT", true, 1, 1)
	-- CustomizableWeaponry.firemodes:registerFiremode("throw", "THROWABLE", true, 1, 1)

// KEK

if CustomizableWeaponry_KK.HOME then
	local gren = {}
	gren.name = "40mm_kk_1337"
	gren.display = " - 1337 ROFLKEK"

	function gren:fireFunc()
		CustomizableWeaponry_KK.ins2.fireRPG(self, IsFirstTimePredicted()) // yay I can doo this two
	end

	CustomizableWeaponry.grenadeTypes:addNew(gren)	
end

// KILLS

if CLIENT then
	local killCol = Color(255, 80, 0, 150)
	local white = Color(255, 255, 255, 150)

	killicon.AddFont("cw_kk_ins2_mel_bayonet",		"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_mel_gurkha",		"CW_KillIcons", "j", killCol)
	
	killicon.AddFont("cw_kk_ins2_m9",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m45",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m1911",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_makarov",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_revolver",			"CW_KillIcons", "a", killCol)
	
	killicon.AddFont("cw_kk_ins2_mp5k",				"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_mp40",				"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_sterling",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_ump45",			"CW_KillIcons", "q", killCol)
	
	killicon.AddFont("cw_kk_ins2_ak74",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_akm",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_aks74u",			"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_fnfal",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_galil",			"CW_KillIcons", "v", killCol)
	killicon.AddFont("cw_kk_ins2_l1a1",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m1a1",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m4a1",				"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_m14",				"CW_HUD22", "M14 EBR", white)
	killicon.AddFont("cw_kk_ins2_m16a4",			"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_m40a1",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_m249",				"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_m590",				"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_mini14",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_mk18",				"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_mosin",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_rpk",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_sks",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_toz",				"CW_KillIcons", "k", killCol)
	
	killicon.AddFont("cw_kk_ins2_at4",				"CW_SelectIcons2", "i", killCol)
	killicon.AddFont("cw_kk_ins2_p2a1",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_rpg",				"CW_SelectIcons2", "i", killCol)
	
	killicon.AddFont("cw_kk_ins2_rpg_pro",			"CW_KillIcons", "a", killCol)
	
	// WS pack
	
	killicon.AddFont("cw_kk_ins2_mel_cstm_ninjato",	"CW_KillIcons", "j", killCol)
	
	killicon.AddFont("cw_kk_ins2_cstm_mp7",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_sten",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_uzi",			"CW_KillIcons", "l", killCol)
	
	killicon.AddFont("cw_kk_ins2_cstm_aug",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_famas",		"CW_KillIcons", "t", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_g36c",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_galil_ace",	"CW_KillIcons", "v", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_ksg",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_m14",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_scar",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_spas12",		"CW_KillIcons", "k", killCol)
end