mainmenu = {}

local hoveringoverplay = false
local hoveringoveroptions = false
local hoveringoverquit = false
local hoveringoveryotubue = false
local hoveringoverdiscord = false
function mainmenu:load()
    --World Stuffs--
    --Libraries--
end

function mainmenu:update(dt)
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()

    if MouseX > 820 and MouseX < 1100 and MouseY > 380 and MouseY < 480 then
        hoveringoverplay = true
        if love.mouse.isDown(1) and not ButtonClickedDisabled then
            Beats:load()
            Beats:reset()
            initiatedscene1 = 0
            Scene = 1
            ButtonClickedDisabled = true
        end
    else
        hoveringoverplay = false
    end
    if MouseX > 735 and MouseX < 1175 and MouseY > 490 and MouseY < 585 then
        hoveringoveroptions = true
        if love.mouse.isDown(1) and not ButtonClickedDisabled then
            Scene = 3
            ButtonClickedDisabled = true
        end
    else
        hoveringoveroptions = false
    end
        if MouseX > 835 and MouseX < 1075 and MouseY > 600 and MouseY < 710 then
        hoveringoverquit = true
        if love.mouse.isDown(1) and not ButtonClickedDisabled then
            love.event.quit()
            ButtonClickedDisabled = true
        end
    else
        hoveringoverquit = false
    end

    if MouseX > 1600 and MouseX < 1765 and MouseY > 920 and MouseY < 1080 then
        hoveringoveryotubue = true
        if love.mouse.isDown(1) and not ButtonClickedDisabled then
            love.system.openURL("https://www.youtube.com/@BillTheBallBTB")
            ButtonClickedDisabled = true
        end
    else
        hoveringoveryotubue = false
    end

    if MouseX > 1765 and MouseX < 1920 and MouseY > 920 and MouseY < 1080 then
        hoveringoverdiscord = true
        if love.mouse.isDown(1) and not ButtonClickedDisabled then
            love.system.openURL("https://discord.gg/9mXMC8eGaH")
            ButtonClickedDisabled = true
        end
    else
        hoveringoverdiscord = false
    end
    if counter < 1 then
        ButtonClickedDisabled = false
    end
        
end

function mainmenu:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.draw(Menu, 0, 0, 0, 6)
    if hoveringoverplay then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(Playhead, 794, 420, 0, 6)
    end
    if hoveringoveroptions then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(Optionshead, 706, 525, 0, 6)
    end
    if hoveringoverquit then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(Quithead, 800, 635, 0, 6)
    end

    if hoveringoveryotubue then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(Yotubuehead, 1670, 888, 0, 6)
    end
    if hoveringoverdiscord then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(Discordhead, 1820, 888, 0, 6)
    end
    love.graphics.print("MouseX: " ..tostring(love.mouse.getX()).. " MouseY: " ..tostring(love.mouse.getY()), 10, 60)
end
