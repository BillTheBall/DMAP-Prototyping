local Player = {}
Player.__index = Player

function Player.Create(draw, velocity, physics, collision, collision_manager)
  local self = setmetatable({}, Player)

  self.position = { x = 0, y = 0 }

  self.sprite = draw.Static_Sprite.Create(-8, -17, "assets/png/dino.png")

  self.velocity = velocity.Create()
  self.walking = physics.Create(200, 0, 700, 0, 800, 0)

  self.collider = collision.Create_Dynamic(collision_manager, -4, -16, 8, 16, self.position)

  return self
end

return Player