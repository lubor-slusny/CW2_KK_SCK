// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_microt1.mdl"

$BodyGroup "aimp2x"
{
	studio "v_cw_kk_ins_cstm_microt1_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$Opaque

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_microt1\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$Attachment "reticle" "A_RenderReticle" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -0.811 -0.979 -0.247 2.375 0.477 1.838

$DefineBone "A_Optic" "" 0 0 0 0 -179.999966 -89.999983 0 0 0 0 0 0
$DefineBone "aimp" "A_Optic" 0.000651 -0.640695 0.894867 0 -179.999966 -90.000037 0 0 0 0 0 0
$DefineBone "A_RenderReticle" "aimp" 0.000651 1.186927 0.511327 0 -89.999928 89.999983 0 0 0 0 0 0
$DefineBone "Lense" "aimp" 0.000651 1.705783 0.511327 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"v_cw_kk_ins_cstm_microt1_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
