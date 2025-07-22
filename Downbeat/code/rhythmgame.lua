rhythmlevelone = {}

local initiated = 0
function rhythmlevelone:load()
    --Variables--
    local ScreenWidth = love.graphics.getWidth()
    local ScreenHeight = love.graphics.getHeight()
    local MainButtonWidth = 300
    local MainButtonHeight = 100
end

function rhythmlevelone:update(dt)
    if Scene == 1 and initiated == 0 then
        Beat1 = world:newCircleCollider(BeatX, BeatY, 50)
        Beat:destroy()
        initiated = 1
    end
    world:update(dt)
end

function rhythmlevelone:draw()
    world:draw()
end
