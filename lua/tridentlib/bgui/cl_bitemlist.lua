--[[tridentlib
  "name": "GUI::Item List"
--tridentlib]]

local Panel = {}

function Panel:Init()
	self.itemList = {}
	self.primaryButtonText = ""
	self.alternateButtonText = ""

	self.textEntry = self:Add("BTextEntry")
	self.textEntry:Dock(FILL)
	self.textEntry:SetTitle("")
	self.textEntry:SetFont("eventsTextLargeFont")
	self.textEntry:SetTextColor(titleText)
	self.textEntry.OnEnter = function(textEntry)
		table.insert(self.itemList, self.textEntry:GetValue())

		self.textEntry:SetValue("")
	end

	self.button = self:Add("DButton", self)
	self.button:SetSize(100, 50)
	self.button:Dock(RIGHT)
	self.button:DockMargin(10, 8, 10, 8)
	self.button:SetText("")
	self.button:SetTextColor(whiteText)
	self.button:SetFont("eventsTextFont")
	self.button.Paint = function(_, w, h)
		draw.RoundedBox(4, 0, 0, w, h, fade2)
		draw.RoundedBox(4, 0, 0, w, h-2, blueText)
	end
	self.button.DoClick = function()
		if (IsValid(self.Menu)) then
			self.button:SetText(self.primaryButtonText)
			self:SetSize(self:GetWide(), 50)

			return self.Menu:Remove()
		end

		self.button:SetText(self.alternateButtonText)
		self:DisplayItems()
	end

	self.addItem = self.textEntry:Add("DButton")
	self.addItem:Dock(RIGHT)
	self.addItem:DockMargin(0, 0, 5, 0)
	self.addItem:SetSize(30, 30)
	self.addItem:SetText("+")
	self.addItem:SetFont("eventsTitleFont")
	self.addItem:SetTextColor(whiteText)
	self.addItem:TDLib()
		:ClearPaint()
		:Circle(blueText)
	self.addItem.DoClick = function()
		table.insert(self.itemList, {["mainData"] = self.textEntry:GetValue(), ["otherData"] = false})

		self.textEntry:SetValue("")
	end
end

function Panel:DisplayItems()
	if (IsValid(self.Menu)) then
		self:SetSize(self:GetWide(), 50)

		self.Menu:Remove()
		self.Menu = nil
	end

	self.textEntry:Dock(NODOCK)
	self.button:Dock(NODOCK)

	self:SetSize(self:GetWide(), #self.itemList*50+50)

	self.Menu = self:Add("DListLayout")
	self.Menu:Dock(FILL)
	self.Menu:DockMargin(0, 50, 0, 0)

	for _, v in pairs(self.itemList) do
		self.Menu:Add(self.ItemDesigner(v))
	end
end

function Panel:ItemDesigner(data) -- for overide
	-- item
end

function Panel:AddItems(data)
	for _, v in pairs(data) do
		table.insert(self.itemList, v)
	end
end

function Panel:Paint() end

function Panel:SetTitle(name, buttonMain, buttonAlt)
	self.textEntry:SetTitle(name)
	self.primaryButtonText = buttonMain
	self.alternateButtonText = buttonAlt
	self.button:SetText(self.primaryButtonText)
end

vgui.Register("BItemList", Panel, "DPanel")