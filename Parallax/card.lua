---@class Card
local Card = {}
Card.__index = Card
local prices = {
    [0] = 9,
    [1] = 7,
    [2] = 7,
    [3] = 5,
    [4] = 5,
    [5] = 11,
    [6] = 11
}

---@param class number
---@param level number
---@return Card
local function new(class, level)
    local mt = {
        class = class or 0,
        level = level or 0,
    }

    return setmetatable(mt, Card)
end

---@param image Drawable
---@param x number
---@param y number
---@param w number
---@param h number
function Card:draw(image, x, y, w, h)
    if image ~= nil then
        love.graphics.draw(image, x, y, 3.1415 / 16)
    else
        love.graphics.rectangle('line', x, y, w, h)
    end
end

---@param board Board
---@param x number
---@param y number
function Card:use(board, x, y, mana)
    local success = false
    local difference = 0
    if mana < prices[self.class] then
        return false, 0
    end
    if self.class == 0 then
        success = board:flip(x, y)
    elseif self.class == 1 then
        for i = 0, 2 do
            success = board:clear(x + i, y) or success
        end
    elseif self.class == 2 then
        for i = 0, 2 do
            success = board:clear(x, y + i) or success
        end
    elseif self.class == 3 then
        success = board:extend(x, y)
    elseif self.class == 4 then
        success = board:remove(x, y)
    elseif self.class == 5 then
        for i = 0, 2 do
            success = board:flip(x + i, y) or success
        end
    elseif self.class == 6 then
        for i = 0, 2 do
            success = board:flip(x, y + i) or success
        end
    end
    if success then
        difference = prices[self.class]
    end
    return success, difference
end

function Card:getPrice()
    return prices[self.class]
end

return setmetatable({ new = new }, {
    __call = function(_, ...)
        return new(...)
    end
})