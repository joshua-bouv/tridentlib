--[[tridentlib
  "name": "Calender",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

local months = {
	[1] = {["month"] = "January", ["days"] = 31}, 
	[2] = {["month"] = "Febuary", ["days"] = 28}, 
	[3] = {["month"] = "March", ["days"] = 31}, 
	[4] = {["month"] = "April", ["days"] = 30}, 
	[5] = {["month"] = "May", ["days"] = 31}, 
	[6] = {["month"] = "June", ["days"] = 30}, 
	[7] = {["month"] = "July", ["days"] = 31}, 
	[8] = {["month"] = "August", ["days"] = 31}, 
	[9] = {["month"] = "September", ["days"] = 30}, 
	[10] = {["month"] = "October", ["days"] = 31}, 
	[11] = {["month"] = "November", ["days"] = 30}, 
	[12] = {["month"] = "December", ["days"] = 31}
}

local day, month, year = tonumber(os.date("%d", os.time())), tonumber(os.date("%m", os.time())), tonumber(os.date("%Y", os.time()))
local curDay, curMonth, curYear = tonumber(os.date("%d", os.time())), tonumber(os.date("%m", os.time())), tonumber(os.date("%Y", os.time()))

local function todate(day, month, year)
	return tostring(day).."/"..tostring(month).."/"..tostring(year)
end

local function generateDays(self, days)
	self.calender:Clear()
	self.calender.Items = {}

	for i = 1, days do
		local but = vgui.Create("DButton", self.calender)
			but:SetSize(20, 20)
			but:SetText("")
			but:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
			but:SetFont("reports_text")
			self.calender:AddItem(but)
			but.Active = false
			if i == curDay and month == curMonth and year == curYear then but.Active = true but.Col = tridentlib("THEME::Get", "BFrame_Default")["Colors"]["Blue"] but.TargetCol = tridentlib("THEME::Get", "BFrame_Default")["Colors"]["Blue"] else but.Col = tridentlib("THEME::Get", "BFrame_Default")["Base"]["Background"] but.TargetCol = but.Col end
			but.Paint = function(self, w, h, theme)
				draw.RoundedBox(4, 0, 0, w, h, self.Col)
				draw.SimpleText(i, "reports_text", w/2, h/2, theme.Text.Default, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				self.Col = tridentlib("LerpColor", 0.1, self.Col, self.TargetCol)

				if not self.Active then
					if self:IsHovered() then
						self.TargetCol = theme.Base.InnerBackground
					else
						self.TargetCol = theme.Base.Background
					end
				end
			end
			but.DoClick = function(pnl)
				day = i
				self:SetValue(todate(day, month, year))
				self.Menu:Remove()
				self:OnDateChanged()
			end
			but:tridentlib("THEME::Apply", "BFrame_Default")
	end
end

local function getMonthDays()
	days = tonumber(os.date('*t',os.time{["year"] = year, ["month"] = month+1, ["day"] = 0})['day'])

	return days
end

function Panel:Init()
	self.InternalCol = tridentlib("THEME::Get", "BFrame_Default")["Base"]["Background"]
	self.Col = self.InternalCol
	self.TargetCol = self.InternalCol
	self.SelectedDay, self.SelectedMonth, self.SelectedYear = day, month, year
	self:SetValue("Select date")
	self:tridentlib("THEME::Apply", "BFrame_Default")

	self:SetTextInset(3, -1)
end

function Panel:GetDate()
	return ""..day.."/"..month.."/"..year..""
end

function Panel:OnSizeChanged(w, h)
	self.hs8 = h-8
	self.hs2 = h-2
end

function Panel:OnDateChanged()
	-- for overide
end

function Panel:DoClick()
	if IsValid(self.Menu) then return self.Menu:Remove() end

	self.Menu = vgui.Create("DPanel", self)
	local x, y = self:LocalToScreen( 0, self:GetTall() )
	self.Menu:SetSize( 150, 135 )
	self.Menu:SetPos(x, y)
	self.Menu:MakePopup()
	self.Menu:SetVisible( true )
	self.Menu:SetKeyboardInputEnabled( false )
	self.Menu.Paint = function(_, w, h, theme)
		draw.RoundedBox(4, 0, 0, w, h, theme.Base.InnerBackground)
		draw.RoundedBox(4, 5, 30, w-10, h-35, theme.Base.Background)
		draw.SimpleText(months[month]["month"], "reports_text", w/2, 5, theme.Text.Default, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText(year, "reports_text_extra_small", w/2, 27.5, theme.Text.Default, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	end
	self.Menu:tridentlib("THEME::Apply", "BFrame_Default")

	self.calender = vgui.Create("DGrid", self.Menu)
	self.calender:SetPos(5, 30)
	self.calender:SetCols(7)
	self.calender:SetColWide(20)
	self.calender:SetRowHeight(20)

	self.prevMonth = vgui.Create("BButton", self.Menu)
	self.prevMonth:SetPos(5, 5)
	self.prevMonth:SetSize(20, 20)
	self.prevMonth:SetTitle("<")
	self.prevMonth:SetFont("reports_text")
	self.prevMonth:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
	self.prevMonth:SetColor(tridentlib("THEME::Get", "BFrame_Default")["Base"]["Background"])
	self.prevMonth:SetOutline(true)
	self.prevMonth.DoClick = function()
		if month == 1 then 
			month = 12
			year = year - 1
		else	
			month = month - 1
		end

		generateDays(self, getMonthDays())
	end

	self.nextMonth = vgui.Create("BButton", self.Menu)
	self.nextMonth:SetPos(125, 5)
	self.nextMonth:SetSize(20, 20)
	self.nextMonth:SetTitle(">")
	self.nextMonth:SetFont("reports_text")
	self.nextMonth:SetTextColor(tridentlib("THEME::Get", "BFrame_Default")["Text"]["Default"])
	self.nextMonth:SetColor(tridentlib("THEME::Get", "BFrame_Default")["Base"]["Background"])
	self.nextMonth:SetOutline(true)
	self.nextMonth.DoClick = function()
		if month == 12 then 
			month = 1 
			year = year + 1
		else	
			month = month + 1 
		end

		generateDays(self, getMonthDays())
	end

	generateDays(self, getMonthDays())
end

function Panel:Paint(w, h, theme)
	draw.RoundedBox(4, 0, self.hs8, w, 8, theme.Base.Fade3)
	draw.RoundedBox(4, 0, 0, w, self.hs2, self.Col)	
	self.Col = tridentlib("LerpColor", 0.1, self.Col, self.TargetCol)

	if self:IsHovered() or self:IsMenuOpen() then
		self.TargetCol = tridentlib("THEME::Get", "BFrame_Default")["Base"]["InnerBackground"]
	else
		self.TargetCol = self.InternalCol
	end
end

vgui.Register("BCalender", Panel, "DComboBox")