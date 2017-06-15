CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.sck = CustomizableWeaponry_KK.sck or {}

local BASE = CustomizableWeaponry_KK.sck

BASE.SpawnMenuTab = "Utilities"
BASE.SpawnMenuTabSection = "Knife Kitty"

BASE.ToolsFolder = "cw_kk/sck/tools/"
BASE.InternalNamesPrefix = "CW_KK_SCK"
BASE.strCCReload = "cw_kk_sck_reload_folder"
BASE.strCCRebuild = "cw_kk_sck_rebuild_panels"
BASE.strKnownGLDTKeys = "M203Active|INS2GLActive"

function BASE:Load()
	if CLIENT then
		local reload = self._toolCache != nil
		
		self._toolCache = {}
		self._lastWep = nil
		self._lastSetup = nil
		
		self._knowGLDTkeys = string.Explode("|", self.strKnownGLDTKeys)
	end
	
	for _,v in pairs(file.Find(self.ToolsFolder .. "*", "LUA")) do
		AddCSLuaFile(self.ToolsFolder .. v)
		if CLIENT then
			include(self.ToolsFolder .. v)
		end
	end
	
	if CLIENT then
		if reload then
			RunConsoleCommand("spawnmenu_reload")
		end
	end
end

if SERVER then
	BASE:Load()
end

AddCSLuaFile("client.lua")
if CLIENT then
	include("client.lua")
end