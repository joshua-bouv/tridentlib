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

	function self.VBar:Paint(_, h, theme)
		draw.RoundedBox(0, ws6, 0, 6, h, theme.Base.Fade2)
	end

	function self.pnlCanvas:Paint()	end

	function self.VBar.btnUp:Paint() end

	function self.VBar.btnDown:Paint() end

	function self.VBar.btnGrip:Paint(_, h, theme)
		draw.RoundedBox(0, ws6, 0, 6, h, theme.Base.Fade5)
	end

	self.VBar:tridentlib("THEME::Apply", "BFrame_Default")
	self.VBar.btnGrip:tridentlib("THEME::Apply", "BFrame_Default")
end

function Panel:OnSizeChange()
	ws6 = 0
end

vgui.Register("BScrollBar", Panel, "DScrollPanel")