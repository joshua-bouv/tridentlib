--[[tridentlib
  "name": "Text Entry",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Col = tridentlib("THEME::Get", "BFrame_Default")["Base"]["Background"]
	self.TargetCol = tridentlib("THEME::Get", "BFrame_Default")["Base"]["Background"]

	self.Title = ""
	self.ValChanged = false

	self:tridentlib("THEME::Apply", "BFrame_Default")
end

function Panel:OnSizeChanged(w, h)
	self.hs8 = h-8
	self.hs2 = h-2
end

function Panel:Paint(w, h, theme)
	draw.RoundedBox(4, 0, self.hs8, w, 8, theme.Base.Fade3)
	draw.RoundedBox(4, 0, 0, w, self.hs2, self.Col)

	self.Col = LerpColor(0.1, self.Col, self.TargetCol) -- make global func not global

	if self:IsHovered() or self:IsEditing() then
		self.TargetCol = theme.Base.InnerBackground
	else
		self.TargetCol = theme.Base.Background
	end

	self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), theme.Text.Default)
end

function Panel:OnGetFocus()
	if self:GetValue() == self.Title then
		self:SetValue("")
		self.ValChanged = true
	end
end

function Panel:OnLoseFocus()
	if self:GetValue() == "" then
		timer.Simple(0.1, function() self:SetValue(self.Title) end)
		self.ValChanged = false
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