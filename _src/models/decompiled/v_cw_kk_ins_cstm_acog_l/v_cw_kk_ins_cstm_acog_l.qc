// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_acog_l.mdl"

$BodyGroup "optic"
{
	studio "v_cw_kk_ins_cstm_acog_l_reference.smd"
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

$BBox -4.375 -1.214 -0.396 1200 1.286 3.107

$DefineBone "A_Optic" "" 0 0 0 -0.000019 -180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "elcan" "A_Optic" 0 0 0 -0.000019 180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "A_RenderPoint" "elcan" 0.000001 -1.972738 1.776575 0 -89.999928 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderAlign" "elcan" 0.000106 -1200 1.776575 0 -89.999928 90.000037 0 0 0 0 0 0
$DefineBone "Lense_RT" "elcan" 0 2.585575 1.770726 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Lense_Reticule" "elcan" 0 2.627346 1.769557 0 0.000057 0 0 0 0 0 0 0
$DefineBone "Lense_Ref" "elcan" 0 2.32023 1.771657 0 0.000057 0 0 0 0 0 0 0
$DefineBone "lens_mesh_front" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "elcan_idle" {
	"v_cw_kk_ins_cstm_acog_l_anims\elcan_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "elcan_zoom" {
	"v_cw_kk_ins_cstm_acog_l_anims\elcan_zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
