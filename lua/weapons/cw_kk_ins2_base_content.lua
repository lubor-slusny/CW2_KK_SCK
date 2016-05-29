
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

	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_DRAW", {"weapons/universal/uni_weapon_draw_01.wav", "weapons/universal/uni_weapon_draw_02.wav", "weapons/universal/uni_weapon_draw_03.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_HOLSTER", "weapons/universal/uni_weapon_holster.wav")
	
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_PISTOL_DRAW", {"weapons/universal/uni_pistol_draw_01.wav", "weapons/universal/uni_pistol_draw_02.wav", "weapons/universal/uni_pistol_draw_03.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER", "weapons/universal/uni_pistol_holster.wav")
	
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_GRENADE_DRAW", {"weapons/universal/uni_grenade_draw_01.wav", "weapons/universal/uni_grenade_draw_02.wav", "weapons/universal/uni_grenade_draw_03.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_GRENADE_HOLSTER", "weapons/universal/uni_grenade_holster.wav")
	
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART", "weapons/universal/uni_bipoddeploy_start.wav")
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND", "weapons/universal/uni_bipoddeploy_end.wav")
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT", "weapons/universal/uni_bipodretract.wav")
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_SWIVEL", {"weapons/universal/uni_bipod_swivel_01.wav", "weapons/universal/uni_bipod_swivel_02.wav", "weapons/universal/uni_bipod_swivel_03.wav", "weapons/universal/uni_bipod_swivel_04.wav", "weapons/universal/uni_bipod_swivel_05.wav"})
	
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_LEFTCRAWL", {"weapons/universal/uni_crawl_l_01.wav", "weapons/universal/uni_crawl_l_02.wav", "weapons/universal/uni_crawl_l_02.wav", "weapons/universal/uni_crawl_l_04.wav", "weapons/universal/uni_crawl_l_05.wav", "weapons/universal/uni_crawl_l_06.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_RIGHTCRAWL", {"weapons/universal/uni_crawl_r_01.wav", "weapons/universal/uni_crawl_r_02.wav", "weapons/universal/uni_crawl_r_03.wav", "weapons/universal/uni_crawl_r_04.wav", "weapons/universal/uni_crawl_r_05.wav", "weapons/universal/uni_crawl_r_06.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_LEANIN", { "weapons/universal/uni_lean_in_01.wav", "weapons/universal/uni_lean_in_02.wav", "weapons/universal/uni_lean_in_03.wav", "weapons/universal/uni_lean_in_04.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_LEANOUT", { "weapons/universal/uni_lean_out_01.wav", "weapons/universal/uni_lean_out_02.wav", "weapons/universal/uni_lean_out_03.wav", "weapons/universal/uni_lean_out_04.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_WEAPONLOWER", "weapons/universal/uni_weapon_lower_01.wav")
	
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

	// WW2 
	CustomizableWeaponry:addFireSound("CW_KK_INS2_WW2_MELEE", {"weapons/universal/weapon_melee_01.wav","weapons/universal/weapon_melee_02.wav","weapons/universal/weapon_melee_03.wav","weapons/universal/weapon_melee_04.wav","weapons/universal/weapon_melee_05.wav","weapons/universal/weapon_melee_06.wav"}, 1, 105, CHAN_STATIC)
	CustomizableWeaponry:addFireSound("CW_KK_INS2_WW2_MELEEHIT", {"weapons/universal/weapon_melee_hitworld_01.wav","weapons/universal/weapon_melee_hitworld_02.wav"}, 1, 105, CHAN_STATIC)
	
