// Created by Crowbar 0.29.0.0

$ModelName "weapons\attachments\v_cw_kk_ins2_cstm_compm4s_l.mdl"

$BodyGroup "optic"
{
	studio "v_cw_kk_ins_cstm_compm4s_l_reference.smd"
}


$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\weapons\attachments\cw_kk_ins2_cstm_compm4s\"
$CDMaterials "models\weapons\upgrades\"
$CDMaterials "models\weapons\optics\"

$Attachment "reticle" "A_RenderReticle" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -1.303 -1.879 -0.498 3.307 1.656 3.082

$DefineBone "A_Optic" "" 0 0 0 0 -179.999966 -89.999983 0 0 0 0 0 0
$DefineBone "aimp" "A_Optic" 0.000814 -0.800869 1.118584 -0.000019 -180.000007 -90.000017 0 0 0 0 0 0
$DefineBone "A_RenderReticle" "aimp" 0.000814 1.483659 0.639159 0 -89.999928 89.999983 0 0 0 0 0 0
$DefineBone "Lense" "aimp" 0.000814 2.132229 0.639159 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"v_cw_kk_ins_cstm_compm4s_l_anims\idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}
