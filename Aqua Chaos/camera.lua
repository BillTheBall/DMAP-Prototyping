Camera = {}
Camera.__index = Camera

function Camera.Create(x, y, zoom)
  local self = setmetatable({}, Camera)

  local Cam = require 'lib.camera'

  self.cam = Cam(x, y)
  self.cam:zoom(zoom)

  return self
end

function Camera:Draw_Box(box)
  x, y = self.cam:cameraCoords(box.x, box.y)
  love.graphics.rectangle("line", x, y, box.w * self.cam.scale, box.h * self.cam.scale)
end

return Camera