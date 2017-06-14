// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_compm4s_2x.mdl"

$BodyGroup "optic"
{
	studio "v_cw_kk_ins_cstm_compm4s_2x_reference.smd"
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

$BBox -3.702 -1.499 -0.394 1000 1.326 2.467

$DefineBone "A_Optic" "" 0 0 0 0 -179.999966 -89.999983 0 0 0 0 0 0
$DefineBone "aimp2x" "A_Optic" 0 0 0 -0.000019 -180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "Lense_Reticule" "aimp2x" 0.00168 2.789587 1.154153 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "Lense_RT" "aimp2x" 0.00168 2.729764 1.154239 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "Lense_Ref" "aimp2x" 0.001681 -0.252816 1.153856 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderPoint" "aimp2x" 0.000001 -3.526777 1.152021 0 -89.999983 89.999983 0 0 0 0 0 0
$DefineBone "Optic_Lense" "aimp2x" 0.00168 3.564837 1.153857 0.000688 -0.030023 90.000037 0 0 0 0 0 0
$DefineBone "A_RenderAlign" "aimp2x" 0.000163 -1000 1.151835 0 -89.999983 89.999983 0 0 0 0 0 0


$Sequence "4x_idle" {
	"v_cw_kk_ins_cstm_compm4s_2x_anims\4x_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "4x_zoom" {
	"v_cw_kk_ins_cstm_compm4s_2x_anims\4x_zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
