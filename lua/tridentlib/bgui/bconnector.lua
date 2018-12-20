--[[tridentlib
  "name": "Checkbox",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	
end

function Panel:OnMousePressed()
	print("hi")

function Panel:OnMouseReleased()
	print("bye")
end

vgui.Register("BConnector", Panel, "DButton")