rhythmlevelone = {}
initiatedscene1 = 0
local ScreenWidth = love.graphics.getWidth()
local ScreenHeight = love.graphics.getHeight()
Beats = {}
Gamespeed = 1
local Seconds = 90/Gamespeed
local startedSceneOnce = 0
local Chart = Seconds * 32 --(2880 Ticks)
--[[ Explaination. So seconds will be the amount of time that the song lasts, counted in 
seconds!!! This allows me to make eachg ong a specific length no matter what, and lets it be
pretty customizable. Then it's *32 due to it needing to be counted down in ticks. Basically
just meaning that it makes it go from seconds, to ticks, and at each tick, it will summon a
specific beat, this is very unoptimal, but it's whatever.]]--

    Score = 0
    MaximumScore = 999999
    ClicksRequired = 7
function rhythmlevelone:load()
    --Variables--
    disabled = false
    Beat1SpawnY = ScreenHeight - ScreenHeight - 25
    Beat1SpawnX = ScreenWidth - ScreenWidth/2
    x = 0
end

function rhythmlevelone:update(dt)
    if Scene == 1 and initiatedscene1 == 0 then

        Seconds = 90/Gamespeed
        Chart = Seconds * 32 --(2880 Ticks)
        Score = 0
        
        initiatedscene1 = 1
    end

    if Scene == 1 and startedSceneOnce == 0 then
        Pocket1 = world:newRectangleCollider(Beat1SpawnX - 1500, 300, 3000, 500)
        Pocket1:setCollisionClass("Reorient")

        -- ZONE 2--
        Pocket2 = world:newCircleCollider(1160, 900, 170)
        Pocket2Zone1 = world:newCircleCollider(1160, 900, 170)
        Pocket2Zone2 = world:newCircleCollider(1160, 900, 110)
        Pocket2Zone3 = world:newCircleCollider(1160, 900, 75)
        Pocket2Zone4 = world:newCircleCollider(1160, 900, 25)
        Pocket2Zone5 = world:newCircleCollider(1160, 900, 5)
        Pocket2Zone6 = world:newRectangleCollider(1060, 1020, 200, 20)
        Pocket2:setCollisionClass("TriggerBeat")
        Pocket2Zone1:setCollisionClass("TriggerBeatScoreZone1")
        Pocket2Zone2:setCollisionClass("TriggerBeatScoreZone2")
        Pocket2Zone3:setCollisionClass("TriggerBeatScoreZone3")
        Pocket2Zone4:setCollisionClass("TriggerBeatScoreZone4")
        Pocket2Zone5:setCollisionClass("TriggerBeatScoreZone5")
        Pocket2Zone6:setCollisionClass("TriggerBeatScoreZone6")

        --ZONE 3--
        Pocket3 = world:newCircleCollider(835, 900, 170)
        Pocket3Zone1 = world:newCircleCollider(835, 900, 170)
        Pocket3Zone2 = world:newCircleCollider(835, 900, 110)
        Pocket3Zone3 = world:newCircleCollider(835, 900, 75)
        Pocket3Zone4 = world:newCircleCollider(835, 900, 25)
        Pocket3Zone5 = world:newCircleCollider(835, 900, 5)
        Pocket3Zone6 = world:newRectangleCollider(735, 1020, 200, 20)
        Pocket3:setCollisionClass("TriggerBeatL")
        Pocket3Zone1:setCollisionClass("TriggerBeatScoreZone1")
        Pocket3Zone2:setCollisionClass("TriggerBeatScoreZone2")
        Pocket3Zone3:setCollisionClass("TriggerBeatScoreZone3")
        Pocket3Zone4:setCollisionClass("TriggerBeatScoreZone4")
        Pocket3Zone5:setCollisionClass("TriggerBeatScoreZone5")
        Pocket3Zone6:setCollisionClass("TriggerBeatScoreZone6")

        --ZONE 4
        Pocket4 = world:newCircleCollider(1500, 900, 170)
        Pocket4Zone1 = world:newCircleCollider(1500, 900, 170)
        Pocket4Zone2 = world:newCircleCollider(1500, 900, 110)
        Pocket4Zone3 = world:newCircleCollider(1500, 900, 75)
        Pocket4Zone4 = world:newCircleCollider(1500, 900, 25)
        Pocket4Zone5 = world:newCircleCollider(1500, 900, 5)
        Pocket4Zone6 = world:newRectangleCollider(1400, 1020, 200, 20)
        Pocket4:setCollisionClass("TriggerBeatR")
        Pocket4Zone1:setCollisionClass("TriggerBeatScoreZone1")
        Pocket4Zone2:setCollisionClass("TriggerBeatScoreZone2")
        Pocket4Zone3:setCollisionClass("TriggerBeatScoreZone3")
        Pocket4Zone4:setCollisionClass("TriggerBeatScoreZone4")
        Pocket4Zone5:setCollisionClass("TriggerBeatScoreZone5")
        Pocket4Zone6:setCollisionClass("TriggerBeatScoreZone6")

        Pocket4:setCollisionClass("TriggerBeatR")

        startedSceneOnce = 1
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
    if Chart == (85*32/Gamespeed) then
        Beats:spawnBullet("right") 
    elseif Chart == (83*32/Gamespeed) then
        Beats:spawnBullet() 
        Beats:spawnBullet("right")
    elseif Chart == (81*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (80*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (76*32/Gamespeed) then
        Beats:spawnBullet()
    elseif Chart == (75*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (74*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (73*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (72*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (71*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (70*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (69*32/Gamespeed) then
        Beats:spawnBullet() 
    elseif Chart == (0/Gamespeed) then
        Scene = 2
    end 
          
    Chart = Chart - 1
    world:update(dt)
end

function rhythmlevelone:draw()
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle('line', 1160, 900, 100)
    love.graphics.circle('line', 835, 900, 100)
    love.graphics.circle('line', 1500, 900, 100)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. Score, 0, 85)
    love.graphics.print("Clicked Down: " .. tostring(clickedDown1), 0, 60)
    love.graphics.print("Timed: " .. Chart, 0, 110)
end
