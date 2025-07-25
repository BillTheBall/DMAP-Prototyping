local Board = require 'board'
local Camera = require 'Camera'

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    board = Board.Create(0, 0, 9, 9)
    camera = Camera(0, 0)
    camera:move(200, 300)
    mx, my = 0, 0
    mb = 0
end

function love.draw()
    camera:attach()
    for i = 1, #board.tiles do
        local tile = board.tiles[i]
        local mode = 'line'
        if tile.side == 1 then
            mode = 'fill'
        end
        love.graphics.rectangle(mode, tile.x * 50, tile.y * 50, 50, 50)
    end
    camera:detach()
    love.graphics.print(width .. ' ' .. height, 0, 0)
    love.graphics.print('x' .. camera.x .. ' y' .. camera.y, 0, 15)
    love.graphics.print('x' .. mx .. ' y' .. my .. ' b' .. mb, 0, 30)
    love.graphics.print('x' .. camera.mx .. ' y' .. camera.my, 0, 45)
end

function love.update(dt)
    camera:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(x, y, button)
    mx, my = x, y
    mb = button
    if button == 1 then
        for i = 1, #board.tiles do
            local tile = board.tiles[i]
            local tx, ty = tile.x * 50, tile.y * 50

            if math.abs(camera.mx - 25 - tx) < 25 and math.abs(camera.my - 25 - ty) < 25 then
                tile.side = 1 - tile.side
            end
        end
    end
end
