local Board = require 'board'
local Deck = require 'Deck'
local Camera = require 'Camera'
local Options = require 'options'

function love.draw()
    camera:attach()
    board:draw()
    camera:detach()
    love.graphics.print('Resolution: '..love.graphics.getWidth()..'x'..love.graphics.getHeight(), 0, 0)
    love.graphics.print('FPS: '..love.timer.getFPS(), 0, 15)
    love.graphics.print('State: '..board:update(), 0, 30)
end

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    board = Board.Create(Options.board.size, Options.board.external, Options.board.scale)
    camera = Camera((board.size + board.external) * board.scale / 2, (board.size + board.external) * board.scale / 2)
    camera.scale = 4
    decks = {}
    decks[0] = Deck.Create(3, 0)
    decks[1] = Deck.Create(3, 1)
    TURN = 1
    world = {x = 0, y = 0}
end

function love.update(dt)
    camera:update(dt)
    world.x, world.y = board:toworld(camera.mx, camera.my)
    board:hover(world.x, world.y)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local p = board:place(world.x, world.y, TURN)
        if p then
            TURN = 1 - TURN
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
