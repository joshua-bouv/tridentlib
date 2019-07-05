--[[tridentlib
  "name": "Toggle Box",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self:SetToggle(false)

	self.InternalCol = innerBackground
	self.colorLerpValue = self.InternalCol
	self.targetColorLerpValue = self.InternalCol

	print(self.Theme)
end

function Panel:OnSizeChanged(w, h)
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
end

function Panel:Paint(w, h)
	self.sliderLerpValue = Lerp(0.9, self.sliderTargetLerpValue, self.sliderLerpValue) -- make global func not global
	self.colorLerpValue = LerpColor(0.94, self.targetColorLerpValue, self.colorLerpValue) -- make global func not global

	draw.NoTexture()

	draw.RoundedBox(0, self.boxX, self.boxY, self.boxW, self.boxH, self.colorLerpValue)
	surface.SetDrawColor(self.colorLerpValue)
	drawSpecialCircle(self.circleX, self.circleY, self.circleR) -- make global func not global
	drawSpecialCircle(self.circleX_2, self.circleY_2, self.circleR_2) -- make global func not global

	surface.SetDrawColor(blue)
	drawSpecialCircle(self.sliderLerpValue, self.circleY, self.circleY) -- make global func not global
end

function Panel:OnToggled(val)
	-- FOR OVERIDE
end

function Panel:OnChange(val)
	if val then
		self.sliderTargetLerpValue = self.sliderOnValue
		self.targetColorLerpValue = lightBlue
	else
		self.sliderTargetLerpValue = self.sliderOffValue
		self.targetColorLerpValue = self.InternalCol
	end

	self:SetToggle(val)
	self:OnToggled(val)
end

vgui.Register("BToggleBox", Panel, "DCheckBox")