Beats = {}

local angle
local bulletDx = 0
local bulletDy = 0
function Beats:load()
	bulletSpeed = 3700
	
	bullets = {}
	player = {x=250, y=250, width=15, height=15}
    straightened = false

    timed = 0 
end

function Beats:draw()
	love.graphics.rectangle("line",  Beat1SpawnX - player.width/2, Beat1SpawnY + player.height, player.width, player.height)
	
	love.graphics.setColor(0.5, 0.5, 0.5)
	for i,v in ipairs(bullets) do
		-- love.graphics.circle("line", v.x, v.y, 75)
	end
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
            if v.x < 700 then
                v.collider:setPosition(635, v.y)
            elseif v.x > 1200 then 
                v.collider:setPosition(1300, v.y)
            else 
                v.collider:setPosition(960, v.y)
            end
        elseif v.targetted then
            if v.x < 700 then
                v.collider:setPosition(635, v.y)
            elseif v.x > 1200 then 
                v.collider:setPosition(1300, v.y)
            else 
                v.collider:setPosition(960, v.y)
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

        if love.mouse.isDown("3") then
            if v.targetted then
                v.collider:destroy()
                table.remove(bullets, i)
            end
            clickedDown3 = true
        elseif love.mouse.isDown("2") then
            if v.targettedR then
                v.collider:destroy()
                table.remove(bullets, i)
            end
            clickedDown2 = true
        elseif clickedDown1 then
            if v.targettedL then
                v.collider:destroy()
                table.remove(bullets, i)
            end
        end 


        -- Remove bullets below threshold
        if v.y > 1080 then
            v.collider:destroy()
            table.remove(bullets, i)
        end
    end
end

function Beats:spawnBullet(direction)
    local startX = Beat1SpawnX + player.width / 2
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

    local beatCollider = world:newCircleCollider(startX, startY, 80)
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
