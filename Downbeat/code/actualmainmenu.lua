actualmainmenu = {}
local FadeAway = 1
local FadeAwayTimer = 64

function actualmainmenu:load()
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

    wf = require "windfield"
    world = wf.newWorld(0, 0)

    world:addCollisionClass('Everything')
    world:addCollisionClass('Reorient')
    world:addCollisionClass('Fixed')


    world:addCollisionClass('TriggerBeatScoreZone1', {ignores = {'TriggerBeatScoreZone1' , 'Reorient'}})
    world:addCollisionClass('TriggerBeatScoreZone2', {ignores = {'TriggerBeatScoreZone1' , 'Reorient', 'TriggerBeatScoreZone2'}})
    world:addCollisionClass('TriggerBeatScoreZone3', {ignores = {'TriggerBeatScoreZone1' , 'Reorient', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3'}})
    world:addCollisionClass('TriggerBeatScoreZone4', {ignores = {'TriggerBeatScoreZone1' , 'Reorient', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4'}})
    world:addCollisionClass('TriggerBeatScoreZone5', {ignores = {'TriggerBeatScoreZone1' , 'Reorient', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5'}})
    world:addCollisionClass('TriggerBeatScoreZone6', {ignores = {'TriggerBeatScoreZone1' , 'Reorient', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})
    world:addCollisionClass('TriggerBeat', {ignores = {'Reorient', 'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})
    world:addCollisionClass('TriggerBeatR', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeat' , 'Reorient', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})
    world:addCollisionClass('TriggerBeatL', {ignores = {'TriggerBeatScoreZone1', 'TriggerBeat', 'Reorient', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})
    world:addCollisionClass('Beat', {ignores = {'Reorient', 'TriggerBeat', 'TriggerBeatR', 'TriggerBeatL', 'Beat', 'TriggerBeatScoreZone1', 'TriggerBeatScoreZone2', 'TriggerBeatScoreZone3', 'TriggerBeatScoreZone4', 'TriggerBeatScoreZone5', 'TriggerBeatScoreZone6'}})

    
end
function actualmainmenu:update(dt)
        FadeAwayTimer = FadeAwayTimer - 1
    if FadeAwayTimer < 0 then
        FadeAway = FadeAway - 0.1
    end
    if FadeAway < 0 then
        Scene = 2
    end
    world:update(dt)
end

function actualmainmenu:draw()
    world:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.draw(Menu, 0, 0, 0, 6)
    love.graphics.setColor(1, 1, 1, FadeAway)
    love.graphics.draw(Watermark, 0, 0, 0, 6)
    love.graphics.print(Scene, 10, 85)
end