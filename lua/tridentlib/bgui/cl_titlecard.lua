--[[tridentlib
  "name": "GUI::Title Card"
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.title = ""
	self.shrunk = false

	self.items = vgui.Create("DListLayout", self)
	self.items:Dock(FILL)
	self.items:DockMargin(0, 55, 0, 0)

	self.expandShrink = vgui.Create("DImageButton", self)
	self.expandShrink:SetSize(20, 20)
	self.expandShrink:SetPos(700, 15)
	self.expandShrink:SetImage("materials/eventaddon/up_icon.png")
	self.expandShrink.DoClick = function()
		if self.shrunk then
			self.expandShrink:SetImage("materials/eventaddon/up_icon.png")
			self:SetSize(self:GetWide(), (#self.items:GetChildren()*50)+60)
			self.shrunk = false		
		else
			self.expandShrink:SetImage("materials/eventaddon/down_icon.png")
			self:SetSize(self:GetWide(), 50)
			self.shrunk = true
		end
	end
end

function Panel:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, fade3)

	draw.RoundedBox(0, 0, 0, w, 1, fade4) -- top
	draw.RoundedBox(0, 0, 1, 1, h-2, fade4) -- left
	draw.RoundedBox(0, w-1, 1, 1, h-2, fade4) -- right
	draw.RoundedBox(0, 0, h-1, w, 1, fade2) -- bottom

	draw.RoundedBox(0, 5, 50, w-10, 1, fade)
	draw.SimpleText(self.title, "eventsSideBarFont", 5, 25, titleText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function Panel:SetText(text)
	self.title = text
end

function Panel:AddItem(panel)
	self.items:Add(panel)
	self:SetSize(self:GetWide(), (#self.items:GetChildren()*50)+60)
end

vgui.Register("BTitleCard", Panel, "DPanel")