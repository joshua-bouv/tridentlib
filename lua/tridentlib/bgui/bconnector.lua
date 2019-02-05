--[[tridentlib
  "name": "Connector",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.Pressed = false
	self.Connected = false
	self.ConnectedTo = false
	self.ConnectionID = false
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

function Panel:GenerateLine()
	local testx1, testy1 = self:GetParent():GetParent():GetParent():GetPos()
	local testx2, testy2 = self:GetParent():GetParent():GetPos()
	local testx3, testy3 = self:GetParent():GetPos()
	local testx4, testy4 = self:GetPos()
	local testw, testh = self:GetSize()

	self.lineW = testx1+testx2+testx3+testx4+testw
	self.lineH = testy1+testy2+testy3+testy4+(testh/2)

	print(self.lineW)
	print(self.lineH)

	self.lineX, self.lineY = self:GetParent():GetParent():GetParent():GetParent():ScreenToLocal(gui.MouseX(), gui.MouseY())

	self:CheckConnected()

	return {["startX"] = self.lineW, ["startY"] = self.lineH, ["endX"] = self.lineX, ["endY"] = self.lineY}
end

function Panel:IsEndpoint()
	return false
end

function Panel:CheckConnected()
	for _, item in pairs(self.endpoints) do
		for _, v in pairs(item) do -- needs optimization
			if v:IsEndpoint() then -- needs optimization
				x, y = v:GetParent():GetParent():GetPos()

				if self.lineX > x-2 and self.lineX < x and self.lineY > y+30 and self.lineY < y+55 then
					self.Connected = true
					self.ConnectedTo = v
					self:OnMouseReleased()
					self:Connection(self, v)
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
	-- for overwide
end

function Panel:GetEndpoint()
	return self.ConnectedTo
end

function Panel:GetConnectionID()
	return self.ConnectionID
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

function Panel:Connection(self, connectedTo)
	-- for overwride
end

function Panel:DoClick()
	self.Connected = false
end

vgui.Register("BConnector", Panel, "DButton")