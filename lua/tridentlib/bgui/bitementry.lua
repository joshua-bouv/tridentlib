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

	self.target = self:Add("BDropDown")
	self.target:SetSize(0, 0)
	self.target:SetSize(0, 0)
	self.target:SetTitle("[name]")
	self.target:SetFont("reports_text_large")
	self.target:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.target:SetColor(tridentlib("THEME::Get", "Reports")["Colors"]["Blue"])
	self.target:SetOptionFont("reports_text")
	self.target:SetOutline(true)
	self.target.OnSelect = function(index)
		updateVariable(self.variable, {index, self.options})
	end

	self.option = self:Add("BDropDown")
	self.option:SetSize(0, 0)
	self.option:SetSize(0, 0)
	self.option:SetTitle("Kick")
	self.option:SetFont("reports_text_large")
	self.option:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.option:SetColor(tridentlib("THEME::Get", "Reports")["Colors"]["Red"])
	self.option:SetOptionFont("reports_text")
	self.option:SetOutline(true)
	self.option.OnSelect = function(index)
		updateVariable(self.variable, {index, self.options})
	end

	// if required

	self.variable = self:Add("BTextEntry")
	self.variable:SetSize(0, 0)
	self.variable:SetSize(0, 0)
	self.variable:SetTitle("")
	self.variable:SetFont("reports_text_large")
	self.variable:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
	self.variable.OnEnter = function(textEntry)
		// run function
	end

	self.delete = self:Add("BButton")
	self.delete:SetSize(0, 0)
	self.delete:SetSize(50, 50)
	self.delete:SetTitle("✕")
	self.delete:SetFont("reports_text")
	self.delete:SetColor(tridentlib("THEME::Get", "Reports")["Colors"]["Red"])
	self.delete:SetTextColor(tridentlib("THEME::Get", "Reports")["Text"]["Default"])
	self.delete.DoClick = function()
		// delete
	end
end

function Panel:AddOptions(tbl)
	self.options = tbl

	for _, v in ipairs(self.options) do
		self.option:AddChoice(v)
	end

	//if (self.options[1]["variable"]["active"]) then
		//updateVariable(self.variable, {1, self.options})
	//end
	// set default option to self.option
end

function Panel:SetOption(tbl)
	// set option
end

function Panel:Paint(w, h, theme)
	draw.SimpleText(self.text, "reports_sidebar", 10, 25, theme.Text.Default, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function Panel:OnSizeChanged(w, h)
	self.target:SetPos(0, 0) // beccause dock is so TRASH I have to do this manually :(
	self.target:SetSize(0, 0)

	self.option:SetPos(0, 0)
	self.option:SetSize(0, 0)

	self.delete:SetPos(0, 0)

	// if required

	self.variable:SetSize(0, 0)
end

vgui.Register("BItemEntry", Panel, "DPanel")