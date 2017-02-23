AddCSLuaFile()

local PANEL
local WEAPON

local wepSetup = {}

local function getWeaponSetup()
	wepSetup.ok = false
	wepSetup.vm = nil
	wepSetup.setSoundTable = nil
	
	if WEAPON.CW20Weapon then
		wepSetup.ok = true
		wepSetup.vm = WEAPON.CW_VM
		wepSetup.setSoundTable = function(a, r, c)
			if WEAPON.Sounds and WEAPON.Sounds[a] then
				WEAPON:setCurSoundTable(WEAPON.Sounds[a], r, c, a)
			else
				WEAPON:removeCurSoundTable()
			end
		end
	elseif WEAPON.IsFAS2Weapon then
		wepSetup.ok = true
		wepSetup.vm = WEAPON.Wep
		wepSetup.setSoundTable = function(a, r, c)
			if WEAPON.Sounds then
				WEAPON.CurSoundTable = WEAPON.Sounds[a] and WEAPON.Sounds[a]
				WEAPON.CurSoundEntry = WEAPON.Sounds[a] and 1
				WEAPON.SoundSpeed = WEAPON.Sounds[a] and r
				WEAPON.SoundTime = WEAPON.Sounds[a] and CurTime()
			end
		end
	end
	
	return wepSetup
end

local fCurRate = 1
local fCurStartCycle = 0
local bPlaySounds = false

local cvarCVMTEnabled
local initdWeps = {}

local function playAnim(txt)
	cvarCVMTEnabled = cvarCVMTEnabled or GetConVar("cvmt_enabled")
	
	if cvarCVMTEnabled:GetInt() != 1 then
		if not initdWeps[WEAPON] then
			cvarCVMTEnabled:SetInt(1)
		end
	end
	
	initdWeps[WEAPON] = true
	
	if bPlaySounds then
		getWeaponSetup().setSoundTable(txt, fCurRate, fCurStartCycle)
	end
	
	RunConsoleCommand("cvmt_playanim", txt, fCurStartCycle, fCurRate)
end

local animButtonsPanel

local function cleanAnimButtonsPanel()
	if !IsValid(animButtonsPanel) then return end
	
	for k,v in pairs(animButtonsPanel:GetChildren()) do
		v:Remove()
	end
end

local iSoundFilter = 1
local cvarCurFilter = CreateClientConVar("cw_kk_cvmt_filter_name", "", false, false)

local colHover = Color(0,255,0,25)
local colIdle = Color(0,0,0,60)
local colClick = Color(0,0,255,25)

local function populateAnimButtonsPanel()
	if !IsValid(animButtonsPanel) then return end
	
	cleanAnimButtonsPanel()
	
	local animButtonsPanelHeight = 0
	
	local vm = getWeaponSetup().vm
	
	for i = 0, vm:GetSequenceCount() - 1 do
		local txt = vm:GetSequenceName(i)
		
		local hasSound = (WEAPON.Sounds != nil) and (WEAPON.Sounds[txt] != nil)
		
		local nameOk = string.find(string.lower(txt), string.lower(cvarCurFilter:GetString())) != nil
		local soundOk = (iSoundFilter == 1) or ((hasSound) == (iSoundFilter == 2))
		
		if nameOk and soundOk then
			
			local animButtonPanel = vgui.Create("DPanel", animButtonsPanel)
			
				local label
				label = vgui.Create("DLabel", animButtonPanel)
				label:SetText(string.format("%3d# %s", i, string.upper(txt)))
				label:SetDark(true)
				label:Dock(FILL)
				label:DockMargin(8,0,8,0)
				label:SizeToContents()
				label:SetMouseInputEnabled(true)
				
				if hasSound then
					local icon
					icon = vgui.Create("DImage", animButtonPanel)
					icon:SetImage("icon16/sound.png")
					icon:SetSize(16,10)
					icon:Dock(RIGHT)
					icon:DockMargin(0,0,4,0)
					-- icon:SetMouseInputEnabled(true)
				end
				
				function label:DoClick()
					playAnim(txt)
				end
				
				function label:Think()
					if self:IsHovered() then
						if input.IsMouseDown(MOUSE_LEFT) then
							animButtonPanel:SetBackgroundColor(colClick)
						elseif input.IsMouseDown(MOUSE_RIGHT) then
							animButtonPanel:SetBackgroundColor(colClick)
							SetClipboardText(txt)
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
					elseif input.IsMouseDown(MOUSE_RIGHT) then
						animButtonPanel:SetBackgroundColor(colClick)
						SetClipboardText(txt)
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

