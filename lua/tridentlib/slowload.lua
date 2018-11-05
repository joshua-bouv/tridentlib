--[[tridentlib
  "name": "SlowLoad Module",
  "state": "Client"
--tridentlib]]

local function SlowLoad(self, data, func, skip)
	timer.Simple(0.01,function()
		local oldScroll = self.VBar.SetScroll
		local count = skip or 1

		local function preload()
			for k, v in pairs(data) do
				if v >= count then
					if !self.VBar.Enabled then
						func(self, v)
						count = count + 1
					else count = k return end
					if k == #data then count = k return end
					timer.Simple(0.01,function() coroutine.resume(slowload) end)
					coroutine.yield()
				end
			end
		end
		slowload = coroutine.create( preload )
		coroutine.resume(slowload)

		self.VBar.SetScroll = function(xself, scrll)
			if self.VBar.CanvasSize == self.VBar:GetScroll() then
				if data[count] then
					func(self, data[count])
					count = count + 1
				end
			end
			oldScroll(xself, scrll)
		end
	end)
end
tridentlib("DefineFunction", "SlowLoad", SlowLoad, {"Panel"})


concommand.Add("test",function()
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 500, 500 )
	frame:Center()
	frame:MakePopup()

	local DScrollPanel = vgui.Create( "BScrollBar", frame )
	DScrollPanel:Dock( FILL )

	for i=0, 25 do
		local DButton = DScrollPanel:Add( "DButton" )
		DButton:SetText( "Button #" .. i )
		DButton:Dock( TOP )
		DButton:DockMargin( 0, 0, 0, 5 )
	end

	local function loadmore(name)
		local DButton = DScrollPanel:Add( "DButton" )
		DButton:SetText( name )
		DButton:Dock( TOP )
		DButton:DockMargin( 0, 0, 0, 5 )
	end

	DScrollPanel:tridentlib("SlowLoad", tridentlib("randTable", 40), loadmore)

end)
