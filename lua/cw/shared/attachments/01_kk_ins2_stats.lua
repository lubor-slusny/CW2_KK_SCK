
// flashlight color, shared

	CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT = "KK_FL"
	CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = {
		{name = "kk_fl_white",	display = "White",		color = Color(255,255,255,255)},
		{name = "kk_fl_whitew",	display = "Warm White",	color = Color(255,255,200,255)},
		{name = "kk_fl_whitec",	display = "Cold White",	color = Color(200,255,255,255)},
	}
		
	CustomizableWeaponry.colorableParts.colorText[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = " (HOLD - change light color)"
	CustomizableWeaponry.colorableParts.defaultColors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][1]

// more stats

	-- CustomizableWeaponry:registerRecognizedStat("SpeedDec", "Decreases movement speed", "Increases movement speed", nok, ok)
	-- CustomizableWeaponry:registerRecognizedStat("WeaponLength", "Decreases weapon length", "Increases weapon length", ok, nok)
