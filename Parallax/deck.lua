local Card = require 'card'
local Sprites = require 'sprites'

local Deck = {}
Deck.__index = Deck

function Deck.Create(size, player)
    local self = setmetatable({}, Deck)

    self.player = player or -1
    self.size = size or 0
    self.cards = {}

    return self
end

function Deck:insert(card)
    if #self.cards < self.size then
        table.insert(self.cards, card)
        return true
    end
    return false
end

function Deck:use(index, board, x, y)
    if #self.cards > 0 then
        local success = self.cards[index]:use(board, x, y)
        if success then
            table.remove(self.cards, index)
        end
    end
    return success
end

function Deck:draw(x, y)
    for i = 1, #self.cards do
        local card = self.cards[i]
        if card.class == 0 then
            love.graphics.draw(Sprites[7], x + i * 30, y)
            love.graphics.draw(Sprites[8], x + i * 30, y)
        elseif card.class == 1 then
            love.graphics.draw(Sprites[7], x + i * 30, y)
            love.graphics.draw(Sprites[9], x + i * 30, y)
        elseif card.class == 2 then
            love.graphics.draw(Sprites[7], x + i * 30, y)
            love.graphics.draw(Sprites[10], x + i * 30, y)
        end
    end
end

return Deck
