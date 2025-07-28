local Options = require 'options'
local Tile = require 'tile'
local Matrix = require 'matrix'
local Sprites = require 'sprites'

local Board = {}
Board.__index = Board

function Board.Create(size, external, interact, scale)
    local self = setmetatable({}, Board)

    self.position = {x = 0, y = 0}
    self.size = size or 9
    self.external = external or 1
    self.interact = interact or false
    self.scale = scale or 16

    self.matrix = Matrix.Create()
    self.timer = 0

    for x = 0, self.size + self.external do
        for y = 0, self.size + self.external do
            self.matrix:set(x, y, Tile.Create(((x > 0) and (x < self.size + self.external)) and ((y > 0) and (y < self.size + self.external))))
        end
    end

    return self
end

function Board:draw()
    self.timer = self.timer + 0.1
    for x = 0, self.size + self.external do
        for y = 0, self.size + self.external do
            local px = self.position.x + x * self.scale
            local py = self.position.y + y * self.scale
            local tile = self.matrix:get(x, y)
            if tile.visible then
                if (x + y) % 2 == 1 then
                    Sprites[1]:draw(self.timer, px, py)
                else
                    love.graphics.draw(Sprites[6], px, py)
                end
                if tile.player == 0 then
                    love.graphics.draw(Sprites[4], px, py)
                elseif tile.player == 1 then
                    love.graphics.draw(Sprites[5], px, py)
                end
                if tile.hover then
                    love.graphics.draw(Sprites[2], px, py)
                end
            else
                love.graphics.draw(Sprites[3], px, py)
            end
            tile.hover = false
        end
    end
end

function Board:move(x, y)
    self.position.x = self.position.x + x
    self.position.y = self.position.y + y
end

function Board:inside(x, y)
    return ((x >= 0) and (x <= self.size + self.external)) and ((y >= 0) and (y <= self.size + self.external))
end

function Board:position(x, y)
    self.position.x = x
    self.position.y = y
end

function Board:interact(interact)
    self.interact = interact
end

function Board:toworld(x, y)
    return math.floor((x - self.position.x) / self.scale), math.floor((y - self.position.y) / self.scale)
end

function Board:hover(x, y)
    if self:inside(x, y) then
        self.matrix:get(x, y).hover = true
    end
end

function Board:place(x, y, player)
    if self:inside(x, y) then
        local tile = self.matrix:get(x, y)
        if tile.visible then
            if tile.player == -1 then
                tile.player = player
                return true
            end
        end
    end
    return false
end

function Board:flip(x, y)
    if self:inside(x, y) then
        local tile = self.matrix:get(x, y)
        if tile.visible then
            if tile.player ~= -1 then
                tile.player = 1 - tile.player
                return true
            end
        end
    end
    return false
end

function Board:remove(x, y)
    if self:inside(x, y) then
        local tile = self.matrix:get(x, y)
        if tile.visible then
            tile.visible = false
            return true
        end
    end
    return false
end

function Board:extend(x, y)
    if self:inside(x, y) then
        local tile = self.matrix:get(x, y)
        if not tile.visible then
            tile.visible = true
            return true
        end
    end
    return false
end

function Board:update()
    for x = 0, self.size + self.external do
        local count = 0
        local current = -1
        for y = 0, self.size + self.external do
            local tile = self.matrix:get(x, y)
            if (tile.player == -1) or (not tile.visible) then
                count = 0
            else
                if tile.player == current then
                    count = count + 1
                    if count >= Options.board.inline then
                        return 'Player '..current..' won!'
                    end
                else
                    count = 1
                    current = tile.player
                end
            end
        end
    end

    for y = 0, self.size + self.external do
        local count = 0
        local current = -1
        for x = 0, self.size + self.external do
            local tile = self.matrix:get(x, y)
            if (tile.player == -1) or (not tile.visible) then
                count = 0
            else
                if tile.player == current then
                    count = count + 1
                    if count >= Options.board.inline then
                        return 'Player '..current..' won!'
                    end
                else
                    count = 1
                    current = tile.player
                end
            end
        end
    end

    return 'Playing'
end

return Board