local soundFilterTxt = {"ALL", "W/", "W/O"}

cvars.AddChangeCallback("cw_kk_cvmt_filter_name", function()
	populateAnimButtonsPanel()
end)

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	PANEL:ClearControls()
	
	PANEL:AddControl("Label", {Text = "CVMT Shared:"}):DockMargin(0, 0, 0, 0)
	
	local cvmtEnablePanel = vgui.Create("DPanel", PANEL)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", cvmtEnablePanel)
		cbox:SetText("Enable HUD elements")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetConVar("cvmt_enabled")
		
	cvmtEnablePanel:Dock(TOP)
	cvmtEnablePanel:SetSize(200,20)
	cvmtEnablePanel:SetPaintBackground(true)
	cvmtEnablePanel:SizeToContents()
	
	PANEL:AddItem(cvmtEnablePanel)
	
	local cvmtAnimsPanel = vgui.Create("DPanel", PANEL)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", cvmtAnimsPanel)
		cbox:SetText("Show anim list")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetConVar("cvmt_animlist")
		
	cvmtAnimsPanel:Dock(TOP)
	cvmtAnimsPanel:SetSize(200,20)
	cvmtAnimsPanel:SetPaintBackground(true)
	cvmtAnimsPanel:SizeToContents()
	
	PANEL:AddItem(cvmtAnimsPanel)
	
	local cvmtAnimNumsPanel = vgui.Create("DPanel", PANEL)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", cvmtAnimNumsPanel)
		cbox:SetText("Show ids in anim list")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetConVar("cvmt_animlist_numbers")
		
	cvmtAnimNumsPanel:Dock(TOP)
	cvmtAnimNumsPanel:SetSize(200,20)
	cvmtAnimNumsPanel:SetPaintBackground(true)
	cvmtAnimNumsPanel:SizeToContents()
	
	PANEL:AddItem(cvmtAnimNumsPanel)
	
	local cvmtCyclePanel = vgui.Create("DPanel", PANEL)
	
		local slider
		slider = vgui.Create("DNumSlider", cvmtCyclePanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(4)
		slider:SetMinMax(0, 1)
		slider:SetValue(1)
		slider:SetText("Set cycle")
		slider:SetDark(true)
		
		slider.Wang:SetDecimals(slider:GetDecimals())
			
		function slider:OnValueChanged(val)
			local wep = LocalPlayer():GetActiveWeapon()
			
			if IsValid(wep.CW_VM) then
				wep.CW_VM:SetCycle(val)
			end
		
			RunConsoleCommand("cvmt_setplaybackrate", 0)
			RunConsoleCommand("cvmt_setcycle", val)
		end
		
	cvmtCyclePanel:Dock(TOP)
	cvmtCyclePanel:SetSize(200,20)
	cvmtCyclePanel:SetPaintBackground(true)
	cvmtCyclePanel:SizeToContents()
	
	PANEL:AddItem(cvmtCyclePanel)
	
	if !IsValid(WEAPON) or !getWeaponSetup().ok then
		cleanAnimButtonsPanel()
		return 
	end

	PANEL:AddControl("Label", {Text = "Preview settings:"}):DockMargin(0, 0, 0, 0)
	
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
	
	local roundSliderPanel = vgui.Create("DPanel", PANEL)
		
		local slider
		slider = vgui.Create("DNumSlider", roundSliderPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(0)
		slider:SetMinMax(-2, 2)
		slider:SetValue(fCurRate)
		slider:SetText("Round PbRate:")
		slider:SetDark(true)
		
		slider.TextArea:SetEditable(false)
		slider.TextArea:SetValue("")
		
		local rateSlider
		
		function slider:OnValueChanged(val)
			rateSlider:SetValue(math.Round(val, self:GetDecimals()))
			
			self.TextArea:SetEditable(false)
			self.TextArea:SetValue("")
		end
		
	roundSliderPanel:Dock(TOP)
	roundSliderPanel:SetSize(200,20)
	roundSliderPanel:SetPaintBackground(true)
	roundSliderPanel:SizeToContents()
	
	PANEL:AddItem(roundSliderPanel)
	
	local roundSlider = slider
	
	local rateSliderPanel = vgui.Create("DPanel", PANEL)
	
		local slider
		slider = vgui.Create("DNumSlider", rateSliderPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(2)
		slider:SetMinMax(-2, 2)
		slider:SetValue(fCurRate)
		slider:SetText("Preview PbRate:")
		slider:SetDark(true)
		
		function slider:OnValueChanged(val)
			fCurRate = math.Round(val, self:GetDecimals())
			fCurStartCycle = (fCurRate > 0) and 0 or 1
		end
		
		rateSlider = slider
		
	rateSliderPanel:Dock(TOP)
	rateSliderPanel:SetSize(200,20)
	rateSliderPanel:SetPaintBackground(true)
	rateSliderPanel:SizeToContents()
	
	PANEL:AddItem(rateSliderPanel)

	local soundFilterPanel = vgui.Create("DPanel", PANEL)

		local slider
		slider = vgui.Create("DNumSlider", soundFilterPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(0)
		slider:SetMinMax(1, 3)
		slider:SetText("Filter by sound:")
		slider:SetDark(true)
		
		function slider:OnValueChanged(val)
			iSoundFilter = math.Round(val, self:GetDecimals())
			
			self.TextArea:SetEditable(false)
			self.TextArea:SetValue(soundFilterTxt[iSoundFilter])
			
			populateAnimButtonsPanel()
		end
		
		slider:SetValue(iSoundFilter)
		
	soundFilterPanel:Dock(TOP)
	soundFilterPanel:SetSize(200,20)
	soundFilterPanel:SetPaintBackground(true)
	soundFilterPanel:SizeToContents()
	
	PANEL:AddItem(soundFilterPanel)
	
	local filterBoxPanel = vgui.Create("DPanel", PANEL)
	
		local label
		label = vgui.Create("DLabel", filterBoxPanel)
		label:SetText("Filter by name:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,0,0)
		label:SizeToContents()
		
		local entry
		entry = vgui.Create("DTextEntry", filterBoxPanel)
		entry:Dock(FILL)
		entry:DockMargin(8,0,0,0)
		
		entry:SetConVar("cw_kk_cvmt_filter_name")
		
		function entry:OnChange()
			self:OnEnter()
		end
		
	filterBoxPanel:Dock(TOP)
	filterBoxPanel:SetSize(200,20)
	filterBoxPanel:SetPaintBackground(true)
	filterBoxPanel:SizeToContents()
	
	PANEL:AddItem(filterBoxPanel)
	
	local labelPanel = vgui.Create("DPanel", PANEL)
	
		local label
		label = vgui.Create("DLabel", labelPanel)
		label:SetText("Preview animation:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(0,0,0,0)
		label:SizeToContents()
		
		local label
		label = vgui.Create("DLabel", labelPanel)
		label:SetText("[LMB - PLAY] [RMB - COPY]")
		label:SetDark(true)
		label:Dock(RIGHT)
		label:DockMargin(0,0,0,0)
		label:SizeToContents()
		
	labelPanel:Dock(TOP)
	labelPanel:SetSize(200,20)
	labelPanel:SetPaintBackground(false)
	labelPanel:SizeToContents()
	
	PANEL:AddItem(labelPanel)
	
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
		if getWeaponSetup().ok then
			cvarCVMTEnabled = cvarCVMTEnabled or GetConVar("cvmt_enabled")
			if cvarCVMTEnabled:GetInt() == 1 then
				initdWeps[WEAPON] = true
			end
		end
		
		updatePanel()
	end
	
	_LAST_SETUP = WEAPON
end

local toolName = "KK_SCK_CVMT_EXT"
local toolPrintName = "CVMT Panel 2.0"

hook.Add("Think", toolName .. "_Think", think)

hook.Add("PopulateToolMenu", toolName, function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", toolName, toolPrintName, "", "", function(panel)
		PANEL = panel
		updatePanel()		
	end)
end)

-- RunConsoleCommand("spawnmenu_reload")
