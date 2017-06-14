// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_acog.mdl"

$BodyGroup "optic"
{
	studio "v_cw_kk_ins_cstm_acog_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_acog\"
$CDMaterials "models\weapons\optics\"
$CDMaterials "models\weapons\upgrades\"

$Attachment "scope_origin" "A_RenderPoint" 0 0 0 rotate 0 0 0
$Attachment "scope_align" "A_RenderAlign" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -3.658 -1.015 -0.331 1000 1.076 2.598

$DefineBone "A_Optic" "" 0 0 0 0.000057 -179.999856 -89.999812 0 0 0 0 0 0
$DefineBone "elcan" "A_Optic" 0 0 0 0.000019 -180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "A_RenderPoint" "elcan" 0.000001 -1.643948 1.480479 0 -89.999928 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderAlign" "elcan" 0.000088 -1000 1.480479 0 -89.999928 90.000037 0 0 0 0 0 0
$DefineBone "Lense_Ref" "elcan" 0 1.940301 1.476381 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Lense_RT" "elcan" 0 2.161421 1.475605 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Lense_Reticule" "elcan" 0 2.19623 1.474631 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Optic_Lense" "elcan" 0.00168 3.581237 1.475922 0.000688 -0.030023 90.000037 0 0 0 0 0 0


$Sequence "elcan_idle" {
	"v_cw_kk_ins_cstm_acog_anims\elcan_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "elcan_zoom" {
	"v_cw_kk_ins_cstm_acog_anims\elcan_zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
