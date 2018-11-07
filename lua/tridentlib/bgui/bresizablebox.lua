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

--	local wPan, hPan = self:GetSize()

--	local wPan = wPan+2
--	local hPan = hPan+2

--	if not size then
--		wPan = wPan-4
--		hPan = hPan-4
--	end

--	self:SetSize(wPan, hPan)

--	self.scale = hPan/self.scaleH
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

vgui.Register("BResizableBox", Panel, "DButton")