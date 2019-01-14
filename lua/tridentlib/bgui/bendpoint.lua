--[[tridentlib
  "name": "Endpoint",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Connected = false
	self.ConnectionID = false
end

function Panel:UpdateLine(currentLine)
	x, y = self:GetParent():GetParent():GetPos()

	self.lineX = x
	self.lineY = y+42.5

	return {["startX"] = currentLine["startX"], ["startY"] = currentLine["startY"], ["endX"] = self.lineX, ["endY"] = self.lineY}
end

function Panel:IsConnected()
	return self.Connected
end

function Panel:GetConnectionID()
	return self.ConnectionID
end

function Panel:Unconnect()
	self.Connected = false
	self.ConnectionID = false
end

function Panel:SetConnectionID(id)
	self.Connected = true
	self.ConnectionID = id
end

function Panel:IsEndpoint()
	return true
end

vgui.Register("BEndpoint", Panel, "DButton")