rhythmlevelone = {}
initiatedscene1 = 0
local ScreenWidth = love.graphics.getWidth()
local ScreenHeight = love.graphics.getHeight()
Beats = {}
Gamespeed = 1
local Seconds = 173/Gamespeed
local startedSceneOnce = 0
local Chart = Seconds * 32 --(2880 Ticks)
--[[ Explaination. So seconds will be the amount of time that the song lasts, counted in 
seconds!!! This allows me to make eachg ong a specific length no matter what, and lets it be
pretty customizable. Then it's *32 due to it needing to be counted down in ticks. Basically
just meaning that it makes it go from seconds, to ticks, and at each tick, it will summon a
specific beat, this is very unoptimal, but it's whatever.]]--

    Score = 0
    MaximumScore = 999999
    ClicksRequired = 246
function rhythmlevelone:load()
    --Variables--
    disabled = false
    Beat1SpawnY = ScreenHeight - ScreenHeight - 25
    Beat1SpawnX = ScreenWidth - ScreenWidth/2
    x = 0
end

function rhythmlevelone:update(dt)
    if CardOneEnabled then
        Gamespeed = 2
        bulletSpeed = 10525 * Gamespeed
    elseif CardTwoEnabled then
        Gamespeed = 3
        bulletSpeed = 10525 * Gamespeed
    elseif CardThreeEnabled then 
        Gamespeed = 4
        bulletSpeed = 10525 * Gamespeed
    else
        Gamespeed = 1
        bulletSpeed = 10525 * Gamespeed
    end

    if Scene == 1 and initiatedscene1 == 0 then
        Seconds = 173/Gamespeed
        Chart = Seconds * 32 --(2880 Ticks)
        Score = 0
        
        initiatedscene1 = 1

        if not source:isPlaying( ) then
		    love.audio.play( source )
	    end
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
    if clickedDown1 then
        print(Chart)
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
if Chart == (5466/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (5451/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (5437/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (5368/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (5352/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (5334/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (5266/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (5252/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (5233/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (5163/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (5149/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (5130/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (5061/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (5044/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (5028/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (5003/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4974/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4963/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4946/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4928/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4876/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4862/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4843/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4826/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4771/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4759/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4742/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4721/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4667/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4650/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4637/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4624/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4614/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4593/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4580/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4568/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4552/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4538/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4523/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4513/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4503/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4486/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4471/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4450/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4434/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4421/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4410/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4401/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4376/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4362/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4348/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4333/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4320/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4310/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4300/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4276/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4258/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4244/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4231/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4216/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4209/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4202/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4179/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4161/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4143/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4128/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4113/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4105/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4096/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4069/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4055/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4041/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (4028/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (4014/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (4001/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3992/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3973/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3958/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3940/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3927/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3913/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3900/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3889/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3873/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3857/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3843/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3827/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3813/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3796/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3781/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3766/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3751/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3737/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3723/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3709/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3696/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3682/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3636/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3616/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3598/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3581/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3560/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3540/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3520/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3502/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3488/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3475/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3427/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3408/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3388/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3370/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3351/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3332/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3311/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3291/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3277/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3265/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3203/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3194/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3179/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3160/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3140/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3120/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3107/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3091/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3077/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (3064/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (3035/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (3008/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2992/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2974/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2956/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2938/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2917/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2900/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2883/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2869/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2828/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2809/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2791/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2775/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2742/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2715/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2694/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2676/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2619/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2602/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2585/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2570/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2530/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2513/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2494/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2477/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2466/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2404/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2383/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2369/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2316/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2301/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2284/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2265/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2208/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2185/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2163/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (2098/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (2081/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (2061/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1995/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1979/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1964/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1954/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1945/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1921/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1906/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1889/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1872/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1857/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1844/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1814/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1800/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1785/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1770/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1758/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1746/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1735/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1716/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1700/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1685/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1668/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1653/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1645/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1630/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1616/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1597/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1582/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1567/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1552/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1542/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1520/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1498/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1480/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1466/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1452/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1441/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1425/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1405/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1391/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1374/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1361/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1348/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1341/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1330/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1310/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1295/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1276/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1261/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1246/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1232/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1214/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1194/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1171/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1150/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1135/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1082/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (1064/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (1050/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (1033/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (977/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (951/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (934/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (870/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (852/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (834/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (767/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (747/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (732/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (671/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (649/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (632/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (564/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (545/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (527/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (460/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (442/Gamespeed) then
    Beats:spawnBullet("right")
elseif Chart == (424/Gamespeed) then
    Beats:spawnBullet()
elseif Chart == (358/Gamespeed) then
    Beats:spawnBullet("left")
elseif Chart == (0/Gamespeed) then
    if Score > HighScore then
        HighScore = Score
    end
    Scene = 2
end 
    
    Chart = Chart - 1
    world:update(dt)
end

function math.round(num) --you should really give it another name though
    return math.floor(num+0.5)
end

function rhythmlevelone:draw()
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle('line', 1160, 900, 100)
    love.graphics.circle('line', 835, 900, 100)
    love.graphics.circle('line', 1500, 900, 100)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.draw(LevelUno, 0, 0, 0, 6)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Score: ", 60, 12, 0, 1)
    love.graphics.print(math.round(Score), 60, 60, 0, 1)
    love.graphics.print("/999,999", 60, 95, 0, 1)
    love.graphics.setColor(1, 1, 1)
end
