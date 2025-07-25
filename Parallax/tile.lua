local Tile = {}
Tile.__index = Tile

function Tile.Create(x, y, side, mutation)
    local self = setmetatable({}, Tile)
    
    self.x = x or 0
    self.y = y or 0
    self.side = side or 0
    self.mutation = mutation or 0

    return self
end

return Tile
