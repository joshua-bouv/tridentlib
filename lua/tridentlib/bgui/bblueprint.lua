--[[tridentlib
  "name": "Blueprint",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.size = 30
	self.backgroundMovementX = 0
	self.backgroundMovementY = 0
end

function Panel:InitializeSquare(pnl, x, y)
	xpos = math.floor(x/self.size)
	ypos = math.floor(y/self.size)

	pnl.CurrentPos = {["x"] = xpos, ["y"] = ypos}

	return xpos*self.size, ypos*self.size
end

function Panel:UpdateSquare(pnl, x, y)
	xpos = math.floor(x/self.size)
	ypos = math.floor(y/self.size)

	pnl.CurrentPos = {["x"] = xpos+self.backgroundMovementX, ["y"] = ypos+self.backgroundMovementY}

	return xpos*self.size, ypos*self.size
end

function Panel:CalculatePosition(pnl, x, y)
	self.backgroundMovementX = -math.floor(self.mousex/self.size)
	self.backgroundMovementY = -math.floor(self.mousey/self.size)

	return (x-self.backgroundMovementX)*self.size, (y-self.backgroundMovementY)*self.size
end

function Panel:Zoom(panels, change)
	self.size = change

	for _, v in pairs(panels) do
		v:SetPos(self:CalculatePosition(v, v.CurrentPos["x"], v.CurrentPos["y"]))
		v:ChangeSize(self.size)
	end
end

function Panel:MoveSquare(pnl)
	pnl:SetPos(self:UpdateSquare(pnl, gui.MouseX()-800, gui.MouseY()-400))
end

vgui.Register("BBlueprint", Panel, "DPanel")