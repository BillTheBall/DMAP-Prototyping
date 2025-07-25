rhythmlevelone = {}
local initiated = 0
local ScreenWidth = love.graphics.getWidth()
local ScreenHeight = love.graphics.getHeight()
Beats = {}
local Seconds = 90
local Chart = Seconds * 32 --(2880 Ticks)
--[[ Explaination. So seconds will be the amount of time that the song lasts, counted in 
seconds!!! This allows me to make eachg ong a specific length no matter what, and lets it be
pretty customizable. Then it's *32 due to it needing to be counted down in ticks. Basically
just meaning that it makes it go from seconds, to ticks, and at each tick, it will summon a
specific beat, this is very unoptimal, but it's whatever.]]--

    Score = 0
    MaximumScore = 999999
    ClicksRequired = 5
function rhythmlevelone:load()
    --Variables--
    disabled = false
    Beat1SpawnY = ScreenHeight - ScreenHeight - 25
    Beat1SpawnX = ScreenWidth - ScreenWidth/2
    x = 0
end

function rhythmlevelone:update(dt)
    if Scene == 1 and initiated == 0 then
        Pocket1 = world:newRectangleCollider(Beat1SpawnX - 300, 400, 1000, 100)
        Pocket1:setCollisionClass("Reorient")
        Pocket2 = world:newCircleCollider(1160, 900, 170)

        Pocket2Zone1 = world:newCircleCollider(1160, 900, 170)
        Pocket2Zone2 = world:newCircleCollider(1160, 900, 110)
        Pocket2Zone3 = world:newCircleCollider(1160, 900, 75)
        Pocket2Zone4 = world:newCircleCollider(1160, 900, 25)
        Pocket2Zone5 = world:newCircleCollider(1160, 900, 5)
        Pocket2Zone6 = world:newRectangleCollider(1060, 1020, 200, 20)
        Pocket3 = world:newCircleCollider(835, 900, 100)
        Pocket4 = world:newCircleCollider(1500, 900, 100)
        Pocket2:setCollisionClass("TriggerBeat")
        Pocket2Zone1:setCollisionClass("TriggerBeatScoreZone1")
        Pocket2Zone2:setCollisionClass("TriggerBeatScoreZone2")
        Pocket2Zone3:setCollisionClass("TriggerBeatScoreZone3")
        Pocket2Zone4:setCollisionClass("TriggerBeatScoreZone4")
        Pocket2Zone5:setCollisionClass("TriggerBeatScoreZone5")
        Pocket2Zone6:setCollisionClass("TriggerBeatScoreZone6")
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
    if Chart == (85*32) then
        Beats:spawnBullet("right") 
        Beats:spawnBullet()
    elseif Chart == (83*32) then
        Beats:spawnBullet() 
        Beats:spawnBullet("left")
    elseif Chart == (81*32) then
        Beats:spawnBullet() 
    elseif Chart == (80*32) then
        Beats:spawnBullet() 
    elseif Chart == (76*32) then
        Beats:spawnBullet() 
    end 
          
    Chart = Chart - 1
    world:update(dt)
end

function rhythmlevelone:draw()
    world:draw()
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.circle('line', 1160, 900, 100)
    love.graphics.print("Score: " .. Score, 0, 85)
    love.graphics.print("Clicked Down: " .. tostring(clickedDown1), 0, 60)
    love.graphics.print("Timed: " .. Chart, 0, 110)
end
