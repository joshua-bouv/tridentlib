--[[tridentlib
  "name": "Toggle Box",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.sliderOffValue = 0
	self.sliderOnValue = 0
	self.sliderLerpValue = 0
	self.sliderTargetLerpValue = 0
	self.sliderActive = false
	self:SetValue(false)
	self.colorLerpValue = alternativeBackground3
	self.targetColorLerpValue = alternativeBackground3
end

function Panel:SizeSet(w, h)
	self.sliderOffValue = h/2
	self.sliderOnValue = w-h/2
	
	self.boxX = h/2.5+h/15
	self.boxY = h/2.5/4
	self.boxW = w-h/1.25-h/7.5
	self.boxH = h/2.5*2

	self.circleX = h/2.5+h/15
	self.circleY = h/2
	self.circleR = h/2.5

	self.circleX_2 = w-h/2.5-h/15
	self.circleY_2 = h/2
	self.circleR_2 = h/2.5

	self.sliderLerpValue = self.sliderOffValue
	self.sliderTargetLerpValue = self.sliderOffValue
	self:SetSize(w, h)
end

function Panel:Paint(w, h)
	self.sliderLerpValue = Lerp(0.9, self.sliderTargetLerpValue, self.sliderLerpValue)
	self.colorLerpValue = LerpColor(0.94, self.targetColorLerpValue, self.colorLerpValue)

	draw.NoTexture()

	draw.RoundedBox(0, self.boxX, self.boxY, self.boxW, self.boxH, self.colorLerpValue)
	surface.SetDrawColor(self.colorLerpValue)
	drawSpecialCircle(self.circleX, self.circleY, self.circleR)
	drawSpecialCircle(self.circleX_2, self.circleY_2, self.circleR_2)

	surface.SetDrawColor(blueText)
	drawSpecialCircle(self.sliderLerpValue, self.circleY, self.circleY)
end

function Panel:SetActive()
	self.sliderTargetLerpValue = self.sliderOnValue
	self.targetColorLerpValue = lightBlue
	self.sliderActive = true
	self:SetValue(true)
end

function Panel:DoClick()
	self:OnChange()

	if self.sliderActive == false then
		self.sliderTargetLerpValue = self.sliderOnValue
		self.targetColorLerpValue = lightBlue
		self.sliderActive = true
	else
		self.sliderTargetLerpValue = self.sliderOffValue
		self.targetColorLerpValue = Color(200, 200, 200, 255)
		self.sliderActive = false
	end

	return true
end

vgui.Register("BToggleBox", Panel, "DCheckBox")