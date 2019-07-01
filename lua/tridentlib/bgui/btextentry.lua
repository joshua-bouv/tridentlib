--[[tridentlib
  "name": "Text Entry",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.InternalCol = backGround
	self.Col = self.InternalCol
	self.TargetCol = self.InternalCol

	self.Title = ""
	self.ValChanged = false
end

function Panel:OnSizeChanged(w, h)
	self.hs8 = h-8
	self.hs2 = h-2
end

function Panel:Paint(w, h)
	draw.RoundedBox(4, 0, self.hs8, w, 8, fade3)
	draw.RoundedBox(4, 0, 0, w, self.hs2, self.Col)

	self.Col = LerpColor(0.1, self.Col, self.TargetCol) -- make global func not global

	if self:IsHovered() or self:IsEditing() then
		self.TargetCol = innerBackground
	else
		self.TargetCol = self.InternalCol
	end

	self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), whiteText)
end

function Panel:OnGetFocus()
	if self:GetValue() == self.Title then
		self:SetValue("")
		self.ValChanged = true
	end
end

function Panel:SetTitle(txt)
	self:SetValue(txt)
	self.Title = txt
end

function Panel:GetChangedVal()
	local txt = ""

	if self.ValChanged then
		txt = self:GetValue()
	end

	return txt
end

vgui.Register("BTextEntry", Panel, "DTextEntry")