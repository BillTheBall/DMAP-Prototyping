-- Sprite Static
local Static_Sprite = {}
Static_Sprite.__index = Static_Sprite

function Static_Sprite.Create(x, y, image_path)
  local sprite = setmetatable({}, Static_Sprite)

  sprite.origin = { x = x, y = y}
  sprite.image = love.graphics.newImage(image_path)

  return sprite
end

function Static_Sprite:Draw(position)
  love.graphics.draw(self.image, position.x + self.origin.x, position.y + self.origin.y)
end

return {
  Static_Sprite = Static_Sprite
}