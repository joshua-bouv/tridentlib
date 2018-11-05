--[[tridentlib
  "name": "Base Module",
  "state": "Shared"
--tridentlib]]

_tridentlib.hookStore = {}

local function createUniqueHook(name)
	_tridentlib.hookStore[name] = _tridentlib.hookStore[name] or {}
	local count = #_tridentlib.hookStore[name]
	table.insert(_tridentlib.hookStore[name], { base = name, name = name..tostring(count)})
	return { base = name, name = name..tostring(count)}
end

tridentlib("DefineFunction", "createUniqueHook", createUniqueHook )


local function randTable(amount)
	local ret = {}
	for i = 0, amount do
		table.insert(ret, math.Rand(0,999999))
	end
	return ret
end

tridentlib("DefineFunction", "randTable", randTable)

local function mergeWithKey(key, tablex)
	local tbl = [[{"%s" = %s}]]
	local format = string.format(tbl, key, util.TableToJSON(tablex))
	return util.JSONToTable(format)
end
tridentlib("DefineFunction", "mergeWithKey", mergeWithKey)

local function getBasePanel(self)
	local tbl = {}
	local ret = nil
	local function loop(selfx)
		if selfx:GetParent() then
			table.insert(tbl,selfx)
			loop(selfx:GetParent())
		else
			ret = tbl[#tbl]
		end
	end

	if self:GetParent() then
		loop(self)
		return ret
	else
		return self
	end
end
tridentlib("DefineFunction", "getBasePanel", getBasePanel, {"Panel"})

local sin,cos,rad = math.sin,math.cos,math.rad;

function CirclePoly(x,y,radius,quality)
	local circle = {};
    for i=1,quality do
        circle[i] = {};
        circle[i].x = x + cos(rad(i*360)/quality)*radius;
        circle[i].y = y + sin(rad(i*360)/quality)*radius;
    end
    return circle;
end
tridentlib("DefineFunction", "CirclePoly", CirclePoly, {})