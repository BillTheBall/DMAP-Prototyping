local Board = require 'board'
local Deck = require 'deck'
local Card = require 'card'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    font = love.graphics.newFont('images/Minecraft_1.1.ttf')
    love.graphics.setFont(font)
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    board = Board(9, 1, 6, 16, width / 2, height / 2, 4, true)
    turn = 1
    decks = {[0] = Deck(9, 0), [1] = Deck(9, 1)}
    for i = 1, 9 do
        decks[0]:insert(Card(math.random(0, 6)))
        decks[1]:insert(Card(math.random(0, 6)))
    end
    text = {[1] = 'Dot', [0] = 'Cross'}
end

function love.draw()
    love.graphics.print('x'..love.mouse.getX()..' y'..love.mouse.getY())
    local px, py = board:toWorld(love.mouse.getX(), love.mouse.getY())
    love.graphics.print('x'..px..' y'..py, 0, 15)
    love.graphics.print(board:update(), 0, 30)
    love.graphics.print('FPS: '..love.timer.getFPS(), 0, 45)
    love.graphics.print('Player: '..text[turn], 0, 60)
    love.graphics.print('LeftMouse: place\nRightMouse: use card\nEscape to close', 0, 75)
    board:draw()
    decks[0]:draw(width / 2, 0, 14, 4)
    decks[1]:draw(width / 2, height - 128, 14, 4)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == '1' then
        decks[turn]:select(1)
    elseif key == '2' then
        decks[turn]:select(2)
    elseif key == '3' then
        decks[turn]:select(3)
    elseif key == '4' then
        decks[turn]:select(4)
    elseif key == '5' then
        decks[turn]:select(5)
    elseif key == '6' then
        decks[turn]:select(6)
    elseif key == '7' then
        decks[turn]:select(7)
    elseif key == '8' then
        decks[turn]:select(8)
    elseif key == '9' then
        decks[turn]:select(9)
    end
end

function love.mousepressed(x, y, button)
    local px, py = board:toWorld(love.mouse.getX(), love.mouse.getY())
    if button == 1 then
        if board:place(px, py, turn) then
            turn = 1 - turn
        end
    elseif button == 2 then
        decks[turn]:use(board, px, py)
    end
end

---@param mx number
---@param my number
---@param x number
---@param y number
---@param w number
---@param h number
---@return boolean
local function inBox(mx, my, x, y, w, h)
    return mx > x and mx < x + w and my > y and my < y + h
end