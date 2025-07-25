local Tile = {}
Tile.__index = Tile

function Tile.Create(x, y, side)
    local self = setmetatable({}, Tile)
    
    self.x = x or 0
    self.y = y or 0
    self.side = side or -1

    return self
end

return Tile
