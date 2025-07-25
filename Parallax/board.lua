local Tile = require 'tile'
local Matrix = require 'matrix'

local Board = {}
Board.__index = Board

function Board.Create(width, height, external, size, x, y)
    local self = setmetatable({}, Board)
    
    self.width = width or 0
    self.height = height or 0
    self.external = external or 0
    self.size = size or 0
    self.x = x or 0
    self.y = y or 0

    self.matrix = Matrix.Create()
    self.tiles = {}

    for x = external, self.width - 1 + external do
        for y = external, self.height - 1 + external do
            local tile = Tile.Create(x, y)
            table.insert(self.tiles, tile)
            self.matrix:set(x, y, tile)
        end
    end

    return self
end

function Board:draw()
    for i = 1, #self.tiles do
        local tile = self.tiles[i]
        local mode = 'line'
        if tile.side == 1 then
            mode = 'fill'
        end
        if tile.side ~= -1 then
            love.graphics.rectangle(mode, tile.x * self.size + self.x, tile.y * self.size + self.y, self.size, self.size)
        end
        love.graphics.print(tile.x .. ' ' .. tile.y, tile.x * self.size + self.x, tile.y * self.size + self.y)
    end
    love.graphics.rectangle('line', self.x, self.y, (self.width + self.external * 2) * self.size, (self.height + self.external * 2) * self.size)
end

function Board:pixeltocoord(x, y)
    return {x = math.floor((x - self.x) / self.size), y = math.floor((y - self.y) / self.size)}
end

function Board:get(x, y)
    return self.matrix:get(x, y)
end

function Board:move(x, y)
    self.x = self.x + x
    self.y = self.y + y
end

function Board:pos(x, y)
    self.x = x
    self.y = y
end

function Board:size(size)
    self.size = size
end

function Board:remove(x, y)
    self.matrix:set(x, y, nil)
end

function Board:set(x, y, value)
    local tile = self.matrix:get(x, y)
    if tile ~= nil then
        tile.side = value
    end
end

function Board:reverse(x, y)
    local tile = self.matrix:get(x, y)
    if tile.side ~= -1 then
        tile.side = 1 - tile.side
    end
end

function Board:update()
    for x = 0, self.width + self.external do
        local count = 0
        local current = 1
        for y = 0, self.height + self.external do
            local tile = self:get(x, y)
            if (tile == nil) or (tile.side == -1) then
                count = 0
            else
                if tile.side == current then
                    count = count + 1
                    if count > 5 then
                        return 'win'
                    end
                else
                    count = 1
                    current = tile.side
                end
            end
        end
    end

    for y = 0, self.height + self.external do
        local count = 0
        local current = 1
        for x = 0, self.width + self.external do
            local tile = self:get(x, y)
            if (tile == nil) or (tile.side == -1) then
                count = 0
            else
                if tile.side == current then
                    count = count + 1
                    if count > 5 then
                        return 'win'
                    end
                else
                    count = 1
                    current = tile.side
                end
            end
        end
    end

    return 'play'
end

return Board

--[[function Board:getcoord(x, y)
    return self.matrix:get(x, y)
end

function Board:getpixel(x, y)
    local p = self:pixeltocoord(x, y)
    return self:getcoord(p.x, p.y)
end
function Board:getpixel(x, y)
    for i = 1, #self.tiles do
        local tile = self.tiles[i]
        local tx = self.x + tile.x * self.size
        local ty = self.y + tile.y * self.size
        local range = self.size / 2

        if math.abs(x - tx - range) < range and math.abs(y - ty - range) < range then
            return tile
        end
    end

    return nil
end

function Board:setpixel(x, y, value)
    local p = self:pixeltocoord(x, y)
    self:setcoord(p.x, p.y, value)
end

function Board:setcoord(x, y, value)
    local tile = self:getcoord(x, y)
    if tile ~= nil then
        tile.side = value
    end
end]]
