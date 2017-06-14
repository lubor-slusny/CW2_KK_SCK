// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_acog_m.mdl"

$BodyGroup "optic"
{
	studio "v_cw_kk_ins_cstm_acog_m_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_acog\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$Attachment "scope_origin" "A_RenderPoint" 0 0 0 rotate 0 0 0
$Attachment "scope_align" "A_RenderAlign" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -3.098 -0.86 -0.281 850 0.911 2.2

$DefineBone "A_Optic" "" 0 0 0 -0.000019 -180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "elcan" "A_Optic" 0 0 0 -0.000019 180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "A_RenderPoint" "elcan" 0.000001 -1.397356 1.258407 0 -89.999928 90.000037 0 0 0 0 0 0
$DefineBone "Lense_Ref" "elcan" 0 1.642906 1.254924 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Lense_Reticule" "elcan" 0 1.860447 1.253436 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Lense_RT" "elcan" 0 1.830859 1.254264 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Optic_Lense" "elcan" 0.001428 2.93789 1.254533 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderAlign" "elcan" 0.000075 -850 1.258407 0 -89.999928 90.000037 0 0 0 0 0 0


$Sequence "elcan_idle" {
	"v_cw_kk_ins_cstm_acog_m_anims\elcan_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "elcan_zoom" {
	"v_cw_kk_ins_cstm_acog_m_anims\elcan_zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
