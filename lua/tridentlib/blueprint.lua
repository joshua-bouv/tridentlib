--[[tridentlib
  "name": "Blueprint Lib",
  "state": "Client"
--tridentlib]]


local gradient = Material( 'vgui/gradient-l' )
local texOutlinedCorner = surface.GetTextureID( "vgui/td/rounded-corner" )
local tex_corner8	= surface.GetTextureID( "gui/corner8" )
local tex_corner16	= surface.GetTextureID( "gui/corner16" )
local tex_corner32	= surface.GetTextureID( "gui/corner32" )
local tex_corner64	= surface.GetTextureID( "gui/corner64" )

local function SetDraggableHeight(self, height)

	if !self.GetDraggable then
		self.IsDraggableBool = false
		function self:GetDraggable()
			return self.IsDraggableBool
		end
		function self:SetDraggable(bool)
			self.IsDraggableBool = bool
		end
		function self:OnMouseReleased()
			self.Dragging = nil
			self:MouseCapture( false )
		end
	end

	self.OnMousePressed = function()
		self:MoveToFront()
		if ( self:GetDraggable() && gui.MouseY()-self:tridentlib("getBasePanel").y < (self.y+self:GetParent().y + height) ) then
			self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
			self:MouseCapture( true )
			return
		end
	end
	self.Think = function()
		local mousex = math.Clamp( gui.MouseX(), 1, ScrW() - 1 )
		local mousey = math.Clamp( gui.MouseY(), 1, ScrH() - 1 )

		if ( self.Dragging ) then

			local x = mousex - self.Dragging[1]
			local y = mousey - self.Dragging[2]

			x = math.Clamp( x, 0, self:GetParent():GetWide()-self:GetWide() )
			y = math.Clamp( y, 0, self:GetParent():GetTall()-self:GetTall() )

			self:SetPos( x, y )

		end

		if ( mousey-self:tridentlib("getBasePanel").y-height < ( self.y + height+15 ) ) then
			self:SetCursor( "sizeall" )
			return
		end

		self:SetCursor( "arrow" )
	end

end
tridentlib("DefineFunction", "BP::SetDraggableHeight", SetDraggableHeight, {"Panel"})

local function ScrollPlane(self)
	self.Dragging = false
	self.DragPos = {}
	self.mousexOld = 0
	self.mouseyOld = 0
	self.mousex = 0
	self.mousey = 0

	function self:OnMouseReleased()
		self.Dragging = false
		self:MouseCapture(false)
	end

	self.OnMousePressed = function()
		self.Dragging = {gui.MouseX(), gui.MouseY()}
		self.DragPos = {}

		for _, v in pairs(self:GetChildren()) do
			local w, h = v:GetPos()
			self.DragPos[v] = {w, h}
		end

		self:MouseCapture(true)

		return
	end
	self.Think = function()
		local mousex = math.Clamp(gui.MouseX(), 1, ScrW() - 1)
		local mousey = math.Clamp(gui.MouseY(), 1, ScrH() - 1)

		if (self.Dragging) then
			local xTemp = mousex - self.Dragging[1]
			local x = math.floor(xTemp/self.size)*self.size
			local yTemp = mousey - self.Dragging[2]
			local y = math.floor(yTemp/self.size)*self.size

			function self:MoveHorizontal()
				for k, v in pairs(self.DragPos) do
					local _, yPan = k:GetPos()
					k:SetPos(x+v[1], yPan)
				end

				self.mousex = x + self.mousexOld
				self.backgroundMovementX = -math.floor(self.mousex/self.size)
			end

			function self:MoveVertial()
				for k, v in pairs(self.DragPos) do
					local xPan, _ = k:GetPos()
					k:SetPos(xPan, y+v[2])
				end

				self.mousey = y + self.mouseyOld
				self.backgroundMovementY = -math.floor(self.mousey/self.size)
			end

			if x + self.mousexOld <= 0 then
				if y + self.mouseyOld <= 0 then
					self:MoveVertial()
				end

				self:MoveHorizontal()
			else
				if y + self.mouseyOld <= 0 then
					self:MoveVertial()
				end
			end
		else
			self.mousexOld = self.mousex
			self.mouseyOld = self.mousey
		end

		self:SetCursor("sizeall")
	end

end
tridentlib("DefineFunction", "BP::ScrollPlane", ScrollPlane, {"Panel"})

---------------------------------------------------------*/
local function DrawCorners( bordersize, x, y, w, h, color, color2, color3, color4 )
	local tex = tex_corner8
	if ( bordersize > 8 ) then tex = tex_corner16 end
	if ( bordersize > 16 ) then tex = tex_corner32 end
	if ( bordersize > 32 ) then tex = tex_corner64 end
	if ( bordersize > 64 ) then tex = tex_corner512 end

	surface.SetTexture( tex )

	surface.SetDrawColor( color.r, color.g, color.b, color.a )
	surface.DrawTexturedRectUV( x, y, bordersize, bordersize, 0, 0, 1, 1 )

	surface.SetDrawColor( color2.r, color2.g, color2.b, color2.a )
	surface.DrawTexturedRectUV( x + w - bordersize, y, bordersize, bordersize, 1, 0, 0, 1 )

	surface.SetDrawColor( color3.r, color3.g, color3.b, color3.a )
	surface.DrawTexturedRectUV( x, y + h -bordersize, bordersize, bordersize, 0, 1, 1, 0 )

	surface.SetDrawColor( color4.r, color4.g, color4.b, color4.a )
	surface.DrawTexturedRectUV( x + w - bordersize, y + h - bordersize, bordersize, bordersize, 1, 1, 0, 0 )
end

tridentlib("DefineFunction", "BP::DrawCorners", DrawCorners )