local Card = {}
Card.__index = Card

function Card.Create(player, class, level)
    local self = setmetatable({}, Card)

    self.player = player or -1
    self.class = class or 0
    self.level = level or 0

    return self
end

function Card:use(board, x, y)
    return true
end

return Card
