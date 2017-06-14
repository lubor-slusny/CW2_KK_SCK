// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\w_cw_kk_ins2_cstm_eotechxps_2x.mdl"

$BodyGroup "studio"
{
	studio "w_cw_kk_ins_cstm_eotechxps_2x_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_eotechxps\"
$CDMaterials "models\weapons\upgrades\"

$CBox 0 0 0 0 0 0

$BBox 32.967 -3.486 -0.207 35.39 4.354 3.148

// $HBoxSet "default"
// $HBox 0 "4x" -1.21 -0.207 -4.354 1.211 3.148 3.486

$DefineBone "ATTACH_ModKit" "" -0.000001 -33.291592 11.031425 0 -90.000037 90.000037 0 0 0 0 0 0
$DefineBone "4x" "ATTACH_ModKit" 0.000004 -0.000001 0.290966 89.980216 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"w_cw_kk_ins_cstm_eotechxps_2x_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}
