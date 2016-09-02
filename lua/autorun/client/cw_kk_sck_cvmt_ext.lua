if not CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()

local PANEL
local WEAPON

local colHover = Color(0,255,0,25)
local colIdle = Color(0,0,0,60)
local colClick = Color(0,0,255,25)

local fCurRate = 1
local fCurStartCycle = 0
local bPlaySounds = false

local strCurFilter = ""

local animButtonsPanel

local function playAnim(txt)
	if bPlaySounds and WEAPON.Sounds[txt] then
		WEAPON:setCurSoundTable(WEAPON.Sounds[txt], fCurRate, fCurStartCycle, txt)
	end
	
	RunConsoleCommand("cvmt_playanim", txt, fCurStartCycle, fCurRate)
end

local function cleanAnimButtonsPanel()
	if !IsValid(animButtonsPanel) then return end
	
	for k,v in pairs(animButtonsPanel:GetChildren()) do
		v:Remove()
	end
end

local function populateAnimButtonsPanel()
	if !IsValid(animButtonsPanel) then return end
	
	cleanAnimButtonsPanel()
	
	local animButtonsPanelHeight = 0
	
	local vm = WEAPON.CW_VM
	
	for i = 0, vm:GetSequenceCount() - 1 do
		local txt = vm:GetSequenceName(i)
		
		if string.find(txt, strCurFilter) then
			
			local animButtonPanel = vgui.Create("DPanel", animButtonsPanel)
			
				local label
				label = vgui.Create("DLabel", animButtonPanel)
				label:SetText(string.format("%3d# %s", i, string.upper(txt)))
				label:SetDark(true)
				label:Dock(FILL)
				label:DockMargin(8,0,8,0)
				label:SizeToContents()
				label:SetMouseInputEnabled(true)
				
				function label:DoClick()
					playAnim(txt)
				end
				
				function label:Think()
					if self:IsHovered() then
						if input.IsMouseDown(MOUSE_LEFT) then
							animButtonPanel:SetBackgroundColor(colClick)
						else
							animButtonPanel:SetBackgroundColor(colHover)
						end
					else
						animButtonPanel:SetBackgroundColor(colIdle)
					end
				end
				
			animButtonPanel:Dock(TOP)
			animButtonPanel:DockMargin(0,0,0,8)
			animButtonPanel:SetSize(200,20)
			animButtonPanel:SetPaintBackground(true)
			animButtonPanel:SizeToContents()
			animButtonPanel:SetMouseInputEnabled(true)
			
			function animButtonPanel:DoClick()
				playAnim(txt)
			end
			
			function animButtonPanel:Think()
				if self:IsHovered() then
					if input.IsMouseDown(MOUSE_LEFT) then
						self:SetBackgroundColor(colClick)
					else
						self:SetBackgroundColor(colHover)
					end
				else
					self:SetBackgroundColor(colIdle)
				end
			end
			
			animButtonsPanelHeight = animButtonsPanelHeight + 28
		end
	end
	
	-- animButtonsPanel:Dock(TOP)
	animButtonsPanel:SetSize(516, animButtonsPanelHeight)
	-- animButtonsPanel:DockPadding(0,0,0,0)
	-- animButtonsPanel:DockMargin(0,0,0,0)
	-- animButtonsPanel:SizeToContents()
	-- animButtonsPanel:SetPaintBackground(false)
	
	-- PANEL:AddItem(animButtonsPanel)
end

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	if !IsValid(WEAPON) or !WEAPON.CW20Weapon then
		cleanAnimButtonsPanel()
		return 
	end

	local soundSwitchPanel = vgui.Create("DPanel", PANEL)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", soundSwitchPanel)
		cbox:SetText("Play animation sounds (if any)")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetValue(bPlaySounds)
		
		function cbox:OnChange(val)
			bPlaySounds = val
		end
		
	soundSwitchPanel:Dock(TOP)
	soundSwitchPanel:SetSize(200,20)
	soundSwitchPanel:SetPaintBackground(true)
	soundSwitchPanel:SizeToContents()
	
	PANEL:AddItem(soundSwitchPanel)
	
	local rateSliderPanel = vgui.Create("DPanel", PANEL)
	
		local slider
		slider = vgui.Create("DNumSlider", rateSliderPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(0)
		slider:SetMinMax(-2, 2)
		slider:SetValue(fCurRate)
		slider:SetText("PlaybackRate:")
		slider:SetDark(true)
		
		function slider:OnValueChanged(val)
			fCurRate = math.Round(val, self:GetDecimals())
			fCurStartCycle = (fCurRate > 0) and 0 or 1
		end
		
	rateSliderPanel:Dock(TOP)
	rateSliderPanel:SetSize(200,20)
	rateSliderPanel:SetPaintBackground(true)
	rateSliderPanel:SizeToContents()
	
	PANEL:AddItem(rateSliderPanel)
	
	local filterBoxPanel = vgui.Create("DPanel", PANEL)
	
		local label
		label = vgui.Create("DLabel", filterBoxPanel)
		label:SetText("Filter anims:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,0,0)
		label:SizeToContents()
		
		local entry
		entry = vgui.Create("DTextEntry", filterBoxPanel)
		entry:Dock(FILL)
		entry:DockMargin(8,0,8,0)
		
		entry:SetValue(strCurFilter)
		
		function entry:OnChange()
			strCurFilter = self:GetValue()
			
			populateAnimButtonsPanel()
		end
		
	filterBoxPanel:Dock(TOP)
	filterBoxPanel:SetSize(200,20)
	filterBoxPanel:SetPaintBackground(true)
	filterBoxPanel:SizeToContents()
	
	PANEL:AddItem(filterBoxPanel)
	
	animButtonsPanel = vgui.Create("DPanel", PANEL)
	
	animButtonsPanel:Dock(TOP)
	animButtonsPanel:SetSize(516, animButtonsPanelHeight)
	animButtonsPanel:DockPadding(0,0,0,0)
	animButtonsPanel:DockMargin(0,0,0,0)
	animButtonsPanel:SizeToContents()
	animButtonsPanel:SetPaintBackground(false)
	
	PANEL:AddItem(animButtonsPanel)
	
	populateAnimButtonsPanel()
end

local _LAST_SETUP

local function think()
	WEAPON = LocalPlayer():GetActiveWeapon()
	
	if _LAST_SETUP != WEAPON then
		updatePanel()
	end
	
	_LAST_SETUP = WEAPON
end

local toolName = "KK_SCK_CVMT_EXT"
local toolPrintName = "CVMT Panel 2.0"

hook.Add("PopulateToolMenu", toolName, function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", toolName, toolPrintName, "", "", function(panel)
		PANEL = panel
		updatePanel()
		
		hook.Add("Think", toolName .. "_Think", think)
	end)
end)

hook.Add("PostReloadToolsMenu", toolName .. "_Remove", function()
	hook.Remove("Think", toolName .. "_Think")
end)

RunConsoleCommand("spawnmenu_reload")
