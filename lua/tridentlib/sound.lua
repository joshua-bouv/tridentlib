--[[tridentlib
  "name": "Sound Module",
  "state": "Client"
--tridentlib]]

// Youtube Engine
if !videotable then videotable = {} end
local function Youtube_Play(url, vol)
  http.Fetch("https://tridentcom.xyz/dashboard/html/class/api/youtubeplayer.php?id="..url, function(result) 
    local sval, eval = string.find(result, "<div", 0)
    if !sval then
      print(result)
    return end
  end)
  local n = table.Count(videotable)
  videotable[n] = vgui.Create( "DFrame" )
  videotable[n]:SetVisible( false )
  videotable[n].DHTML = vgui.Create( "DHTML" , videotable[n] )
  videotable[n].DHTML:SetAllowLua(true)
  videotable[n].DHTML:OpenURL("https://tridentcom.xyz/dashboard/html/class/api/youtubeplayer.php?vol="..data["vol"].."&tbl=videotable&vid="..n.."&id="..data["url"])
  videotable[n].DHTML.ConsoleMessage = function( msg, file, line )
    if !isstring(msg) then return end
    if !string.StartWith(msg, "RUNLUA:") then return end
  end
end
tridentlib("DefineFunction", "Youtube_Play", Youtube_Play )

local function YouTube_GetTable(id) 
  if !videotable then return end
  if id then
    videotable[id]:Remove() 
  else
    for k, v in pairs (videotable) do 
      if v then 
        v:Remove() 
      end
    end
  end
end

function yt_get() 
  return videotable
end

tridentlib("DefineFunction", "YouTube_GetTable", YouTube_GetTable )