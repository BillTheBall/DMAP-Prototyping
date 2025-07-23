local Controls = {}

function Controls.Player(player, dt)
  local isLeft = love.keyboard.isDown("left")
  local isRight = love.keyboard.isDown("right")

  if isLeft and isRight then
    player.walking:Decelerate(player.velocity, dt)
    player.velocity:Apply_Speed(player.position, dt)
  elseif isLeft then
    player.velocity.direction.x = -1
    player.walking:Accelerate(player.velocity, dt)
    player.velocity:Apply_Speed(player.position, dt)
  elseif isRight then
    player.velocity.direction.x = 1
    player.walking:Accelerate(player.velocity, dt)
    player.velocity:Apply_Speed(player.position, dt)
  else
    player.walking:Decelerate(player.velocity, dt)
    player.velocity:Apply_Speed(player.position, dt)
  end
end

function Controls.Main(player, dt)
  Controls.Player(player, dt)
end

return Controls