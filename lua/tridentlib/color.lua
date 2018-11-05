--[[tridentlib
  "name": "Color Module",
  "state": "Client"
--tridentlib]]

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