--[[tridentlib
  "name": "Num slider",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self:SetDecimals(0)

	self.Label:SetVisible(false)

	self.TextArea:SetTextColor(text)

	self.SliderDesc = vgui.Create("DLabel", self)
	self.SliderDesc:SetTextColor(text)

	function self.Slider:Paint(w, h)
		local x, _ = self.Knob:GetPos()

		draw.RoundedBox(1, 5, h/2-2, w-10, 4, fade5)
		draw.RoundedBox(1, 5, h/2-2, x, 4, lightBlueText)
	end

	function self.Slider.Knob:Paint(w, h) 
		draw.NoTexture()
		surface.SetDrawColor(blueText)
		drawSpecialCircle(w/2, h/2, h/2)
	end
end

function Panel:SetText(text)
	self.SliderDesc:SetText(text)
	self.SliderDesc:SizeToContents()
	self.SliderDesc:Center()
	self.SliderDesc:AlignBottom(0)
end

function Panel:SetFont(txt)
	self.SliderDesc:SetFont(txt)
	self.TextArea:SetFont(txt)
end

vgui.Register("BNumSlider", Panel, "DNumSlider")