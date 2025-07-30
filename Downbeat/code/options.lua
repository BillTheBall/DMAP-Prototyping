options = {}

local hoveringoverback = false
local hoveringoverlayout = false
function options:load()
    --World Stuffs--
    --Libraries--
end

function options:update(dt)

    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()

    if MouseX > 15 and MouseX < 275 and MouseY > 15 and MouseY < 120 then
        hoveringoverback = true
        if love.mouse.isDown(1) and not ButtonClickedDisabled then
            Scene = 2
            ButtonClickedDisabled = true
        end
    else
        hoveringoverback = false
    end

    if MouseX > 385 and MouseX < 730 and MouseY > 575 and MouseY < 690 then
        hoveringoverlayout = true
        if clickedDown1 and not ButtonClickedDisabled then
            if KeyLayout == "ASD" then
                KeyLayout = "123"
            elseif KeyLayout == "123" then
                KeyLayout = "890"
            elseif KeyLayout == "890" then
                KeyLayout = "ZXC"
            elseif KeyLayout == "ZXC" then
                KeyLayout = "JKL"
            elseif KeyLayout == "JKL" then
                KeyLayout = "<->"
            elseif KeyLayout == "<->" then
                KeyLayout = "ASD"
            end
        end
    else
        hoveringoverlayout = false
    end
    if counter < 1 then
        ButtonClickedDisabled = false
    end
        
end

function options:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.draw(Options, 0, 0, 0, 6)
    if hoveringoverback then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(Quitheadflipped, 281, 50, 0, 6)
    end

    if hoveringoverlayout then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(LayoutArrow, 354, 606, 0, 6)
        love.graphics.draw(LayoutArrowFlipped, 742, 606, 0, 6)
    end

    if KeyLayout == "ASD" then
        love.graphics.draw(ASD, 385, 575, 0, 6)
    end
    if KeyLayout == "123" then
        love.graphics.draw(One23, 385, 575, 0, 6)
    end
    if KeyLayout == "890" then
        love.graphics.draw(Eight90, 385, 575, 0, 6)
    end
    if KeyLayout == "ZXC" then
        love.graphics.draw(ZXC, 385, 575, 0, 6)
    end
    if KeyLayout == "JKL" then
        love.graphics.draw(JKL, 385, 575, 0, 6)
    end
    if KeyLayout == "<->" then
        love.graphics.draw(Arrows, 385, 575, 0, 6)
    end
end
