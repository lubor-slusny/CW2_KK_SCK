AddCSLuaFile()

local TOOL = {}

TOOL.Name = "cvmtpanel"
TOOL.PrintName = "CVMT Control Panel"
TOOL.Version = "2.1"

function TOOL:Initialize()
	self._fCurRate = self._fCurRate or 1
	self._fCurStartCycle = self._fCurStartCycle or 0
	self._bPlaySounds = self._bPlaySounds or true

	self._iSoundFilter = self._iSoundFilter or 1
	self._strSoundFilter = {"ALL", "W/", "W/O"}

	self._cvarCurFilter = self._cvarCurFilter or CreateClientConVar("_cw_kk_cvmt_filter_name", "", false, false)
	
	cvars.AddChangeCallback("_cw_kk_cvmt_filter_name", function()
		TOOL:_updatePanelSectionAnimList()
	end)
end

local label, backgroundPanel

function TOOL:_addSectionTickBoxes()
	local panel = self._panel
	local wep = self._wep
	
	backgroundPanel = vgui.Create("DPanel", panel)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetText("Enable HUD elements")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetConVar("cvmt_enabled")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
	
	backgroundPanel = vgui.Create("DPanel", panel)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetText("Show anim list")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetConVar("cvmt_animlist")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
	
	backgroundPanel = vgui.Create("DPanel", panel)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetText("Show ids in anim list")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetConVar("cvmt_animlist_numbers")
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionCycleSlider()
	local panel = self._panel
	local wep = self._wep
	
	backgroundPanel = vgui.Create("DPanel", panel)
	
		local slider
		slider = vgui.Create("DNumSlider", backgroundPanel)
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
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionPreviewControls()
	local panel = self._panel
	local wep = self._wep
	
	local backgroundPanel = vgui.Create("DPanel", panel)

		local cbox
		cbox = vgui.Create("DCheckBoxLabel", backgroundPanel)
		cbox:SetText("Play animation sounds (if any)")
		cbox:SetDark(true)
		cbox:Dock(FILL)
		cbox:DockMargin(8,0,0,0)
		
		cbox.Label:Dock(LEFT)
		cbox.Label:DockMargin(24,0,0,0)
		
		cbox:SetValue(self._bPlaySounds)
		
		function cbox:OnChange(val)
			TOOL._bPlaySounds = val
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
		
		local slider
		slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(0)
		slider:SetMinMax(-2, 2)
		slider:SetValue(self._fCurRate)
		slider:SetText("Round PbRate:")
		slider:SetDark(true)
		
		slider.TextArea:SetEditable(false)
		slider.TextArea:SetValue("")
		
		function slider:OnValueChanged(val)
			TOOL._sliderPBRate:SetValue(math.Round(val, self:GetDecimals()))
			
			self.TextArea:SetEditable(false)
			self.TextArea:SetValue("")
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
	
	local roundSlider = slider
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	
		local slider
		slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(2)
		slider:SetMinMax(-2, 2)
		slider:SetValue(self._fCurRate)
		slider:SetText("Preview PbRate:")
		slider:SetDark(true)
		
		function slider:OnValueChanged(val)
			TOOL._fCurRate = math.Round(val, self:GetDecimals())
			TOOL._fCurStartCycle = (TOOL._fCurRate > 0) and 0 or 1
		end
		
		self._sliderPBRate = slider
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)

	local backgroundPanel = vgui.Create("DPanel", panel)

		local slider
		slider = vgui.Create("DNumSlider", backgroundPanel)
		slider:Dock(FILL)
		slider:DockMargin(8,0,8,0)
		slider:SetDecimals(0)
		slider:SetMinMax(1, 3)
		slider:SetText("Filter by sound:")
		slider:SetDark(true)
		
		function slider:OnValueChanged(val)
			TOOL._iSoundFilter = math.Round(val, self:GetDecimals())
			
			self.TextArea:SetEditable(false)
			self.TextArea:SetValue(TOOL._strSoundFilter[TOOL._iSoundFilter])
			
			TOOL:_updatePanelSectionAnimList()
		end
		
		slider:SetValue(self._iSoundFilter)
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
	
	local backgroundPanel = vgui.Create("DPanel", panel)
	
		label = vgui.Create("DLabel", backgroundPanel)
		label:SetText("Filter by name:")
		label:SetDark(true)
		label:Dock(LEFT)
		label:DockMargin(8,0,0,0)
		label:SizeToContents()
		
		local entry
		entry = vgui.Create("DTextEntry", backgroundPanel)
		entry:Dock(FILL)
		entry:DockMargin(8,0,0,0)
		
		entry:SetConVar("_cw_kk_cvmt_filter_name")
		
		function entry:OnChange()
			self:OnEnter()
		end
		
	backgroundPanel:Dock(TOP)
	backgroundPanel:SetSize(200,20)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SetPaintBackground(true)
	backgroundPanel:SizeToContents()
	panel:AddItem(backgroundPanel)
end

function TOOL:_addSectionAnimList()
	local panel = self._panel
	local wep = self._wep
	
	backgroundPanel = vgui.Create("DPanel", panel)
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(0,0,0,0)
	backgroundPanel:DockMargin(8,0,8,0)
	backgroundPanel:SizeToContents()
	backgroundPanel:SetPaintBackground(false)
	panel:AddItem(backgroundPanel)
	
	self._animListSectionPanel = backgroundPanel
end

local _wepSetup = {}