// SHELLS
do
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_38", {"weapons/bullets/shells/concrete/38_shell_concrete_01.wav", "weapons/bullets/shells/concrete/38_shell_concrete_02.wav", "weapons/bullets/shells/concrete/38_shell_concrete_03.wav", "weapons/bullets/shells/concrete/38_shell_concrete_04.wav", "weapons/bullets/shells/concrete/38_shell_concrete_05.wav", "weapons/bullets/shells/concrete/38_shell_concrete_06.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_9MM", {"weapons/bullets/shells/concrete/9mm_shell_concrete_01.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_02.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_03.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_04.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_05.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_06.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_FLARE", {"weapons/bullets/shells/concrete/flare_shell_concrete_01.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_02.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_03.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_04.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_M203", {"weapons/bullets/shells/concrete/m203_shell_concrete_01.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_02.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_03.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_04.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_LINK", {"weapons/bullets/shells/concrete/m249_link_concrete_01.wav", "weapons/bullets/shells/concrete/m249_link_concrete_02.wav", "weapons/bullets/shells/concrete/m249_link_concrete_03.wav", "weapons/bullets/shells/concrete/m249_link_concrete_04.wav", "weapons/bullets/shells/concrete/m249_link_concrete_05.wav", "weapons/bullets/shells/concrete/m249_link_concrete_06.wav", "weapons/bullets/shells/concrete/m249_link_concrete_07.wav", "weapons/bullets/shells/concrete/m249_link_concrete_08.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_12G", {"weapons/bullets/shells/concrete/shotgun_shell_concrete_01.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_02.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_03.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_04.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_05.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_06.wav"}, 65)
	
	if CLIENT then
		local convertedSounds = {}
		local allMaterials = ""
		
		hook.Add("InitPostEntity", "CW_KK_INS2_INIT_PHYSMAT", function()
			-- print("initializing physmats:", allMaterials)
			physenv.AddSurfaceData(allMaterials)
		end)
		
		function CustomizableWeaponry.shells:addNew_KKINS2(name, model, sound, rotationView, rotationWorld, BBoxMins, BBoxMaxs)
			if not convertedSounds[sound] then

				allMaterials = [[
"]] .. sound .. [["
{
	"impacthard"	"]] .. sound .. [["
	"impactsoft"	"]] .. sound .. [["
	
	"audiohardnessfactor" "0.0"
	"audioroughnessfactor" "0.0"

	"scrapeRoughThreshold" "1.0"
	"impactHardThreshold" "1.0"
}

]] .. allMaterials

				convertedSounds[sound] = true
			end
			
			self.cache[name] = {
				m = model, 
				s = sound,
				rv = rotationView, 
				rw = rotationWorld, 
				bbmin = BBoxMins, 
				bbmax = BBoxMaxs
			}
		end
		
		local noTweak = {Forward = 0, Right = 0, Up = 0}
		local up90 = {Forward = 0, Right = 0, Up = 90}
		local upneg90 = {Forward = 0, Right = 0, Up = -90}
		local up180 = {Forward = 0, Right = 0, Up = 180}
		
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_12guage", "models/weapons/shells/12guage.mdl", "CW_KK_INS2_SHELL_12G", upneg90, noTweak, Vector(-0.4, -1.2, -0.4), Vector(0.4, 1.2, 0.4))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_40mm", "models/weapons/shells/40mm.mdl", "CW_KK_INS2_SHELL_M203", upneg90, noTweak, Vector(-0.8, -0.8, 0), Vector(0.8, 0.8, 2))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_45apc", "models/weapons/shells/45apc.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak, Vector(-0.25, -0.5, -0.25), Vector(0.25, 0.5, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_545x39", "models/weapons/shells/545x39.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak, Vector(-0.25, -1.15, -0.25), Vector(0.25, 1.15, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_556x45", "models/weapons/shells/556x45.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak, Vector(-0.2, -1, -0.2), Vector(0.2, 1, 0.2))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_556x45_link", "models/weapons/shells/556x45_link.mdl", "CW_KK_INS2_SHELL_LINK", up180, upneg90, Vector(-0.65, -0.5, -0.25), Vector(0.9, 0.55, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x33", "models/weapons/shells/762x33.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak, Vector(-0.15, -0.5, -0.15), Vector(0.15, 0.5, 0.15))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x39", "models/weapons/shells/762x39.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak, Vector(-0.2, -0.9, -0.2), Vector(0.2, 0.9, 0.2))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x51", "models/weapons/shells/762x51.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak, Vector(-0.25, -1.25, -0.25), Vector(0.25, 1.25, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x54", "models/weapons/shells/762x54.mdl", "CW_KK_INS2_SHELL_38", upneg90, noTweak, Vector(-0.25, -1.25, -0.25), Vector(0.25, 1.25, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_9x19", "models/weapons/shells/9x19.mdl", "CW_KK_INS2_SHELL_38", up90, up180, Vector(-0.2, -0.4, -0.2), Vector(0.2, 0.4, 0.2))
		
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_SPOON", "models/weapons/w_gren_spoon.mdl", "CW_KK_INS2_SHELL_M203", noTweak, noTweak)
		
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_GARAND", "models/weapons/shells/garand_clip.mdl", "CW_KK_INS2_SHELL_M203", noTweak, up90, Vector(-0.55, -0.45, -0.85), Vector(0.55, 0.45, 0.85))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_REVOLVER", "models/weapons/upgrades/a_speedloader_rev.mdl", "CW_KK_INS2_SHELL_12G", noTweak, noTweak, Vector(-0.8, -0.55, -0.55), Vector(0.25, 0.55, 0.55))
		
		// models/weapons/w_at4.mdl Vector(-33, -3, -1), Vector(9.5, 3, 5)
		// 
		
		CustomizableWeaponry:addRegularSound("CW_KK_CSS_SHELL_M72", "weapons/cw_kk_css_m72/law_shell.wav", 65)
		CustomizableWeaponry.shells:addNew_KKINS2("KK_CSS_M72", "models/weapons/w_cw_kk_css_m72.mdl", "CW_KK_CSS_SHELL_M72", noTweak, noTweak, Vector(-18.5, -1.7, -0.2), Vector(18, 1, 2.5))
	end
end
// AMMO
	
	CustomizableWeaponry:registerAmmo(".30 Carbine", ".30 Carbine Rounds", 7.62, 32.76)
	CustomizableWeaponry:registerAmmo(".38 Special", ".38 Special Rounds", 9.1, 29.3)
	CustomizableWeaponry:registerAmmo(".357 Magnum", ".357 Magnum Rounds", 9.1, 33)
	CustomizableWeaponry:registerAmmo(".380 ACP", ".380 ACP Rounds", 9, 17.3)
	
	CustomizableWeaponry:registerAmmo(".22 LR", ".22 LR Rounds", 5.6, 15)
	CustomizableWeaponry:registerAmmo("4.6x30MM", "4.6x30MM Rounds", 4.6, 30)
	
	CustomizableWeaponry:registerAmmo(".30-06", ".30-06 Springfield Rounds", 7.62, 63.3)
	CustomizableWeaponry:registerAmmo("7.92x57MM", "7.92x57MM Mauser Rounds", 7.92, 57)
	CustomizableWeaponry:registerAmmo("7.92x33MM", "7.92x33MM Kurz Rounds", 7.92, 33)
	
	-- CustomizableWeaponry:registerAmmo(".30-06 Springfield", ".30-06 Springfield Rounds", 7.62, 63.3)
	-- CustomizableWeaponry:registerAmmo("7.92x57MM Mauser", "7.92x57MM Mauser Rounds", 7.92, 57)
	-- CustomizableWeaponry:registerAmmo("7.92x33MM Kurz", "7.92x33MM Kurz Rounds", 7.92, 33)
	
	CustomizableWeaponry:registerAmmo("PG-7VM Grenade", "PG-7VM Grenades", 0, 0)
	CustomizableWeaponry:registerAmmo("AT4 Launcher", "AT4 Rocket Launchers", 0, 0)
	CustomizableWeaponry:registerAmmo("M6A1 Rocket", "M6A1 Rockets", 0, 0)
	CustomizableWeaponry:registerAmmo("Panzerfaust", "Panzerfaust Rocket Launchers", 0, 0)
	
	CustomizableWeaponry:registerAmmo("25MM Flare", "25MM Flares", 0, 0)
	CustomizableWeaponry:registerAmmo("C4", "C4 explosives", 0, 0)
	CustomizableWeaponry:registerAmmo("IED", "Improvised explosives", 0, 0)
	CustomizableWeaponry:registerAmmo("Incediary", "Incendiary explosives", 0, 0)
	
// FIREMODES

	CustomizableWeaponry.firemodes:registerFiremode("single", "SINGLE-SHOT", true, 1, 1)
	-- CustomizableWeaponry.firemodes:registerFiremode("throw", "THROWABLE", true, 1, 1)

// STATS
do
	local ok = CustomizableWeaponry.textColors.POSITIVE
	local nok = CustomizableWeaponry.textColors.NEGATIVE

	CustomizableWeaponry:registerRecognizedStat("SpeedDec", "Decreases movement speed", "Increases movement speed", nok, ok)
	CustomizableWeaponry:registerRecognizedStat("WeaponLength", "Decreases weapon length", "Increases weapon length", ok, nok)

	CustomizableWeaponry.originalValue:add("SpeedDec", false, false)
	CustomizableWeaponry.originalValue:add("WeaponLength", false, false)
	
	if CLIENT then	
		local stat = {}
		stat.varName = "WeaponLength"
		stat.display = "WEAPON LENGTH"
		stat.desc = "Minimal distance allowed between weapon and target.\nMoving closer to your target will holster your weapon.\nSuppressors and barrel modifications affect this stat."
		stat.reverse = true

		function stat:compare(wep)
			local var1, var2 = wep[self.varName], wep[self.origVarName]

			if !var1 or !var2 then 
				return CustomizableWeaponry.textColors.REGULAR 
			end
			
			if var1 < var2 then
				return CustomizableWeaponry.textColors.POSITIVE
			elseif var1 > var2 then
				return CustomizableWeaponry.textColors.NEGATIVE
			end
		end
		
		local out
		
		function stat:textFunc(wep)
			out = "N/A"
			
			if wep.WeaponLength then
				out = (math.Round(wep.WeaponLength * 0.0254, 2)) .. "M"
			end
			
			return out
		end

		function stat:origTextFunc(wep)
			out = "N/A"
			
			if wep.WeaponLength_Orig then
				out = (math.Round(wep.WeaponLength_Orig * 0.0254, 2)) .. "M"
			end
			
			return out
		end

		CustomizableWeaponry.statDisplay:addStat(stat)
	end
end
// KILLS

if CLIENT then
	local killCol = Color(255, 80, 0, 150)
	local white = Color(255, 255, 255, 150)

	killicon.AddFont("cw_kk_ins2_damage_melee",		"CW_KillIcons", "j", killCol)
	
	killicon.AddFont("cw_kk_ins2_mel_bayonet",		"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_mel_gurkha",		"CW_KillIcons", "j", killCol)
	
	killicon.AddFont("cw_kk_ins2_m9",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m45",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m1911",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_makarov",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_revolver",			"CW_KillIcons", "a", killCol)
	
	killicon.AddFont("cw_kk_ins2_mp5k",				"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_mp40",				"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_sterling",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_ump45",			"CW_KillIcons", "q", killCol)
	
	killicon.AddFont("cw_kk_ins2_ak74",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_akm",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_aks74u",			"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_fnfal",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_galil",			"CW_KillIcons", "v", killCol)
	killicon.AddFont("cw_kk_ins2_l1a1",				"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_m1a1",				"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_m1a1_para",		"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_m4a1",				"CW_KillIcons", "w", killCol)
	-- killicon.AddFont("cw_kk_ins2_m14",				"CW_KillIcons", "i", white)
	killicon.AddFont("cw_kk_ins2_m14",				"CW_HUD22", "M14 EBR", white)
	killicon.AddFont("cw_kk_ins2_m16a4",			"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_m40a1",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_m249",				"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_m590",				"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_mini14",			"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_mk18",				"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_mosin",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_rpk",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_sks",				"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_toz",				"CW_KillIcons", "k", killCol)
	
	killicon.AddFont("cw_kk_ins2_at4",				"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_p2a1",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_rpg",				"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_nade_c4",			"CW_KillIcons", "I", killCol)
	killicon.AddFont("cw_kk_ins2_nade_ied",			"CW_KillIcons", "I", killCol)
	
	killicon.AddFont("cw_kk_ins2_gp25",				"HL2MPTypeDeath", "7", killCol)
	killicon.AddFont("cw_kk_ins2_rpg_pro",			"CW_KillIcons", "a", killCol)
	
	killicon.AddFont("cw_kk_ins2_projectile_at4",	"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_flare",	"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_rpg",	"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_c4",	"CW_KillIcons", "I", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_ied",	"CW_KillIcons", "I", killCol)
	
	killicon.AddFont("cw_kk_ins2_projectile_frag",	"CW_KillIcons", "h", killCol)
	
	// WS pack
	
	killicon.AddFont("cw_kk_ins2_mel_cstm_ninjato",	"CW_KillIcons", "j", killCol)
	
	killicon.AddFont("cw_kk_ins2_cstm_cobra",		"HL2MPTypeDeath", ".", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_mateba",		"HL2MPTypeDeath", ".", killCol)
	
	killicon.AddFont("cw_kk_ins2_cstm_kriss",		"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_mp5a4",		"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_mp7",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_sten",		"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_uzi",			"CW_KillIcons", "l", killCol)
	
	killicon.AddFont("cw_kk_ins2_cstm_aug",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_colt",		"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_famas",		"CW_KillIcons", "t", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_g36c",		"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_galil_ace",	"CW_KillIcons", "v", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_ksg",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_m14",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_m500",		"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_scar",		"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_spas12",		"CW_KillIcons", "k", killCol)
	
	// WW2 pack
	killicon.AddFont("cw_kk_ins2_ww2_k98kknife",	"CW_KillIcons", "j", killCol)
	
	killicon.AddFont("cw_kk_ins2_ww2_luger",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_p38",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_ppk",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_m1911",		"CW_KillIcons", "a", killCol)
	
	killicon.AddFont("cw_kk_ins2_ww2_mp40",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_thom",			"CW_KillIcons", "q", killCol)
	
	killicon.AddFont("cw_kk_ins2_ww2_k98k",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_spring",		"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_bar",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_g43",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_garand",		"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_stg44",		"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_browning",		"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_mg42",			"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_m1",			"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_pump",			"CW_KillIcons", "k", killCol)
	
	killicon.AddFont("cw_kk_ins2_ww2_bazoo",		"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_frag_de",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_frag_us",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_tankfist",		"HL2MPTypeDeath", "3", killCol)
	
	killicon.AddFont("cw_kk_ins2_projectile_m6a1",	"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_pf60",	"HL2MPTypeDeath", "3", killCol)
end

if CLIENT then
	language.Add("cw_kk_ins2_damage_melee", "Melee attack")
	
	language.Add("cw_kk_ins2_projectile_rpg", "PG-7VM grenade")
	language.Add("cw_kk_ins2_projectile_rpg_2", "PG-7VM grenade")
	language.Add("cw_kk_ins2_projectile_at4", "AT4 rocket")
	
	language.Add("cw_kk_ins2_projectile_c4", "Active C4 charge")
	language.Add("cw_kk_ins2_projectile_ied", "Active IED")
	language.Add("cw_kk_ins2_projectile_flare", "25MM Flare")
	
	language.Add("cw_kk_ins2_thrown_molotov", "Fake Molotov")
	
	language.Add("cw_kk_ins2_projectile_m6a1", "M6A1 rocket")
	language.Add("cw_kk_ins2_projectile_pf60", "Panzerfaust projectile")
end

// MAG SYSTEM

if CustomizableWeaponry.magSystem then
	CustomizableWeaponry.magSystem:registerMagType("lmgBox", " LMG belt", 2)
	CustomizableWeaponry.magSystem:registerMagType("revLoader", " Revolver Loader", 6)	
	CustomizableWeaponry.magSystem:registerMagType("m1Clip", " M1 Garand Clip", 6)	
end

-- // KEK

-- if CustomizableWeaponry_KK.HOME then
	-- // RPG
	-- local gren = {}
	-- gren.name = "40mm_kk_1337"
	-- gren.display = " - 1337 ROFLKEK"

	-- function gren:fireFunc()
		-- CustomizableWeaponry_KK.ins2.fireRPG(self, IsFirstTimePredicted()) // yay I can doo this two
	-- end

	-- CustomizableWeaponry.grenadeTypes:addNew(gren)
	
	-- // FRAG
	-- local gren = {}
	-- gren.name = "40mm_kk_1338"
	-- gren.display = " - 1338 ROFLKEK"

	-- function gren:fireFunc()
		-- local pos = self.Owner:GetShootPos()
		-- local offset = CustomizableWeaponry.quickGrenade.getThrowOffset(self)
		-- local eyeAng = self.Owner:EyeAngles()
		-- local forward = eyeAng:Forward()
		
		-- local nade = ents.Create("cw_grenade_thrown")
		-- nade:SetPos(pos + offset)
		-- nade:SetAngles(eyeAng)
		-- nade:Spawn()
		-- nade:Activate()
		-- nade:Fuse(3)
		-- nade:SetOwner(self.Owner)
		
		-- local phys = nade:GetPhysicsObject()
		
		-- if IsValid(phys) then
			-- local overallSideMod = self.Owner:KeyDown(IN_SPEED) and 2 or 1

			-- // take the velocity into account
			-- addMod = math.Clamp(self.Owner:GetVelocity():Length() / self.Owner:GetRunSpeed(), 0, 1)
			
			-- local velocity = forward * CustomizableWeaponry.quickGrenade.throwVelocity + CustomizableWeaponry.quickGrenade.addVelocity
			-- local velNorm = self.Owner:GetVelocity():GetNormal()
			-- velNorm.z = 0
			
			-- // add velocity based on player velocity normal
			-- velocity = velocity + velNorm * CustomizableWeaponry.quickGrenade.movementAddVelocity * addMod
			
			-- phys:SetVelocity(velocity)
			-- phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
		-- end
	-- end

	-- CustomizableWeaponry.grenadeTypes:addNew(gren)	
	
	-- // magnuss
	-- local gren = {}
	-- gren.name = "40mm_kk_1339"
	-- gren.display = " - ANTI-STRIDER"

	-- function gren:fireFunc()
		-- CustomizableWeaponry_KK.ins2.fireHL2EP2(self, IsFirstTimePredicted())
	-- end

	-- CustomizableWeaponry.grenadeTypes:addNew(gren)
	
	-- // balls
	-- local gren = {}
	-- gren.name = "40mm_kk_13399"
	-- gren.display = " - BALLSBALLSBALLSBALLS"

	-- function gren:fireFunc()
		-- CustomizableWeaponry_KK.ins2.fireHL2EP1(self, IsFirstTimePredicted())
	-- end

	-- CustomizableWeaponry.grenadeTypes:addNew(gren)
	
	-- // add mw2 m203 flare kek
-- end
