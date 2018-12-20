--[[tridentlib
  "name": "Checkbox",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Pressed = false
end

function Panel:OnMousePressed()
	self:MouseCapture(true)
	self.Pressed = true
end

function Panel:OnMouseReleased()
	self:MouseCapture(false)
	self.Pressed = false
end

function Panel:Think()
	if self.Pressed then
		-- activate connector endpoints
		-- update line to mouse pos
	end
end

function Panel:IsDragging()
	return self.Pressed
end

function Panel:GenerateLine()
	print(self:GetParent():GetParent():GetParent():GetPos()[1])
	print(gui.MouseX()-self:GetParent():GetParent():GetParent():GetPos()[1])
	return {["startX"] = 50, ["startY"] = 50, ["endX"] = 500, ["endY"] = 500}
end

vgui.Register("BConnector", Panel, "DButton")