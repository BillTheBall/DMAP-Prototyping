local Controls = {}

function Controls.Player(player, collision, dt)
  local isLeft = love.keyboard.isDown("left")
  local isRight = love.keyboard.isDown("right")

  if isLeft and isRight then
    player.physics.x:Decelerate(player.velocity.x, dt)
  elseif isLeft then
    player.velocity.x.direction = -1
    player.physics.x:Accelerate(player.velocity.x, dt)
  elseif isRight then
    player.velocity.x.direction = 1
    player.physics.x:Accelerate(player.velocity.x, dt)
  else
    player.physics.x:Decelerate(player.velocity.x, dt)
  end

  player.velocity.y.direction = 1
  player.physics.y:Accelerate(player.velocity.y, dt)

  -- Change position based on speed
  local move_x = player.box.x + player.velocity.x.speed * dt
  local move_y = player.box.y + player.velocity.y.speed * dt
  
  -- Move, check colliders, set new position
  local new_x, new_y = collision.world:move(player.box, move_x, move_y)
  player.box.x = new_x
  player.box.y = new_y
end

function Controls.Main(player, collision, dt)
  Controls.Player(player, collision, dt)
end

return Controls