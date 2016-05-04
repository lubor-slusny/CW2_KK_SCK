
if CLIENT then
	CreateClientConVar("cw_kk_ins2_rig", 1, true, true)
	
	CustomizableWeaponry_KK.ins2.hands = {
		"models/weapons/v_hands_ins_h.mdl",
		"models/weapons/v_hands_ins_l.mdl",
		"models/weapons/v_hands_ins_m.mdl",
		"models/weapons/v_hands_sec_h.mdl",
		"models/weapons/v_hands_sec_l.mdl",
		"models/weapons/v_hands_sec_m.mdl",
		"models/weapons/v_hands_vip.mdl",
		"models/weapons/v_cw_kk_ins2_hands_css.mdl",
	}
	
	if not CustomizableWeaponry_KK.panels then
		CustomizableWeaponry_KK.panels = {}
	end
	
	CustomizableWeaponry_KK.panels.ins2 = function(panel)
		panel:AddControl("Label", {Text = "INS2 Pack:"}):DockMargin( 0, 0, 8, 8 )
		
		panel:AddControl("Slider", {
			Label = "Rig:",
			Type = "Integer",
			Min = "1",
			Max = table.Count(CustomizableWeaponry_KK.ins2.hands),
			Command = "cw_kk_ins2_rig"
		}):DockMargin( 8, 0, 8, 8 )
	end	
end
