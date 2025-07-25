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
    world:addCollisionClass('Everything')
    world:addCollisionClass('Reorient')
    world:addCollisionClass('Fixed')

    world:addCollisionClass('TriggerBeatScoreZone1', {ignores = {'TriggerBeatScoreZone1'}})
    world:addCollisionClass('TriggerBeatScoreZone2', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2'}})
    world:addCollisionClass('TriggerBeatScoreZone3', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3'}})
    world:addCollisionClass('TriggerBeatScoreZone4', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4'}})
    world:addCollisionClass('TriggerBeatScoreZone5', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5'}})
    world:addCollisionClass('TriggerBeatScoreZone6', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})
    world:addCollisionClass('TriggerBeat', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})
    world:addCollisionClass('TriggerBeatR')
    world:addCollisionClass('TriggerBeatL')
    world:addCollisionClass('Beat', {ignores = {'Reorient', 'TriggerBeat', 'TriggerBeatR', 'TriggerBeatL', 'Beat', 'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})

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
