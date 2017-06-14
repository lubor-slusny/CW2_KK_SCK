// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_compm4s_l_2x.mdl"

$BodyGroup "optic"
{
	studio "v_cw_kk_ins_cstm_compm4s_l_2x_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_compm4s\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$Attachment "scope_origin" "A_RenderPoint" 0 0 0 rotate 0 0 0
$Attachment "scope_align" "A_RenderAlign" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -4.45 -1.802 -0.474 1200 1.594 2.965

$DefineBone "A_Optic" "" 0 0 0 0 -179.999966 -89.999983 0 0 0 0 0 0
$DefineBone "aimp2x" "A_Optic" 0 0 0 -0.000019 -180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "Lense_Reticule" "aimp2x" 0.002016 3.347505 1.384984 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "Lense_RT" "aimp2x" 0.002016 3.275717 1.385087 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "Lense_Ref" "aimp2x" 0.002017 -0.303379 1.384627 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderPoint" "aimp2x" 0.000001 -4.232132 1.382425 0 -89.999983 89.999983 0 0 0 0 0 0
$DefineBone "Optic_Lense" "aimp2x" 0.002016 4.277804 1.384628 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderAlign" "aimp2x" 0.000196 -1200 1.382202 0 -89.999983 89.999983 0 0 0 0 0 0


$Sequence "4x_idle" {
	"v_cw_kk_ins_cstm_compm4s_l_2x_anims\4x_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "4x_zoom" {
	"v_cw_kk_ins_cstm_compm4s_l_2x_anims\4x_zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
