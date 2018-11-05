--[[tridentlib
  "name": "GUI::Text Entry"
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Col = Color(255, 255, 255, 255)
	self.MenuTitle = ""
	self.VisibleMenuTitle = ""
	self.VisibleMenuMainTitle = ""
end

function Panel:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, self.Col)
	surface.SetDrawColor(200, 200, 200, 255)
	surface.DrawLine(0, 49, w, 49)

	draw.SimpleText(self.VisibleMenuTitle, "eventsTextFontSmall", 3, 1, Color(68, 138, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(self.VisibleMenuMainTitle, self:GetFont(), 3, h/2, titleText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)	

	if self:IsHovered() then
		self.Col = Color(235, 235, 235, 255)
	else
		self.Col = Color(255, 255, 255, 255)
	end

	if self:IsEditing() then
		self.VisibleMenuTitle = self.MenuTitle
		self.VisibleMenuMainTitle = ""
	else
		if self:GetValue() == "" then
			self.VisibleMenuTitle = ""
			self.VisibleMenuMainTitle = self.MenuTitle
		else
			if self:GetValue() == self.MenuTitle then
				self.VisibleMenuTitle = ""
				self.VisibleMenuMainTitle = self.MenuTitle
			else
				self.VisibleMenuTitle = self.MenuTitle
				self.VisibleMenuMainTitle = ""
			end
		end
	end

	self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor())
end

function Panel:SetTitle(data)
	self.MenuTitle = data
	self.VisibleMenuMainTitle = data
end

vgui.Register("BTextEntry", Panel, "DTextEntry")