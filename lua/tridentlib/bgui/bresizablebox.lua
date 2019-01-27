--[[tridentlib
  "name": "Resizable Box",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.scale = 1
	self.FontSize = 20
	self.Dragging = false
	self.PosX, self.PosY, self.CanvasMovementX, self.CanvasMovementY = 0, 0, 0, 0
end

function Panel:SizeSet(w, h)
	self.scaleW, self.scaleH = w, h
	self:SetSize(w, h)
end

function Panel:GetInternalPos()
	return self.PosX, self.PosY
end

function Panel:SetInternalPos(x, y)
	self.PosX, self.PosY = x, y
end

function Panel:ChangeSize(size)
	self.scale = size
	self:SetSize(self.scaleW*self.scale, self.scaleH*self.scale)
	self.FontScale = math.Round(20*self.scale, 0)
end

function Panel:Think()
	if (self.Dragging) then
		self.CanvasMovementX, self.CanvasMovementY = (self.Dragging[1] - gui.MouseX()), (self.Dragging[2] - gui.MouseY())
		self.Dragging = {gui.MouseX(), gui.MouseY()}

		local backX, backY = self:GetParent():GetBackgroundMovement()
		local x, y = self:GetPos()
		local xNew, yNew = x+-self.CanvasMovementX, y+-self.CanvasMovementY

		self:SetPos(xNew, yNew)
		self:SetInternalPos(math.abs(backX) + xNew, math.abs(backY) + yNew)
	end
end

function Panel:OnMousePressed()
	self.Dragging = {gui.MouseX(), gui.MouseY()}
end

function Panel:OnMouseReleased()
	self.Dragging = false
end

-------------------------------

function Panel:SetFontSize(size)
	self.FontSize = size
	self.FontScale = math.Round(20*self.scale, 0)
end

function Panel:SquareMoved()
	-- for overide
end

vgui.Register("BResizableBox", Panel, "DButton")