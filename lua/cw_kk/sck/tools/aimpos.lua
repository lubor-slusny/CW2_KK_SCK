if not CustomizableWeaponry_KK.HOME then return end

local TOOL = {}

TOOL.Name = "aimpos"
TOOL.PrintName = "AimPos Builder"
TOOL.Version = "5.0"

function TOOL:Initialize()
	if not self._relevantAttsCache then
		local primary = {}
		local secondary = {}
		local grenade = {}
		
		for _,att in pairs(CustomizableWeaponry.registeredAttachments) do
			local attInfo = {}
			local subCache
			
			if att.isSight then
				subCache = primary
			elseif att.isSecondarySight then
				subCache = secondary
			elseif att.isGrenadeLauncher then
				attInfo.prefix = "M203"
				subCache = grenade
			else
				continue
			end
			
			attInfo.name = att.name
			attInfo.displayName = att.displayName
			attInfo.prefix = attInfo.prefix
				or att.aimPos and
					string.sub(att.aimPos[1], 1, string.len(att.aimPos[1]) - 3)
				or "Aim"
			
			table.insert(subCache, attInfo)
		end
		
		self._relevantAttsCache = {}
		self._relevantAttsCache[1] = secondary
		self._relevantAttsCache[2] = grenade
		self._relevantAttsCache[3] = primary		
	end
	
	
end

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	if !IsValid(wep) or !wep.CW20Weapon then
		panel:AddControl("Label", {Text = "Not a CW2 swep, move along."})
		return
	end
	
	panel:AddControl("Label", {Text = "classname"})
	panel:AddControl("Label", {Text = "cvar force xh"})
	panel:AddControl("Label", {Text = "cvar freeze rets"})
	panel:AddControl("Label", {Text = "cvar hold ads"})
	panel:AddControl("Label", {Text = "cvar free aim sc"})
	
	panel:AddControl("Label", {Text = "butts wipe|reload"})
	
	panel:AddControl("Label", {Text = "sight print nam"})
	panel:AddControl("Label", {Text = "sight code nam"})
	panel:AddControl("Label", {Text = "sight cur mdl"})
	panel:AddControl("Label", {Text = "sight code prefix"})
	
	panel:AddControl("Label", {Text = "tentry ??add suffix"})
	
	panel:AddControl("Label", {Text = "sight sliders"})
	
	panel:AddControl("Label", {Text = "export normal"})
	panel:AddControl("Label", {Text = "export backup"})
	panel:AddControl("Label", {Text = "butt export all normal"})
	panel:AddControl("Label", {Text = "butt export all backup"})
	
	panel:AddControl("Label", {Text = "slider zoomamount"})
	panel:AddControl("Label", {Text = "slider aimvmfov"})
	panel:AddControl("Label", {Text = "slider aimswayintense"})
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

TOOL:_updatePanel()
