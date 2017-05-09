CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.sck = CustomizableWeaponry_KK.sck or {}

local BASE = CustomizableWeaponry_KK.sck

BASE.SpawnMenuTab = "Utilities"
BASE.SpawnMenuTabSection = "Knife Kitty 2.0"

BASE.ToolsFolder = "cw_kk/sck/tools/"
BASE.InternalNamesPrefix = "CW_KK_SCK"
BASE.strCCReload = "cw_kk_sck_reload_folder"

/*
TOOL table structure
	[mandatory]
	Name = "TOOL_NAME"
	PrintName = "Secksy spawnmenu name"
	SetPanel(self, panel)
	
	[optional]
	OnWeaponChanged(self, old, new)
	OnSetupChanged(self)
	
	[internal]
	build or update panel - tool shud call from 
		OnXChanged and SetPanel
*/

function BASE:AddTool(tab)
	if SERVER then return end
	
	if not tab then return end
	if not tab.Name then return end
	if not tab.SetPanel then return end
	
	tab.PrintName = tab.PrintName or tab.Name
	tab.SelectCommand = tab.SelectCommand or ""
	
	self._toolCache = self._toolCache or {}
	local old = self._toolCache[tab.Name]
	if old then
		old.__index = old
		setmetatable(tab, old)
	end
	
	self._toolCache[tab.Name] = tab
end

function BASE:Load()
	for _,v in pairs(file.Find(self.ToolsFolder .. "*", "LUA")) do
		AddCSLuaFile(self.ToolsFolder .. v)
		include(self.ToolsFolder .. v)
	end
end

BASE:Load()

if CLIENT then
	BASE._toolCache = BASE._toolCache or {}
	BASE.IsValid = function(self) return true end

	function BASE:PopulateToolMenu()		
		for name,tool in pairs(self._toolCache) do
			spawnmenu.AddToolMenuOption(
				self.SpawnMenuTab,
				self.SpawnMenuTabSection,
				self.InternalNamesPrefix .. "." .. name, 
				tool.PrintName, 
				tool.SelectCommand, 
				"", 
				function(panel) tool:SetPanel(panel) end
			)
		end
		
		self._spawnMenuPopulated = true
	end

	hook.Add("PopulateToolMenu", BASE, BASE.PopulateToolMenu)

	function BASE:PreReloadToolsMenu()
		for _,tool in pairs(self._toolCache) do
			tool:SetPanel()
		end
		
		self._spawnMenuPopulated = false
	end

	hook.Add("PreReloadToolsMenu", BASE, BASE.PreReloadToolsMenu)

	-- function BASE:PostReloadToolsMenu()
		-- for _,tool in pairs(self._toolCache) do
			-- tool:SetPanel()
		-- end
	-- end

	-- hook.Add("PostReloadToolsMenu", BASE, BASE.PostReloadToolsMenu)

	function BASE:_OnWeaponChanged(new, old)
		for _,tool in pairs(self._toolCache) do
			if tool.OnWeaponChanged then
				tool:OnWeaponChanged(new, old)
			end
		end
	end

	function BASE:_OnSetupChanged()
		for _,tool in pairs(self._toolCache) do
			if tool.OnSetupChanged then
				tool:OnSetupChanged()
			end
		end
	end

	function BASE:Think()
		if !self._spawnMenuPopulated then return end
		
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		
		local wep = ply:GetActiveWeapon()
		if wep != self._lastWep then
			self:_OnWeaponChanged(wep, self._lastWep)
		else
			local curSetup = ""
			
			if IsValid(wep) and wep.ActiveAttachments then
				for k,v in pairs(wep.ActiveAttachments) do
					if v then 
						curSetup = curSetup .. k .. "|"
					end
				end
			end
			
			if curSetup != self._lastSetup then
				self:_OnSetupChanged()
			end
			
			self._lastSetup = curSetup
		end
		self._lastWep = wep
		
		for _,tool in pairs(self._toolCache) do
			if tool.Think then
				tool:Think()
			end
		end
	end

	hook.Add("Think", BASE, BASE.Think)
	
	concommand.Add(BASE.strCCReload, function()
		BASE:Load()
		RunConsoleCommand("spawnmenu_reload")
	end)
end
