-- Collider
local Collider = {}
Collider.__index = Collider

function Collider.Create_Static(collision_manager, x, y, w, h, position)
  local self = setmetatable({}, Collider)

  self.box = { x = x, y = y, w = w, h = h }
  table.insert(collision_manager.colliders.static, {collider = self.box, position = position})

  return self
end

function Collider.Create_Dynamic(collision_manager, x, y, w, h, position)
  local self = setmetatable({}, Collider)

  self.box = { x = x, y = y, w = w, h = h }
  table.insert(collision_manager.colliders.dynamic, {collider = self.box, position = position})

  return self
end

function Collider:Draw(cam, position)
  x, y = cam:cameraCoords(position.x + self.box.x, position.y + self.box.y)
  love.graphics.rectangle("line", x, y, self.box.w * cam.scale, self.box.h * cam.scale)
end

return Collider