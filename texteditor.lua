clearScreen()
KC = true
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
      y = y + 1
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
    if(code == 0x40) then
      println("")
      println("Running the file " .. buffer .. ".lua on this HDD...")
      nl()
      loadfile(buffer .. ".lua")()
    end
    if(code == 0x41) then
      savetolua()
    end
    if(not (code == 0x1C or code == 0x40 or code == 0x41 or code == 0x44 or code == 0x58)) then
      printf(key[code])
    end
    if(code == 0x44 or code == 0x58)
    then
      clearScreen()
      break
    end
    component.gpu.set(w-(9+#tostring(y)+#tostring(x)),h,"editor L" .. tostring(y) .. "C" .. tostring(x))
  end
  ::continue::
end