function TOOL:_getWepSetup()
	_wepSetup.ok = false
	_wepSetup.vm = nil
	_wepSetup.setSoundTable = nil
	
	local wep = self._wep
	
	if IsValid(wep) then
		if wep.CW20Weapon then
			_wepSetup.ok = true
			_wepSetup.vm = wep.CW_VM
			_wepSetup.setSoundTable = function(a, r, c)
				if wep.Sounds and wep.Sounds[a] then
					wep:setCurSoundTable(wep.Sounds[a], r, c, a)
				else
					wep:removeCurSoundTable()
				end
			end
		elseif wep.IsFAS2Weapon then
			_wepSetup.ok = true
			_wepSetup.vm = wep.Wep
			_wepSetup.setSoundTable = function(a, r, c)
				if wep.Sounds then
					wep.CurSoundTable = wep.Sounds[a] and wep.Sounds[a]
					wep.CurSoundEntry = wep.Sounds[a] and 1
					wep.SoundSpeed = wep.Sounds[a] and r
					wep.SoundTime = wep.Sounds[a] and CurTime()
				end
			end
		end
	end
	
	return _wepSetup
end

function TOOL:_playAnim(txt)
	GetConVar("cvmt_enabled"):SetInt(1)

	if self._bPlaySounds then
		self:_getWepSetup().setSoundTable(txt, self._fCurRate, self._fCurStartCycle)
	end
	
	RunConsoleCommand("cvmt_playanim", txt, self._fCurStartCycle, self._fCurRate)
end

TOOL._colAnimButtonHover = Color(0,255,0,25)
TOOL._colAnimButtonIdle = Color(0,0,0,60)
TOOL._colAnimButtonClick = Color(0,0,255,25)

function TOOL:_updatePanelSectionAnimList()
	local panel = self._animListSectionPanel
	
	if !IsValid(panel) then return end
	
	for _,v in pairs(panel:GetChildren()) do
		v:Remove()
	end
	
	local animListSectionHeight = 0
	local vm = self:_getWepSetup().vm
	
	for i = 0, vm:GetSequenceCount() - 1 do
		local txt = vm:GetSequenceName(i)
		local hasSound = (wep.Sounds != nil) and (wep.Sounds[txt] != nil)
		local nameOk = string.find(string.lower(txt), string.lower(self._cvarCurFilter:GetString())) != nil
		local soundOk = (self._iSoundFilter == 1) or ((hasSound) == (self._iSoundFilter == 2))
		
		if nameOk and soundOk then
			local backgroundPanel = vgui.Create("DPanel", panel)
			
				label = vgui.Create("DLabel", backgroundPanel)
				label:SetText(string.format("%3d# %s", i, string.upper(txt)))
				label:SetDark(true)
				label:Dock(FILL)
				label:DockMargin(8,0,8,0)
				label:SizeToContents()
				label:SetMouseInputEnabled(true)
				
				if hasSound then
					local icon
					icon = vgui.Create("DImage", backgroundPanel)
					icon:SetImage("icon16/sound.png")
					icon:SetSize(16,10)
					icon:Dock(RIGHT)
					icon:DockMargin(0,0,4,0)
				end
				
				function label:DoClick()
					TOOL:_playAnim(txt)
				end
				
				function label:Think()
					if self:IsHovered() then
						if input.IsMouseDown(MOUSE_LEFT) then
							backgroundPanel:SetBackgroundColor(TOOL._colAnimButtonClick)
						elseif input.IsMouseDown(MOUSE_RIGHT) then
							backgroundPanel:SetBackgroundColor(TOOL._colAnimButtonClick)
							SetClipboardText(txt)
						else
							backgroundPanel:SetBackgroundColor(TOOL._colAnimButtonHover)
						end
					else
						backgroundPanel:SetBackgroundColor(TOOL._colAnimButtonIdle)
					end
				end
				
			backgroundPanel:Dock(TOP)
			backgroundPanel:DockMargin(0,0,0,8)
			backgroundPanel:SetSize(200,20)
			backgroundPanel:SetPaintBackground(true)
			backgroundPanel:SizeToContents()
			backgroundPanel:SetMouseInputEnabled(true)
			
			function backgroundPanel:DoClick()
				TOOL:_playAnim(txt)
			end
			
			function backgroundPanel:Think()
				if self:IsHovered() then
					if input.IsMouseDown(MOUSE_LEFT) then
						self:SetBackgroundColor(TOOL._colAnimButtonClick)
					elseif input.IsMouseDown(MOUSE_RIGHT) then
						self:SetBackgroundColor(TOOL._colAnimButtonClick)
						SetClipboardText(txt)
					else
						self:SetBackgroundColor(TOOL._colAnimButtonHover)
					end
				else
					self:SetBackgroundColor(TOOL._colAnimButtonIdle)
				end
			end
			
			animListSectionHeight = animListSectionHeight + 28
		end
	end
	
	panel:SetSize(516, animListSectionHeight + 8)
end

function TOOL:_updatePanel()
	local panel = self._panel
	local wep = self._wep
	
	if !IsValid(panel) then return end
	
	panel:ClearControls()
	
	self:AddHeaderSimpleLR(panel, "CVMT Shared:")
	self:_addSectionTickBoxes()
	self:_addSectionCycleSlider()
	
	if !IsValid(wep) or !self:_getWepSetup().ok then
		return
	end
	
	self:AddHeaderSimpleLR(panel, "Preview settings:")
	self:_addSectionPreviewControls()
	self:AddHeaderSimpleLR(panel, "Preview animation:", "[LMB - PLAY] [RMB - COPY]")
	self:_addSectionAnimList()
	self:_updatePanelSectionAnimList()
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
