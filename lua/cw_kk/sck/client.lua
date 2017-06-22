local BASE = CustomizableWeaponry_KK.sck

/*
TOOL table structure
	[mandatory]
	Name = "TOOL_NAME"
	PrintName = "Secksy spawnmenu name"
	SetPanel(self, panel)
	
	[optional]
	SpawnMenuTab = "Utilities"
	SpawnMenuTabSection = "Knife Kitty"
	Initialize(self)
	OnWeaponChanged(self, new, old)
	OnWeaponSetupChanged(self)
	OnWeaponClipChanged(self)
	OnWeaponGLStateChanged(self)
	Think(self)
	
	[internal-recommended]
	build or update panel - tool shud call from 
		OnXChanged and SetPanel
	
	[pre-defined]
	SaveSliderZoom(self, slider)
	LoadSliderZoom(self, slider)
	AngleToString(Angle)
	VectorToString(Vector)
	ThrowNewNotImplemented()
	ThrowNewInvalidWeapon()
*/

BASE._toolMeta = {}
local toolMeta = BASE._toolMeta
toolMeta.__index = toolMeta

function toolMeta:Initialize() end

local function initSliderStorage(tool, slider)
	if not slider._cwkksckid then
		local txt = slider.Label:GetText()
		txt = string.Replace(txt, ".", "_")
		txt = string.Replace(txt, " ", "_")
		txt = string.lower(txt)
		slider._cwkksckid = string.format("_cw_kk_sck_slzoom_%s_%s", tool.Name, txt)
	end
	
	tool._storedSliders = tool._storedSliders or {}
	
	if not tool._storedSliders[slider._cwkksckid] then
		tool._storedSliders[slider._cwkksckid] = CreateClientConVar(slider._cwkksckid, 1, true, false)
	end
end

function toolMeta:SaveSliderZoom(slider)
	initSliderStorage(self, slider)
	self._storedSliders[slider._cwkksckid]:SetFloat(slider.Wang:GetZoom())
end

function toolMeta:LoadSliderZoom(slider)
	initSliderStorage(self, slider)
	
	slider.Wang:SetDecimals(4) // ???
	slider.Wang:SetZoom(self._storedSliders[slider._cwkksckid]:GetFloat())
end

function toolMeta:AngleToString(a)
	if not a then
		return "nil"
	end
	
	if a:IsZero() then
		return "Angle()"
	end

	return string.format(
		"Angle(%s, %s, %s)",
		tostring(math.Round(a.p,4)),
		tostring(math.Round(a.y,4)),
		tostring(math.Round(a.r,4))
	)
end

function toolMeta:VectorToString(v)
	if not v then
		return "nil"
	end
	
	if v:Length() == 0 then
		return "Vector()"
	end

	return string.format(
		"Vector(%s, %s, %s)",
		tostring(math.Round(v.x,4)),
		tostring(math.Round(v.y,4)),
		tostring(math.Round(v.z,4))
	)
end

function toolMeta:ThrowNewNotImplemented()
	local snds = {
		"http://cdn.frustra.org/sounds/sound_tf2/vo/scout_no02.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/pyro_no01.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/soldier_no03.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/demoman_no01.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/heavy_no02.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/medic_no02.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/engineer_no01.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/sniper_no01.mp3",
		"http://cdn.frustra.org/sounds/sound_tf2/vo/spy_no02.mp3",
	}

	sound.PlayURL(table.Random(snds), "", function(station)
		if IsValid(station) then
			station:Play()
			print("This stuff aint implemented yet.")
		else
			print("INVALID INTERNET CONNECTION OMGF!")
		end
	end)
end

function toolMeta:ThrowNewInvalidWeapon()
	self._panel:ClearControls()
	self._panel:AddControl("Label", {Text = 
		"No valid weapon detected. If you reloaded Spawnmenu just now, try switching weapons."
	})
end

function toolMeta:ThrowNewNotCW2Weapon()
	self._panel:ClearControls()
	self._panel:AddControl("Label", {Text = 
		"Your active weapon is not CW2-based."
	})
end

function BASE:AddTool(tab)
	if SERVER then return end
	
	if not tab then return end
	if not tab.Name then return end
	if not tab.SetPanel then return end
	
	tab.SpawnMenuTab = tab.SpawnMenuTab or self.SpawnMenuTab
	tab.SpawnMenuTabSection = tab.SpawnMenuTabSection or self.SpawnMenuTabSection
	
	tab.PrintName = tab.PrintName or tab.Name
	tab.SelectCommand = tab.SelectCommand or ""
	
	self._toolCache = self._toolCache or {}
	
	setmetatable(tab, self._toolMeta)
	local old = self._toolCache[tab.Name]
	
	if not self._cleanLoad then
		if old then
			old.__index = old
			setmetatable(tab, old)
		end
	end
	
	tab:Initialize()
	
	self._toolCache[tab.Name] = tab
end

BASE:Load()

BASE._toolCache = BASE._toolCache or {}
BASE.IsValid = function(self) return true end

function BASE:PopulateToolMenu()		
	for name,tool in pairs(self._toolCache) do
		spawnmenu.AddToolMenuOption(
			tool.SpawnMenuTab,
			tool.SpawnMenuTabSection,
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

function BASE:_OnWeaponChanged(new, old)
	for _,tool in pairs(self._toolCache) do
		if tool.OnWeaponChanged then
			tool:OnWeaponChanged(new, old)
		end
	end
end

function BASE:_OnWeaponSetupChanged()
	for _,tool in pairs(self._toolCache) do
		if tool.OnWeaponSetupChanged then
			tool:OnWeaponSetupChanged()
		end
	end
end

function BASE:_OnWeaponClipChanged()
	for _,tool in pairs(self._toolCache) do
		if tool.OnWeaponClipChanged then
			tool:OnWeaponClipChanged()
		end
	end
end

function BASE:_OnWeaponGLStateChanged()
	for _,tool in pairs(self._toolCache) do
		if tool.OnWeaponGLStateChanged then
			tool:OnWeaponGLStateChanged()
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
		local curClip = nil
		local curGLState = nil
		
		if IsValid(wep) then
			if wep.ActiveAttachments then
				for k,v in pairs(wep.ActiveAttachments) do
					if v then 
						curSetup = curSetup .. k .. "|"
					end
				end
			end
			
			curClip = wep:Clip1()
			
			for _,gldtKey in pairs(self._knowGLDTkeys) do
				curGLState = curGLState or (wep.dt and wep.dt[gldtKey])
			end
		end
		
		if curSetup != self._lastSetup then
			self:_OnWeaponSetupChanged()
		end
		self._lastSetup = curSetup
		
		if curClip != self._lastClip then
			self:_OnWeaponClipChanged()
		end
		self._lastClip = curClip
		
		if curGLState != self._lastGLState then
			self:_OnWeaponGLStateChanged()
		end
		self._lastGLState = curGLState
	end
	self._lastWep = wep
	
	for _,tool in pairs(self._toolCache) do
		if tool.Think then
			tool:Think()
		end
	end
end

hook.Add("Think", BASE, BASE.Think)

-- function BASE:ForceRebuildTools()
	-- for _,tool in pairs(self._toolCache) do
		-- local panel = tool._panel 
		
		-- if IsValid(panel) then
			-- tool:SetPanel(nil)
			
			-- panel:Clear()
			
			-- tool:SetPanel(panel)
		-- end
	-- end
-- end

-- concommand.Add(BASE.strCCRebuild, function()
	-- BASE:ForceRebuildTools()
-- end)
