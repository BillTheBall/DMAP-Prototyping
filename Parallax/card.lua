---@class Card
local Card = {}
Card.__index = Card

---@param class number
---@param level number
---@return Card
local function new(class, level)
    local mt = {
        class = class or 0,
        level = level or 0
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
        love.graphics.draw(image, x, y)
    else
        love.graphics.rectangle('line', x, y, w, h)
    end
end

---@param board Board
---@param x number
---@param y number
function Card:use(board, x, y)
    local success = false
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
    end
    return success
end

return setmetatable({ new = new }, {
    __call = function(_, ...)
        return new(...)
    end
})