--[[tridentlib
  "name": "Net Module",
  "state": "Shared"
--tridentlib]]

_tridentlib.NET = {}
_tridentlib.NET.theads = {}
_tridentlib.NET.looptheads = {}
_tridentlib.NET.messages = {}
_tridentlib.NET.distribute = {}
_tridentlib.NET.distributeloop = {}
if SERVER then

	local function Loopback(name, options, func)
		options = options or {}
		
		if isbool(options.unpack) then
			options.unpack = options.unpack
		else
			options.unpack = true
		end

		if isbool(options.broadcast) then
			options.broadcast = options.broadcast
		else
			options.broadcast = false
		end

		local broadcast = type(broadcast) or false
		if !_tridentlib.NET.messages[name] then
			util.AddNetworkString(name)
		end

		_tridentlib.NET.distributeloop[name] = {}
		table.insert(_tridentlib.NET.distributeloop[name], func)

		if !_tridentlib.NET.theads[name] then
			local base = [[
			net.Receive("%s",function(len, ply) 
				for k, v in pairs(_tridentlib.NET.distributeloop["%s"]) do
					local ret = nil
					if %s then
						ret = v(ply, unpack(net.ReadTable()))
					else
						ret = v(ply, net.ReadTable())
					end
					if ret then
						net.Start("%s")
							net.WriteTable(ret)
						if %s then
							net.Broadcast()
						else
							net.Send(ply)
						end
					end
				end
			end)
			]]
			local insert = string.format(base,name,name,options.unpack,name,options.broadcast)
			local run = CompileString(insert, "tridentlib::NET | Loopback Receive", false)
			run()
			_tridentlib.NET.theads[name] = true
		end

		table.insert(_tridentlib.NET.distribute, func)
	end

	tridentlib("DefineFunction", "NET::Loopback", Loopback )

end

if CLIENT then
	
local function Transfer(name, options, func, ...)
	options = options or {}
	
	if isbool(options.unpack) then
		options.unpack = options.unpack
	else
		options.unpack = true
	end

	net.Start(name)
		net.WriteTable({...})
	net.SendToServer()

	_tridentlib.NET.distribute[name] = {}
	table.insert(_tridentlib.NET.distribute[name], func)

	if !_tridentlib.NET.theads[name] then
		local base = [[
		net.Receive("%s",function(len, ply)
			for k, v in pairs(_tridentlib.NET.distribute["%s"]) do
				if %s then
					local ret = v(unpack(net.ReadTable()))
				else
					local ret = v(net.ReadTable())
				end
				if ret then
					net.Start("%s")
						net.WriteTable(ret)
					net.Send(ply)
				end
			end
		end)
		]]
		local insert = string.format(base,name,name,options.unpack,name)
		local run = CompileString(insert, "tridentlib::NET | Transfer Receive", false)
		run()
		_tridentlib.NET.theads[name] = true
	end

	_tridentlib.NET.messages[name] = true
end

tridentlib("DefineFunction", "NET::Transfer", Transfer )

end

/* SERVER 
if SERVER then
	local function test(ply, woah, woah2)
		print("server")
		print(woah)
		print(woah2)
		print(ply)
		return { "test", "test2" }
	end 

	tridentlib("NET::Loopback", "test_msg", test )
end
// CLIENT
if CLIENT then
	local function test(woah, woah2)
		print("client")
		print(woah)
		print(woah2)
	end

	tridentlib("NET::Transfer", "test_msg", {}, test, "hey", "ho" )
end
*/