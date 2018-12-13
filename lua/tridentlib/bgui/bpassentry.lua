--[[tridentlib
  "name": "Password Entry",
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
	self.lengthOfText = {} 
	self.length = 0
end

function Panel:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, self.Col)

	if self.BottomHighlight then
		draw.RoundedBox(0, 0, 49, w, 1, fade2)
	end

	draw.SimpleText(self.VisibleMenuTitle, "eventsTextFontSmall", 3, 1, blueText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(self.VisibleMenuMainTitle, self:GetFont(), 3, h/2, text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)	

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

	self.lengthOfText = {} 

	self.length = string.len(self:GetText()) 

	for i = 1, self.length do 
		table.insert(self.lengthOfText, "●") 
	end 

	draw.SimpleText(table.concat(self.lengthOfText, ""), "eventsTextFont", 2, h/2, text , TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function Panel:ShowBottomHighlight(bool)
	self.BottomHighlight = bool
end

function Panel:SetTitle(data)
	self.MenuTitle = data
	self.VisibleMenuMainTitle = data
end

function Panel:SetColors(primary, alternative)
	self.PrimaryCol = primary
	self.AltCol = alternative
	self.Col = self.PrimaryCol
end

vgui.Register("BPassEntry", Panel, "DTextEntry")