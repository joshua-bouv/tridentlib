--[[tridentlib
  "name": "Math Module",
  "state": "Shared"
--tridentlib]]

local function beizerVector(points)
	tbl = {}
	numx = 0
	local function increase(num)
		if num <= 1 then
			table.insert(tbl, math.BSplinePoint( num, points, 1 ) )
			num = num + 0.001
			increase(num)
		else
			return
		end
	end
	increase(0)
	return tbl
end

tridentlib("DefineFunction", "MATH::beizerVector", beizerVector )

local function beizerPoly(points)
	tbl = {}
	numx = 0
	local function increase(num)
		if num <= 1 then
			local big = math.BSplinePoint( num, points, 1 )
			table.insert(tbl, { x = big[1], y = big[2] } )
			table.insert(tbl, { x = big[1], y = big[2]+5 } )
			num = num + 0.1
			increase(num)
		else
			return
		end
	end
	increase(0)
	return tbl
end

tridentlib("DefineFunction", "MATH::beizerPoly", beizerPoly )

local function SquareLine2Points(num)
	return num/2
end

tridentlib("DefineFunction", "MATH::QuickSplit|2Point", SquareLine2Points )

/*
hook.Add( "HUDPaint", "BSplinePointExample3", function()

	local startx = 10
	local starty = 10

	local endx = gui.MouseX()
	local endy = gui.MouseY()

	local pointcalc = tridentlib("MATH::QuickSplit|2Point", endx)

	surface.SetDrawColor(255,255,0)
	surface.DrawLine(startx,starty,endx,endy)

	// hypo top
	surface.SetDrawColor(0,100,100)
	surface.DrawLine(startx,starty,pointcalc,starty)

	// h to b
	surface.SetDrawColor(0,255,100)
	surface.DrawLine(pointcalc,starty,pointcalc,endy)

	// hypo bottom
	surface.SetDrawColor(255,100,100)
	surface.DrawLine(pointcalc*2,endy,pointcalc,endy)
end)



hook.Add( "HUDPaint", "BSplinePointExample", function()
	local points = { Vector( 100, 100, 0 ), Vector( 200, 200, 0 ), Vector( 300, 100, 0 ), Vector( gui.MouseX(), gui.MouseY(), 0 ) }
	
	local poly = tridentlib("MATH::beizerPoly", points)

	surface.SetDrawColor( 255, 0, 0, 255 )
	draw.NoTexture() 
	surface.DrawPoly( poly )

end )


hook.Add("HUDPaint", "BSplinePointExample2", function()
	local points = { Vector( 100, 100, 0 ), Vector( 200, 200, 0 ), Vector( 300, 100, 0 ), Vector( gui.MouseX(), gui.MouseY(), 0 ) }
	
	for k, v in pairs(tridentlib("MATH::beizerVector", points)) do
		//surface.DrawCircle(v.x - 2, v.y - 2,1, Color(255,0,0))
		draw.RoundedBox( 0, v.x - 2+200, v.y - 2 + 200, 4, 4, Color( 0, 0, 0 ) )
	end

end)
*/