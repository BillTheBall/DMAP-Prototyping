Beats = {}

local angle
local bulletDx = 0
local bulletDy = 0
function Beats:load()
	bulletSpeed = 6525
	
	bullets = {}
	player = {x=250, y=250, width=15, height=15}
    straightened = false

    timed = 0 
end

function Beats:update(dt)

    -- Iterate backward so you can safely remove items
    for i = #bullets, 1, -1 do
        local v = bullets[i]

        -- Update position manually for legacy compatibility

        if not v.dead then
           v.x = v.x + (v.dx * dt)  
        end

        if v.dead and not v.targetted then 
            if v.x < 900 then
                v.collider:setPosition(835, v.y)
            elseif v.x > 1400 then 
                v.collider:setPosition(1500, v.y)
            else 
                v.collider:setPosition(1160, v.y)
            end
        elseif v.targetted then
            if v.x < 900 then
                v.collider:setPosition(835, v.y)
            elseif v.x > 1400 then 
                v.collider:setPosition(1500, v.y)
            else 
                v.collider:setPosition(1160, v.y)
            end
        end 
        
        v.y = v.y + (v.dy * dt)

        -- Move collider
        if not v.dead and not v.targetted then
        v.collider:setPosition(v.x, v.y)
        end

        if v.collider:enter('Reorient') then
            x = x + 1
            v.dead = true
            angle = math.rad(90)
        end


        if v.collider:enter('TriggerBeat') then
            v.targetted = true
        end
        if v.collider:enter('TriggerBeatR') then
            v.targettedR = true
        end
        if v.collider:enter('TriggerBeatL') then
            v.targettedL = true
        end

        if v.collider:enter('TriggerBeatScoreZone1') then
            v.score1 = true
        end
        if v.collider:exit('TriggerBeatScoreZone1') then
            v.score1 = false
        end
        if v.collider:enter('TriggerBeatScoreZone2') then
            v.score2 = true
        end
        if v.collider:exit('TriggerBeatScoreZone2') then
            v.score2 = false
        end
        if v.collider:enter('TriggerBeatScoreZone3') then
            v.score3 = true
        end
        if v.collider:exit('TriggerBeatScoreZone3') then
            v.score3 = false
        end
        if v.collider:enter('TriggerBeatScoreZone4') then
            v.score4 = true
        end
        if v.collider:exit('TriggerBeatScoreZone4') then
            v.score4 = false
        end
        if v.collider:enter('TriggerBeatScoreZone5') then
            v.score5 = true
        end
        if v.collider:enter('TriggerBeatScoreZone6') then
            v.score1 = false
            v.score2 = false
            v.score3 = false
            v.score4 = false
            v.score5 = false
        end
        if v.collider:exit('TriggerBeatScoreZone5') then
            v.score5 = false
        end

        if clickedDown3 then
            if v.targetted then
                if v.score1 then
                    Score = Score + ((MaximumScore/ClicksRequired) * 0.1)
                    if v.score2 then
                        Score = Score + ((MaximumScore/ClicksRequired) * 0.2)
                        if v.score3 then
                            Score = Score + ((MaximumScore/ClicksRequired) * 0.3)
                            if v.score4 then
                                Score = Score + ((MaximumScore/ClicksRequired) * 0.3)
                                if v.score5 then
                                    Score = Score + ((MaximumScore/ClicksRequired) * 0.1)
                                end
                            end
                        end
                    end
                end
                v.collider:destroy()
                table.remove(bullets, i)
            end
        end
        if clickedDown2 then
            if v.targettedR then
                v.collider:destroy()
                table.remove(bullets, i)
            end
        end
        if clickedDown1 then
            if v.targettedL then
                v.collider:destroy()
                table.remove(bullets, i)
            end
        end 


        -- Remove bullets below threshold
        if v.y > 1010 then
            v.collider:destroy()
            table.remove(bullets, i)
        end
    end
end


function Beats:draw()
	love.graphics.setColor(1, 0, 0)
	for i,v in ipairs(bullets) do
		love.graphics.circle("line", v.collider:getX(), v.collider:getY(), 75)
	end
end

function Beats:spawnBullet(direction)
    local startX = Beat1SpawnX - player.width/2 + 200
    local startY = Beat1SpawnY + player.height / 2

    -- Choose target angle based on string
    if direction == "left" then
        angle = math.rad(135)
    elseif direction == "right" then
        angle = math.rad(45)
    else -- "center" or default
        angle = math.rad(90) -- straight down
    end

    bulletDx = bulletSpeed * math.cos(angle)
    bulletDy = bulletSpeed * math.sin(angle)

    local beatCollider = world:newCircleCollider(startX, startY, 10)
    beatCollider:setCollisionClass("Beat")

    beatCollider:setSensor(false)         -- allow physical collision if needed
    beatCollider:setRestitution(0)        -- no bounce
    beatCollider:setFriction(0)           -- no friction drag
    beatCollider:setMass(0.01)            -- very light so it doesn't push anything
    beatCollider:setInertia(0)            -- no rotation drift
    beatCollider:setGravityScale(0)       -- in case you ever add gravity
    beatCollider:setBullet(true)          -- better high-speed physics

    table.insert(bullets, {
        x = startX,
        y = startY,
        dx = bulletDx,
        dy = bulletDy,
        collider = beatCollider
    })
end
