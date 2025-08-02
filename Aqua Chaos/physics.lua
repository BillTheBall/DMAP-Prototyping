local Physics = {}
Physics.__index = Physics

function Physics.Create()
  local self = setmetatable({}, Physics)

    self.topSpeed = 0
    self.acceleration = 0
    self.deceleration = 0

  return self
end

function Physics:Switch(new_physics)
  self.topSpeed = new_physics[1]
  self.acceleration = new_physics[2]
  self.deceleration = new_physics[3]
end

function Physics:Accelerate(velocity, dt)
  -- Decelerate before switching directions
  if velocity.speed * velocity.direction < 0 then
    self:Decelerate(velocity, dt)
  
  -- Normal acceleration
  elseif velocity.speed * velocity.direction < self.topSpeed then
    velocity.speed = velocity.speed + self.acceleration * velocity.direction * dt
  
  -- Top Speed
  else
    velocity.speed = self.topSpeed * velocity.direction
  end
end

function Physics:Decelerate(velocity, dt)
  -- Deceleration X Axis
  if velocity.speed * velocity.direction > 0 then
    if
      velocity.speed < 0 and velocity.speed + self.deceleration * velocity.direction * dt > 0 or
      velocity.speed > 0 and velocity.speed + self.deceleration * velocity.direction * dt < 0
      then
      velocity.speed = 0
    else 
      velocity.speed = velocity.speed - self.deceleration * velocity.direction * dt
    end
  else
    velocity.speed = 0
  end
end

return Physics