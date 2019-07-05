--[[tridentlib
  "name": "Meta Lib",
  "state": "Shared",
  "priority": 1
--tridentlib]]

local function createMeta(name, base)
	_tridentlib.MetaTables[name] = base
	_tridentlib.MetaFunctions[name] = {}
	_tridentlib.MetaFunctions[name].__index = _tridentlib.MetaFunctions[name]
	setmetatable( _tridentlib.MetaTables[name], _tridentlib.MetaFunctions[name] )
end

tridentlib("DefineFunction", "META::create", createMeta )

local function getMeta(name)
	return _tridentlib.MetaTables[name]
end

tridentlib("DefineFunction", "META::get", getMeta )

local function createFunc(location, name, functionx)
	_tridentlib.MetaFunctions[location][name] = functionx
end

tridentlib("DefineFunction", "META::function", createFunc )