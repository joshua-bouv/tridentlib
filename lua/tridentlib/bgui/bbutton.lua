--[[tridentlib
  "name": "Button",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Font = "Default"
	self.Color = Color(255, 255, 255, 255)
	self.Outline = false
	self.Text = ""
end

function Panel:OnSizeChanged(w, h)
	self.hs2 = h-2
	self.hs6 = h-6
	self.hs8 = h-8
	self.hs2d2 = (h-2)/2
	self.wd2 = w/2
	self.ws4 = w-4
end

function Panel:Paint(w, h)
	draw.RoundedBox(4, 0, self.hs8, w, 8, fade3)
	draw.RoundedBox(4, 0, 0, w, self.hs2, blue)
	if self.Outline then draw.RoundedBox(4, 2, 2, self.ws4, self.hs6, self.Color) end

	draw.SimpleText(self.Text, self.Font, self.wd2, self.hs2d2, text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function Panel:SetText(txt)
	self.Text = txt
end

function Panel:SetColor(col)
	self.Color = col
end

function Panel:SetOutline(bool)
	self.Outline = bool
end

function Panel:SetFont(txt)
	self.Font = txt
end

vgui.Register("BButton", Panel, "DButton")