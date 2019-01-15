--[[tridentlib
  "name": "Text Entry",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.PrimaryCol = backGround
	self.AltCol = alternativeBackground
	self.Col = self.PrimaryCol
	self.BottomHighlight = true
	self.MenuTitle = ""
	self.VisibleMenuTitle = ""
	self.VisibleMenuMainTitle = ""
	self.spacing = ""
end

function Panel:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, self.Col)

	if self.BottomHighlight then
		draw.RoundedBox(0, 0, h-1, w, 1, fade2)
	end

	draw.SimpleText(self.VisibleMenuTitle, "eventsTextFontSmall", 3, 1, blueText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(self.spacing..self.VisibleMenuMainTitle, self:GetFont(), 3, h/2, text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)	

	if self:IsHovered() then
		self.Col = self.AltCol
	else
		self.Col = self.PrimaryCol
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

function Panel:ShowBottomHighlight(bool)
	self.BottomHighlight = bool
end

function Panel:SetTitle(data)
	self.MenuTitle = data
	self.VisibleMenuMainTitle = data
end

function Panel:SetSpacing(str)
	self.spacing = str
end

function Panel:SetColors(primary, alternative)
	self.PrimaryCol = primary
	self.AltCol = alternative
	self.Col = self.PrimaryCol
end

vgui.Register("BTextEntry", Panel, "DTextEntry")