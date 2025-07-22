mainmenu = {}

function mainmenu:load()
    --Variables--
    local ScreenWidth = love.graphics.getWidth()
    local ScreenHeight = love.graphics.getHeight()
    local MainButtonWidth = 300
    local MainButtonHeight = 100
    MouseX = 1
    MouseY = 0
    BeatX = ScreenWidth - ScreenWidth/2 - MainButtonWidth + 150
    BeatX2 = ScreenWidth - ScreenWidth/2 + 150
    BeatY = ScreenHeight - ScreenHeight/2 - 50
    BeatY2 = ScreenHeight - ScreenHeight/2 + MainButtonHeight - 50
    ButtonClickedDisabled = false
    --World Stuffs--
    --Libraries--
    wf = require "windfield"
    world = wf.newWorld(0, 0)
    Beat = world:newRectangleCollider(BeatX, BeatY, MainButtonWidth, MainButtonHeight)
end

function mainmenu:update(dt)
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()

    if MouseX > BeatX and MouseX < BeatX2 and MouseY > BeatY and MouseY < BeatY2 then
        if love.mouse.isDown(1) and not ButtonClickedDisabled then
            Scene = 1
            ButtonClickedDisabled = true
        end
    end

    if counter < 1 then
        ButtonClickedDisabled = false
    end
        world:update(dt)
end

function mainmenu:draw()
    world:draw()
    love.graphics.print("MouseX: " ..tostring(love.mouse.getX()).. " MouseY: " ..tostring(love.mouse.getY()), 10, 60)
    love.graphics.print(Scene, 10, 85)
end
