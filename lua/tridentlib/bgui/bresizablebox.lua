--[[tridentlib
  "name": "Resizable Box",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.scale = 1
	self.outerScale = 30
end

function Panel:ChangeSize(size)
	self.scale = self.outerScale/size
	local sizeW = self.scaleW/self.scale
	local sizeH = self.scaleH/self.scale

	self:SetSize(sizeW, sizeH)

	self.FontScale = math.Round(self.FontSize/self.scale, 0)
end

function Panel:SizeSet(w, h)
	self.scaleW, self.scaleH = w, h
	self:SetSize(w, h)
end

function Panel:SetFontSize(size)
	self.FontSize = size
	self.FontScale = size
end

function Panel:SquareMoved()
	-- for overide
end

vgui.Register("BResizableBox", Panel, "DButton")