--[[tridentlib
  "name": "Checkbox",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	
end

function Panel:OnMousePressed()
	self:MouseCapture(true)
	print("hi")
end

function Panel:OnMouseReleased()
	self:MouseCapture(false)
	print("bye")
end

vgui.Register("BConnector", Panel, "DButton")