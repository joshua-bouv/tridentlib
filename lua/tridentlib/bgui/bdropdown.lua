--[[tridentlib
  "name": "Dropdown",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.MenuTitle = ""
	self.VisibleMenuTitle = ""
	self.cornersEnabled = false
	self.Col = backGround

	self:SetTextInset(3, 0)
end

function Panel:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, self.Col)

	if self.cornersEnabled then
		surface.SetDrawColor(0, 0, 0, 25)
		surface.DrawLine(0, 0, 0, h)
		surface.DrawLine(w-1, 0, w-1, h)
	else
		draw.RoundedBox(0, 0, 49, w, 1, fade2)
	end

	draw.SimpleText(self.VisibleMenuTitle, "eventsTextFontSmall", 3, 1, blueText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	if self:IsHovered() then
		if self:IsMenuOpen() then 
			self.Col = alternativeBackground2
		else
			self.Col = alternativeBackground
		end
	elseif self:IsMenuOpen() then
		self.Col = alternativeBackground2
	else
		self.Col = backGround
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
		draw.RoundedBox(0, 2, 2, w-4, h-4, backGround)
		draw.RoundedBox(0, 0, 0, 1, h, fade5) -- LEFT
		draw.RoundedBox(0, w-1, 0, 1, h, fade5) -- RIGHT
		draw.RoundedBox(0, 1, h-1, w-2, 1, fade5) -- BOTTOM
	end

	for k, v in pairs(self.Menu:GetCanvas():GetChildren()) do
		local text = ""

		if k == self:GetSelectedID() then
			text = "✓"
		end

		v:SetFont("eventsTextFont")
		v:SetColor(black)
		function v:Paint(w, h)
			if v:IsHovered() then
				draw.RoundedBox(0, 1, 0, w-2, h-1, alternativeBackground)
			else
				draw.RoundedBox(0, 1, 0, w-2, h-1, backGround)
			end
			draw.SimpleText(text, "eventsTickFont", 15, h/2, black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

function Panel:SetTitle(data)
	self.MenuTitle = data
	self:SetValue(data)
end

vgui.Register("BDropDown", Panel, "DComboBox")