// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_barska_l.mdl"

$BodyGroup "eotech"
{
	studio "v_cw_kk_ins_cstm_barska_l_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_barska\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$Attachment "reticle" "A_RenderReticle" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -2.203 -0.85 -0.235 2.732 0.857 2.032

// $HBoxSet "default"
// $HBox 0 "Eotech" -0.85 -2.732 -0.201 0.857 2.126 2.032

$DefineBone "A_Optic" "" 0 0 0 0 -179.999966 -89.999983 0 0 0 0 0 0
$DefineBone "Eotech" "A_Optic" 0 0 0 0 -179.999966 -90.000037 0 0 0 0 0 0
$DefineBone "A_RenderReticle" "Eotech" 0.000001 0.467468 1.38182 0 -90.000099 90.000037 0 0 0 0 0 0
$DefineBone "Lense" "Eotech" 0.008504 1.049143 1.2672 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"v_cw_kk_ins_cstm_barska_l_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "zoom" {
	"v_cw_kk_ins_cstm_barska_l_anims\zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
