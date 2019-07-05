--[[tridentlib
  "name": "Keybind Module",
  "state": "Client"
--tridentlib]]

local function MultiClick(self, amount, click, finish)
	self.ClickAmount = self.ClickAmount or 0
	if self.LastClick-CurTime() >= 0.5 then
		self.ClickAmount = self.ClickAmount + 1
	else
		self.ClickAmount = 0
	end
	if self.ClickAmount == amount then
		finish()
	end
	click(self.ClickAmount)
	self.LastClick = CurTime()
end

tridentlib("DefineFunction", "MultiClick", MultiClick )

local function CreateBind(keyx, functionx)
	hook.Add( "KeyPress", tridentlib("createUniqueHook", "keybind"), function( ply, key )
		if ( key == keyx ) then
			functionx()
		end
	end )
end

tridentlib("DefineFunction", "CreateBind", CreateBind )