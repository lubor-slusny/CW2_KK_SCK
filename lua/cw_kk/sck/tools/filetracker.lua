AddCSLuaFile()

local TOOL = {}

TOOL.Name = "filetracker"
TOOL.PrintName = "File Tracker"
TOOL.Version = "1.1"

TOOL.workshopLink = "http://steamcommunity.com/sharedfiles/filedetails/?id="

TOOL.examplePathsOrig = {
	"lua/autorun/cw_kk_ins.lua",
	"lua/cw_kk/sck/tools/filetracker.lua",
}

TOOL.exampleColors = {
	[".lua"] = Color(150, 0, 0, 255),
	[".mdl"] = Color(0, 150, 0, 255),
	[".vmt"] = Color(0, 0, 150, 255),
}

TOOL.elementFuncs = {
	AllowInput = function() return true end, // allow? Yes - means no... kek
	OnGetFocus = function(self) SetClipboardText(self:GetValue()) end,
	DoClick = function(self) SetClipboardText(self:GetText()) end,
}

TOOL.moreEnts = {
	"CW_KK_HANDS",
	"CW_KK_KNIFE",
	"CW_GREN",
}

local SCK = CustomizableWeaponry_KK.sck

function TOOL:Initialize()
	self._lastFile = self._lastFile or ""
end

function TOOL:_lastFileEmpty()
	return not self._lastFile or self._lastFile == ""
end

function TOOL:_generateExamples()
	local wep = self._wep

	self.examplePaths = self.examplePathsOrig

	local curVM = "models/weapons/v_mg42.mdl"
	local curAni
	local curSigh = "models/weapons/upgrades/a_optic_kobra.mdl"
	local curWM

	if IsValid(wep) then
		if wep.CW20Weapon then
			if wep.AttachmentModelsVM then
				if wep.AttachmentModelsVM.ani_body then
					curAni = wep.AttachmentModelsVM.ani_body.model
				end

				local att = SCK:GetTool("aimpos"):PrepareAttInfo(wep)
				if att and wep.AttachmentModelsVM[att.name] then
					curSigh = wep.AttachmentModelsVM[att.name].model
				end
			end
			curVM = wep.CW_VM:GetModel()
			curWM = IsValid(wep.WMEnt) and (wep.WMEnt:GetModel())
		else
			curVM = wep.ViewModel
		end
	end

	self.examplePaths["curVM"] = curVM
	self.examplePaths["curAni"] = curAni
	self.examplePaths["curSigh"] = curSigh

	if not self._extraExamples then
		return
	end

	if !IsValid(wep) then
		return
	end

	if !wep.CW20Weapon then
		return
	end

	if !wep.KKINS2Wep then
		return
	end

	self.examplePaths = {}

		-- PrintTable(self.knownPaths)

	local function addPath(path)
		self.knownPaths = /*self.knownPaths or*/ {}
		-- if !string.find(path, ".vmt") then
			-- return
		-- end

		if self.knownPaths[path] then
			return
		end

		self.knownPaths[path] = true
		table.insert(self.examplePaths, path)
	end

	addPath(string.format("lua/weapons/%s/shared.lua", wep:GetClass()))

	local elementsTool = SCK:GetTool("elements")

	for elementTable,elementTableProperties in pairs(elementsTool.elementTableProperties) do
		addPath(string.format("%s and shit", elementTableProperties.defParent))
		local ent = wep[elementTableProperties.defParent]
		if IsValid(ent) then
			addPath(ent:GetModel())
			for _,material in pairs(ent:GetMaterials()) do
				addPath(string.format("materials/%s.vmt", material))
			end
		end

		if not wep[elementTable] then
			continue
		end

		for elementName,elementProperties in pairs(wep[elementTable]) do
			if not elementProperties.active then
				continue
			end

			if elementProperties.model then
				addPath(elementProperties.model)
			end

			ent = elementProperties.ent
			if IsValid(ent) then
				for _,material in pairs(ent:GetMaterials()) do
					addPath(string.format("materials/%s.vmt", material))
				end
			end
		end
	end

	addPath("hands and shit")

	for _,entName in pairs(self.moreEnts) do
		local ent = wep[entName]
		if IsValid(ent) then
			addPath(ent:GetModel())
			for _,material in pairs(ent:GetMaterials()) do
				addPath(string.format("materials/%s.vmt", material))
			end
		end
	end
end

function TOOL:_addSectionExamples()
	local panel = self._panel

	self:AddHeaderSimpleLR(panel, "Or pick from examples:", "[LMB - USE] [RMB - COPY]")

	for _,p in pairs(self.examplePaths) do
		local label = vgui.Create("DLabel", panel)
		label:SetText(p)
		label:SetDark(true)
		label:SetContentAlignment(6)
		label:Dock(RIGHT)
		label:DockMargin(8, 0, 8, 0)
		label:SetMouseInputEnabled(true)

		for pattern, color in pairs(self.exampleColors) do
			if string.find(p, pattern) then
				label:SetTextColor(color)
				break
			end
		end

		function label:DoClick()
			TOOL._lastFile = p
			TOOL:_updatePanel()
		end

		function label:DoRightClick()
			SetClipboardText(p)
		end

		panel:AddItem(label)
	end

	local butt = vgui.Create("DButton", panel)
	butt:SetText(self._extraExamples and "˄˄ show less ˄˄" or "˅˅ show all relevant ˅˅")
	butt:DockMargin(8, 0, 8, 0)

	function butt:DoClick()
		TOOL._extraExamples = not TOOL._extraExamples
		TOOL:_updatePanel()
	end

	panel:AddItem(butt)
