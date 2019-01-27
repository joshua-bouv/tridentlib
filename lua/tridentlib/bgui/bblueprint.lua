--[[tridentlib
  "name": "Blueprint",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Dragging = false
	self.ZoomAmount = 1 -- E
	self.ScaledSize = 30
	self.BackgroundMovementX = 0 -- A
	self.BackgroundMovementY = 0 -- C
end

function Panel:Think()
	if (self.Dragging) then
		self.BackgroundMovementX, self.BackgroundMovementY = self.BackgroundMovementX - (self.Dragging[1] - gui.MouseX()), self.BackgroundMovementY - (self.Dragging[2] - gui.MouseY())
		self.Dragging = {gui.MouseX(), gui.MouseY()}

		for _, v in pairs(self:GetChildren()) do
			x, y = v:GetInternalPos()
			v:SetPos(x + self.BackgroundMovementX, y + self.BackgroundMovementY)
		end
	end
end

function Panel:GetBackgroundMovement()
	return self.BackgroundMovementX, self.BackgroundMovementY
end

function Panel:Zoom(change)
	self.ZoomAmount = self.ZoomAmount + change

	for _, v in pairs(self:GetChildren()) do
--		v:SetPos(self:CalculatePosition(v, v.CurrentPos["x"], v.CurrentPos["y"]))
		v:ChangeSize(self.ZoomAmount)
	end
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

/*
function Panel:InitializeSquare(pnl, x, y)
	local xpos = math.floor(x/self.size)
	local ypos = math.floor(y/self.size)

	pnl.CurrentPos = {["x"] = xpos, ["y"] = ypos}

	return xpos*self.size, ypos*self.size
end

function Panel:CalculatePosition(pnl, x, y)
	self.BackgroundMovementX = -self.mousex/self.size
	self.BackgroundMovementY = -self.mousey/self.size

	return (x-self.BackgroundMovementX)*self.size, (y-self.BackgroundMovementY)*self.size
end

function Panel:BackgroundMoved()
	-- for overide
end

function Panel:UpdateSquare(pnl, x, y)
	local xpos = math.floor(x/self.size)
	local ypos = math.floor(y/self.size)

	pnl.CurrentPos = {["x"] = xpos+self.BackgroundMovementX, ["y"] = ypos+self.BackgroundMovementY}

	return xpos*self.size, ypos*self.size
end
*/

vgui.Register("BBlueprint", Panel, "DPanel")