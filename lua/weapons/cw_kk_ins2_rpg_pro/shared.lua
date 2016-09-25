if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_soundscript.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Professional Russian"
	
	SWEP.IconLetter = "C"
	
	SWEP.AttachmentModelsVM = {
		["nade"] = {model = "models/weapons/w_at4_projectile.mdl", bone = "Weapon", pos = Vector(0.028, 0.087, 18.68), angle = Angle(-90, 90, 0), size = Vector(0.75, 0.75, 0.75), active = true},
		["fx_light"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.01), attachment = "lighter", active = true, nodraw = true},
		["fx_rag"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(-0.67614, 0.05519, -0.63427), angle = Angle(0, 0, 0), size = Vector(0.01, 0.01, 0.01), attachment = "rag", active = true, nodraw = true},
	}
	
	SWEP.HUD_MagText = "0 > "
end

SWEP.CanRestOnObjects = false

SWEP.Animations = {
	pullpin = "pullback_high",
	throw = "throw",
	
	pull_cook = "pullback_highbake",
	throw_cook = "throw_bake",
	
	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 5

SWEP.Slot = 5
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base_nade"
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_rpg_pro.mdl"
-- SWEP.WorldModel		= "models/weapons/w_at4_projectile.mdl"
SWEP.WorldModel		= "models/weapons/w_cw_kk_ins2_rpg7_projectile_pd2.mdl"

SWEP.WMPos = Vector(14.17, -0.193, -25.729)
SWEP.WMAng = Angle(113.916, 13.63, 0)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.baseContentMounted()
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.baseContentMounted()

SWEP.AdminOnly			= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "PG-7VM Grenade"

SWEP.HolsterTime = 0.6
SWEP.timeToThrow = 1.5
SWEP.swapTime = 0.5

SWEP.canCook = false // this swep should b cook only lol

function SWEP:createProjectile()
	CustomizableWeaponry_KK.ins2.rpgs.fireRPG(self, IsFirstTimePredicted())
end

if CLIENT then
	function SWEP:IndividualInitialize()
		local boneIds = {}
		local vm = self.CW_VM
		
		for _,v in pairs({"Rag_God", "Weapon", "Liq_top", "Bone01", "Bone02", "Bone03", "Bone04", "Bone06", "Bone07"}) do 
			boneIds[v] = vm:LookupBone(v)
		end
		
		for _,v in pairs(boneIds) do 
			vm:ManipulateBoneScale(v, Vector(0.01,0.01,0.01))
		end
	end
	
	local m
	local muz = {}
	
	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
			muz.Pos = m:GetTranslation()
			muz.Ang = m:GetAngles()
			return muz
		end
		
		return self.CW_VM:GetAttachment(2)
	end
end