end

function TOOL:_addSectionInput()
	local panel = self._panel

	self:AddHeaderSimpleLR(panel, "Gimmi file (full path + extension):")

	local box = vgui.Create("DTextEntry", panel)
	box:Dock(TOP)
	box:DockMargin(8, 0, 8, 0)
	box:SetValue(self._lastFile)
	panel:AddItem(box)

	function box:OnEnter()
		TOOL._lastFile = self:GetValue()
		TOOL:_updatePanel()
	end

	if not self:_lastFileEmpty() then
		local butt = vgui.Create("DButton", panel)
		butt:SetText(self:_lastFileEmpty() and "ROLL DAT DICE" or "CLEAR")
		butt:DockMargin(8, 0, 8, 0)
		panel:AddItem(butt)

		function butt:DoClick()
			TOOL._lastFile = ""
			TOOL:_updatePanel()
		end
	end
end

function TOOL:_addSectionSourceNotFound()
	local panel = self._panel

	local foundAtAll = file.Exists(self._lastFile, "GAME")

	// if not found at all, end here
	if not foundAtAll then
		self:AddHeaderSimpleLR(panel, "File not found at all.")
		return true
	end
end

function TOOL:_addSectionSourceGMFolder()
	local panel = self._panel

	local foundInGMod = file.Exists(self._lastFile, "MOD") // doesnt ignore mount.cfg mounting, GG WP

	// if found in gmod folder, no need to check all addons, right?
	if not foundInGMod then
		self:AddHeaderSimpleLR(panel, "File loaded from Garry`s Mod main folder.")
		return true
	end
end

function TOOL:_addSectionSourceWorkshop()
	local panel = self._panel

	// check mounted workshop addons
	local sources = {}

	for _,addon in pairs(engine.GetAddons()) do
		if addon.models == 0 then continue end
		if !addon.mounted then continue end

		local found = file.Find(self._lastFile, addon.title)

		if table.Count(found) > 0 then
			sources[addon.wsid] = addon.title
		end
	end

	if table.Count(sources) > 0 then
		self:AddHeaderSimpleLR(panel, "File found in Workshop addon/-s:", "[LMB - COPY]")

		for id,name in pairs(sources) do
			local label = vgui.Create("DLabel", panel)
			label:SetText(name)
			label:SetDark(true)
			label:DockMargin(8, 0, 0, 0)
			label:SetMouseInputEnabled(true)
			label.DoClick = self.elementFuncs.DoClick
			panel:AddItem(label)

			local left = vgui.Create("DLabel", panel)
			left:SetText("Workshop ID:")
			left:SetDark(true)
			left:DockMargin(8, 0, 0, 0)

			local box = vgui.Create("DTextEntry", panel)
			box:Dock(TOP)
			box:DockMargin(0, 0, 8, 0)
			box:SetValue(id)
			box.AllowInput = self.elementFuncs.AllowInput
			box.OnGetFocus = self.elementFuncs.OnGetFocus
			panel:AddItem(left, box)

			local left = vgui.Create("DLabel", panel)
			left:SetText("Workshop Link:")
			left:SetDark(true)
			left:DockMargin(8, 0, 0, 0)

			local box = vgui.Create("DTextEntry", panel)
			box:Dock(TOP)
			box:DockMargin(0, 0, 8, 0)
			box:SetValue(self.workshopLink .. id)
			box.AllowInput = self.elementFuncs.AllowInput
			box.OnGetFocus = self.elementFuncs.OnGetFocus
			panel:AddItem(left, box)
		end

		return true
	end
end

function TOOL:_addSectionSourceUnclear()
	local panel = self._panel

	self:AddHeaderSimpleLR(panel, "Source unclear, can be any of:")

	// if it aint anywhere else
	local label = vgui.Create("DLabel", panel)
	label:SetText("- legacy addons")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(8, 0, 8, 0)
	panel:AddItem(label)

	local label = vgui.Create("DLabel", panel)
	label:SetText("- mounted games")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(8, 0, 8, 0)
	panel:AddItem(label)

	local label = vgui.Create("DLabel", panel)
	label:SetText("- Garry`s Mod folder")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(8, 0, 8, 0)
	panel:AddItem(label)
end

function TOOL:_updatePanel()
	local panel = self._panel

	if !IsValid(panel) then return end

	self:_generateExamples()

	panel:ClearControls()

	self:_addSectionInput()
	self:_addSectionExamples()

	if self:_lastFileEmpty() then
		return
	end

	local _ =
	self:_addSectionSourceNotFound() or
	-- self:_addSectionSourceGMFolder() or
	self:_addSectionSourceWorkshop() or
	self:_addSectionSourceUnclear()
end

function TOOL:SetPanel(panel)
	self._panel = panel
	self:_updatePanel()
end

function TOOL:OnWeaponChanged(new, old)
	self._wep = new
	self:_updatePanel()
end

function TOOL:OnWeaponSetupChanged()
	self:_updatePanel()
end

CustomizableWeaponry_KK.sck:AddTool(TOOL)

TOOL:_updatePanel()
