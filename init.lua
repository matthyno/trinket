setmetatable(component,{__index = function(_,k) return component.getPrimary(k) end})
fsaddr = component.invoke(component.list("eeprom")(), "getData")
local _component_primaries = {}
_component_primaries['filesystem'] = component.proxy(fsaddr)

function component.setPrimary(dev, addr)
  for k,v in component.list() do
    if k == addr and v == dev then
      _component_primaries[dev] = component.proxy(addr)
    end
  end
end

function component.getPrimary(dev)
  if _component_primaries[dev] == null then
    for k, v in component.list() do
      if v == dev then component.setPrimary(v,k) break end
    end
  end
  return _component_primaries[dev]
end
function haltwo()
  coroutine.yield(32)
end

read = function(handle) return component.filesystem.read(handle, math.huge) end

function readfile(fn)
  local f,err = component.filesystem.open(fn,"r")
  if not f then error(err) end
  local buf = ""
  repeat
    local d, err_r = read(f)
    if not data and err_r then error(err_r) end
    buf = buf .. (d or '')
  until not data
  component.filesystem.close(f)
  return buf
end 
 
function loadfile(file) 
  res, err = load(readfile(file), '=' .. file)
  if res then
    return res
  else
    error(err)
  end
end
y = 2
x = 1
function printf(s)
  component.gpu.set(x,y,s)
  x = x + #s
end
function nl()
  y = y + 1
end
function println(s)
  printf(s)
  nl()
end

w, h = component.gpu.getResolution()
function clearScreen()
  component.gpu.fill(1,2,w,h," ")
end
buffer = ""
x = 1
function printBuffer(buf)
  x = 1
  y = 2  
  for i = 1, #buf do
  local c = buf:sub(i,i)
    if ( c == "\n") then
      nl()
      x=1
    else
      printf(c)
    end
  
  end
end

function runfile(file, argc, args)
  local prog, err = readfile(file .. ".lua")
  if prog then
    local res = table.pack(xpcall(prog, function(...) return debug.traceback() end, argc, args))
    if res[1] then
      return table.unpack(res, 2, res.n)
    else
    end
  else
  end
end
loadfile("keys.lua")()
loadfile("lib.lua")()
loadfile("terminal.lua")()
loadfile("loop.lua")()
