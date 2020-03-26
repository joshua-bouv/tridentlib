--[[tridentlib
  "name": "Checkbox",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self:SetToggle(false)

	self.Text = ""
	self.Font = "Default" // need theme for default font

	self.InternalCol = tridentlib("THEME::Get", "BFrame_Default")["Base"]["Background"]
	self.Col = self.InternalCol
	self.TargetCol = self.InternalCol
	self:tridentlib("THEME::Apply", "BFrame_Default")
end

function Panel:OnSizeChanged(w, h)
	self.ws2 = w-2
	self.hs2 = h-2
	self.wd2 = w/2
	self.hd2 = h/2
end

function Panel:Paint(w, h)
	draw.RoundedBox(4, 0, 0, w, h, theme.Base.Fade3)
	draw.RoundedBox(4, 1, 1, self.ws2, self.hs2, self.Col)
	draw.SimpleText(self.Text, self.Font, self.wd2, self.hd2, theme.Base.Default, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	self.Col = tridentlib("LerpColor", 0.1, self.Col, self.TargetCol)
	
	if not self:GetToggle() then
		if self:IsHovered() then
			self.TargetCol = theme.Base.InnerBackground
		else
			self.TargetCol = theme.Base.Background
		end
	end
end

function Panel:OnChange(val)
	if val then
		self.TargetCol = tridentlib("THEME::Get", "Reports")["Colors"]["Blue"]
		self.Text = "✓"
	else
		self.TargetCol = self.InternalCol
		self.Text = ""
	end

	self:SetToggle(val)
end

function Panel:SetFont(font)
	self.Font = font
end

vgui.Register("BCheckBox", Panel, "DCheckBox")