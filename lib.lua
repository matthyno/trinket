function require(name)
  loadfile(name .. ".lua")()
end
function savetolua(name)
  local f = component.filesystem.open("script-" .. tostring(#buffer) .. ".lua", "w")
  component.filesystem.write(f, buffer)
  component.filesystem.close(f)
end
