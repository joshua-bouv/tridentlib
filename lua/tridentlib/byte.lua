--[[tridentlib
  "name": "Byte Module",
  "state": "Shared"
--tridentlib]]

local function ToByte(string)
	return string.Implode("⬛", {string.byte( string, 1, -1 )})
end

tridentlib("DefineFunction", "BYTE::ToByte", ToByte )

local function ToString(string)
	return string.char(unpack(string.Explode("⬛", string )))
end

tridentlib("DefineFunction", "BYTE::ToString", ToString )