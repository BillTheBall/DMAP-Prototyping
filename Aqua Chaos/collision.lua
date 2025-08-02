-- Collision Manager
local Collision = {}
Collision.__index = Collision

function Collision.Create()
  local self = setmetatable({}, Collision)

  local bump = require 'lib.bump'

  self.world = bump.newWorld(64)

  return self
end

return Collision