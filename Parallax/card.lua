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
    local success = false
    if self.class == 0 then
        success = board:flip(x, y)
    elseif self.class == 1 then
        for i = 0, 3 do
            success = (board:place(x + i, y, self.player) or success)
        end
    elseif self.class == 2 then
        for i = 0, 3 do
            success = (board:place(x, y + i, self.player) or success)
        end
    end
    return success
end

return Card
