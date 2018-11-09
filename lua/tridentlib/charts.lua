--[[tridentlib
  "name": "Charts Module",
  "state": "Disabled"
--tridentlib]]

local cos, sin, abs, max, rad1, log, pow = math.cos, math.sin, math.abs, math.max, math.rad, math.log, math.pow

// LINE
local function CreateLine(self, x, y, xto, zto, w )

end
tridentlib("DefineFunction", "CHART::CreateLine", CreateLine)


// ARC
local function CreateArc(cx,cy,radius,thickness,startang,endang,roughness,color)
	surface.SetDrawColor(color)
	surface.DrawArc(surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness))
end
tridentlib("DefineFunction", "CHART::CreateArc", CreateArc)

// ARC
local function DrawArc( arc )
	for k,v in ipairs(arc) do
		surface.DrawPoly(v)
	end
end
tridentlib("DefineFunction", "CHART::DrawArc", DrawArc)

// ARC
local function CreateArc(cx,cy,radius,thickness,startang,endang,roughness)
	local triarc = {}
	-- local deg2rad = math.pi / 180
	
	-- Define step
	local roughness = math.max(roughness or 1, 1)
	local step = roughness
	
	-- Correct start/end ang
	local startang,endang = startang or 0, endang or 0
	
	if startang > endang then
		step = math.abs(step) * -1
	end
	
	-- Create the inner circle's points.
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*r), cy+(-math.sin(rad)*r)
		table.insert(inner, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end	
	
	-- Create the outer circle's points.
	local outer = {}
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*radius), cy+(-math.sin(rad)*radius)
		table.insert(outer, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end	
	
	-- Triangulize the points.
	for tri=1,#inner*2 do -- twice as many triangles as there are degrees.
		local p1,p2,p3
		p1 = outer[math.floor(tri/2)+1]
		p3 = inner[math.floor((tri+1)/2)+1]
		if tri%2 == 0 then --if the number is even use outer.
			p2 = outer[math.floor((tri+1)/2)]
		else
			p2 = inner[math.floor((tri+1)/2)]
		end
	
		table.insert(triarc, {p1,p2,p3})
	end
	
	-- Return a table of triangles to draw.
	return triarc
end
tridentlib("DefineFunction", "CHART::CreateArc", CreateArc)


// MAIN CHARTS
local function CreateChart(self, type, data)

end
tridentlib("DefineFunction", "CHART::CreateChart", CreateChart)

/*
hook.Add("HUDPaint", "asdasd", function()
	draw.NoTexture()

	tridentlib("CHART::CreateArc", 
		500, 500,
		50 + math.sin( CurTime() ) * 25, // radius
		15 + math.cos( CurTime() ) * 10, // thickness
		180 + math.cos( CurTime() ) * 45, // start angle indeg360 + math.cos( CurTime() ) * 45, // end angle indeg ( must be lower than start ang )
		0, // roughness
		color_white 
	)
	
	draw.Arc( 500, 500,
		50 + math.sin( CurTime() ) * 25, // radius
		15 + math.cos( CurTime() ) * 10, // thickness
		180 + math.cos( CurTime() ) * 45, // start angle indeg360 + math.cos( CurTime() ) * 45, // end angle indeg ( must be lower than start ang )
		math.sin( CurTime() ) * 50, // roughness
		HSVToColor( (CurTime() * 100 ) % 360, 1, 1 ) )
	
end )
*/