--[[tridentlib
  "name": "Image Module",
  "state": "Client"
--tridentlib]]


_tridentlib.IMG = {}

function _tridentlib.IMG.setupFolders()
 file.CreateDir("tridentlib", "DATA")
 file.CreateDir("tridentlib/images", "DATA")
 file.Write("tridentlib/images/cache.dat", "{}")
 _tridentlib.IMG.AddMissing()
end

function _tridentlib.IMG.AddMissing()
	http.Fetch("https://upload.wikimedia.org/wikipedia/commons/b/b1/Missing-image-232x150.png",function(data)
			file.Write("tridentlib/images/missing.png", data)
	end)
	http.Fetch("http://www.kraigbrockschmidt.com/wp-content/uploads/2013/01/splash-screen-1.png",function(data)
			file.Write("tridentlib/images/loading.png", data)
	end)
	http.Fetch("https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Fucktext.svg/2000px-Fucktext.svg.png",function(data)
			file.Write("tridentlib/images/failed.png", data)
	end)
end

function _tridentlib.IMG.ValidateSetup()
  if not file.IsDir( "tridentlib", "DATA") then return _tridentlib.IMG.setupFolders() end
  if not file.IsDir( "tridentlib/images", "DATA") then return _tridentlib.IMG.setupFolders() end
  if not file.Exists( "tridentlib/images/cache.dat", "DATA") then return _tridentlib.IMG.setupFolders() end
  if not file.Exists( "tridentlib/images/missing.png", "DATA") then return _tridentlib.IMG.AddMissing() end
end


function _tridentlib.IMG.checkURL(url)
	bstart, bend = string.find(url,".png", 1)
		if bstart then return ".png" end
    astart, aend = string.find(url,".jpg", 1)
    	if astart then return ".jpg" end
    cstart, cend = string.find(url,".vtf", 1)
    	if cstart then return ".vtf" end
    return false
end

function _tridentlib.IMG.GetImage(url)
	_tridentlib.IMG.ValidateSetup()
	local cache = util.JSONToTable(file.Read("tridentlib/images/cache.dat", "DATA"))
	if !cache then _tridentlib.IMG.setupFolders() end
	for k, v in pairs(cache) do
		if v["url"] == url then
			return v["img"]
		end
	end

	http.Fetch(url,function(data)
		local ucheck = _tridentlib.IMG.checkURL(url)
		if ucheck then
			local tag = table.Count(cache)
			table.insert(cache, {img = "../data/tridentlib/images/img"..tag..ucheck, url = url})
			file.Write("tridentlib/images/img"..tag..ucheck, data)
			file.Write("tridentlib/images/cache.dat", util.TableToJSON(cache))
			return "../data/tridentlib/images/img"..tag..ucheck
		else
			return "../data/tridentlib/images/missing.png"
		end
	end, function() 
		return "../data/tridentlib/images/missing.png" 
	end)
end

function _tridentlib.IMG.popCache()

end

function _tridentlib.IMG.popStore()

end

function _tridentlib.IMG.isDownloading()

end

function SetWebImage(self, url)
	local img = _tridentlib.IMG.GetImage(url)
	if img then
		self:SetImage(img)
	else
		self:SetImage("../data/tridentlib/images/loading.png")
		local count = 1
		local function restart()
			timer.Simple(1,function()
				local image = tridentlib.IMG.GetImage(url)
				if !image then
					count = count + 1
					if count >= 10 then
						print("failed")
						self:SetImage("../data/tridentlib/images/failed.png")
						return
					end
					restart()
				else
					self:SetImage(image)
					return
				end
			end)
		end
		restart()
	end
end
tridentlib("DefineFunction", "SetWebImage", SetWebImage, {"Panel"} )

function _tridentlib.IMG.WaitForImg(url)
	local count = 1
	local function restart()
		timer.Simple(1,function()
			print("loaded")
			if !_tridentlib.IMG.GetImage(url) then
				count = count + 1
				if count >= 10 then
					print("failed")
					return "../data/tridentlib/images/failed.png"
				end
				restart()
			else
				print("true")
				return true
			end
		end)
	end
	restart()
end