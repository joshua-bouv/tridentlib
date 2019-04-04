--[[tridentlib
  "name": "Connector",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Pressed = false
	self.Connected = false
	self.ConnectionID = false
	self.Connections = {}
end

function Panel:OnMousePressed()
	self:MouseCapture(true)
	self:MousePressed()
	self.Pressed = true
end

function Panel:OnMouseReleased()
	self:MouseCapture(false)
	self.Pressed = false
	self:MouseReleased()
end

function Panel:GetPosition()
	local testx1, testy1 = self:GetParent():GetParent():GetParent():GetPos()
	local testx2, testy2 = self:GetParent():GetParent():GetPos()
	local testx3, testy3 = self:GetParent():GetPos()
	local testx4, testy4 = self:GetPos()
	local testw, testh = self:GetSize()

	local w, h = testx1+testx2+testx3+testx4+testw, testy1+testy2+testy3+testy4+(testh/2)

	return w, h
end

function Panel:GenerateLine()
	local testx1, testy1 = self:GetParent():GetParent():GetParent():GetPos()
	local testx2, testy2 = self:GetParent():GetParent():GetPos()
	local testx3, testy3 = self:GetParent():GetPos()
	local testx4, testy4 = self:GetPos()
	local testw, testh = self:GetSize()

	self.lineW, self.lineH = self:GetPosition()
	self.lineX, self.lineY = self:GetParent():GetParent():GetParent():GetParent():ScreenToLocal(gui.MouseX(), gui.MouseY())

	self:CheckConnected()

	return {["startX"] = self.lineW, ["startY"] = self.lineH, ["endX"] = self.lineX, ["endY"] = self.lineY}
end

function Panel:IsEndpoint()
	return false
end

function Panel:CheckConnected()
	for _, item in pairs(self.endpoints) do
		for _, v in pairs(item) do
			if v:IsEndpoint() then
				local testx1, testy1 = v:GetParent():GetParent():GetParent():GetPos()
				local testx2, testy2 = v:GetParent():GetParent():GetPos()
				local testx3, testy3 = v:GetParent():GetPos()
				local testx4, testy4 = v:GetPos()
				local testw, testh = v:GetSize()

				local x, y = testx1+testx2+testx3+testx4, testy1+testy2+testy3+testy4

				if self.lineX > x-2 and self.lineX < x and self.lineY > y+testw and self.lineY < y+testh then
					self:StoreConnection(self.ConnectionID, v)
					self:OnMouseReleased()
					self:Connection(v, self.ConnectionID)
				end
			end
		end
	end
end

function Panel:UpdateLine(currentLine)
	local x, y = self:GetParent():GetParent():GetPos()
	local x2, _, w2, _ = self:GetParent():GetBounds()
	local _, _, _, h2 = self:GetBounds()

	self.lineW = x+(x2+w2)
	self.lineH = y+(30+(h2/2))

	return {["startX"] = self.lineW, ["startY"] = self.lineH, ["endX"] = currentLine["endX"], ["endY"] = currentLine["endY"]}
end

function Panel:MousePressed()
	-- for overide
end

function Panel:MouseReleased(self)
	-- for overide
end

function Panel:StoreConnection(id, endpoint)
	self.Connected = true
	self.Connections[id] = endpoint
end

function Panel:Unconnect(id)
	self.Connections[id] = nil

	if #self.Connections == 0 then self.Connected = false end
end

function Panel:GetConnectionID()
	return self.ConnectionID
end

function Panel:GetConnection(id)
	return self.Connections[id]
end

function Panel:SetConnectionID(id)
	self.ConnectionID = id
end

function Panel:IsConnected()
	return self.Connected
end

function Panel:IsDragging()
	return self.Pressed
end

function Panel:Connection(v)
	-- for overwride
end

function Panel:DoClick()
	self.Connected = false
end

vgui.Register("BConnector", Panel, "DButton")