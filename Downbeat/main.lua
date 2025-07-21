function love.load()
    --Libraries--
    wf = require "windfield"
    --Variables
    tickPeriod = 1/30 -- seconds per tick
    accumulator = 0.0

    --World Stuffs--
    world = wf.newWorld(0, 500000)

    --Collisions--
    Beat = world:newCircleCollider(400, 300, 10)
end
-- Nope. Don't even ask me how, this just runs the logic at a consistent rate-- 
function love.update(dt)
    FRAMERATE = love.timer.getFPS
    accumulator = accumulator + dt
    if accumulator >= tickPeriod then
        world:update(dt)
        accumulator = accumulator - tickPeriod
    end
end

function love.draw()
    world:draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end