local inventory = {}
inventory.__index = inventory

local function origin(image, x, y)
    love.graphics.draw(image, x, y, _, _, _, image:getWidth() / 2, image:getHeight() / 2)
end

local function shuffle(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

local function new()
    local mt = {
        cards = {},
        extracting = 1
    }

    return setmetatable(mt, inventory)
end

function inventory:shuffle()
    shuffle(self.cards)
    self.extracting = 1
end

function inventory:insert(card)
    table.insert(self.cards, card)
end

function inventory:extract()
    self.extracting = self.extracting + 1
    return self.cards[self.extracting - 1]
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })