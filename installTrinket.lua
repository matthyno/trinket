function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

local shell = require("shell")
local arg, ops = shell.parse(...) 
local internet = require("internet")
local fs = require("filesystem")
function readurl(url)
  r = ""
  for chunk in internet.request("https://" .. url) do r = r .. chunk end
  return tostring(r)
end
function saveUrlToFile(url, fn)
  local f = io.open(fn, "w")
  print("GET "..url)
  f:write(readurl(url))
  f:close()
end
print("Innstalling to " .. arg[1] .. "...")
saveUrlToFile("bit.ly/3PVn29N", arg[1] .. "/init.lua")
sleep(3)
saveUrlToFile("bit.ly/3FSOZuu", arg[1] .. "/keys.lua")
sleep(3)
saveUrlToFile("bit.ly/3YFKXOu", arg[1] .. "/lib.lua")
sleep(3)
saveUrlToFile("bit.ly/3YOWaws", arg[1] .. "/terminal.lua")
sleep(3)
saveUrlToFile("bit.ly/3YFL6Bw", arg[1] .. "/texteditor.lua")
sleep(3)
saveUrlToFile("bit.ly/3HXSpyv", arg[1] .. "/loop.lua")
print("Install should be done. Shutdown computer, remove OpenOS HDD, then boot up again!")
