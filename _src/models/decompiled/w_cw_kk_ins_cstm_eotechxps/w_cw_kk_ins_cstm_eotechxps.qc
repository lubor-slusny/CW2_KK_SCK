// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\w_cw_kk_ins2_cstm_eotechxps.mdl"

$BodyGroup "studio"
{
	studio "w_cw_kk_ins_cstm_eotechxps_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_eotechxps\"
$CDMaterials "models\weapons\upgrades\"

$CBox 0 0 0 0 0 0

$BBox 33.503 -2.272 -0.226 35.457 2.253 1.979

// $HBoxSet "default"
// $HBox 0 "EO" -0.822 -0.17 -2.253 0.821 1.979 2.272

$DefineBone "ATTACH_ModKit" "" 0 0.043247 15.609779 0 -90.000037 90.000037 0 0 0 0 0 0
$DefineBone "EO" "ATTACH_ModKit" 0 0 0 89.980216 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"w_cw_kk_ins_cstm_eotechxps_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}
