--[[tridentlib
  "name": "Frame",
  "state": "Client",
  "priority": 3
--tridentlib]]

local Panel = {}

function Panel:Init()
	self:SetTitle("")
	self.minimized = false
	self.sideBarSep = 250
	self.targetSideBarSep = 250
	self.hooks = {}
	self.data = {}
	self.theme = "Events"

	self.closeButton = vgui.Create("DButton", self)
	self.closeButton:SetPos(0, 450)
	self.closeButton:SetSize(250, 50)
	self.closeButton:SetText("")
	self.closeButton.Paint = function(_, _, _, theme)
		draw.DrawText("Close", "eventsSideBarFont", 55, 17, theme.Text.Default, TEXT_ALIGN_LEFT)
	end
	self.closeButton:tridentlib("THEME::Apply", self.theme)
	self.closeButton.DoClick = function()
		hook.Run(self.hooks["close"])
	end	

	self.moreTabs = vgui.Create("DButton", self)
	self.moreTabs:SetSize(50, 48)
	self.moreTabs:SetText("")
	self.moreTabs:SetPos(0, 0)
 	self.moreTabs.DoClick = function()
		hook.Run(self.hooks["tabs"], self:IsMinimized())
	end
	self.moreTabs.Paint = function(_, _, _, theme)
 		draw.RoundedBox(0, 15, 17, 20, 3, theme.Colors.White)
 		draw.RoundedBox(0, 15, 22, 20, 3, theme.Colors.White)
 		draw.RoundedBox(0, 15, 27, 20, 3, theme.Colors.White)
	end
	self.moreTabs:tridentlib("THEME::Apply", self.theme)
    self.moreTabs:TDLib()
		:CircleClick(Color(255, 255, 255, 25))

	self.tabContents = vgui.Create("DPanel", self)
	self.tabContents:SetPos(250, 100)
	self.tabContents:SetSize(950, 400)
	self.tabContents.Paint = function() end

	self.sideBar = vgui.Create("BScrollBar", self)
	self.sideBar:SetPos(0, 50)
	self.sideBar:SetSize(250, 400)
end

function Panel:IsMinimized()
	return self.minimized
end

function Panel:SetTheme(str)
	self.theme = str
end

function Panel:GetSidebarSeperator()
	return self.sideBarSep
end

function Panel:GetSidebarSeperatorTarget()
	return self.targetSideBarSep
end

function Panel:SetMinimized(bool)
	self.minimized = bool
end

function Panel:SetSidebarSeperatorTarget(num)
	self.targetSideBarSep = num
end

function Panel:SetSidebarSeperator(num)
	self.sideBarSep = num
end

function Panel:SetHooks(tbl)
	self.hooks = tbl
end

function Panel:ArrangeTopBar(start, width)
	self.topBarPanel.targetPosTopBarHighlight = start
	self.topBarPanel.targetTopBarWidtHighlight = width
end

function Panel:FixTextColours(target, actived)
	for k, v in pairs(target) do
		if k == actived then
			v.textCol = tridentlib("THEME::Get", self.theme)["Text"]["Blue"]
		else
			v.textCol = tridentlib("THEME::Get", self.theme)["Text"]["Default"]
		end
	end
end

function Panel:FixImages(target, actived)
	for k, v in pairs(target) do
		if k == actived then
			v.itemImage:SetImage(v.activeImage)
		else
			v.itemImage:SetImage(v.image)
		end
	end
end

function Panel:SetData(data)
	self.data = data
end

function Panel:SetTabs(tbl)
	local function topBar(parent, topBarTabs)
		self.topBarPanel = vgui.Create("DHorizontalScroller", parent)
		self.topBarPanel:SetPos(self:GetSidebarSeperatorTarget(), 50)
		self.topBarPanel:SetSize(750, 50)
		self.topBarPanel.posTopBarHighlight = 0
		self.topBarPanel.targetPosTopBarHighlight = 0
		self.topBarPanel.topBarWidtHighlight = topBarTabs[1]["boxSize"]
		self.topBarPanel.targetTopBarWidtHighlight = topBarTabs[1]["boxSize"]
		self.topBarPanel.Paint = function(self, _, _, theme)
			self.posTopBarHighlight = Lerp(0.9, self.targetPosTopBarHighlight, self.posTopBarHighlight)
			self.topBarWidtHighlight = Lerp(0.9, self.targetTopBarWidtHighlight, self.topBarWidtHighlight)	
			draw.RoundedBox(0, self.posTopBarHighlight, 48, self.topBarWidtHighlight, 2, theme.Colors.Blue)	
		end
		self.topBarPanel:tridentlib("THEME::Apply", "Reports")

		for key, v in pairs(topBarTabs) do
			local name = v["name"]
			local boxSize = v["boxSize"]

			local item = vgui.Create("DButton")
				item:SetSize(boxSize, 50)
				item:SetText("")
				item:Dock(LEFT)
				self.topBarPanel:AddPanel(item)
				item.textCol = tridentlib("THEME::Get", self.theme)["Text"]["Default"]
				item.DoClick = function()
					self.tabContents:Clear()
					hook.Run("eventsTabChanged", self:IsMinimized())
					v["contents"](self.tabContents, self.data)

					self:ArrangeTopBar(v["pos"], boxSize)
					self:FixTextColours(self.topBarPanel:GetChildren()[1]:GetChildren(), key)
				end
				item.Paint = function(self, w)
					draw.DrawText(name, "eventsTopBarFont", w/2, 20, self.textCol, TEXT_ALIGN_CENTER)
				end
			    item:TDLib()
					:CircleClick(Color(0, 0, 0, 25))
		end

		topBarTabs[1]["contents"](self.tabContents, topBarTabs[1]["format"](topBarTabs[1]["data"], self.data))
		self:FixTextColours(self.topBarPanel:GetChildren()[1]:GetChildren(), 1)
	end

	for key, v in pairs(tbl) do
		local name = v["name"]

		local item = vgui.Create("DButton")
			item:SetSize(250, 50)
			item:SetText("")
			item:Dock(TOP)
			self.sideBar:AddItem(item)
			item.textCol = tridentlib("THEME::Get", self.theme)["Text"]["Default"]
			item.image = v["image"]
			item.activeImage = v["activeImage"]
			item.DoClick = function()
				self.topBarPanel:Remove()
				hook.Run(self.hooks["switch"], self:IsMinimized())
				self.tabContents:Clear()

				self:FixImages(self.sideBar:GetChildren()[1]:GetChildren(), key)
				self:FixTextColours(self.sideBar:GetChildren()[1]:GetChildren(), key)

				if #v["topBar"] == 0 then
					self:ArrangeTopBar(0, 0)
				else
					topBar(self, v["topBar"])
					self:ArrangeTopBar(0, v["topBar"][1]["boxSize"])
				end
			end
			item.Paint = function(self)
				draw.DrawText(name, "eventsSideBarFont", 55, 17, self.textCol, TEXT_ALIGN_LEFT)
			end
		    item:TDLib()
				:CircleClick(Color(0, 0, 0, 25))

		local itemImage = vgui.Create("DImage", item)
			itemImage:SetPos(10, 10)
			itemImage:SetSize(30, 30)
		  	itemImage:SetImage(v["image"])

		item.itemImage = itemImage
	end

	topBar(self, tbl[1]["topBar"])
	self:FixImages(self.sideBar:GetChildren()[1]:GetChildren(), 1)
	self:FixTextColours(self.sideBar:GetChildren()[1]:GetChildren(), 1)
end

vgui.Register("BFrame", Panel, "DFrame")