--[[tridentlib
  "name": "Itemlist",
  "state": "Client",
  "priority": 3
--tridentlib]]

/*
DO TRIDENTLIB COLORS
*/

local Panel = {}

function Panel:Init()
	self.itemList = {}

	self.textEntry = self:Add("BTextEntry")
	self.textEntry:SetTitle("")
	self.textEntry:SetFont("eventsTextLargeFont")
	self.textEntry:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
--	self.textEntry:ShowBottomHighlight(false)
	self.textEntry.OnEnter = function(textEntry)
		self:AddItems({[1] = {["mainData"] = self.textEntry:GetValue(), ["otherData"] = false}})

		self:ItemAdded()

		self.textEntry:SetValue("")
	end

	self.addItem = self.textEntry:Add("DButton")
	self.addItem:Dock(RIGHT)
	self.addItem:DockMargin(0, 0, 10, 0)
	self.addItem:SetSize(30, 30)
	self.addItem:SetText("+")
	self.addItem:SetFont("eventsTitleFont")
	self.addItem:SetTextColor(whiteText)
	self.addItem:TDLib()
		:ClearPaint()
		:Circle(blueText)
	self.addItem.DoClick = function()
		self:AddItems({[1] = {["mainData"] = self.textEntry:GetValue(), ["otherData"] = false}})

		self:ItemAdded()

		self.textEntry:SetValue("")
	end

	self.Menu = self:Add("DListLayout")
	self.Menu:SetPos(0, 50)
	self.Menu:Dock(FILL)
	self.Menu:DockMargin(0, 50, 0, 0)
end

function Panel:ItemDesigner(data)
	-- for overide
end

function Panel:ItemAdded()
	-- for overide
end

function Panel:AddItems(data)
	for _, v in pairs(data) do
		table.insert(self.itemList, v)
		self.Menu:Add(self.ItemDesigner(v))
	end

	self:SetSize(self:GetWide(), #self.itemList*50+50)
end

function Panel:GetItems()
	return self.itemList
end

function Panel:OnSizeChanged(w, h)
	self:SetSize(w, h)
	self.textEntry:SetSize(w, h)
end

function Panel:SetTitle(name)
	self.textEntry:SetTitle(name)
end

vgui.Register("BItemList", Panel, "DPanel")