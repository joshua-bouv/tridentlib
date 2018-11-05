--[[tridentlib
  "name": "GUI::Dropdown"
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.MenuTitle = ""
	self.VisibleMenuTitle = ""
	self.cornersEnabled = false
	self.Col = Color(255, 255, 255, 255)

	self:SetTextInset(3, 0)
end

function Panel:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, self.Col)

	if self.cornersEnabled then
		surface.SetDrawColor(0, 0, 0, 25)
		surface.DrawLine(0, 0, 0, h)
		surface.DrawLine(w-1, 0, w-1, h)
	else
		surface.SetDrawColor(200, 200, 200, 255)
		surface.DrawLine(0, 49, w, 49)
	end

	draw.SimpleText(self.VisibleMenuTitle, "eventsTextFontSmall", 3, 1, Color(68, 138, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	if self:IsHovered() then
		if self:IsMenuOpen() then 
			self.Col = Color(215, 215, 215, 255)
		else
			self.Col = Color(235, 235, 235, 255)
		end
	elseif self:IsMenuOpen() then
		self.Col = Color(215, 215, 215, 255)
	else
		self.Col = Color(255, 255, 255, 255)
	end
end

function Panel:OnSelect()
	if self:GetTall() >= 35 then
		self.VisibleMenuTitle = self.MenuTitle
	end
end

function Panel:EnableCorners()
	self.cornersEnabled = true
end

function Panel:DoClick()
	if (self:IsMenuOpen()) then
		return self:CloseMenu()
	end

	self:OpenMenu()
	if !self.Menu then return end
	self.Menu.Paint = function(_, w, h)
		draw.RoundedBox(0, 2, 2, w-4, h-4, Color(255, 255, 255, 255))
		draw.RoundedBox(0, 0, 0, 1, h, fade) -- LEFT
		draw.RoundedBox(0, w-1, 0, 1, h, fade) -- RIGHT
		draw.RoundedBox(0, 1, h-1, w-2, 1, fade) -- BOTTOM
	end

	for k, v in pairs(self.Menu:GetCanvas():GetChildren()) do
		local text = ""

		if k == self:GetSelectedID() then
			text = "✓"
		end

		v:SetFont("eventsTextFont")
		v:SetColor(Color(0, 0, 0, 255))
		function v:Paint(w, h)
			if v:IsHovered() then
				draw.RoundedBox(0, 1, 0, w-2, h-1, Color(235, 235, 235, 255))
			else
				draw.RoundedBox(0, 1, 0, w-2, h-1, Color(255, 255, 255, 255))
			end
			draw.SimpleText(text, "eventsTickFont", 15, h/2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

function Panel:SetTitle(data)
	self.MenuTitle = data
	self:SetValue(data)
end

vgui.Register("BDropDown", Panel, "DComboBox")