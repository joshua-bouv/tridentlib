--[[tridentlib
  "name": "SQL Wrapper",
  "state": "Server",
  "priority": 10
--tridentlib]]

_tridentlib.SQL = {}

local function replaceChar(pos, str, r)
    return table.concat{str:sub(1,pos-1), r, str:sub(pos+1)}
end

local function RunQuery(self)
	local query = _tridentlib.SQL[self.script][self.name].query
	local optionI = 0
	
	local TEMPDATAREMOVEME = ""

	if (_tridentlib.SQL[self.script].type == "SQLITE") then
		for i = 1, #query do
			if (query:sub(i, i)) == "?" then
				query = replaceChar(i, query, sql.SQLStr(self.options[optionI]))
				optionI = optionI + 1
			end
		end

		if (self.output) then // TODO: HANDLE THIS PROPERLY
			TEMPDATAREMOVEME = sql.Query(query) // make return		
		else
			sql.Query(query)
		end
	elseif ((_tridentlib.SQL[self.script].type == "MYSQLOO")) then
		function query:returnFunc(type, pos, data)
			local types = {
				["string"] = self:setString(pos, tostring(data)),
				["number"] = self:setNumber(pos, tonumber(data)),
				["boolean"] = self:setBoolean(pos, tobool(data)),
				["nil"] = self:setNull(pos, data) // handle this properly potentially not needs testing remember me!!!
			}

			return types[type]
		end

		if self.options != nil then
			for k, v in pairs(self.options) do
				query:returnFunc(type(v), k+1, self.options[optionI])
				optionI = optionI + 1
			end
		end

		if (self.output) then // TODO: HANDLE THIS PROPERLY
			function query:onSuccess(data)
				TEMPDATAREMOVEME = data  // make return
			end
		end

		query:start()
	end

	print(TEMPDATAREMOVEME)
end

tridentlib("DefineFunction", "WRAPPER::RunQuery", RunQuery)

local function processQuery(db, store, type)
	if (type == "MYSQLOO") then
		store.query = db:prepare(store.query)
	end

	return store
end

local function AddQuery(self)
	_tridentlib.SQL[self.script][self.store.name] = processQuery(_tridentlib.SQL[self.script].db, self.store, _tridentlib.SQL[self.script].type)
end

tridentlib("DefineFunction", "WRAPPER::AddQuery", AddQuery)

local function Create(self)
	_tridentlib.SQL[self.script] = {}
	_tridentlib.SQL[self.script].db = self.db
	_tridentlib.SQL[self.script].type = self.type
end

tridentlib("DefineFunction", "WRAPPER::Create", Create)