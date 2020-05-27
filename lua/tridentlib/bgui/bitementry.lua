--[[tridentlib
  "name": "Item Entry",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

local function togglePanel(parent, panel, data)
	if data['inputRequired'] != false then
		parent:SetSize(135, 0)
		panel:SetSize(135, 0)
		panel:SetTitle(data['placeholder'])
		// type checking set
	else
		parent:SetSize(272.5, 0)
		panel:SetSize(0, 0)
	end
end

function Panel:Init()
	self.options = {}
	self.targets = {}

	self.variable = false
	self.playerInfo = false

	self:tridentlib("THEME::Apply", "BFrame_Default")

	self.playerHandler = self:Add("DPanel")
	self.playerHandler:Dock(LEFT)
	self.playerHandler:SetSize(272.5, 40)
	self.playerHandler.Paint = function() end

	self.target = self.playerHandler:Add("BDropDown")
	self.target:Dock(LEFT)
	self.target:SetSize(272.5, 40)
	self.target:SetTitle("")
	self.target:SetFont("reports_text_large")
	self.target:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.target:SetColor(tridentlib("THEME::Get", "Reports")["Colors"]["Blue"])
	self.target:SetOptionFont("reports_text")
	self.target:SetOutline(true)
	self.target:SetSortItems(false)
	self.target.OnSelect = function(_, index)
		togglePanel(self.target, self.playerInfo, self.targets[index]['input'])
	end

	self.playerInfo = self.playerHandler:Add("BTextEntry")
	self.playerInfo:Dock(FILL)
	self.playerInfo:DockMargin(5, 0, 0, 0)
	self.playerInfo:SetSize(135, 40)
	self.playerInfo:SetTitle("")
	self.playerInfo:SetFont("reports_text_large")
	self.playerInfo:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
	self.playerInfo.OnEnter = function(textEntry)
		// run function
	end

	self.actionHandler = self:Add("DPanel")
	self.actionHandler:Dock(FILL)
	self.actionHandler:DockMargin(5, 0, 5, 0)
	self.actionHandler:SetSize(272.5, 40)
	self.actionHandler.Paint = function() end

	self.option = self.actionHandler:Add("BDropDown")
	self.option:Dock(LEFT)
	self.option:SetSize(272.5, 40)
	self.option:SetTitle("")
	self.option:SetFont("reports_text_large")
	self.option:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.option:SetColor(tridentlib("THEME::Get", "Reports")["Colors"]["Red"])
	self.option:SetOptionFont("reports_text")
	self.option:SetOutline(true)
	self.option:SetSortItems(false)
	self.option.OnSelect = function(_, index)
		togglePanel(self.option, self.variable, self.options[index]['input'])
	end

	self.variable = self.actionHandler:Add("BTextEntry")
	self.variable:Dock(FILL)
	self.variable:DockMargin(5, 0, 0, 0)
	self.variable:SetSize(135, 40)
	self.variable:SetTitle("")
	self.variable:SetFont("reports_text_large")
	self.variable:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
	self.variable.OnEnter = function(textEntry)
		// run function
	end

	self.delete = self:Add("BButton")
	self.delete:Dock(RIGHT)
	self.delete:DockMargin(0, 7.5, 0, 7.5)
	self.delete:SetSize(25, 25)
	self.delete:SetTitle("✕")
	self.delete:SetFont("reports_text")
	self.delete:SetColor(tridentlib("THEME::Get", "Reports")["Colors"]["Red"])
	self.delete:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.delete.DoClick = function()
		self:Remove()
	end
end

function Panel:AddPlayerTargets(tbl)
	self.targets = tbl

	for _, v in ipairs(self.targets) do
		self.target:AddChoice(v['text'])
	end
	self.target:SetTitle(self.targets[1]['text'])
	togglePanel(self.target, self.playerInfo, self.targets[1]['input'])
end

function Panel:AddPunishments(tbl)
	self.options = tbl

	for _, v in ipairs(self.options) do
		self.option:AddChoice(v['text'])
	end
	self.option:SetTitle(self.options[1]['text'])
	togglePanel(self.option, self.variable, self.options[1]['input'])
end

function Panel:Paint() end

vgui.Register("BItemEntry", Panel, "DPanel")