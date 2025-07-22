function love.load()
    -- Libraries --
    wf = require "windfield"
    mm = require "code.mainmenu"
    mn = require "code.rhythmgame"
    -- Variables --
    tickPeriod = 1/50 -- seconds per tick
    accumulator = 0.0
    counter = 0
    timer = 0
    Scene = 0
    love.graphics.setDefaultFilter("nearest", "nearest")

    mainmenu:load() 
    rhythmlevelone:load() 
end

-- Nope. Don't even ask me how, this just runs the logic at a consistent rate --
function love.update(dt)
    timer = timer + dt
    if timer > 1 then
        counter = 0
        timer = 0
    end

    FRAMERATE = love.timer.getFPS()
    accumulator = accumulator + dt
    if accumulator >= tickPeriod then
        if Scene == 0 then
            mainmenu:update(dt) 
        elseif Scene == 1 then
            rhythmlevelone:update(dt) 
        end
        accumulator = accumulator - tickPeriod
        counter = counter + 1
    end
end

function love.draw()
    if Scene == 0 then 
        mainmenu:draw()
    elseif Scene == 1 then
        rhythmlevelone:draw() 
    end
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
    love.graphics.print(tostring(counter), 10, 35)
end
