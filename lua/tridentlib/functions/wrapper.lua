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
	local query = _tridentlib.SQL[self.table][self.name].query
	local optionI = 0

	function query:returnFunc(type, pos, data)
		local types = {
			["string"] = self:setString(pos, tostring(data)),
			["number"] = self:setNumber(pos, tonumber(data)),
			["boolean"] = self:setBoolean(pos, tobool(data)), // handle this
			["nil"] = self:setNull(pos, data) // handle this
		}

		return types[type]
	end

	if (_tridentlib.SQL[self.table].type == "SQLITE") then
		for i = 1, #query do
			if (query:sub(i, i)) == "?" then
				query = replaceChar(i, query, self.options[optionI])
				optionI = optionI + 1
			end
		end
	elseif ((_tridentlib.SQL[self.table].type == "MYSQLOO")) then
		if self.options != nil then
			for k, v in pairs(self.options) do
				query:returnFunc(type(v), k+1, self.options[optionI])
				optionI = optionI + 1
			end
		end
	end

	print(query)
	// run query
	// return query result if any
end

tridentlib("DefineFunction", "WRAPPER::RunQuery", RunQuery )

local function processQuery(db, store, type)
	if (type == "MYSQLOO") then
		store.query = db:prepare(store.query)
	end

	return store
end

local function AddQuery(self)
	_tridentlib.SQL[self.table][self.store.name] = processQuery(self.db, self.store, _tridentlib.SQL[self.table].type)
end

tridentlib("DefineFunction", "WRAPPER::AddQuery", AddQuery )

local function Create(self)
	_tridentlib.SQL[self.name] = {}
	_tridentlib.SQL[self.name]["type"] = self.type
end

tridentlib("DefineFunction", "WRAPPER::Create", Create )