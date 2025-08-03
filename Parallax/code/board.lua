local matrix = require 'code.matrix'
local tile = require 'code.tile'

local board = {}
board.__index = board

love.graphics.setDefaultFilter('nearest', 'nearest')

local images = {
    Base1 = love.graphics.newImage('images/tiles/Base1.png'),
    Base2 = love.graphics.newImage('images/tiles/Base2.png'),
    Float = love.graphics.newImage('images/tiles/Float.png'),
    HoverBase = love.graphics.newImage('images/tiles/HoverBase.png'),
    HoverFloat = love.graphics.newImage('images/tiles/HoverFloat.png'),
    Cross = love.graphics.newImage('images/tiles/Cross.png'),
    Dot = love.graphics.newImage('images/tiles/Dot.png')
}

local function origin(image, x, y)
    love.graphics.draw(image, x, y, _, _, _, image:getWidth() / 2, image:getHeight() / 2)
end

local function new(size, external, inline, x, y, scale)
    local mt = {
        size = size,
        external = external,
        fullsize = size + external * 2,
        matrix = matrix(),
        x = x or 0,
        y = y or 0,
        scale = scale or 1,
        inline = inline,
    }

    for x = 0, mt.fullsize - 1 do
        for y = 0, mt.fullsize - 1 do
            local float = (x >= mt.external and y >= mt.external and x < mt.fullsize - mt.external and y < mt.fullsize - mt.external)
            mt.matrix:set(x, y, tile(not float))
        end
    end
    
    return setmetatable(mt, board)
end

function board:draw()
    love.graphics.push()
    love.graphics.scale(self.scale)
    local mx, my = self:toWorld(love.mouse.getX(), love.mouse.getY())
    for x = 0, self.fullsize - 1 do
        for y = 0, self.fullsize - 1 do
            local t = self.matrix:get(x, y)
            local tx = self.x / self.scale + (x - (self.fullsize - 1) / 2) * 16
            local ty = self.y / self.scale + (y - (self.fullsize - 1) / 2) * 16
            local pattern = (x + y) % 2
            if t.float then
                origin(images.Float, tx, ty)
                if x == mx and y == my then
                    origin(images.HoverFloat, tx, ty)
                end
            else
                if pattern == 1 then
                    origin(images.Base1, tx, ty)
                else
                    origin(images.Base2, tx, ty)
                end
                if x == mx and y == my then
                    origin(images.HoverBase, tx, ty)
                end
                if t.player == 1 then
                    origin(images.Cross, tx, ty)
                elseif t.player == 0 then
                    origin(images.Dot, tx, ty)
                end
            end
        end
    end
    love.graphics.pop()
end

function board:toWorld(x, y)
    return math.floor((x - self.x) / self.scale / 16 + (self.fullsize) / 2), math.floor((y - self.y) / self.scale / 16 + (self.fullsize) / 2)
end

function board:place(x, y, player)
    local t = self.matrix:get(x, y)
    if t ~= nil then
        if not t.float and t.player == -1 then
            t.player = player
            return true
        end
    end
    return false
end

function board:flip(x, y)
    local t = self.matrix:get(x, y)
    if t ~= nil then
        if not t.float and t.player ~= -1 then
            t.player = 1 - t.player
            return true
        end
    end
    return false
end

function board:remove(x, y)
    local t = self.matrix:get(x, y)
    if t ~= nil then
        if not t.float then
            t.float = true
            t.player = -1
            return true
        end
    end
    return false
end

function board:clear(x, y)
    local t = self.matrix:get(x, y)
    if t ~= nil then
        if not t.float and t.player ~= -1 then
            t.player = -1
            return true
        end
    end
    return false
end

function board:extend(x, y)
    local t = self.matrix:get(x, y)
    if t ~= nil then
        if t.float then
            t.float = false
            return true
        end
    end
    return false
end

function board:reset()
    for x = 0, self.fullsize - 1 do
        for y = 0, self.fullsize - 1 do
            local t = self.matrix:get(x, y)
            local float = (x >= self.external and y >= self.external and x < self.fullsize - self.external and y < self.fullsize - self.external)
            t.float = not float
            t.player = -1
        end
    end
end

function board:update()
    local p0, p1 = false, false
    for x = 0, self.fullsize - 1 do
        local count = 0
        local current = -1
        for y = 0, self.fullsize - 1 do
            local t = self.matrix:get(x, y)
            if t.float or t.player == -1 then
                count = 0
            else
                if t.player == current then
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
                    current = t.player
                end
            end
        end
    end

    for y = 0, self.fullsize - 1 do
        local count = 0
        local current = -1
        for x = 0, self.fullsize - 1 do
            local t = self.matrix:get(x, y)
            if t.float or t.player == -1 then
                count = 0
            else
                if t.player == current then
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
                    current = t.player
                end
            end
        end
    end

    if p0 and p1 then
        return 'Tie!'
    elseif p0 then
        return 'Player 1 won!'
    elseif p1 then
        return 'Player 2 won!'
    else
        return 'Playing'
    end
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })