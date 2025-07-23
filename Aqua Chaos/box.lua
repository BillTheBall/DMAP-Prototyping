local Box = {}
Box.__index = Box

function Box.Create(x, y, w, h, collider, collision_manager)
  local self = setmetatable({}, Box)
  
  self.position = { x = x, y = y}
  self.collider = collider.Create_Static(collision_manager, 0, 0, w, h, self.position)

  return self
end

return Box