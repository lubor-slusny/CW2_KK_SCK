if not CustomizableWeaponry_KK.HOME then return end
if CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()

CW_KK_SCK = CW_KK_SCK or {}

CW_KK_SCK.AIMPOS_BUILDER = CW_KK_SCK.AIMPOS_BUILDER or {}

local TOOL = CW_KK_SCK.AIMPOS_BUILDER

TOOL.utilityTabName = "CW_KK_SCK_AIMPOS_BUILDER"
TOOL.printName = "AimPos Builder 5.0"

function TOOL:IsValid() return true end

TOOL.buttFunc = {}

function TOOL:updatePanel()
	local PANEL = self.PANEL
	
	if not PANEL then return end
	
	PANEL:ClearControls()

	PANEL:AddControl("Label", {Text = CurTime()})
end

function TOOL:think()
	self.WEAPON = LocalPlayer():GetActiveWeapon()
	
	local curSetup
	
	if IsValid(self.WEAPON) then 
		curSetup = self.WEAPON:GetClass() .. "|" 
		
		if self.WEAPON.ActiveAttachments then
			for k,v in pairs(self.WEAPON.ActiveAttachments) do
				if v then 
					curSetup = curSetup .. k .. "|"
				end
			end
		end
	end
	
	if curSetup != self._think_lastSetup then
		self:updatePanel()
	end
	
	self._think_lastSetup = curSetup
end

function TOOL:PopulateToolMenu()
	local instance = self
	
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", TOOL.utilityTabName, TOOL.printName, "", "", function(panel)
		instance.PANEL = panel
		instance:updatePanel()
		
		hook.Add("Think", instance, instance.think)
	end)
end

hook.Add("PopulateToolMenu", TOOL, TOOL.PopulateToolMenu)

function TOOL:PostReloadToolsMenu()
	hook.Remove("Think", self)
end

hook.Add("PostReloadToolsMenu", TOOL, TOOL.PostReloadToolsMenu)

RunConsoleCommand("spawnmenu_reload")
