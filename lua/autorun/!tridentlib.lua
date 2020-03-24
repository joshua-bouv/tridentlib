 -- TRIDENTLIB 4.0                                    
_tridentlib = _tridentlib or {}     
_tridentlib.metaTables = {}  

_tridentlib.MetaTables = {}
_tridentlib.MetaFunctions = {}

_tridentlib.FunctionLoader = _tridentlib.FunctionLoader or {}
_tridentlib.FunctionLoader.Functions = _tridentlib.FunctionLoader.Functions or {}

--[ CONSOLE PRINT ]  
function _tridentlib.ConsolePrint(message)
	print(message)
end

--[ META FUNCTION LOADER ]  
function _tridentlib.CreateMetaFunction(v, explode, name)
	local inject = [[
	local meta = FindMetaTable("%s")
	if !meta then return end
	function meta:%s(func, ...)
		return _tridentlib.RunFunction("%s::"..func, self, ...)
	end
	]]
	local func, err = CompileString(string.format(inject, v, explode, explode, explode), "TRIDENTLIB::Meta Definer", false)
	if err then print("TRIDENTLIB::Meta Definer | Fatal error in: "..name) end
	func()
end

--[ META FUNCTION LOADER ]  
function _tridentlib.DefineFunction(name, func, metatables)
	local explode = string.Explode("::", name)[1]
	if metatables then
		if metatables[1] then
			_tridentlib.metaTables[explode] = _tridentlib.metaTables[explode] or {}
			for _, v in pairs(metatables) do
				if !_tridentlib.metaTables[explode][v] then
					_tridentlib.CreateMetaFunction(v, explode, name)
					_tridentlib.metaTables[explode][v] = true
				end
			end
		end
	end
	_tridentlib.FunctionLoader.Functions[name] = func
end

--[ META FUNCTION LOADER ]  
function _tridentlib.RunFunction(func, self, ...)
	if _tridentlib.FunctionLoader.Functions[func] then
		if self then
			return _tridentlib.FunctionLoader.Functions[func](self, ...)
		else
			return _tridentlib.FunctionLoader.Functions[func](...)
		end
	end
	error("TRIDENTLIB::Function Loader | attempt to call a nil function: "..func )
end

--[ LOAD ADDDON INT ] 
function _tridentlib.LoadAddonInt(name, namespace, enable_namespace)
	_tridentlib.ConsolePrint(" ")
	_tridentlib.ConsolePrint("TRIDENTLIB> Loading Addon: "..name..".")
	_tridentlib.ConsolePrint(" > Initializing addon.")
	local inject = [[
	local function DefineFunction(name, func, metatables)
		_tridentlib.DefineFunction("%s::"..name, func, metatables)
	end
	_tridentlib.DefineFunction("%s::DefineFunction", DefineFunction, {})

	function %s(func, ...)
		return _tridentlib.RunFunction("%s::"..func, nil, ...)
	end
	]]
	if (enable_namespace == "true") then
		local func, err = CompileString(string.format(inject, namespace, namespace, namespace, namespace, namespace, namespace), "TRIDENTLIB::Function Definer", false)
		if err then error("TRIDENTLIB::Function Definer | Fatal Error loading "..name.."/"..namespace, 2) 
		else func() _tridentlib.ConsolePrint(" > Enabled namespace functions.") end
	end
end

function _tridentlib.defineAddon(name, namespace, enable_namespace)
	_tridentlib.LoadAddonInt(name, namespace, enable_namespace)
end

function _tridentlib.loadFile(file, name, state, priority)
	local loaded = false
	if (state == "client") then 
		if SERVER then AddCSLuaFile(file) end 
		if CLIENT then include(file) loaded=true end 
	end
	if (state == "shared") then 
		if SERVER then AddCSLuaFile(file) end
		include(file) 
		loaded=true
	end
	if (state == "server") then 
		if SERVER then include(file) loaded=true end
	end
	if (loaded) then print(" > Loaded "..name) end
end

function _tridentlib.finalizeDefine(name, namespace, enable_namespace)
	print("> Finished loading Addon: "..name..".")
end