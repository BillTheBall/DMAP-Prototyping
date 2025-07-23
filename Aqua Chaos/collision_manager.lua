-- Collision Manager
local Collision_Manager = {}
Collision_Manager.__index = Collision_Manager

function Collision_Manager.Create()
  local self = setmetatable({}, Collision_Manager)

  self.colliders = {}
  self.colliders.dynamic = {}
  self.colliders.static = {}

  return self
end

function Collision_Manager.AABB_Check(collider_a, position_a, collider_b, position_b)
  local ax, ay, aw, ah = position_a.x + collider_a.x, position_a.y + collider_a.y, collider_a.w, collider_a.h
  local bx, by, bw, bh = position_b.x + collider_b.x, position_b.y + collider_b.y, collider_b.w, collider_b.h

  return (
    ax < bx + bw and
    ax + aw > bx and
    ay < by + bh and
    ay + ah > by
  )
end

function Collision_Manager:Collision_Check(collider_box, position)
  -- Given a collider and a position, it check with all of the STATIC colliders

  for i, collider in ipairs(self.colliders.static) do
    if self.AABB_Check(collider_box, position, self.colliders.static[i].collider, self.colliders.static[i].position) then
      love.graphics.print("COLLISION", 200, 10)
    end
  end
end

return Collision_Manager