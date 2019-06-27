--[[tridentlib
  "name": "Dropdown",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.MenuTitle = ""
	self.VisibleMenuTitle = ""
	self.Corners = false
	self.BottomHighlight = false
	self.Outline = false
	self.Col = backGround
	self.OutlineCol = transparent

	self:SetTextInset(5, -1)
end

function Panel:Paint(w, h)
	if self.Outline then
		draw.RoundedBox(4, 0, 0, w, h-2, self.OutlineCol)
		draw.RoundedBox(4, 2, 2, w-4, h-6, self.Col)
	else
		draw.RoundedBox(4, 2, 2, w, h, self.Col)
	end

	if self.BottomHighlight then
		draw.RoundedBox(0, 0, h-1, w, 1, fade2)
	else
		draw.RoundedBox(4, 0, h-8, w, 8, fade3)
	end

	if self.Corners then
		surface.SetDrawColor(0, 0, 0, 25)
		surface.DrawLine(0, 0, 0, h)
		surface.DrawLine(w-1, 0, w-1, h)
	else
		draw.RoundedBox(0, 0, 49, w, 1, fade2)
	end

	draw.SimpleText(self.VisibleMenuTitle, "eventsTextFontSmall", 5, 3, whiteText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	if self:IsHovered() or self:IsMenuOpen() then
		self.Col = innerBackground
	else
		self.Col = backGround
	end
end

function Panel:OnSelect()
	self:SetTextInset(5, 3)

	if self:GetTall() >= 35 then
		self.VisibleMenuTitle = self.MenuTitle
	end
end

function Panel:DoClick()

	if (self:IsMenuOpen()) then
		return self:CloseMenu()
	end

	self:OpenMenu()

	if !self.Menu then return end
	self.Menu.Paint = function(_, w, h)
		draw.RoundedBox(0, 0, 0, w, h, backGround)
	end

	for k, v in pairs(self.Menu:GetCanvas():GetChildren()) do
		local text = ""

		if k == self:GetSelectedID() then
			text = "✓"
		end

		v:SetFont("eventsTextFont")
		v:SetColor(whiteText)
		function v:Paint(w, h)
			if v:IsHovered() then
				draw.RoundedBox(0, 1, 0, w-2, h-1, Color(32, 34, 37, 255))
			else
				draw.RoundedBox(0, 1, 0, w-2, h-1, backGround)
			end
			draw.SimpleText(text, "eventsTickFont", 15, h/2, whiteText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

function Panel:SetTitle(data)
	self.MenuTitle = data
	self:SetValue(data)
end

function Panel:DrawCorners(bool)
	self.Corners = bool
end

function Panel:DrawOutline(col)
	self.Outline = true
	self.OutlineCol = col
end

function Panel:DrawBottomHighlight(bool)
	self.BottomHighlight = true
end

vgui.Register("BDropDown", Panel, "DComboBox")