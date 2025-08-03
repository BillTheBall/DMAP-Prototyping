local hand = {}
hand.__index = hand

local function origin(image, x, y)
    love.graphics.draw(image, x, y, _, _, _, image:getWidth() / 2, image:getHeight() / 2)
end

local function new(size, mana)
    local mt = {
        size = size or 3,
        mana = mana or 0,
        cards = {},
        selecting = -1,
        key = ''
    }

    return setmetatable(mt, hand)
end

function hand:draw(x, y, dist, scale)
    love.graphics.push()
    love.graphics.scale(scale)
    for i = 1, #self.cards do
        local imgX = x / scale + (i - 0.5 - #self.cards / 2) * dist
        local imgY = y / scale
        if i ~= self.selecting then
            local card = self.cards[i]
            card:follow(imgX, imgY)
            card:draw()
        end
    end
    if self.selecting ~= -1 then
        local imgX = x / scale + (self.selecting - 0.5 - #self.cards / 2) * dist
        local imgY = y / scale - 8
        local card = self.cards[self.selecting]
        card:follow(imgX, imgY)
        card:draw()
    end
    love.graphics.pop()
end

function hand:insert(card)
    if #self.cards < self.size then
        table.insert(self.cards, card)
        return true
    end
    return false
end

function hand:use(Board, x, y)
    if self.selecting ~= -1 then
        local card = self.cards[self.selecting]
        if card ~= nil then
            local price = card:price()
            if self.mana >= price then
                if card:use(Board, x, y) then
                    self.mana = self.mana - price
                    table.remove(self.cards, self.selecting)
                    self.selecting = -1
                    return true
                end
            end
        end
    end
    return false
end

function hand:select(key)
    self.key = key
    local selecting = -1
    if key == '1' then
        selecting = 1
    elseif key == '2' then
        selecting = 2
    elseif key == '3' then
        selecting = 3
    elseif key == '4' then
        selecting = 4
    elseif key == '5' then
        selecting = 5
    elseif key == '6' then
        selecting = 6
    elseif key == '7' then
        selecting = 7
    elseif key == '8' then
        selecting = 8
    elseif key == '9' then
        selecting = 9
    elseif key == '0' then
        selecting = 10
    end
    if selecting == self.selecting then
        self.selecting = -1
    elseif selecting ~= -1 and selecting <= #self.cards then
        self.selecting = selecting
    end
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })