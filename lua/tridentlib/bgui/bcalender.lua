--[[tridentlib
  "name": "Calender",
  "state": "Client",
  "priority": 3
--tridentlib]]


local Panel = {}

function Panel:Init()
	local months = {
		[1] = {["month"] = "January", ["days"] = 31}, 
		[2] = {["month"] = "Febuary", ["days"] = 29}, 
		[3] = {["month"] = "March", ["days"] = 31}, 
		[4] = {["month"] = "April", ["days"] = 30}, 
		[5] = {["month"] = "May", ["days"] = 31}, 
		[6] = {["month"] = "June", ["days"] = 30}, 
		[7] = {["month"] = "July", ["days"] = 31}, 
		[8] = {["month"] = "August", ["days"] = 31}, 
		[9] = {["month"] = "September", ["days"] = 30}, 
		[10] = {["month"] = "October", ["days"] = 31}, 
		[11] = {["month"] = "November", ["days"] = 30}, 
		[12] = {["month"] = "December", ["days"] = 31}}

	local day, month = tonumber(os.date("%d", os.time())), tonumber(os.date("%m", os.time()))

	self.prevMonth = vgui.Create("BButton", self)
	self.prevMonth:SetPos(5, 5)
	self.prevMonth:SetSize(20, 20)
	self.prevMonth:SetTitle("<")
	self.prevMonth:SetFont("reports_text")
	self.prevMonth:SetTextColor(whiteText)
	self.prevMonth:SetColor(backGround)
	self.prevMonth:SetOutline(true)

	self.nextMonth = vgui.Create("BButton", self)
	self.nextMonth:SetPos(125, 5)
	self.nextMonth:SetSize(20, 20)
	self.nextMonth:SetTitle(">")
	self.nextMonth:SetFont("reports_text")
	self.nextMonth:SetTextColor(whiteText)
	self.nextMonth:SetColor(backGround)
	self.nextMonth:SetOutline(true)

	self.calender = vgui.Create("DGrid", self)
	self.calender:SetPos(5, 30)
	self.calender:SetCols(7)
	self.calender:SetColWide(20)
	self.calender:SetRowHeight(20)
	self.calender.activeDay = false

	for i = 1, months[month]["days"] do
		local but = vgui.Create( "DButton" )
		but:SetSize(20, 20)
		but:SetText("")
		but:SetTextColor(whiteText)
		but:SetFont("reports_text")
		self.calender:AddItem(but)
		but.Col = backGround
		but.TargetCol = but.Col
		but.Active = false
		but.Paint = function(self, w, h)
			draw.RoundedBox(4, 0, 0, w, h, self.Col)
			draw.SimpleText(i, "reports_text", w/2, h/2, whiteText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			self.Col = LerpColor(0.1, self.Col, self.TargetCol) -- make global func not global

			if not self.Active then
				if self:IsHovered() then
					self.TargetCol = innerBackground
				else
					self.TargetCol = backGround
				end
			end
		end
		but.DoClick = function(pnl)
			self.calender.activeDay.Active = false			

			pnl.Active = true
			pnl.TargetCol = blue
			self.calender.activeDay = pnl
		end

		self.calender.activeDay = but
	end
end

function Panel:Paint(w, h)
	draw.RoundedBox(4, 0, 0, w, h, innerBackground)
	draw.RoundedBox(4, 5, 30, w-10, h-35, backGround)
	draw.SimpleText("July", "reports_text", w/2, 15, whiteText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("BCalender", Panel, "DPanel")