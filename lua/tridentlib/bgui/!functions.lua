--[[tridentlib
  "name": "Functions",
  "state": "Client",
  "priority": 2
--tridentlib]]


header = Color(3, 169, 244, 255)
backGround = Color(54, 57, 63, 255)
innerBackground = Color(32, 34, 37, 255)
alternativeBackground = Color(235, 235, 235, 255)
alternativeBackground2 = Color(215, 215, 215, 255)
alternativeBackground3 = Color(200, 200, 200, 255)

fade1 = Color(125, 125, 125, 12.5)
fade2 = Color(125, 125, 125, 25)
fade3 = Color(125, 125, 125, 50)
fade4 = Color(125, 125, 125, 75)
fade5 = Color(125, 125, 125, 100)

text = Color(255, 255, 255, 255)
whiteText = Color(255, 255, 255, 255)
blueText = Color(68, 138, 255, 255)
redText = Color(244, 67, 54, 255)
greenText = Color(76, 175, 80, 255)
lightBlueText = Color(98, 168, 255, 255)
orangeText = Color(243, 156, 18, 255)

white = Color(255, 255, 255, 255)
blue = Color(68, 138, 255, 255)
lightBlue = Color(98, 168, 255, 255)
red = Color(244, 67, 54, 255)
green = Color(76, 175, 80, 255)
black = Color(0, 0, 0, 255)
transparent = Color(0, 0, 0, 0)

blueTransparent = Color(68, 138, 255, 0)


----------------------
function drawCircle(x, y, r)
    local circle = {}

    for i = 1, 360 do
        circle[i] = {}
        circle[i].x = x + math.cos(math.rad(i * 360) / 360) * r
        circle[i].y = y + math.sin(math.rad(i * 360) / 360) * r
    end

    surface.DrawPoly(circle)
end

function createAvatar(player, parent, w, h, x, y)
    local avatar = vgui.Create("DPanel", parent)
        avatar:SetSize(w, h)
        avatar:SetPos(x, y)     
        avatar:TDLib()
            :CircleAvatar()
            :SetPlayer(player, w*2)
end

function drawSpecialCircle(x, y, r)
	local circle = {}

	for i = 1, 360 do
		circle[i] = {}
		circle[i].x = x + math.cos(math.rad(i * 360) / 360) * r
		circle[i].y = y + math.sin(math.rad(i * 360) / 360) * r
	end

	surface.DrawPoly(circle)
end

function LerpColor(frac, from, to)
    local col = Color(
        Lerp(frac, from.r, to.r),
        Lerp(frac, from.g, to.g),
        Lerp(frac, from.b, to.b),
        Lerp(frac, from.a, to.a)
    )

    return col
end

function LerpTransparency(frac, from, to)
    local col = Color(
        from.r,
        from.g,
        from.b,
        Lerp(frac, from.a, to.a)
    )

    return col
end

function AddDPanel(text)
    local DPanel = vgui.Create("DPanel")
        DPanel:SetSize(740, 50)
        DPanel.Paint = function(_, w, h) 
            surface.SetDrawColor(200, 200, 200, 255)
            surface.DrawLine(0, 48, w, 48)
            surface.DrawLine(0, 0, 0, h)
            surface.DrawLine(w-6, 0, w-6, h)
            draw.SimpleText(text, "eventsTextLargeFont", 0, h/2, titleText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

    return DPanel
end