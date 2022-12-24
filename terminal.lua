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
  component.gpu.set(1,1,"trinket v0.1.0 | f12 shutdown | f6 run | f7 save")
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
