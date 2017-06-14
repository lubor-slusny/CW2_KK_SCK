// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_eotechxps.mdl"

$BodyGroup "eotech"
{
	studio "v_cw_kk_ins_cstm_eotechxps_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_eotechxps\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$Attachment "reticle" "A_RenderReticle" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -0.889 -3.206 -0.197 0.902 1.772 1.747

// $HBoxSet "default"
// $HBox 0 "Eotech" -0.709 -2.277 -0.167 0.714 1.772 1.694

$DefineBone "A_Optic" "" 0 0 0 0 -179.999966 -89.999983 0 0 0 0 0 0
$DefineBone "Eotech" "A_Optic" 0 0 0 0 -179.999966 -90.000037 0 0 0 0 0 0
$DefineBone "A_RenderReticle" "Eotech" 0.000001 0.389557 1.151517 0 -90.000099 90.000037 0 0 0 0 0 0


$Sequence "idle" {
	"v_cw_kk_ins_cstm_eotechxps_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "zoom" {
	"v_cw_kk_ins_cstm_eotechxps_anims\zoom.smd"
	activity "ACT_VM_ZOOM" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
