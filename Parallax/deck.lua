local Card = require 'card'

---@class Deck
local Deck = {}
Deck.__index = Deck

---@param size number
---@param player number
---@return Deck
local function new(size, player)
    local folder = 'images/deck/'
    local mt = {
        size = size or 0,
        player = player or 0,
        cards = {},
        current = -1,
        imageBase = love.graphics.newImage(folder..'CardBase.png'),
        imageFlip = love.graphics.newImage(folder..'CardFlip.png'),
        imageRow = love.graphics.newImage(folder..'CardRow.png'),
        imageColumn = love.graphics.newImage(folder..'CardColumn.png')
    }

    return setmetatable(mt, Deck)
end

function Deck:draw(x, y, dist, scale)
    love.graphics.scale(scale, scale)
    for i = 1, #self.cards do
        local imgX = x / scale + (i - 1 - #self.cards / 2) * dist
        local imgY = y / scale
        if i == self.current then
            if self.player == 0 then
                imgY = imgY + 8
            else
                imgY = imgY - 8
            end
        end
        local card = self.cards[i]
        card:draw(self.imageBase, imgX, imgY, 16, 32)
        if card.class == 0 then
            card:draw(self.imageFlip, imgX, imgY, 16, 32)
        elseif card.class == 1 then
            card:draw(self.imageRow, imgX, imgY, 16, 32)
        elseif card.class == 2 then
            card:draw(self.imageColumn, imgX, imgY, 16, 32)
        end
        love.graphics.print(i, imgX, imgY, _, 2 / scale, 2 / scale)
    end
    love.graphics.scale(1 / scale, 1 / scale)
end

---@param card Card
---@return boolean
function Deck:insert(card)
    if #self.cards < self.size then
        table.insert(self.cards, card)
        return true
    end
    return false
end

---@param i number
function Deck:select(i)
    if self.current == i then
        self.current = -1
    elseif i - 1 < #self.cards then
        self.current = i
    end
end

---@param board Board
---@param x number
---@param y number
function Deck:use(board, x, y)
    if self.current > 0 then
        if self.cards[self.current]:use(board, x, y) then
            table.remove(self.cards, self.current)
            self.current = -1
            return true
        end
    end
    return false
end

return setmetatable({ new = new }, {
    __call = function(_, ...)
        return new(...)
    end
})