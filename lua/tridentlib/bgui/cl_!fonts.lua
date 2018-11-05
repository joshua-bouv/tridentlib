--[[tridentlib
  "name": "GUI::Fonts",
  "priority": 5
--tridentlib]]

hook.Add("InitPostEntity", "testfontCreateFonts", function()
	for i = 0, 100 do
		surface.CreateFont("BlueprintFontEvents" .. i, {font = "Roboto Lt", size = i, weight = 250, antialias = true})
	end
end)

surface.CreateFont( "eventsCountdowm", {
	font = "Roboto Medium",
	size = 200,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "eventsCrossFont", {
	font = "Roboto Medium",
	size = 35,
	weight = 600,
	antialias = true,
} )

surface.CreateFont( "eventsTitleFontBold", {
	font = "Roboto Medium",
	size = 25,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "eventsTitleFont", {
	font = "Roboto Lt",
	size = 25,
	weight = 250,
	antialias = true,
} )

surface.CreateFont( "eventsSideBarFont", {
	font = "Roboto Lt",
	size = 20,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "eventsTextLargeFont", {
	font = "Roboto Lt",
	size = 20,
	weight = 250,
	antialias = true,
} )

surface.CreateFont( "eventsTextMidFont", {
	font = "Roboto Lt",
	size = 18,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "eventsTickFont", {
	font = "Roboto Lt",
	size = 18,
	weight = 100,
	antialias = true,
} )

surface.CreateFont( "eventsTopBarFont", {
	font = "Roboto Lt",
	size = 17,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "eventsTopBarFontSkinny", {
	font = "Roboto Lt",
	size = 17,
	weight = 250,
	antialias = true,
} )

surface.CreateFont( "eventsTextFontThick", {
	font = "Roboto Lt",
	size = 15,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "eventsTextFont", {
	font = "Roboto Lt",
	size = 15,
	weight = 250,
	antialias = true,
} )

surface.CreateFont( "eventsSmallTextFont", {
	font = "Roboto Lt",
	size = 13,
	weight = 250,
	antialias = true,
} )

surface.CreateFont( "eventsTextFontSmall", {
	font = "Roboto Lt",
	size = 11,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "eventsExtraSmallTextFont", {
	font = "Roboto Lt",
	size = 10,
	weight = 250,
	antialias = true,
} )