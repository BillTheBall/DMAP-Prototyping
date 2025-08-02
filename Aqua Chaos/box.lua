local Box = {}
Box.__index = Box

function Box.Create(x, y, w, h, collision)
  local self = setmetatable({}, Box)
  
  self.box = { x = x, y = y, w = w, h = h }
  collision.world:add(
    self.box,
    self.box.x,
    self.box.y,
    self.box.w,
    self.box.h
  )

  return self
end

return Box