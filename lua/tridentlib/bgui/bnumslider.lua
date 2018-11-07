--[[tridentlib
  "name": "Num slider",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.Label:SetWide(0)
	self.Label:Dock(NODOCK)
	self.Label:SetVisible(false)

	self:PerformLayout()
	self.Slider:PerformLayout()

	self.Slider.TranslateValues = function( slider, x, y ) return self:TranslateSliderValues( x, y ) end

	self.Slider:SetSize(1, 1)

	self.TextArea:SetTextColor(titleText)
	self.TextArea:SetFont("eventsTextLargeFont")

	self.SliderDesc = vgui.Create("DLabel", self)
	self.SliderDesc:SetPos(0, 0)
	self.SliderDesc:SetTextColor(titleText)
	self.SliderDesc:SetFont("eventsTopBarFontSkinny")
	self.SliderDesc:SetMouseInputEnabled(true)

	function self.Slider:Paint(w, h)
		local x, _ = self.Knob:GetPos()
		draw.RoundedBox(1, 5, h/2-2, w-10, 4, fade)
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

vgui.Register("BNumSlider", Panel, "DNumSlider")