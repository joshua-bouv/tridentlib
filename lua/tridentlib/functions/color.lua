--[[tridentlib
  "name": "Color Module",
  "state": "Client",
  "priority": 1
--tridentlib]]

_tridentlib.Theme = {}
_tridentlib.Themes = {}
_tridentlib.ThemeFallback = {}

local function GetTheme(addon)
    if _tridentlib.Theme[addon] then
        if _tridentlib.Themes[addon][_tridentlib.Theme[addon]] then
            return _tridentlib.Themes[addon][_tridentlib.Theme[addon]]
        else
            if _tridentlib.Themes[_tridentlib.ThemeFallback[addon]] then
                return _tridentlib.ThemeFallback[_tridentlib.Theme[addon]]
            else
                error("Theme and fallback theme failed.")
            end
        end
    else
        error("Requested addon does not have a theme.")
    end
end
tridentlib("DefineFunction", "THEME::Get", GetTheme )

local function CreateTheme(addon, theme, fallback)
    if fallback then
        if !_tridentlib.Theme[addon] then
            _tridentlib.Theme[addon] = fallback
        end
        if !_tridentlib.ThemeFallback[addon] then
            _tridentlib.ThemeFallback[addon] = fallback
        end
    end
    for k,v in pairs(theme) do
        _tridentlib.Themes[addon] = {}
        _tridentlib.Themes[addon][k] = v
    end
end
tridentlib("DefineFunction", "THEME::Create", CreateTheme )

local function SetTheme(addon, theme)
    if _tridentlib.Theme[addon] then
        if _tridentlib.Themes[addon] then
            if _tridentlib.Themes[addon][theme] then
                _tridentlib.Theme[addon] = theme
            end
        end
    end
end
tridentlib("DefineFunction", "THEME::Set", SetTheme )

local function GetThemes(addon)
    if _tridentlib.Theme[addon] then
        if _tridentlib.Themes[addon] then
            return _tridentlib.Themes[addon]
        end
    end
end
tridentlib("DefineFunction", "THEME::GetAll", GetThemes )

local function ApplyTheme(self, addon)

    local function apply(theme)
        local pnt = self.Paint
        self.Paint = function(self, w, h)
            pnt(self, w, h, theme)
        end
    end
    if self then
        apply(tridentlib("THEME::Get", addon))
    end
end
tridentlib("DefineFunction", "THEME::Apply", ApplyTheme )

// MISC
local function LerpColor(frac, from, to)
    local col = Color(
        Lerp(frac, from.r, to.r),
        Lerp(frac, from.g, to.g),
        Lerp(frac, from.b, to.b),
        Lerp(frac, from.a, to.a)
    )

    return col
end
tridentlib("DefineFunction", "LerpColor", LerpColor )

local function LerpTransparency(frac, from, to)
    local col = Color(
        from.r,
        from.g,
        from.b,
        Lerp(frac, from.a, to.a)
    )

    return col
end
tridentlib("DefineFunction", "LerpTransparency", LerpTransparency  )

/*
tridentlib("THEME::Create", "Test", {
    Default = {
        Dashboard = {
            Background = Color(255,0,0)
        }
    },
    TransparentDashboard = {
        Dashboard = {
            Background = Color(255,0,0,100)
        }
    }
}, "Default")
*/

/*
concommand.Add("dev", function()
    local DermaPanel = vgui.Create( "DFrame" )
    DermaPanel:SetPos( 100, 100 )
    DermaPanel:SetSize( 300, 200 )
    DermaPanel:SetTitle( "My new Derma frame" )
    DermaPanel:SetDraggable( true )
    DermaPanel:MakePopup()
    DermaPanel.Paint = function(_, w, h, theme)
        draw.RoundedBox(0,0,0,w,h,theme.Dashboard.Background)
    end
    DermaPanel:tridentlib("THEME::Apply", "Test")
end)
*/