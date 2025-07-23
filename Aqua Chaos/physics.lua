local Physics = {}
Physics.__index = Physics

function Physics.Create(topSpeed_x, topSpeed_y, acceleration_x, acceleration_y, deceleration_x, deceleration_y)
  local self = setmetatable({}, Physics)

    self.topSpeed =     { x = topSpeed_x,     y = topSpeed_y }
    self.acceleration = { x = acceleration_x, y = acceleration_y }
    self.deceleration = { x = deceleration_x, y = deceleration_y }

  return self
end

function Physics:Accelerate(velocity, dt)
  -- Acceleration X Axis
    -- Decelerate before switching directions
    if velocity.speed.x * velocity.direction.x < 0 then
      self:Decelerate(velocity, dt)
    
    -- Normal acceleration
    elseif velocity.speed.x * velocity.direction.x < self.topSpeed.x then
      velocity.speed.x = velocity.speed.x + self.acceleration.x * velocity.direction.x * dt
    
    -- Top Speed
    else
      velocity.speed.x = self.topSpeed.x * velocity.direction.x
    end
  
  -- Acceleration Y Axis
    -- Decelerate before switching directions
    if velocity.speed.y * velocity.direction.y < 0 then
      self:Decelerate(velocity, dt)
    
    -- Normal acceleration
    elseif velocity.speed.y * velocity.direction.y < self.topSpeed.y then
      velocity.speed.y = velocity.speed.y + self.acceleration.y * velocity.direction.y * dt
    
    -- Top Speed
    else
      velocity.speed.y = self.topSpeed.y * velocity.direction.y
    end

end

function Physics:Decelerate(velocity, dt)
  -- Deceleration X Axis
    if velocity.speed.x * velocity.direction.x > 0 then
      if
        velocity.speed.x < 0 and velocity.speed.x + self.deceleration.x * velocity.direction.x * dt > 0 or
        velocity.speed.x > 0 and velocity.speed.x + self.deceleration.x * velocity.direction.x * dt < 0
        then
        velocity.speed.x = 0
      else 
        velocity.speed.x = velocity.speed.x - self.deceleration.x * velocity.direction.x * dt
      end
    else
      velocity.speed.x = 0
    end
  
  -- Deceleration Y Axis
    if velocity.speed.y * velocity.direction.y > 0 then
      velocity.speed.y = velocity.speed.y - self.deceleration.y * velocity.direction.y * dt
    else
      velocity.speed.y = velocity.speed.y + self.deceleration.y * velocity.direction.y * dt
    end

end

return Physics