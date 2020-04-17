--[[tridentlib
  "name": "SQL Wrapper",
  "state": "Server",
  "priority": 10
--tridentlib]]

_tridentlib.SQL = {}

local function replaceChar(pos, str, r)
    return table.concat{str:sub(1,pos-1), r, str:sub(pos+1)}
end

local function returnFunc(type)
	local types = {
		["string"] = setString,
		["number"] = setNumber,
		["boolean"] = setBoolean,
		["nil"] = setNull
	}

	return types[type]
end

local function RunQuery(self)
	local query = _tridentlib.SQL[self.table][self.name].query
	local optionI = 0

	if (_tridentlib.SQL[self.table].type == "MYSQLITE") then
		for i = 1, #query do
			if (query:sub(i, i)) == "?" then
				query = replaceChar(i, query, self.options[optionI])
				optionI = optionI + 1
			end
		end
	elseif ((_tridentlib.SQL[self.table].type == "MYSQLOO")) then
		for k, v in pairs(self.options) do
			query:returnFunc(v.type())(k, self.options[optionI])
		end
	end

	print(query)
	// return query result if any
end

tridentlib("DefineFunction", "WRAPPER::RunQuery", RunQuery )

local function processQuery(db, query, type)
	if (type == "MYSQLOO") then
		query = db:prepare(query)
	end

	return query
end

local function AddQuery(self)
	_tridentlib.SQL[self.table][self.store.name] = processQuery(self.db, self.store, _tridentlib.SQL[self.table].type)
end

tridentlib("DefineFunction", "WRAPPER::AddQuery", AddQuery )

local function Create(self)
	_tridentlib.SQL["type"] = self.type
	_tridentlib.SQL[self.name] = {}
end

tridentlib("DefineFunction", "WRAPPER::Create", Create )