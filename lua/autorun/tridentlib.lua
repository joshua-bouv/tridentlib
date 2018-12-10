-- TRIDENTLIB 2.0
_tridentlib = {}     
_tridentlib.metaTables = {}  

_tridentlib.FileLoader = {}
_tridentlib.FileLoader.Data = {} 

_tridentlib.FunctionLoader = {}
_tridentlib.FunctionLoader.Functions = {} 

--[ FUNCTION lOADER ]  
function _tridentlib.FunctionLoader.Inject(v, explode, name)
	local inject = [[
		local meta = FindMetaTable("%s")
		if !meta then return end
		function meta:%s(func, ...)
		return _tridentlib.FunctionLoader.Run("%s::"..func, self, ...)
		end
	]]
	local func, err = CompileString(string.format(inject, v, explode, explode, explode), "TRIDENTLIB::Meta Definer", false)
	if err then print("TRIDENTLIB::Meta Definer | Fatal error in: "..name) end
	func()
end

function _tridentlib.FunctionLoader.Define(name, func, metatables)
	local explode = string.Explode("::", name)[1]
	if metatables then
		if metatables[1] then
			_tridentlib.metaTables[explode] = _tridentlib.metaTables[explode] or {}
			for _, v in pairs(metatables) do
				if !_tridentlib.metaTables[explode][v] then
					_tridentlib.FunctionLoader.Inject(v, explode, name)
					_tridentlib.metaTables[explode][v] = true
				end
			end
		end
	end
	_tridentlib.FunctionLoader.Functions[name] = func
end
/*  
function _tridentlib.TableInject(name)
	local inject = [[
		%s = {}
	]]
	local func, err = CompileString(string.format(inject, name), "TRIDENTLIB::Table Definer", false)
	if err then print("TRIDENTLIB::Table Definer | Fatal error in: "..name) end
	func()
end

function _tridentlib.TableLoad(base, structure)
	for k, v in pairs(structure) do
		if v[k] == "table" then
			_tridentlib.TableInject(v[k][])
		end
		if v[k] == "string" then
			
		end
	end
end
*/
function _tridentlib.FunctionLoader.Run(func, self, ...)
	if _tridentlib.FunctionLoader.Functions[func] then
		if self then
  			return _tridentlib.FunctionLoader.Functions[func](self, ...)
  		else
			return _tridentlib.FunctionLoader.Functions[func](...)
  		end
  	end
  	error("TRIDENTLIB::Function Loader | attempt to call a nil function: "..func )
end

 --[ FILE lOADER ] 
function _tridentlib.FileLoader.parseFile(raw, full)
	local data = {}
	data["priority"] = 99999999999
    local prefix = string.Explode("_", raw)[1]
    local suffix = string.Explode(".",raw)[2]
    if suffix == "lua" then
	    data["prefix"] = data["prefix"] or prefix
	    // check file contents
	    local filedata = file.Read(full, "LUA")
	    if filedata then
			local stage1 = string.Explode("--[[tridentlib", filedata)
			if stage1[2] then
				local stage2 = string.Explode("--tridentlib]]", stage1[2])
				local filecontents = util.JSONToTable("{"..stage2[1].."}")
				if filecontents then
					data["prefix"] = filecontents["state"] or data["prefix"]
					data["priority"] = filecontents["priority"] or data["priority"]
					data["data"] = filecontents
				end
			end
		end
	end
	return data
end

function _tridentlib.FileLoader.mapFolder(base, folder) 
  local files, folders = file.Find( folder.."/*", "LUA") 
  for k, v in pairs(files) do 
    table.insert(_tridentlib.FileLoader.Data[base], table.Merge({ full = folder.."/"..v, raw = v }, _tridentlib.FileLoader.parseFile(v, folder.."/"..v)))
  end 
  for k, v in pairs(folders) do 
    _tridentlib.FileLoader.mapFolder(base, folder.."/"..v) 
  end 
end 
 
