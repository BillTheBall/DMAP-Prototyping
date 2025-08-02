local Player = {}
Player.__index = Player

function Player.Create(draw, velocity, physics, collision)
  local self = setmetatable({}, Player)

  -- Variables
  self.box = { x = 0, y = -16, w = 8, h = 16}

  self.sprite = draw.Static_Sprite.Create(-4, -1, "assets/png/dino.png")

  self.velocity = {}
    self.velocity.x = {}
      self.velocity.x.speed = 0
      self.velocity.x.direction = 0
    self.velocity.y = {}
      self.velocity.y.speed = 0
      self.velocity.y.direction = 0

  self.physics = {}
    self.physics.x = physics.Create()
    self.physics.y = physics.Create()

    self.physics.walking = { 200, 1500, 1800 }
    self.physics.gravity = { 200, 700, 800 }
    self.physics.jump = { 400, 700, 800 }

  -- Setup
  collision.world:add(
      self.box,
      self.box.x,
      self.box.y,
      self.box.w,
      self.box.h
    )

  self.physics.x:Switch(self.physics.walking)
  self.physics.y:Switch(self.physics.gravity)
  
  return self
end

return Player