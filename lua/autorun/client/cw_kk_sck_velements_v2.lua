AddCSLuaFile()

CW_KK_SCK = CW_KK_SCK or {}

CW_KK_SCK.ELEMENT_BROWSER = CW_KK_SCK.ELEMENT_BROWSER or {}

local TOOL = CW_KK_SCK.ELEMENT_BROWSER

TOOL.utilityTabName = "CW_KK_SCK_ELEMENT_BROWSER"
TOOL.printName = "Element Browser 2.0"

function TOOL:IsValid() return true end

TOOL.buttFunc = {
	updatePanel = function()
		TOOL:updatePanel()
	end,
	
	
}

function TOOL:updatePanel()
	local PANEL = self.PANEL
	
	if not PANEL then return end
	
	PANEL:ClearControls()
	PANEL:AddHeader()

	local butt
	butt = vgui.Create("DButton", PANEL)
	butt:SetTooltip("Loads changes made outside of this tool.")
	butt:DockMargin(0, 0, 0, 8)	
	butt:SetText("Refresh")
	butt.DoClick = self.buttFunc.updatePanel
	
	PANEL:AddItem(butt)
	
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
