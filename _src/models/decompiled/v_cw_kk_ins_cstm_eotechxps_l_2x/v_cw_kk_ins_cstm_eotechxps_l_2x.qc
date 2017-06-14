// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_eotechxps_l_2x.mdl"

$BodyGroup "aimp2x"
{
	studio "v_cw_kk_ins_cstm_eotechxps_l_2x_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_eotechxps\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$Attachment "scope_origin" "A_RenderPoint" 0 0 0 rotate 0 0 0
$Attachment "scope_align" "A_RenderAlign" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -1.874 -1250 -0.356 1.19 4.611 3.627

// $HBoxSet "default"
// $HBox 0 "aimp2x" -1.874 -1250 -0.356 1.189 4.611 3.626

$DefineBone "A_Optic" "" 0 0 0 0 -179.999966 -89.999983 0 0 0 0 0 0
$DefineBone "aimp2x" "A_Optic" 0 0 0 0 -179.999966 -90.000037 0 0 0 0 0 0
$DefineBone "Lense_Reticule" "aimp2x" 0.0021 3.486984 1.442691 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "Lense_RT" "aimp2x" 0.0021 3.412205 1.442799 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "Lense_Ref" "aimp2x" 0.002101 -0.31602 1.44232 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderPoint" "aimp2x" 0.000001 -4.408471 1.440026 0 -89.999983 89.999983 0 0 0 0 0 0
$DefineBone "Optic_Lense" "aimp2x" 0.0021 4.456046 1.442321 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderAlign" "aimp2x" 0.000204 -1250 1.439794 0 -89.999983 89.999983 0 0 0 0 0 0


$Sequence "4x_idle" {
	"v_cw_kk_ins_cstm_eotechxps_l_2x_anims\4x_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "4x_zoom" {
	"v_cw_kk_ins_cstm_eotechxps_l_2x_anims\4x_zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
