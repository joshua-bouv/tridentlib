--[[tridentlib
  "name": "Endpoint",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Connected = false
	self.ConnectionID = false
	self.ConnectedTo = false
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

function Panel:GetConnectionID(id)
	return self.ConnectionID
end

function Panel:GetPosition()
	local testx1, testy1 = self:GetParent():GetParent():GetParent():GetPos()
	local testx2, testy2 = self:GetParent():GetParent():GetPos()
	local testx3, testy3 = self:GetParent():GetPos()
	local testx4, testy4 = self:GetPos()
	local testw, testh = self:GetSize()

	local x, y = testx1+testx2+testx3+testx4, testy1+testy2+testy3+testy4+(testh/2)

	return x, y
end

function Panel:Unconnect(id)
	self.Connected = false
	self.ConnectionID = false
	self.ConnectedTo = false
end

function Panel:SetConnectionID(id)
	self.Connected = true
	self.ConnectionID = id
end

function Panel:SetConnection(pnl)
	self.ConnectedTo = pnl
end

function Panel:GetConnection(id)
	return self.ConnectedTo
end

function Panel:IsEndpoint()
	return true
end

vgui.Register("BEndpoint", Panel, "DButton")