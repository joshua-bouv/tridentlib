--[[tridentlib
  "name": "Scrollbar",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

local ws6 = 0

function Panel:Init()
	self.VBar:SetHideButtons(true)
	self.VBar:SetWidth(8)

	function self.VBar:Paint(_, h)
		draw.RoundedBox(0, ws6, 0, 6, h, fade2)
	end

	function self.pnlCanvas:Paint()	end

	function self.VBar.btnUp:Paint() end

	function self.VBar.btnDown:Paint() end

	function self.VBar.btnGrip:Paint(_, h)
		draw.RoundedBox(0, ws6, 0, 6, h, fade5)
	end
end

function Panel:OnSizeChange()
	ws6 = 0
end

vgui.Register("BScrollBar", Panel, "DScrollPanel")