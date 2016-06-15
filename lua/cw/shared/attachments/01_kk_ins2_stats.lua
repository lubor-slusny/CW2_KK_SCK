
// flashlight color

CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT = "KK_FL"
CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = {
	{name = "kk_fl_white",	display = "White",		color = Color(255,255,255,255)},
	{name = "kk_fl_whitew",	display = "Warm White",	color = Color(255,255,200,255)},
	{name = "kk_fl_whitec",	display = "Cold White",	color = Color(200,255,255,255)},
}
	
CustomizableWeaponry.colorableParts.colorText[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = " (HOLD - change light color)"
CustomizableWeaponry.colorableParts.defaultColors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][1]

// Weapon Length

CustomizableWeaponry.originalValue:add("WeaponLength", false, false)
CustomizableWeaponry:registerRecognizedVariable(
	"WeaponLength",
	
	"Decreases weapon length by ",
	
	"Increases weapon length by ",
	
	CustomizableWeaponry.textColors.POSITIVE,
	
	CustomizableWeaponry.textColors.NEGATIVE,
	
	function(weapon, attachmentData)
		weapon.WeaponLength = weapon.WeaponLength + attachmentData.WeaponLength
	end,
	
	function(weapon, attachmentData)
		weapon.WeaponLength = weapon.WeaponLength - attachmentData.WeaponLength
	end,
	
	function(attachmentData, value, varData)
		if value > 0 then
			return varData.greater .. math.abs((math.Round(value * 0.0254, 2))) .. "M", varData.greaterColor
		end
		
		return varData.lesser .. math.abs((math.Round(value * 0.0254, 2))) .. "M", varData.lesserColor
	end
)
