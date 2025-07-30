local Matrix = require 'matrix'
local Tile = require 'tile'

---@class Board
local Board = {}
Board.__index = Board

---@param size number
---@param external number
---@param inline number
---@param scale number
---@param x number
---@param y number
---@param zoom number
---@param hover boolean
---@return Board
local function new(size, external, inline, scale, x, y, zoom, hover)
    local folder = 'images/board/'
    local mt = {
        x = x or 0, y = y or 0,
        size = size or 9, external = external or 1,
        scale = scale or 16,
        fullsize = (size or 9) + (external or 1) * 2,
        matrix = Matrix(),
        inline = inline or 6,
        zoom = zoom or 1,
        hover = hover or false,
        folder = folder,
        imageBase1 = love.graphics.newImage(folder..'Base1.png'),
        imageBase2 = love.graphics.newImage(folder..'Base2.png'),
        imageBase3 = love.graphics.newImage(folder..'Base3.png'),
        imageFloat = love.graphics.newImage(folder..'Float.png'),
        imageHover = love.graphics.newImage(folder..'Hover.png'),
        imageHoverFloat = love.graphics.newImage(folder..'HoverFloat.png'),
        imageDot = love.graphics.newImage(folder..'Dot.png'),
        imageCross = love.graphics.newImage(folder..'Cross.png')
    }

    for x = 0, mt.fullsize - 1 do
        for y = 0, mt.fullsize - 1 do
            local visible = (x >= mt.external and y >= mt.external and x < mt.fullsize - mt.external and y < mt.fullsize - mt.external)
            mt.matrix:set(x, y, Tile(visible))
        end
    end

    return setmetatable(mt, Board)
end

---@param dx number
---@param dy number
function Board:move(dx, dy)
    self.x, self.y = self.x + dx, self.y + dy
end

function Board:draw()
    love.graphics.scale(self.zoom, self.zoom)
    mx, my = self:toWorld(love.mouse.getX(), love.mouse.getY())
    for x = 0, self.fullsize - 1 do
        for y = 0, self.fullsize - 1 do
            local imgX = self.x / self.zoom + (x - self.fullsize / 2) * self.scale
            local imgY = self.y / self.zoom + (y - self.fullsize / 2) * self.scale
            local pattern = (x + y) % 2
            local tile = self.matrix:get(x, y)
            if tile.visible then
                if pattern == 0 then
                    tile:draw(self.imageBase3, imgX, imgY, self.scale)
                elseif pattern == 1 then
                    tile:draw(self.imageBase2, imgX, imgY, self.scale)
                elseif pattern  == 2 then
                    tile:draw(self.imageBase3, imgX, imgY, self.scale)
                end
                if self.hover and x == mx and y == my then
                    self.matrix:get(x, y):draw(self.imageHover, imgX, imgY, self.scale)
                end
                if tile.player == 1 then
                    tile:draw(self.imageDot, imgX, imgY, self.scale)
                elseif tile.player == 0 then
                    tile:draw(self.imageCross, imgX, imgY, self.scale)
                end
            else
                tile:draw(self.imageFloat, imgX, imgY, self.scale)
                if self.hover and x == mx and y == my then
                    self.matrix:get(x, y):draw(self.imageHoverFloat, imgX, imgY, self.scale)
                end
            end
        end
    end
    love.graphics.scale(1 / self.zoom, 1 / self.zoom)
end

---@param x number
---@param y number
---@return number, number
function Board:toWorld(x, y)
    return math.floor(((x - self.x) / self.zoom) / self.scale + self.fullsize / 2), math.floor(((y - self.y) / self.zoom) / self.scale + self.fullsize / 2)
end

---@param x number
---@param y number
---@param player number
---@return boolean
function Board:place(x, y, player)
    local tile = self.matrix:get(x, y)
    if tile ~= nil then
        if tile.player == -1 and tile.visible then
            tile.player = player
            return true
        end
    end
    return false
end

---@param x number
---@param y number
---@return boolean
function Board:flip(x, y)
    local tile = self.matrix:get(x, y)
    if tile ~= nil then
        if tile.visible and tile.player ~= -1 then
            tile.player = 1 - tile.player
            return true
        end
    end
    return false
end

---@param x number
---@param y number
---@return nil
function Board:get(x, y)
    return self.matrix:get(x, y)
end

---@param x number
---@param y number
---@param aspect string
---@param value nil
---@return boolean
function Board:set(x, y, aspect, value)
    local tile = self.matrix:get(x, y)
    if tile ~= nil then
        tile[aspect] = value
        return true
    end
    return false
end

---@param x number
---@param y number
---@return boolean
function Board:remove(x, y)
    local tile = self.matrix:get(x, y)
    if tile ~= nil then
        if tile.visible then
            tile.visible = false
            tile.player = -1
            return true
        end
    end
    return false
end

---@param x number
---@param y number
---@return boolean
function Board:clear(x, y)
    local tile = self.matrix:get(x, y)
    if tile ~= nil then
        if tile.visible and tile.player ~= -1 then
            tile.player = -1
            return true
        end
    end
    return false
end

---@param x number
---@param y number
---@return boolean
function Board:extend(x, y)
    local tile = self.matrix:get(x, y)
    if tile ~= nil then
        if not tile.visible then
            tile.visible = true
            tile.player = -1
            return true
        end
    end
    return false
end

function Board:update()
    local p0, p1 = false, false
    for x = 0, self.fullsize - 1 do
        local count = 0
        local current = -1
        for y = 0, self.fullsize - 1 do
            local tile = self.matrix:get(x, y)
            if (tile.player == -1) or (not tile.visible) then
                count = 0
            else
                if tile.player == current then
                    count = count + 1
                    if count >= self.inline then
                        if current == 1 then
                            p1 = true
                        else
                            p0 = true
                        end
                    end
                else
                    count = 1
                    current = tile.player
                end
            end
        end
    end

    for y = 0, self.fullsize - 1 do
        local count = 0
        local current = -1
        for x = 0, self.fullsize - 1 do
            local tile = self.matrix:get(x, y)
            if (tile.player == -1) or (not tile.visible) then
                count = 0
            else
                if tile.player == current then
                    count = count + 1
                    if count >= self.inline then
                        if current == 1 then
                            p1 = true
                        else
                            p0 = true
                        end
                    end
                else
                    count = 1
                    current = tile.player
                end
            end
        end
    end

    if p0 and p1 then
        return 'Tie!'
    elseif p0 then
        return 'Player '..'1'..' won!'
    elseif p1 then
        return 'Player '..'2'..' won!'
    else
        return 'Playing'
    end
end

return setmetatable({ new = new }, {
    __call = function(_, ...)
        return new(...)
    end
})