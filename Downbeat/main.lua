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
    abilitytoClickDown2 = true
    abilitytoClickDown3 = true
    countered1 = 0
    countered2 = 0
    countered3 = 0
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
    accumulator = accumulator + 1 * dt
    if accumulator >= tickPeriod then
        if Scene == 0 then
            mainmenu:update(dt) 
        elseif Scene == 1 then
            rhythmlevelone:update(dt) 
            Beats:update(dt)
        end

    if not abilitytoClickDown1  then
        countered1 = countered1 + 1 * dt
        clickedDown1 = false
    end
    if countered1 > 0.01 then
        abilitytoClickDown1 = true
        clickedDown1 = false
        countered = 0
    end

    if not abilitytoClickDown2  then
        countered2 = countered2 + 1 * dt
        clickedDown2 = false
    end
    if countered2 > 0.01 then
        abilitytoClickDown2 = true
        clickedDown2 = false
        countered2 = 0
    end

    if not abilitytoClickDown3  then
        countered3 = countered3 + 1 * dt
        clickedDown3 = false
    end
    if countered3 > 0.01 then
        abilitytoClickDown3 = true
        clickedDown3 = false
        countered3 = 0
    end


        accumulator = accumulator - tickPeriod
        counter = counter + 1
    end

    function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 and abilitytoClickDown1 then
        clickedDown1 = true
        abilitytoClickDown1 = false
    elseif button == 2 and abilitytoClickDown2 then
        clickedDown2 = true
        abilitytoClickDown2 = false
    elseif button == 3 and abilitytoClickDown3 then
        clickedDown3 = true
        abilitytoClickDown3 = false
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