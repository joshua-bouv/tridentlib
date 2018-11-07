--[[tridentlib
  "name": "Star rater",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.defaultVal = 3
	self.hoveredVal = 3
	self.starIcon = Material("materials/eventaddon/star_icon.png")
	self:SetCols(5)
	self:SetColWide(20)
	self:SetRowHeight(20)

	for i = 1, 5 do
		local star = vgui.Create("DButton")
			star:SetSize(20, 20)
			star:SetText("")
			star.col = Color(200, 200, 200, 50)
			star.targetCol = Color(200, 200, 200, 50)
			star.Paint = function(s, w, h)
				if self.hoveredVal >= i then
					s.targetCol = Color(200, 200, 200, 255)
				else
					s.targetCol = Color(200, 200, 200, 50)
				end
				
				s.col = LerpTransparency(0.9, s.targetCol, s.col)

				surface.SetMaterial(self.starIcon)
				surface.SetDrawColor(s.col)
				surface.DrawTexturedRect(0, 0, w, h)
			end
			star.OnCursorEntered = function()
				self.hoveredVal = i
			end
			star.OnCursorExited = function()
				self.hoveredVal = self.defaultVal
			end
			star.DoClick = function()
				self.defaultVal = i
				self.hoveredVal = i				
			end

		self:AddItem(star)
	end
end

function Panel:SetRating(val)
	self.defaultVal = val
	self.hoveredVal = val
end

vgui.Register("BStarRater", Panel, "DGrid")