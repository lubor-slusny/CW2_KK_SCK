
AddCSLuaFile()

local PANEL
local lastFile = ""

local function AllowInput() return true end
local workshopLink = "http://steamcommunity.com/sharedfiles/filedetails/"

local function OnGetFocus(self)
	SetClipboardText(self:GetValue())
end

local examplePaths = {
	"lua/autorun/cw_kk_ins.lua",
	"models/weapons/upgrades/a_optic_kobra.mdl",
	"models/weapons/v_mg42.mdl"
}

local function updatePanel()
	if !IsValid(PANEL) then return end
	
	local panel = PANEL
	
	panel:ClearControls()
	
	local label = vgui.Create("DLabel", panel)
	label:SetText("Gimmi file (full path + extension, like VV):")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(8, 0, 8, 0)
	panel:AddItem(label)
	
	for _,p in pairs(examplePaths) do
		local label = vgui.Create("DLabel", panel)
		label:SetText(p)
		label:SetDark(true)
		-- label:Dock(TOP)
		label:DockMargin(16, 0, 8, 0)
		label:SetMouseInputEnabled(true)
		
		function label:DoClick()
			lastFile = p
			updatePanel()
		end
		
		panel:AddItem(label)
	end
	
	local box = vgui.Create("DTextEntry", panel)
	box:Dock(TOP)
	box:DockMargin(8, 0, 8, 0)
	box:SetValue(lastFile)
	panel:AddItem(box)
	
	function box:OnEnter()
		lastFile = self:GetValue() 
		updatePanel()
	end
	
	local butt = vgui.Create("DButton", panel)
	butt:SetText("ROLL DAT DICE")
	butt:DockMargin(8, 0, 8, 0)
	panel:AddItem(butt)
	
	function butt:DoClick()
		lastFile = box:GetValue() 
		updatePanel()
	end
	
	if !lastFile or lastFile == "" then return end
	
	local foundAtAll = file.Exists(lastFile, "GAME")
	
	// if not found at all, end here
	if not foundAtAll then
		local label = vgui.Create("DLabel", panel)
		label:SetText("File not found at all.")
		label:SetDark(true)
		label:DockMargin(8, 0, 8, 0)
		panel:AddItem(label)
		
		return
	end
	
	-- local foundInGMod = file.Exists(lastFile, "MOD") // doesnt ignore mount.cfg mounting, GG WP
	
	-- // if found in gmod folder, no need to check all addons, right?
	-- if not foundInGMod then
		-- local label = vgui.Create("DLabel", panel)
		-- label:SetText("File loaded from Garry`s Mod main folder.")
		-- label:SetDark(true)
		-- label:DockMargin(8, 0, 8, 0)
		-- panel:AddItem(label)
		
		-- return
	-- end
	
	// check mounted workshop addons
	local sources = {}
	
	for _,addon in pairs(engine.GetAddons()) do
		if addon.models == 0 then continue end
		if !addon.mounted then continue end
		
		local found = file.Find(lastFile, addon.title)
		
		if table.Count(found) > 0 then
			sources[addon.wsid] = addon.title
		end
	end
	
	if table.Count(sources) > 0 then
		local labelPanel = vgui.Create("DPanel", PANEL)
		
			local label
			label = vgui.Create("DLabel", labelPanel)
			label:SetText("File loaded from Workshop:")
			label:SetDark(true)
			label:Dock(LEFT)
			label:DockMargin(0,0,0,0)
			label:SizeToContents()
			
			local label
			label = vgui.Create("DLabel", labelPanel)
			label:SetText("[LMB - COPY]")
			label:SetDark(true)
			label:Dock(RIGHT)
			label:DockMargin(0,0,0,0)
			label:SizeToContents()
			
		labelPanel:Dock(TOP)
		labelPanel:DockMargin(8,0,8,0)
		labelPanel:SizeToContents()
		labelPanel:SetPaintBackground(false)
		panel:AddItem(labelPanel)
	
		for id,name in pairs(sources) do
			local left = vgui.Create("DLabel", panel)
			left:SetText("Addon title:")
			left:SetDark(true)
			left:DockMargin(16, 0, 0, 0)
			
			local box = vgui.Create("DTextEntry", panel)
			box:Dock(TOP)
			box:DockMargin(0, 0, 16, 0)
			box:SetValue(name)
			box.AllowInput = AllowInput
			box.OnGetFocus = OnGetFocus
			panel:AddItem(left, box)
			
			local left = vgui.Create("DLabel", panel)
			left:SetText("Workshop ID:")
			left:SetDark(true)
			left:DockMargin(16, 0, 0, 0)
			
			local box = vgui.Create("DTextEntry", panel)
			box:Dock(TOP)
			box:DockMargin(0, 0, 16, 0)
			box:SetValue(id)
			box.AllowInput = AllowInput
			box.OnGetFocus = OnGetFocus
			panel:AddItem(left, box)
			
			local left = vgui.Create("DLabel", panel)
			left:SetText("Workshop Link:")
			left:SetDark(true)
			left:DockMargin(16, 0, 0, 0)
			
			local box = vgui.Create("DTextEntry", panel)
			box:Dock(TOP)
			box:DockMargin(0, 0, 16, 0)
			box:SetValue(workshopLink .. id)
			box.AllowInput = AllowInput
			box.OnGetFocus = OnGetFocus
			panel:AddItem(left, box)
		end
		
		return
	end
	
	// if it aint anywhere else
	local label = vgui.Create("DLabel", panel)
	label:SetText("File loaded from one of:")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(8, 0, 8, 0)
	panel:AddItem(label)
	
	local label = vgui.Create("DLabel", panel)
	label:SetText("legacy addons OR")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(16, 0, 8, 0)
	panel:AddItem(label)
	
	local label = vgui.Create("DLabel", panel)
	label:SetText("mounted games OR")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(24, 0, 8, 0)
	panel:AddItem(label)
	
	local label = vgui.Create("DLabel", panel)
	label:SetText("Garry`s Mod folder")
	label:SetDark(true)
	label:Dock(TOP)
	label:DockMargin(32, 0, 8, 0)
	panel:AddItem(label)
end

local toolName = "conflictracker"
local toolPrintName = "File Tracker"

hook.Add("PopulateToolMenu", toolName, function()
	spawnmenu.AddToolMenuOption("Utilities", "Knife Kitty", toolName, toolPrintName, "", "", function(p)
		PANEL = p
		updatePanel()
	end)
end)

RunConsoleCommand("spawnmenu_reload")
