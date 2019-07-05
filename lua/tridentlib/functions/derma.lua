--[[tridentlib
  "name": "Derma Module",
  "state": "Client"
--tridentlib]]

local function SetDraggableHeight(self, height)

	self.OnMousePressed = function()
		if ( self:GetDraggable() && gui.MouseY() < (self.y + height) ) then
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

			-- Lock to screen bounds if screenlock is enabled
			if ( self:GetScreenLock() ) then

				x = math.Clamp( x, 0, ScrW() - self:GetWide() )
				y = math.Clamp( y, 0, ScrH() - self:GetTall() )

			end

			self:SetPos( x, y )

		end

		if ( self.Hovered && self:GetDraggable() && mousey < ( self.y + height ) ) then
			self:SetCursor( "sizeall" )
			return
		end

	end

end
tridentlib("DefineFunction", "SetDraggableHeight", SetDraggableHeight, {"Panel"} )

local function ToolGunPanelSize(self, data)
	local parent = self:GetParent():GetParent()
	self:GetParent():Remove()
	return parent
end
tridentlib("DefineFunction", "ToolGunPanelSize", ToolGunPanelSize, {"Panel"} )