local Board = require 'board'
local Deck = require 'deck'
local Card = require 'card'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    font = love.graphics.newFont('images/fonts/pixelated.ttf', 16)
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
    text = {[1] = 'P2 (Dot)', [0] = 'P1 (Cross)'}
end

function love.draw()
    love.graphics.print('x'..love.mouse.getX()..' y'..love.mouse.getY())
    local px, py = board:toWorld(love.mouse.getX(), love.mouse.getY())
    love.graphics.print('x'..px..' y'..py, 0, 15)
    love.graphics.print(board:update(), 0, 30)
    love.graphics.print('FPS: '..love.timer.getFPS(), 0, 45)
    love.graphics.print('Player: '..text[turn], 0, 60)
    love.graphics.print('LeftMouse: place\nRightMouse: use card\nEscape to close\nP1 Mana: '..decks[0].mana..'\nP2 Mana: '..decks[1].mana..'\n1-9 to choose card', 0, 75)
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
            decks[turn].mana = decks[turn].mana + 1
            turn = 1 - turn
        end
    elseif button == 2 then
        decks[turn]:use(board, px, py)
    end
end