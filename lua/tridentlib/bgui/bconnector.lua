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
	self.EndpointID = false
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

function Panel:CheckConnected()
	for k, v in pairs(self.endpoints) do
		x, y = k:GetParent():GetParent():GetPos()

		if self.lineX > x-2 and self.lineX < x and self.lineY > y+30 and self.lineY < y+55 then
			self.Connected = true
			self.ConnectedTo = k
			k:SetEndpointID(self:GetConnectionID)
			self:OnMouseReleased()
			self:Connection(self, k)
		end
	end
end

function Panel:GenerateLine()
	local x, y = self:GetParent():GetParent():GetPos()
	local x2, _, w2, _ = self:GetParent():GetBounds()
	local _, _, _, h2 = self:GetBounds()

	self.lineW = x+(x2+w2)
	self.lineH = y+(30+(h2/2))
	self.lineX = gui.MouseX()-600
	self.lineY = gui.MouseY()-300

	self:CheckConnected()

	return {["startX"] = self.lineW, ["startY"] = self.lineH, ["endX"] = self.lineX, ["endY"] = self.lineY}
end

function Panel:UpdateLineStart()
	if not self.Connected then return end

	local x, y = self:GetParent():GetParent():GetPos()
	local x2, _, w2, _ = self:GetParent():GetBounds()
	local _, _, _, h2 = self:GetBounds()

	self.lineW = x+(x2+w2)
	self.lineH = y+(30+(h2/2))

	return {["startX"] = self.lineW, ["startY"] = self.lineH, ["endX"] = self.lineX, ["endY"] = self.lineY}
end

function Panel:UpdateLineEnd()
	if not self.Connected then return end

	x, y = self.ConnectedTo:GetParent():GetParent():GetPos()

	self.lineX = gui.MouseX()-600
	self.lineY = gui.MouseY()-300

	return {["startX"] = self.lineW, ["startY"] = self.lineH, ["endX"] = self.lineX, ["endY"] = self.lineY}
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

function Panel:SetEndpointID(id)

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