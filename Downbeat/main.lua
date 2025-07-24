function love.load()
    -- Libraries --
    wf = require "windfield"
    mm = require "code.mainmenu"
    ry = require "code.rhythmgame"
    bb =  require "code.Beats"

    -- Variables --
    tickPeriod = 1/32 -- seconds per tick
    accumulator = 0.0
    counter = 0
    timer = 0
    clickedDown1 = false
    clickedDown2 = false
    clickedDown3 = false
    abilitytoClickDown1 = true
    countered = 0
    Scene = 0
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    mainmenu:load() 
    rhythmlevelone:load() 
    Beats:load()
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
            Beats:update(dt)
        end

    if not abilitytoClickDown1  then
        countered = countered + 1 * dt
        clickedDown1 = false
    end
    if countered > 0.01 then
        abilitytoClickDown1 = true
        clickedDown1 = false
        countered = 0
    end
        accumulator = accumulator - tickPeriod
        counter = counter + 1
    end


    function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 and abilitytoClickDown1 then
        clickedDown1 = true
        abilitytoClickDown1 = false
    end
end
end



function love.draw()
    if Scene == 0 then 
        mainmenu:draw()
    elseif Scene == 1 then
        rhythmlevelone:draw() 
        Beats:draw()
    end
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
    love.graphics.print(tostring(counter), 10, 35)
end