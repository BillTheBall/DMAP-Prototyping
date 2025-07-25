local Tile = require 'tile'

local Board = {}
Board.__index = Board

function Board.Create(x, y, sx, sy)
    local self = setmetatable({}, Board)
    
    self.x = x or 0
    self.y = y or 0
    self.sx = sx or 0
    self.sy = sy or 0

    self.tiles = {}

    for tx = 1, self.sx do
        for ty = 1, self.sy do
            local tile = Tile.Create(tx + self.x, ty + self.y)
            table.insert(self.tiles, tile)
        end
    end

    return self
end

return Board
