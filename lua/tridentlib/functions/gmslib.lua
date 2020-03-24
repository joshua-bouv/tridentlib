--[[tridentlib
  "name": "GMS Module",
  "state": "Client"
--tridentlib]]

surface.CreateFont( "tridentlib_text", {
	font = "Product Sans",
	size = 15,
	weight = 0,
} )

local function UpdatePanel(self, version, alive)
	local return_version = 10

	local lerp_speed = 0.8
	local lerp_pos = 0
	local lerp_goto = 40

	local remove_time = CurTime() + alive

	local name = tridentlib("createUniqueHook", "tridentlibGMS")["name"]

	local grn = Color(76, 175, 80, 255)
	local ylw = Color(251,192,45)
	local red = Color(244, 67, 54, 255)
	local textCol = Color(255, 255, 255, 255)

	hook.Add("HUDPaint",name,function()
		if IsValid(self) then
			local x, y, w, h = self:GetBounds()

			lerp_pos = Lerp(0.05, lerp_pos, lerp_goto)

			if return_version-version >= 5 then
				draw.RoundedBox(0, x, y+h-20, w, lerp_pos, red)
				draw.SimpleText("The addon is heavily out of date! Please update!", "tridentlib_text", x+w/2, y+h+lerp_pos-37, textCol, TEXT_ALIGN_CENTER)
			else
				if version < return_version then
					draw.RoundedBox(0, x, y+h-20, w, lerp_pos, ylw)
					draw.SimpleText("There is a new update available!", "tridentlib_text", x+w/2, y+h+lerp_pos-37, textCol, TEXT_ALIGN_CENTER)
					if CurTime() > remove_time then
						lerp_goto = 19
						if lerp_pos <= lerp_goto+1 then hook.Remove("HUDPaint", name)	end
					end
				else
					draw.RoundedBox(0, x, y+h-20, w, lerp_pos, grn)

					draw.SimpleText("The addon is up to date!", "tridentlib_text", x+w/2, y+h+lerp_pos-37, textCol, TEXT_ALIGN_CENTER)
					if CurTime() > remove_time then
						lerp_goto = 19
						if lerp_pos <= lerp_goto+1 then hook.Remove("HUDPaint", name)	end
					end
				end
			end
		else
			hook.Remove("HUDPaint", name)
		end
	end)
end

tridentlib("DefineFunction", "UpdatePanel", UpdatePanel)