function _tridentlib.FileLoader.mapStart(base, folder)
  local base_files, folder_table = file.Find(folder .. "*", "LUA")
  for k, v in pairs(base_files) do
    table.insert(_tridentlib.FileLoader.Data[base], table.Merge({ full = folder..v, raw = v }, _tridentlib.FileLoader.parseFile(v, folder..v)))
  end 
  for k, v in pairs(folder_table) do
    _tridentlib.FileLoader.mapFolder(base, folder..v) 
  end
end 

function _tridentlib.FileLoader.ConsolePrint(data, message)
	print(message)
end

function _tridentlib.FileLoader.loadFile(data, filex)
  if filex["prefix"] then
	  local state = string.lower(filex["prefix"])
	  if(state == "cl" or state == "client")then 
	    if SERVER then AddCSLuaFile(filex["full"]) end 
	    if CLIENT then include(filex["full"]) 
	      if filex["data"] and filex["data"]["name"] then
	        _tridentlib.FileLoader.ConsolePrint(data, "  > Loaded: ".. filex["data"]["name"])
	      else
	        _tridentlib.FileLoader.ConsolePrint(data, "  > Loaded: ".. filex["raw"])
	      end
	    end end 
	  if(state == "sv" or state == "server")then 
	    if SERVER then include(filex["full"]) 
	      if filex["data"] and filex["data"]["name"] then
	        _tridentlib.FileLoader.ConsolePrint(data, "  > Loaded: ".. filex["data"]["name"])
	      else
	        _tridentlib.FileLoader.ConsolePrint(data, "  > Loaded: ".. filex["raw"])
	      end
	    end end 
	  if(state == "sh" or state == "shared")then 
	    AddCSLuaFile(filex["full"]) include(filex["full"]) 
	      if filex["data"] and filex["data"]["name"] then
	        _tridentlib.FileLoader.ConsolePrint(data, "  > Loaded: ".. filex["data"]["name"])
	      else
	        _tridentlib.FileLoader.ConsolePrint(data, "  > Loaded: ".. filex["raw"])
	      end
		end
	else
		print("  > File without state found. Skipping.")
	end
end

function _tridentlib.LoadAddon(data)
	_tridentlib.FileLoader.ConsolePrint(data, " ")
	_tridentlib.FileLoader.ConsolePrint(data, "TRIDENTLIB> Loading Addon: "..data["folder"]..".")
	if data["func"] then
		_tridentlib.FileLoader.ConsolePrint(data, " > Createing addon functions")
	    local inject = [[
			local function DefineFunction(name, func, metatables)
			    _tridentlib.FunctionLoader.Define("%s::"..name, func, metatables)
			end
			_tridentlib.FunctionLoader.Define("%s::DefineFunction", DefineFunction, {})

			function %s(func, ...)
			  return _tridentlib.FunctionLoader.Run("%s::"..func, nil, ...)
			end
		]]
		local func, err = CompileString(string.format(inject, data["func"], data["func"], data["func"], data["func"], data["func"], data["func"]), "TRIDENTLIB::Function Definer", false)
		if err then error("TRIDENTLIB::Function Definer | Fatal Error "..data["func"].."/"..data["folder"], 2) 
		else _tridentlib.FileLoader.ConsolePrint(data, " > Finalized creation of functons.") end
		func()
	end
	if data["folder"] then
		_tridentlib.FileLoader.Data[data["folder"]] = {}
		_tridentlib.FileLoader.mapStart(data["folder"], data["folder"].."/")

		table.sort( _tridentlib.FileLoader.Data[data["folder"]], function( a, b ) return a["priority"] < b["priority"] end )
		print(" > Loading "..#_tridentlib.FileLoader.Data[data["folder"]].." files.")
		for k, v in pairs(_tridentlib.FileLoader.Data[data["folder"]]) do
			_tridentlib.FileLoader.loadFile(data, v)
		end
	end
	_tridentlib.FileLoader.ConsolePrint(data, " > Loaded Addon")
end

_tridentlib.LoadAddon({ folder = "tridentlib", func = "tridentlib" })

if tridentlib_load then
	for k,v in pairs(tridentlib_load) do
		_tridentlib.LoadAddon(v)
	end
end
