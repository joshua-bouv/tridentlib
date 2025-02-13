--[[tridentlib
  "name": "Blueprint",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

/*
DO TRIDENTLIB COLORS
*/

function Panel:Init()
//	self.Dragging = false
//	self.ZoomAmount = 1
//	self.ScaledSize = 30
//	self.ObjectMovementX = -180
//	self.ObjectMovementY = -180
//	self.BackgroundMovementX = -180
//	self.BackgroundMovementY = -180


	self.ZoomAmount = 1
end

function Panel:Think()
//	if (self.Dragging) then
//		self.ObjectMovementX, self.ObjectMovementY = self.ObjectMovementX - (self.Dragging[1] - gui.MouseX()), self.ObjectMovementY - (self.Dragging[2] - gui.MouseY())
//		self.BackgroundMovementX, self.BackgroundMovementY = self.BackgroundMovementX - (self.Dragging[1] - gui.MouseX()), self.BackgroundMovementY - (self.Dragging[2] - gui.MouseY())
//		self.Dragging = {gui.MouseX(), gui.MouseY()}

//		for _, v in pairs(self:GetChildren()) do
//			local x, y, backX, backY = v:GetInternalPos()
//			local a, c = self:GetObjectMovement()

//			v:SetPos((x + -backX)*self.ZoomAmount - -a, (y + -backY)*self.ZoomAmount - -c)
//			v:SquareMoved()
//		end
//	end

	self:SetCursor("sizeall")
end

function Panel:GetObjectMovement()
	return self.ObjectMovementX, self.ObjectMovementY
end

function Panel:Zoom(change)
	self.ZoomAmount = self.ZoomAmount + change

//	for _, v in pairs(self:GetChildren()) do
//		local x, y, backX, backY = v:GetInternalPos()
//		local tempX = ((x + -backX)+self.ObjectMovementX/self.ZoomAmount) * self.ZoomAmount -- not perfect but close enough for now
//		local tempY = ((y + -backY)+self.ObjectMovementY/self.ZoomAmount) * self.ZoomAmount -- not perfect but close enough for now

//		v:SetPos(tempX , tempY)
//		v:ChangeSize(self.ZoomAmount)
//		v:SquareMoved()
//	end
end

function Panel:GetScale()
	return math.Round(self.ScaledSize*self.ZoomAmount, 0)
end

function Panel:OnMouseWheeled(direction)
	if direction > 0 then
		self:Zoom(0.05)
	else
		self:Zoom(-0.05)
	end	
end

function Panel:OnMousePressed()
	self.Dragging = {gui.MouseX(), gui.MouseY()}
	self:MouseCapture(true)

	return
end

function Panel:OnMouseReleased()
	self.Dragging = false
	self:MouseCapture(false)

	return
end

vgui.Register("BBlueprint", Panel, "DPanel")