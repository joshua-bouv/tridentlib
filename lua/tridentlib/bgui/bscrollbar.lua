--[[tridentlib
  "name": "Scrollbar",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	function self.pnlCanvas:Paint()	end

    local vbar = self.VBar

	vbar:SetHideButtons(true)

    vbar:SetWidth(8)

    function vbar:Paint(w, h)
        draw.RoundedBox(0, w-6, 0, 6, h, fade3)
    end

    function vbar.btnUp:Paint() end

    function vbar.btnDown:Paint() end

    function vbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, w-6, 0, 6, h, fade)
    end
end

vgui.Register("BScrollBar", Panel, "DScrollPanel")