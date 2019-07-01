--[[tridentlib
  "name": "Password Entry",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}


function Panel:Init()
	self.Text = ""
	self:SetValue("")
end

function Panel:OnSizeChanged(w, h)
	self.hs8 = h-8
	self.hs2 = h-2
	self.hs2d2 = (h-2)/2
end

function Panel:Paint(w)
	draw.RoundedBox(4, 0, self.hs8, w, 8, fade3)
	draw.RoundedBox(4, 0, 0, w, self.hs2, self.Col)

	self.Col = LerpColor(0.1, self.Col, self.TargetCol) -- make global func not global

	if self:IsHovered() or self:IsEditing() then
		self.TargetCol = innerBackground
	else
		self.TargetCol = self.InternalCol
	end

	draw.SimpleText(self.Text, self:GetFont(), 5, self.hs2d2, whiteText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function Panel:OnChange()
	self.Text = string.rep("●", string.len(self:GetText()))
end

vgui.Register("BPassEntry", Panel, "BTextEntry")