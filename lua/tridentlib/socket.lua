--[[tridentlib
  "name": "Websocket Module",
  "state": "Server",
  "priority": 1
--tridentlib]]

_tridentlib.Sockets = _tridentlib.Sockets or {} 
_tridentlib.Sockets.Included = 0

local function CreateSocket(name, url, parameters, type, echo, msg, err, precall)
	if type == "http" then
		_tridentlib.Sockets[name] = {}
		_tridentlib.Sockets[name].Data = {}
		echo("Connected to server: "..url, "success")
		timer.Create("NLIB::HSocket-"..name, 1, 0, function()
			local params = {}
			params.data = table.Copy(_tridentlib.Sockets[name].Data)
			_tridentlib.Sockets[name].Data = {}

			local dat = util.JSONToTable(file.Read("ares_link.dat","DATA")) or {}
			table.Merge(dat, params)

			local request = {
				url			= url,
				method		= "get",
				parameters = dat,
				success = function( code, body, headers )
					if body != "[]" then
						msg(body, "normal")
					end
				end,
				failed = function( reason )
					err(reason, "danger")
					tridentlib("SOCKET::RemoveSocket", "TridentcomAres", "http")
					echo("Websocket disconnected", "warning")
				end
			}
			HTTP( request )
		end)
	end

	if type == "gwsockets" then
		if _tridentlib.Sockets.Included == 0 then
			require("gwsockets")
			_tridentlib.Sockets.Included = 1
		end
		local request = {
			url			= url,
			method		= "post",
			parameters = {},
			success = function( code, body, headers )

				if _tridentlib.Sockets[name] then err("Socket already exists", "danger") return end
				_tridentlib.Sockets[name] = GWSockets.createWebSocket(url, false)
				local socket = _tridentlib.Sockets[name]

				function socket:onMessage(txt)
					msg(txt, "normal")
				end

				function socket:onError(txt)
					err(txt, "danger")
				end
				function socket:onConnected()
					_tridentlib.Sockets[name].Connected = 1
					echo("Connected to server: "..url, "success")
				end
				function socket:onDisconnected()
					_tridentlib.Sockets[name].Connected = 0
					echo("Websocket disconnected", "warning")
					_tridentlib.Sockets[name] = nil
				end

				precall(_tridentlib.Sockets[name])

				socket:open()

			end,
			failed = function( reason )
				err("Websocket failed to connect to: "..url, "danger")
			end
		}
		HTTP( request )

	end
end

tridentlib("DefineFunction", "SOCKET::CreateSocket", CreateSocket)

local function RemoveSocket(name, type)
	if type == "http" then
		timer.Remove("NLIB::HSocket-"..name)
	end
	if type == "gwsockets" then
		_tridentlib.Sockets[name]:close()
		_tridentlib.Sockets[name] = nil
	end
end

tridentlib("DefineFunction", "SOCKET::RemoveSocket", RemoveSocket)

local function SocketSend(name, type, data)
	if type == "http" then
		table.insert(_tridentlib.Sockets[name].Data, data)
	end
	if type == "gwsockets" then
		_tridentlib.Sockets[args[1]]:close()
		_tridentlib.Sockets[args[1]] = nil
	end
end

tridentlib("DefineFunction", "SOCKET::SocketSend", SocketSend)
