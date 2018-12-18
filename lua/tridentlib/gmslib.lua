--[[tridentlib
  "name": "GMS Module",
  "state": "Client"
--tridentlib]]

local function UpdatePanel(self, version, alive)
	local return_version = 10

	local lerp_speed = 0.8
	local lerp_pos = 0
	local lerp_goto = 40

	local remove_time = CurTime() + alive

	local name = tridentlib("createUniqueHook", "tridentlibGMS")["name"]

	hook.Add("HUDPaint",name,function()
		if IsValid(self) then
			local x, y, w, h = self:GetBounds()

			lerp_pos = Lerp(0.05, lerp_pos, lerp_goto)

			if return_version-version >= 5 then
				draw.RoundedBox(0, x, y+h-20, w, lerp_pos, redText)
				draw.SimpleText("The addon is heavily out of date! Please update!","eventsTextFont",x+w/2,y+h+lerp_pos-37,Color(255,255,255),TEXT_ALIGN_CENTER)
			else
				if version < return_version then
					draw.RoundedBox(0, x, y+h-20, w, lerp_pos, Color(251,192,45))
					draw.SimpleText("There is a new update available!","eventsTextFont",x+w/2,y+h+lerp_pos-37,Color(255,255,255),TEXT_ALIGN_CENTER)
					if CurTime() > remove_time then
						lerp_goto = 19
						if lerp_pos <= lerp_goto+1 then hook.Remove("HUDPaint", name)	end
					end
				else
					draw.RoundedBox(0, x, y+h-20, w, lerp_pos, greenText)

					draw.SimpleText("The addon is up to date!","eventsTextFont",x+w/2,y+h+lerp_pos-37,Color(255,255,255),TEXT_ALIGN_CENTER)
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

tridentlib("DefineFunction", "UpdatePanel", UpdatePanel )