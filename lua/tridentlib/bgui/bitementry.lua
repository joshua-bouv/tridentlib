--[[tridentlib
  "name": "Item Entry",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

local function updateVariable(panel, data)
	// if check
	self.variable:SetSize(0, 0)
end

function Panel:Init()
	self.text = ""
	self.options = {}

	self:tridentlib("THEME::Apply", "BFrame_Default")

	self.options = self:Add("BDropDown")
	self.options:SetPos(0, 0)
	self.options:SetSize(0, 0)
	self.options:SetTitle("Select user/s")
	self.options:SetFont("reports_text_large")
	self.options:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.options:SetColor(tridentlib("THEME::Get", "Reports")["Colors"]["Red"])
	self.options:SetOptionFont("reports_text")
	self.options:SetOutline(true)
	self.options.OnSelect = function(index)
		updateVariable(self.variable, {index, self.options})
	end

	// if required

	self.variable = self:Add("BTextEntry")
	self.variable:Dock(RIGHT)
	self.variable:DockMargin(0, 0, 10, 0)
	self.variable:SetSize(0, 0)
	self.variable:SetTitle("")
	self.variable:SetFont("reports_text_large")
	self.variable:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
	self.variable.OnEnter = function(textEntry)
		// run function
	end

	self.delete = self:Add("BButton")
	self.delete:Dock(RIGHT)
	self.delete:DockMargin(0, 0, 10, 0)
	self.delete:SetSize(30, 30)
	self.delete:SetText("✕")
	self.delete:SetFont("reports_text_extra_large")
	self.delete:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.delete.DoClick = function()
		// delete
	end
end

function Panel:SetOptions(tbl)
	self.options = tbl

	if (self.options[1]["variable"]["active"]) then
		updateVariable(self.variable, {1, self.options})
	end
end

function Panel:Paint(w, h)
	draw.SimpleText(self.text, "reports_sidebar", 10, 25, theme.Text.Default, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function Panel:OnSizeChanged(w, h)
	self.options:SetPos()
	self.options:SetSize()

	// if required

	self.options:SetSize()
end

vgui.Register("BItemEntry", Panel, "DPanel")