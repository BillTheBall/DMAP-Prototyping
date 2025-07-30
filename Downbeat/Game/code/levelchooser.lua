levelchooser = {}
local SpeedcardEnabled = false
local hoveringoverback = false
local hoveringoverplay = false

local hoveringovercardone = false
 CardOneEnabled = false

local hoveringovercardtwo = false
 CardTwoEnabled = false

local hoveringovercardthree = false
 CardThreeEnabled = false

 HighScore = 0

function levelchooser:load()

end

function levelchooser:update(dt)
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()

    if MouseX > 15 and MouseX < 275 and MouseY > 15 and MouseY < 120 then
        hoveringoverback = true
        if clickedDown1 and not ButtonClickedDisabled then
            Scene = 2
            ButtonClickedDisabled = true
        end
    else
        hoveringoverback = false
    end

    if MouseX > 1165 and MouseX < 1430 and MouseY > 950 and MouseY < 1050 then
        hoveringoverplay = true
        if clickedDown1 and not ButtonClickedDisabled then
            ButtonClickedDisabled = true
            Scene = 1
        end
    else
        hoveringoverplay = false
    end

    if MouseX > 425 and MouseX < 535 and MouseY > 300 and MouseY < 470 then
        hoveringovercardone = true
        if clickedDown1 and not ButtonClickedDisabled and not CardOneEnabled and not SpeedcardEnabled then
            CardOneEnabled = true
            SpeedcardEnabled = true
        elseif clickedDown1 and not ButtonClickedDisabled and CardOneEnabled then 
            CardOneEnabled = false
            SpeedcardEnabled = false
        end
    else
        hoveringovercardone = false
    end

    if MouseX > 612 and MouseX < 722 and MouseY > 300 and MouseY < 470 then
        hoveringovercardtwo = true
        if clickedDown1 and not ButtonClickedDisabled and not CardTwoEnabled and not SpeedcardEnabled then
            CardTwoEnabled = true
            SpeedcardEnabled = true
        elseif clickedDown1 and not ButtonClickedDisabled and CardTwoEnabled then 
            CardTwoEnabled = false
            SpeedcardEnabled = false
        end
    else
        hoveringovercardtwo = false
    end

        if MouseX > 792 and MouseX < 902 and MouseY > 300 and MouseY < 470 then
        hoveringovercardthree = true
        if clickedDown1 and not ButtonClickedDisabled and not CardThreeEnabled and not SpeedcardEnabled then
            CardThreeEnabled = true
            SpeedcardEnabled = true
        elseif clickedDown1 and not ButtonClickedDisabled and CardThreeEnabled then 
            CardThreeEnabled = false
            SpeedcardEnabled = false
        end
    else
        hoveringovercardthree = false
    end

    
    if counter < 1 then
        ButtonClickedDisabled = false
    end
end


function levelchooser:draw()
    love.graphics.draw(LevelUnoMenu, 0, 0, 0, 6)
    if hoveringoverback then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(Quitheadflipped, 281, 50, 0, 6)
    end
    if hoveringoverplay then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(PlayHead2D, 1146, 981, 0, 6)
    end

    if hoveringovercardone or CardOneEnabled then
        --love.graphics.setColor(red,green,blue,alpha)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 426, 310, 108, 158)
    end
    if hoveringovercardtwo or CardTwoEnabled then
        --love.graphics.setColor(red,green,blue,alpha)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 612, 310, 108, 158)
    end
    if hoveringovercardthree or CardThreeEnabled then
        --love.graphics.setColor(red,green,blue,alpha)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 792, 310, 108, 158)
    end
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(HighScore, 400, 580, 0, 2)
    if HighScore == 0 then
        love.graphics.print("?", 1280, 485, 0, 5) 
    elseif HighScore < (999999 * 0.1) then
        love.graphics.print("F", 1280, 485, 0, 5) 
    elseif HighScore < (999999 * 0.3) then
        love.graphics.print("D", 1280, 485, 0, 5) 
    elseif HighScore < (999999 * 0.5) then
        love.graphics.print("C", 1280, 485, 0, 5) 
    elseif HighScore < (999999 * 0.7) then
        love.graphics.print("B", 1280, 485, 0, 5) 
    elseif HighScore < (999999 * 0.9) then
       love.graphics.print("A", 1280, 485, 0, 5) 
    elseif HighScore < (999999 * 1) then
       love.graphics.print("A", 1280, 485, 0, 5) 
    end
    love.graphics.print("MouseX: " ..tostring(love.mouse.getX()).. " MouseY: " ..tostring(love.mouse.getY()), 10, 1)
    love.graphics.setColor(1, 1, 1)
end