local card = {}
card.__index = card

love.graphics.setDefaultFilter('nearest', 'nearest')

local images = {
    Base = love.graphics.newImage('images/cards/Base.png'),
    [0] = love.graphics.newImage('images/cards/Flip.png'),
    [1] = love.graphics.newImage('images/cards/ClearRow.png'),
    [2] = love.graphics.newImage('images/cards/ClearColumn.png'),
    [3] = love.graphics.newImage('images/cards/Clear.png'),
    [4] = love.graphics.newImage('images/cards/FlipRow.png'),
    [5] = love.graphics.newImage('images/cards/FlipColumn.png'),
    [6] = love.graphics.newImage('images/cards/Extend.png'),
    [7] = love.graphics.newImage('images/cards/Remove.png')
}

local prices = {
    [0] = 3,
    [1] = 5,
    [2] = 5,
    [3] = 4,
    [4] = 5,
    [5] = 5,
    [6] = 3,
    [7] = 3
}

local function origin(image, x, y)
    love.graphics.draw(image, x, y, nil or math.pi / 32, _, _, image:getWidth() / 2, image:getHeight() / 2)
end

local function new(class, level)
    local mt = {
        class = class or 0,
        level = level or 0,
        fx = 0, fy = 0,
        x = 0, y = 0
    }

    return setmetatable(mt, card)
end

function card:draw()
    self.x = (self.fx - self.x) * 0.3 + self.x
    self.y = (self.fy - self.y) * 0.3 + self.y
    origin(images.Base, self.x, self.y)
    origin(images[self.class], self.x, self.y)
    love.graphics.print(self:price(), self.x - images.Base:getWidth() / 2 + 2, self.y - images.Base:getHeight() / 2, _, 0.4)
end

function card:price()
    return prices[self.class]
end

function card:follow(x, y)
    self.fx, self.fy = x, y
end

function card:use(Board, x, y)
    local success = false
    if self.class == 0 then
        success = Board:flip(x, y)
    elseif self.class == 1 then
        for i = 0, 2 do
            success = Board:clear(x + i, y) or success
        end
    elseif self.class == 2 then
        for i = 0, 2 do
            success = Board:clear(x, y + i) or success
        end
    elseif self.class == 3 then
        success = Board:clear(x, y) or success
    elseif self.class == 4 then
        for i = 0, 2 do
            success = Board:flip(x + i, y) or success
        end
    elseif self.class == 5 then
        for i = 0, 2 do
            success = Board:flip(x, y + i) or success
        end
    elseif self.class == 6 then
        success = Board:extend(x, y)
    elseif self.class == 7 then
        success = Board:remove(x, y)
    --[[elseif self.class == 8 then
        ...
    elseif self.class == 9 then
        ...
    elseif self.class == 10 then
        ...]]
    end
    return success
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })