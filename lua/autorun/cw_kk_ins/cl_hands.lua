
if CLIENT then
	CustomizableWeaponry_KK.ins2.hands = {
		{"models/weapons/v_hands_ins_h.mdl", "[INS] T Heavy"},
		{"models/weapons/v_hands_ins_m.mdl", "[INS] T Medium"},
		{"models/weapons/v_hands_ins_l.mdl", "[INS] T Light"},
		{"models/weapons/v_hands_sec_h.mdl", "[INS] CT Heavy"},
		{"models/weapons/v_hands_sec_m.mdl", "[INS] CT Medium"},
		{"models/weapons/v_hands_sec_l.mdl", "[INS] CT Light"},
		{"models/weapons/v_hands_vip.mdl", "[INS] Very Individual Player"},
		
		{"models/weapons/v_cw_kk_ins2_hands_css.mdl", "[CSS] shared"},
	}
	
	local function add(tab)
		table.insert(CustomizableWeaponry_KK.ins2.hands, tab)
	end
	
	if CustomizableWeaponry_KK.ins2.isContentMounted4({Folder = "weapons/doigameContentOK"}) then
		add({"models/weapons/v_hands_short_brit.mdl", "[DOI] GB Short"})
		add({"models/weapons/v_hands_brit.mdl", "[DOI] GB Sleeve"})
		add({"models/weapons/v_hands_brit_gloves.mdl", "[DOI] GB Gloved"})
		add({"models/weapons/v_hands_short_brit_indian.mdl", "[DOI] GB India Short"})
		add({"models/weapons/v_hands_brit_indian.mdl", "[DOI] GB India Sleeve"})
		
		add({"models/weapons/v_hands_short_us.mdl", "[DOI] US Short"})
		add({"models/weapons/v_hands_us.mdl", "[DOI] US Sleeve"})
		add({"models/weapons/v_hands_us_glove.mdl", "[DOI] US Gloved"})
		add({"models/weapons/v_hands_us_buffalo.mdl", "[DOI] US Buff Sleeve"})
		add({"models/weapons/v_hands_us_glove_airborne.mdl", "[DOI] US Para"})
		
		add({"models/weapons/v_hands_short_ger.mdl", "[DOI] DE Short"})
		add({"models/weapons/v_hands_ger.mdl", "[DOI] DE Sleeve"})
		add({"models/weapons/v_hands_ger_gloves.mdl", "[DOI] DE Gloved"})
		add({"models/weapons/v_hands_ger_wehrmacht.mdl", "[DOI] DE Wehr Sleeve"})
		add({"models/weapons/v_hands_ger_gloves_wehrmacht.mdl", "[DOI] DE Wehr Gloved"})
		add({"models/weapons/v_hands_ger_gloves_paratrooper.mdl", "[DOI] DE Para"})
	end
	
	if CustomizableWeaponry_KK.ins2.isContentMounted4({Folder = "weapons/cw_kk_ins2_nam_"}) then
		add({"models/weapons/v_hands_short_us_nam.mdl", "[B2K] US Short"})
		add({"models/weapons/v_nam_hands_us.mdl", "[B2K] US Sleeve"})
		add({"models/weapons/v_hands_short_us_black.mdl", "[B2K] US2 Short"})
		add({"models/weapons/v_hands_nva.mdl", "[B2K] NVA Short"})
	end
end
