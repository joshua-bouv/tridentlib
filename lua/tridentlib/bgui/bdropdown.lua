--[[tridentlib
  "name": "Dropdown",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.MenuTitle = ""
	self.VisibleMenuTitle = ""
	
	self.InternalCol = tridentlib("THEME::Get", "Reports")["Base"]["Background"]
	self.Col = self.InternalCol
	self.TargetCol = self.InternalCol

	self.Outline = false
	self.OutlineCol = white

	self.MiniFont = "Default"
	self.OptionFont = "Default"

	self:SetTextInset(3, -1)
end

function Panel:OnSizeChanged(w, h)
	self.hs8 = h-8
	self.hs2 = h-2
	self.ws4 = w-4
	self.hs6 = h-6
end

function Panel:Paint(w)
	draw.RoundedBox(4, 0, self.hs8, w, 8, fade3)
	draw.RoundedBox(4, 0, 0, w, self.hs2, self.Col)	
	if self.Outline then draw.RoundedBox(4, 0, 0, w, self.hs2, self.OutlineCol) draw.RoundedBox(4, 2, 2, self.ws4, self.hs6, self.Col) end
	draw.SimpleText(self.VisibleMenuTitle, self.MiniFont, 5, 3, whiteText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	self.Col = LerpColor(0.1, self.Col, self.TargetCol) -- make global func not global

	if self:IsHovered() or self:IsMenuOpen() then
		self.TargetCol = innerBackground
	else
		self.TargetCol = self.InternalCol
	end
end

function Panel:OnSelect()
	self:SetTextInset(3, 3)

	if self:GetTall() >= 35 then
		self.VisibleMenuTitle = self.MenuTitle
	end
end

function Panel:DoClick()
	if (self:IsMenuOpen()) then	return self:CloseMenu()	end

	self:OpenMenu()

	if !self.Menu then return end

	self.Menu.Paint = function(_, w, h)
		draw.RoundedBox(0, 0, 0, w, h, backGround)
	end

	for k, v in pairs(self.Menu:GetCanvas():GetChildren()) do
		local check = ""

		if k == self:GetSelectedID() then
			check = "✓"
		end

		v:SetFont(self.OptionFont)
		v:SetColor(whiteText)
		function v:Paint(w, h)
			if v:IsHovered() then
				draw.RoundedBox(0, 1, 0, w-2, h-1, Color(32, 34, 37, 255))
			else
				draw.RoundedBox(0, 1, 0, w-2, h-1, backGround)
			end
			draw.SimpleText(check, "eventsTickFont", 15, h/2, whiteText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

function Panel:SetTitle(data)
	self.MenuTitle = data
	self:SetValue(data)
end

function Panel:SetColor(col)
	self.InternalCol = col
	self.Col = self.InternalCol
	self.TargetCol = self.InternalCol
end

function Panel:SetOutline(bool)
	self.Outline = bool	

	if bool then
		self.OutlineCol = self.InternalCol

		self.InternalCol = backGround
		self.Col = self.InternalCol
		self.TargetCol = self.InternalCol
	end
end

function Panel:SetOptionFont(txt)
	self.OptionFont = txt
end

function Panel:SetMiniFont(txt)
	self.MiniFont = txt
end

vgui.Register("BDropDown", Panel, "DComboBox")