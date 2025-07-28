local Card = require 'card'

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
    local success = self.cards[index]:use(board, x, y)
    if success then
        table.remove(self.cards, index)
    end
    return success
end

return Deck
