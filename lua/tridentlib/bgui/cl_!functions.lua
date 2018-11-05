--[[tridentlib
  "name": "GUI::Functions",
  "priority": 1
--tridentlib]]

header = Color(3, 169, 244, 255)
backGround = Color(255, 255, 255, 255)
snackbarBackGround = Color(50, 50, 50, 255)
blackBackGround = Color(50, 50, 50, 255)
fade = Color(0, 0, 0, 100)
fade5 = Color(0, 0, 0, 75)
fade2 = Color(0, 0, 0, 50)
fade3 = Color(0, 0, 0, 25)
fade4 = Color(0, 0, 0, 12.5)
titleText = Color(100, 100, 100, 255)
whiteText = Color(255, 255, 255, 255)
redText = Color(255, 82, 82, 255)
redTextTrans = Color(255, 82, 82, 150)
greenText = Color(76, 175, 80, 255)
brightGreenText = Color(46, 204, 113, 255)
blueText = Color(68, 138, 255, 255)
blueTextTrans = Color(68, 138, 255, 150)
lightBlueText = Color(98, 168, 255, 255)
lightBackground = Color(235, 235, 235, 255)
snackbarBackGround = Color(50, 50, 50, 255)

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