local Board = require 'board'
local Camera = require 'Camera'

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    board = Board.Create(9, 9, 1, 50)
    camera = Camera(11 * 50 / 2, 11 * 50 / 2)
end

function love.draw()
    camera:attach()
    board:draw()
    camera:detach()
    love.graphics.print(width .. ' ' .. height, 0, 0)
    love.graphics.print('x' .. camera.x .. ' y' .. camera.y, 0, 15)
    love.graphics.print('x' .. camera.mx .. ' y' .. camera.my, 0, 30)
    love.graphics.print(board:update(), 0, 45)
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
    if button == 1 then
        local p = board:pixeltocoord(camera.mx, camera.my)
        local tile = board:get(p.x, p.y)
        if tile ~= nil then
            if tile.side ~= -1 then
                board:reverse(p.x, p.y)
            else
                board:set(p.x, p.y, 1)
            end
        end
    end
end
