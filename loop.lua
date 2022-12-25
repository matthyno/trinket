clearScreen()
KC = true
function startsWith(str, with) 
  isone, _ = string.find(str, with) 
  return isone == 1
end
function checkMatch(c) 
  if startsWith(c,"shutdown") then
    computer.shutdown(false)
  end
  if startsWith(c,"restart") or startsWith(c,"reboot") then
    computer.shutdown(true)
  end
  if startsWith(c, "edit") then
    loadfile("texteditor.lua")()
  end
  if startsWith(c, "run ") then
    nl()
    x=1
    loadfile(string.sub(c, 5, #c))()
    
    nl()
  end
end
cmd = ""
while (1)
do
  local e, addr, char, code = computer.pullSignal()
  if(code == 0x2A) then
    KC = not KC
  end
  if(code == 0x0E) then
    buffer = buffer:sub(1,#buffer-1)
    clearScreen()
    printBuffer(buffer)
  end
  if(e == 'key_down' and not KC)
  then
    if(not (cey[code] == nil)) then
      buffer = buffer .. cey[code]
      printf(cey[code])
    end    
  
  end
  if(e == 'key_down' and KC)
  then
    if(code == 0x1C)
    then
      cmd = buffer
      buffer = ""
      checkMatch(cmd)
      x = 1
    end
    if (not (code == 0x40 or code == 0x41 or code == 0x44 or code == 0x58)) then
      buffer = buffer .. key[code]
    end
    if(math.fmod(x,w) == 0)
    then
      y = y  + 1
      x = 1
    end
    if(y>h)
    then
      clearScreen()
      y = 2
      x = 1
    end
    if(not (code == 0x1C or code == 0x40 or code == 0x41 or code == 0x44 or code == 0x58)) then
      printf(key[code])
    end
  end
  ::continue::
end
