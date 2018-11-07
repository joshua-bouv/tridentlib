--[[tridentlib
  "name": "Checkbox",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Col = Color(255, 255, 255, 255)
	self.lerpCol = Color(68, 138, 255, 0)
	self.targetLerpCol = Color(68, 138, 255, 0)
	self.text = ""
end

function Panel:Paint(w, h)
	draw.RoundedBox(2, 0, 0, w, h, self.Col)
	draw.RoundedBox(0, 1, 0, w-2, 1, fade) -- TOP
	draw.RoundedBox(0, 1, h-1, w-2, 1, fade) -- BOTTOM
	draw.RoundedBox(0, 0, 0, 1, h, fade) -- LEFT
	draw.RoundedBox(0, w-1, 0, 1, h, fade) -- RIGHT
	self.lerpCol = LerpTransparency(0.9, self.targetLerpCol, self.lerpCol)
	draw.RoundedBox(2, 1, 1, w-2, h-2, self.lerpCol)

	draw.SimpleText(self.text, "eventsTextMidFont",w/2, h/2, whiteText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if self:IsHovered() then
		self.Col = Color(235, 235, 235, 255)
	else
		self.Col = Color(255, 255, 255, 255)
	end
end

function Panel:OnChange(val)
	if val then
		self.targetLerpCol = Color(68, 138, 255, 255)
		self.text = "✓"
	else
		self.targetLerpCol = Color(68, 138, 255, 0)
		self.text = ""
	end
end

vgui.Register("BCheckBox", Panel, "DCheckBox")