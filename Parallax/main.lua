local board = require 'code.board'
--local inventory = require 'code.inventory'
local card = require 'code.card'
local hand = require 'code.hand'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    ManaOrb = love.graphics.newImage('images/ManaOrb.png')
    font = love.graphics.newFont('fonts/pixelated.TTF', 16)
    love.graphics.setFont(font)
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    Board = board(9, 1, 6, width / 2, height / 2)
    p = 0
    HandP1 = hand(10, 0)
    HandP2 = hand(3, 0)

    for i = 1, 10 do
        HandP1:insert(card(math.random(0, 7)))
    end
end

function love.draw()
    Board.scale = 3
    Board:draw()
    HandP1:draw(width / 2, height - 100, 14, 5)
    love.graphics.push()
    love.graphics.scale(7)
    origin(ManaOrb, width / 4 / 7, (height - height / 8) / 7)
    love.graphics.pop()
    love.graphics.print(HandP1.mana, width / 4 + 30, (height - height / 8) + 25, _, 2)
    love.graphics.print('State: '..Board:update()..'\nIn hand: '..#HandP1.cards..'\nSelected: '..HandP1.selecting..'\nKey: '..HandP1.key..'\nMana: '..HandP1.mana..'\n\n1-0 Select card\nLeftMouse - place\nRightMouse - use card\nEscape - exit\nR - reset\n\nResolution: '..width..'x'..height..'\nFPS: '..love.timer.getFPS()..'\n')
end

function love.update(dt)
    --Board:update()
    local c = 0
    if p == 1 then
        while true do
            c = c + 1
            if Board:place(math.random(0, 10), math.random(0, 10), 1) then
                p = 0
                break
            end
            if c > 1000 then
                p = 0
                break
            end
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    HandP1:select(key)
    if key == 'r' then
        Board:reset()
        HandP1.mana = 0
    end
end

function love.mousepressed(mx, my, button)
    local x, y = Board:toWorld(mx, my)
    if button == 1 then
        if Board:place(x, y, p) then
            p = 1 - p
            HandP1.mana = HandP1.mana + 1
        end
    elseif button == 2 then
        HandP1:use(Board, x, y)
        --HandP1:insert(card(math.random(0, 7)))
    end
end

function origin(image, x, y)
    love.graphics.draw(image, x, y, _, _, _, image:getWidth() / 2, image:getHeight() / 2)
end