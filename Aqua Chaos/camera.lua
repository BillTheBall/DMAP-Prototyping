Camera = {}
Camera.__index = Camera

function Camera.Create(x, y, zoom)
  local self = setmetatable({}, Camera)

  local Cam = require 'lib.camera'

  self.cam = Cam(x, y)
  self.cam:zoom(zoom)

  return self
end

return Camera