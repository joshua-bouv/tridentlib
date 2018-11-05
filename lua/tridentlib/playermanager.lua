--[[tridentlib
  "name": "PlayerManager Module",
  "state": "Shared"
--tridentlib]]

if SERVER then

util.AddNetworkString("tridentlib.SendError")

_tridentlib.PLYManager = _tridentlib.PLYManager or {}

local function CreatePlayerManager(data)
	//_tridentlib.PLYManager["name"] = {}
	local RedJoin = data["join"]
	local RedLeave = data["leave"]
	local RedFail = data["onfail"]

	data["onfail"] = function(ply, msg)
		local err = RedFail(msg)
		if !err then
			net.Start("tridentlib.SendError")
				net.WriteString("An undefined error has occured.")
				net.WriteString(data["addon"])
			net.Send(ply)
		else
			net.Start("tridentlib.SendError")
				net.WriteString(err)
				net.WriteString(data["addon"])
			net.Send(ply)
		end
	end

	data["join"] = function(ply)
		if RedJoin(ply) then
			data["onjoin"](ply)
		else
			data["onfail"](ply, "fJoin")
		end
	end

	data["leave"] = function(ply)
		if RedLeave(ply) then
			data["onleave"](ply)
		else
			data["onfail"](ply, "fLeavex")
		end
	end
	_tridentlib.PLYManager[data["addon"]] = {}
	_tridentlib.PLYManager[data["addon"]][data["name"]] = data

end

tridentlib("DefineFunction", "CreatePlayerManager", CreatePlayerManager )


local function GetPlayerManager(addon, name)
	return _tridentlib.PLYManager[addon][name]
end

tridentlib("DefineFunction", "GetPlayerManager", GetPlayerManager )

end

if CLIENT then

_tridentlib.ERRManager = _tridentlib.ERRManager or {}
net.Receive("tridentlib.SendError",function()
	local err = net.ReadString()
	local addon = net.ReadString()

	_tridentlib.ERRManager[addon]({ msg = err})
end)

local function ErrorPlayerManager(addon, functionx)
	_tridentlib.ERRManager[addon] = functionx
end

tridentlib("DefineFunction", "ErrorPlayerManager", ErrorPlayerManager )

end