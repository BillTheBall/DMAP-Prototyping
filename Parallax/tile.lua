local Tile = {}
Tile.__index = Tile

function Tile.Create(visible)
    local self = setmetatable({}, Tile)
    
    self.visible = visible or false
    self.player = -1
    self.hover = false

    return self
end

return Tile
