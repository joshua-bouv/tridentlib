--[[tridentlib
  "name": "Dataset Module",
  "state": "Server"
--tridentlib]]

_tridentlib.DataSets = _tridentlib.DataSets or {}

local function createDataSet(name, data, prems)
	_tridentlib.DataSets[name] = { name = name, data = data, prems = prems } 
end
tridentlib("DefineFunction", "createDataSet", createDataSet )


local function getDataSet(name, ply)
	if _tridentlib.DataSets[name] then
		if _tridentlib.DataSets[name]["prems"](name, ply) then
			return _tridentlib.DataSets[name]["data"]
		else
			return "You are not allowed to read this dataset."
		end
	else
		return "Dataset not found."
	end
end
tridentlib("DefineFunction", "getDataSet", getDataSet )