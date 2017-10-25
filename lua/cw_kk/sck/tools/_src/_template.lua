AddCSLuaFile()

local TOOL = {}

TOOL.Name = "template"
TOOL.PrintName = "Tool File Template"

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep

	if !IsValid(panel) then return end

	panel:ClearControls()

	if !IsValid(wep) then
		self:ThrowNewInvalidWeapon()
		return
	end

	if !wep.CW20Weapon then
		self:ThrowNewNotCW2Weapon()
		return
	end

	panel:AddControl("Label", {Text = "2doo"})
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

function TOOL:OnWeaponChanged(new, old)
	self._wep = new
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

-- TOOL:_updatePanel() -- only use with SCK loader

/*
To make this file standalone (not dependent on SCK loader),
uncomment following and drop file into lua/autorun/client/
*/

-- MenuTab = "Utilities"
-- MenuTabSection = "Knife Kitty"
-- spawnmenu.AddToolMenuOption(
	-- MenuTab:GetString(),
	-- MenuTabSection:GetString(),
	-- "CW_KK_SCK_SA." .. TOOL.name,
	-- TOOL.PrintName,
	-- TOOL.SelectCommand or "",
	-- "",
	-- function(panel) TOOL:SetPanel(panel) end
-- )
