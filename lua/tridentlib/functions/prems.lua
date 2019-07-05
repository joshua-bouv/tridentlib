--[[tridentlib
  "name": "Prems Module",
  "state": "Shared"
--tridentlib]]

_tridentlib.Prems = {}
_tridentlib.PremsL = {
    Usergroup = function(ply, dat)
        if ply:GetUserGroup() == dat then
            return true
        end
    end,
    SteamID = function(ply, dat)
        if ply:SteamID() == dat then
            return true
        end
    end,
    SteamID64 = function(ply, dat)
        if ply:SteamID64() == dat then
            return true
        end
    end
}

local function CreatePrems(addon, prems)
   _tridentlib.Prems[addon] = prems
end
tridentlib("DefineFunction", "PREMS::Create", CreatePrems )

local function Can(self, addon, prem)
    for k,v in pairs(_tridentlib.Prems[addon][prem]) do
        if _tridentlib.PremsL[v[2]](self, v[1]) then
            return true
        end
    end
    return false
end
tridentlib("DefineFunction", "PREMS::Can", Can, {"Player"} )

/*
Prems = {
  OpenMenu = {
    { "76561198070703762", "SteamID64" },
    { "Superadmin", "Usergroup" },
  }
}

if SERVER then
    tridentlib("PREMS::Create", "Ares", Prems )

    concommand.Add("dev2", function(ply)
        local dat = ply:tridentlib("PREMS::Can", "Ares", "OpenMenu" )
        print(dat)
    end)

end
*/




