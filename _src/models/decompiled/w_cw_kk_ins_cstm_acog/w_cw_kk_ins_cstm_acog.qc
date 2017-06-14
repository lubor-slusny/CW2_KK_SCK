// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\w_cw_kk_ins2_cstm_acog.mdl"

$BodyGroup "studio"
{
	studio "w_cw_kk_ins_cstm_acog_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_acog\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$CBox 0 0 0 0 0 0

$BBox 48.668 -1.005 10.634 54.155 1.065 13.535

$DefineBone "ATTACH_ModKit" "" -0.000005 -52.354969 10.933355 0.000019 -90.000017 90.000017 0 0 0 0 0 0
$DefineBone "ELCAN" "ATTACH_ModKit" -0.700996 1.142082 -0.000005 -89.980216 -89.999983 0 0 0 0 0 0 0


$Sequence "idle" {
	"w_cw_kk_ins_cstm_acog_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}
