--[[tridentlib
  "name": "Title Card",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	self.shrunk = true

	self.items = vgui.Create("DListLayout", self)
	self.items:Dock(FILL)
	self.items:DockMargin(0, 55, 0, 0)

	self.expandShrink = vgui.Create("DImageButton", self)
	self.expandShrink:SetSize(20, 20)
	self.expandShrink:SetPos(700, 15)
	self.expandShrink:SetImage("materials/down_icon_white.png")
	self.expandShrink.DoClick = function()
		if self.shrunk then
			self.expandShrink:SetImage("materials/up_icon_white.png")
			self:SetSize(self.wide, self.tall)
			self.shrunk = false		
		else
			self.expandShrink:SetImage("materials/down_icon_white.png")
			self:SetSize(self.wide, 50)
			self.shrunk = true
		end
	end
end

function Panel:AddItem(panel)
	self.items:Add(panel)
	self.wide, self.tall = self:GetWide(), (#self.items:GetChildren()*50)+60
end

function Panel:AddChild(panel)
	self.items:Add(panel)
	self.wide, self.tall = self:GetWide(), panel:GetTall()+60
	
	panel.ItemAdded = function()
		self:UpdateLayout(panel)
	end
end

function Panel:UpdateLayout(panel)
	self.tall = panel:GetTall()+60
	self:SetSize(self.wide, self.tall)
end

vgui.Register("BTitleCard", Panel, "DPanel")