local Velocity = {}
Velocity.__index = Velocity

function Velocity.Create()
  local self = setmetatable({}, Velocity)

  self.speed = { x = 0, y = 0 }
  self.direction = { x = 0, y = 0 }

  return self
end

function Velocity:Apply_Speed(position, dt)
  position.x = position.x + self.speed.x * dt
  position.y = position.y + self.speed.y * dt
end


return Velocity