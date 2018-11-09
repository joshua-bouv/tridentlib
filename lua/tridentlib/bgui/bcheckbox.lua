--[[tridentlib
  "name": "Checkbox",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Col = backGround
	self.lerpCol = blueTransparent
	self.targetLerpCol = blueTransparent
	self.text = ""
end

function Panel:Paint(w, h)
	draw.RoundedBox(2, 0, 0, w, h, self.Col)
	draw.RoundedBox(0, 1, 0, w-2, 1, fade5) -- TOP
	draw.RoundedBox(0, 1, h-1, w-2, 1, fade5) -- BOTTOM
	draw.RoundedBox(0, 0, 0, 1, h, fade5) -- LEFT
	draw.RoundedBox(0, w-1, 0, 1, h, fade5) -- RIGHT
	self.lerpCol = LerpTransparency(0.9, self.targetLerpCol, self.lerpCol)
	draw.RoundedBox(2, 1, 1, w-2, h-2, self.lerpCol)

	draw.SimpleText(self.text, "eventsTextMidFont",w/2, h/2, whiteText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if self:IsHovered() then
		self.Col = alternativeBackground
	else
		self.Col = backGround
	end
end

function Panel:OnChange(val)
	if val then
		self.targetLerpCol = blue
		self.text = "✓"
	else
		self.targetLerpCol = blueTransparent
		self.text = ""
	end
end

vgui.Register("BCheckBox", Panel, "DCheckBox")