rhythmlevelone = {}
local initiated = 0
local ScreenWidth = love.graphics.getWidth()
local ScreenHeight = love.graphics.getHeight()
Beats = {}

function rhythmlevelone:load()
    --Variables--
    disabled = false
    Beat1SpawnY = ScreenHeight - ScreenHeight - 25
    Beat1SpawnX = ScreenWidth - ScreenWidth/2
    x = 0
end

function rhythmlevelone:update(dt)
    if Scene == 1 and initiated == 0 then
        Pocket1 = world:newRectangleCollider(Beat1SpawnX - 500, 400, 1000, 100)
        Pocket1:setCollisionClass("Reorient")

        Pocket2 = world:newCircleCollider(960, 900, 100)
        Pocket3 = world:newCircleCollider(635, 900, 100)
        Pocket4 = world:newCircleCollider(1300, 900, 100)
        Pocket2:setCollisionClass("TriggerBeat")
        Pocket3:setCollisionClass("TriggerBeatL")
        Pocket4:setCollisionClass("TriggerBeatR")
        Beat:destroy()
        initiated = 1
    end
    --[[
     if x < 200 then
        Beat1 = world:newCircleCollider(Beat1SpawnX, 540, 50)
        x = x + 1
        Beat1:setLinearVelocity(5000, 5000)
        Beat1y = Beat1:getY()
    end 
         NEVER GET MORE THAN 250 OBJECTS WITHOUT DESTROYING THEM
    ]]-- 
    if counter < 1 then
        if not disabled then
            disabled = true
            Beats:spawnBullet() 
            Beats:spawnBullet("left") 
            Beats:spawnBullet("right")          
        elseif disabled then
            disabled = false
        end
    end
    world:update(dt)
end

function rhythmlevelone:draw()
    world:draw()
    love.graphics.print("Score: " .. Score, 0, 85)
    love.graphics.print("Clicked Down: " .. tostring(clickedDown1), 0, 60)
    love.graphics.print("Timed: " .. countered, 0, 110)
end
