--[[tridentlib
  "name": "Database Module",
  "state": "Server",
  "priority": 10
--tridentlib]]

_tridentlib.Database = {}
_tridentlib.Database.Operators = {}
_tridentlib.Database.Operators["mysql"] = {
	["="] = "=",
	["!="] = "!=",
	[">"] = ">",
	["<"] = "<",
	[">="] = ">=",
	["<="] = "<="
}
_tridentlib.Database.Operators["sqlite"] = {
	["=="] = "==",
	["="] = "=",
	["!="] = "!=",
	["<>"] = "!=",
	[">"] = ">",
	["<"] = "<",
	[">="] = ">=",
	["<="] = "<=",
	["!<"] = ">=",
	["!>"] = ">="
}
_tridentlib.Database.Base = {
	data = {
		params = {where = 0},
		select = "*",
		query = "select *",
		type = nil
	}
}
_tridentlib.Database.Functions = {}

_tridentlib.Database.Functions["sqlite"] = {
	insert = function(self, row, tablex)
		local count = 0
		local params = ""
		for k,v in pairs(tablex) do
			params = params..sql.SQLStr(k, true)
			if #tablex == count then
				params = params..", "
			end
			count = count+1
		end
		self.data.query = "insert into "..row.."("..params..")"
	end,
	select = function(self, row)
		self.data.query = "select "..row
	end,
	update = function(self, row)
		self.data.query = "update "..row
	end,
	from = function(self, gtable)
		self.data.query = self.data.query.." from "..gtable
		return self
	end,
	set = function(self, tablex)
		local params = " "
		local count = 0
		for k,v in pairs(tablex) do
			params = params..sql.SQLStr(v,true).."="..sql.SQLStr(v)
			if #tablex == count then
				params = params..", "
			end
			count = count+1
		end
		self.data.query = self.data.query.." SET"..params
		return self
	end,
	where = function(self, ...)
		local cond = {...}
		local selector1 = sql.SQLStr(cond[1], true)
		local selector2 = sql.SQLStr(cond[2])
		local operator = _tridentlib.Database.Operators["sqlite"][cond[2]] or "="
		if _tridentlib.Database.Operators["sqlite"][cond[2]] then
			selector2 = sql.SQLStr(cond[3])
		end		
		if self.data.params.where == 1 then self.data.query = self.data.query.." and" self.data.params.where = 1 end
		if self.data.params.where == 0 then self.data.query = self.data.query.." where" self.data.params.where = 1 end
		self.data.query = self.data.query.." "..selector1..operator..selector2
		return self
	end,
	values = function(self, tablex)
		local params = ""
		local count = 0
		for k,v in pairs(tablex) do
			params = params..sql.SQLStr(v)
			if #tablex == count then
				params = params..", "
			end
			count = count+1
		end
		self.data.query = self.data.query.." VALUES("..params..")"
		return self
	end,
	get = function(self)
		local data = table.Copy(self.data)
		self.data = table.Copy(_tridentlib.Database.Base.data) 
		self.data.type = data.data.type
		return sql.Query( data.query )
	end,
	first = function(self)
		local data = table.Copy(self.data)
		self.data = table.Copy(_tridentlib.Database.Base.data) 
		self.data.type = data.data.type
		sql.QueryRow( data.query )
	end
}

tridentlib("META::create", "database", table.Copy(_tridentlib.Database.Base))

// Debug Functions
function Dump(self)
	local data = table.Copy(self)
	self.data = table.Copy(_tridentlib.Database.Base.data) 
	self.data.type = data.data.type
	return data
end
tridentlib("META::function", "database", "Dump", Dump)

// Definer Functions
function Sqlite(self)
	self.data.type = "sqlite"
	return self
end
tridentlib("META::function", "database", "Sqlite", Sqlite)

function Mysql(self)
	self.data.type = "mysql"
	return self
end
tridentlib("META::function", "database", "Mysql", Mysql)

function Type(self, type)
	self.data.type = string.lower(type)
	return self
end
tridentlib("META::function", "database", "Type", Type)

// Selector Functions
function Insert(self, row, tablex)
	_tridentlib.Database.Functions[self.data.type]["insert"](self, row, tablex)
	return self
end
tridentlib("META::function", "database", "Insert", Insert)

function Update(self, row)
	_tridentlib.Database.Functions[self.data.type]["update"](self, row)
	return self
end
tridentlib("META::function", "database", "Update", Update)

function Values(self, row)
	_tridentlib.Database.Functions[self.data.type]["values"](self, row)
	return self
end
tridentlib("META::function", "database", "Values", Values)

function Set(self, data)
	_tridentlib.Database.Functions[self.data.type]["set"](self, data)
	return self
end
tridentlib("META::function", "database", "Set", Set)

function Select(self, row)
	_tridentlib.Database.Functions[self.data.type]["select"](self, row)
	return self
end
tridentlib("META::function", "database", "Select", Select)

function From(self, gtable)
	_tridentlib.Database.Functions[self.data.type]["from"](self, gtable)
	return self
end
tridentlib("META::function", "database", "From", From)

function Where(self, ...)
	_tridentlib.Database.Functions[self.data.type]["where"](self, ...)
	return self
end
tridentlib("META::function", "database", "Where", Where)

function First(self, ...)
	return _tridentlib.Database.Functions[self.data.type]["first"](self)
end
tridentlib("META::function", "database", "First", First)

function Get(self)
	return _tridentlib.Database.Functions[self.data.type]["first"](self)
end
tridentlib("META::function", "database", "Get", Get)

/*
local Database = tridentlib("META::get", "database")
Database.data.type = "sqlite"
print("----------------------------------------")

PrintTable(Database:Select("name"):From("money_table"):Where("steamid", "no"):Dump())

local data = {
	["name"] = "my name",
	["lastname"] = "my last name"
}
PrintTable(Database:Insert("name", data):Values(data):Dump())
PrintTable(Database:Update("name", data):Where("name", "my name"):Set(data):Dump())

//PrintTable(Database:Type("mysql"):From("money_table"):Where("steamid", "no"):Dump()) <-- mysql functions not defined

print("----------------------------------------")
*/