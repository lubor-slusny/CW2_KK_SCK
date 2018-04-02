AddCSLuaFile()

CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.sck = CustomizableWeaponry_KK.sck or {}

local BASE = CustomizableWeaponry_KK.sck

BASE.SpawnMenuTab = "Utilities"
BASE.SpawnMenuTabSection = "Knife Kitty"

BASE.ToolsFolder = "cw_kk/sck/tools/"
BASE.InternalNamesPrefix = "CW_KK_SCK"
BASE.strCCReload = "cw_kk_sck_reload_folder"
BASE.strCCReloadClient = "_cw_kk_sck_reload_cl"
BASE.strKnownGLDTKeys = "M203Active|INS2GLActive"

BASE.strCVMenuTab = "cw_kk_sck_menu_tab"
BASE.strCVMenuTabSection = "cw_kk_sck_menu_tab_section"

function BASE:Load()
	print("[KK SCK] starting tool folder scan")

	local reload

	if CLIENT then
		reload = self._toolCache != nil

		self._toolCache = {}
		self._lastWep = nil
		self._lastSetup = nil

		self._knownGLDTkeys = string.Explode("|", self.strKnownGLDTKeys)

		BASE.cvMenuTab = CreateClientConVar(BASE.strCVMenuTab, BASE.SpawnMenuTab, true, false)
		BASE.cvMenuTabSection = CreateClientConVar(BASE.strCVMenuTabSection, BASE.SpawnMenuTabSection, true, false)
	end

	for _,v in pairs(file.Find(self.ToolsFolder .. "*", "LUA")) do
		AddCSLuaFile(self.ToolsFolder .. v)
		if CLIENT then
			print("[KK SCK] loading file " .. v)
			include(self.ToolsFolder .. v)
		end
	end

	if CLIENT then
		if reload then
			RunConsoleCommand("spawnmenu_reload")
		end
	end

	print("[KK SCK] finished tool folder scan")
end

if SERVER then
	BASE:Load()
end

AddCSLuaFile("client.lua")
if CLIENT then
	include("client.lua")
end

if SERVER then
	concommand.Add(BASE.strCCReload, function(ply)
		print("[KK SCK] reload")
		BASE:Load()

		if IsValid(ply) then
			ply:ConCommand(BASE.strCCReloadClient)
		end
	end)
end
