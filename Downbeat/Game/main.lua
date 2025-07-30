ALSOFT_DRIVERS=pipewire
function love.load()
    -- Libraries --
    MYfont = love.graphics.newFont( "Artisting/pixelated.TTF", 48 )
    love.graphics.setFont(MYfont)
    wf = require "windfield"
    am = require "code.actualmainmenu"
    mm = require "code.mainmenu"
    op =  require "code.options"
    ry = require "code.rhythmgame"
    bb =  require "code.Beats"
    lc =  require "code.levelchooser"
    -- Variables --
    KeyLayout = "ASD"
    tickPeriod = 1/32 -- seconds per tick
    accumulator = 0.0
    counter = 0
    timer = 0
    clickedDown1 = false
    clickedDown2 = false
    clickedDown3 = false
    abilitytoClickDown1 = true
    abilitytoClickDown2 = true
    abilitytoClickDown3 = true
    countered1 = 0
    countered2 = 0
    countered3 = 0
    Scene = 0
    Volume = 1
    love.graphics.setDefaultFilter("nearest", "nearest")
        
    Watermark = love.graphics.newImage("Artisting/BTBStudiosIntroScreenWatermark.png")

    Menu = love.graphics.newImage("Artisting/BTBStudiosIntroScreenk.png")
    Playhead = love.graphics.newImage("Artisting/PlayArrow.png")
    Optionshead = love.graphics.newImage("Artisting/OptionsArrow.png")
    Quithead = love.graphics.newImage("Artisting/QuitArrow.png")
    Discordhead = love.graphics.newImage("Artisting/DiscordArrow.png")
    Yotubuehead = love.graphics.newImage("Artisting/YouTubeArrow.png")

    Options = love.graphics.newImage("Artisting/BTBStudiosOptionsScreen.png")
    Quitheadflipped = love.graphics.newImage("Artisting/QuitArrowFlipped.png")
    ASD = love.graphics.newImage("Artisting/ASD.png")
    One23 = love.graphics.newImage("Artisting/123.png")
    Eight90 = love.graphics.newImage("Artisting/890.png")
    JKL = love.graphics.newImage("Artisting/JKL.png")
    ZXC = love.graphics.newImage("Artisting/ZXC.png")
    Arrows = love.graphics.newImage("Artisting/Arrows.png")
    LayoutArrow = love.graphics.newImage("Artisting/LayoutArrowNormal.png")
    LayoutArrowFlipped = love.graphics.newImage("Artisting/LayoutArrow.png")

    LevelUnoMenu = love.graphics.newImage("Artisting/BTBStudiosLevelChoose.png")
    PlayHead2D = love.graphics.newImage("Artisting/PlayArrow2.png")
    
    Chip = love.graphics.newImage("Artisting/CasinoChip.png")
    LevelUno = love.graphics.newImage("Artisting/BTBStudiosLevelOne.png")

    source = love.audio.newSource("Music/StabbedAll.wav", "stream")

    actualmainmenu:load()
    mainmenu:load() 
    rhythmlevelone:load() 
    Beats:load()
    options:load()
    levelchooser:load()
end

-- Nope. Don't even ask me how, this just runs the logic at a consistent rate --
function love.update(dt)

    timer = timer + dt
    if timer > 1 then
        counter = 0
        timer = 0
    end

    FRAMERATE = love.timer.getFPS()
    accumulator = accumulator + 1 * dt
    if accumulator >= tickPeriod then
        if Scene == 0 then
            actualmainmenu:update(dt)
        elseif Scene == 1 then
            rhythmlevelone:update(dt) 
            Beats:update(dt)
        elseif Scene == 2 then
            mainmenu:update(dt) 
        elseif Scene == 3 then
            options:update(dt)
        elseif Scene == 4 then
            levelchooser:update(dt)
        end

    if not abilitytoClickDown1  then
        countered1 = countered1 + 1 * dt
        clickedDown1 = false
    end
    if countered1 > 0.01 then
        abilitytoClickDown1 = true
        clickedDown1 = false
        countered = 0
    end

    if not abilitytoClickDown2  then
        countered2 = countered2 + 1 * dt
        clickedDown2 = false
    end
    if countered2 > 0.01 then
        abilitytoClickDown2 = true
        clickedDown2 = false
        countered2 = 0
    end

    if not abilitytoClickDown3  then
        countered3 = countered3 + 1 * dt
        clickedDown3 = false
    end
    if countered3 > 0.01 then
        abilitytoClickDown3 = true
        clickedDown3 = false
        countered3 = 0
    end


        accumulator = accumulator - tickPeriod
        counter = counter + 1
    end

    function love.mousepressed( x, y, button, istouch, presses )
        if button == 1 and abilitytoClickDown1 then
            clickedDown1 = true
            abilitytoClickDown1 = false
        elseif button == 2 and abilitytoClickDown2 then
            clickedDown2 = true
            abilitytoClickDown2 = false
        elseif button == 3 and abilitytoClickDown3 then
            clickedDown3 = true
            abilitytoClickDown3 = false
        end
    end
    -- Clicked Down 1 = Left
    -- Clicked Down 2 = Right
    -- Clicked Down 3 = Middle

    function love.keypressed(key)
        if KeyLayout == "ASD" then
            if key == "a" and abilitytoClickDown1 then
                clickedDown1 = true
                abilitytoClickDown1 = false
            elseif key == "d" and abilitytoClickDown2 then
                clickedDown2 = true
                abilitytoClickDown2 = false
            elseif key == "s" and abilitytoClickDown3 then
                clickedDown3 = true
                abilitytoClickDown3 = false
            end 
        end

        if KeyLayout == "123" then
            if key == "1" and abilitytoClickDown1 then
                clickedDown1 = true
                abilitytoClickDown1 = false
            elseif key == "3" and abilitytoClickDown2 then
                clickedDown2 = true
                abilitytoClickDown2 = false
            elseif key == "2" and abilitytoClickDown3 then
                clickedDown3 = true
                abilitytoClickDown3 = false
            end 
        end

        if KeyLayout == "ZXC" then
            if key == "Z" and abilitytoClickDown1 then
                clickedDown1 = true
                abilitytoClickDown1 = false
            elseif key == "C" and abilitytoClickDown2 then
                clickedDown2 = true
                abilitytoClickDown2 = false
            elseif key == "X" and abilitytoClickDown3 then
                clickedDown3 = true
                abilitytoClickDown3 = false
            end 
        end

        if KeyLayout == "JKL" then
            if key == "j" and abilitytoClickDown1 then
                clickedDown1 = true
                abilitytoClickDown1 = false
            elseif key == "l" and abilitytoClickDown2 then
                clickedDown2 = true
                abilitytoClickDown2 = false
            elseif key == "k" and abilitytoClickDown3 then
                clickedDown3 = true
                abilitytoClickDown3 = false
            end 
        end

        if KeyLayout == "890" then
            if key == "8" and abilitytoClickDown1 then
                clickedDown1 = true
                abilitytoClickDown1 = false
            elseif key == "0" and abilitytoClickDown2 then
                clickedDown2 = true
                abilitytoClickDown2 = false
            elseif key == "9" and abilitytoClickDown3 then
                clickedDown3 = true
                abilitytoClickDown3 = false
            end 
        end

        if KeyLayout == "<->" then
            if key == "left" and abilitytoClickDown1 then
                clickedDown1 = true
                abilitytoClickDown1 = false
            elseif key == "right" and abilitytoClickDown2 then
                clickedDown2 = true
                abilitytoClickDown2 = false
            elseif key == "down" and abilitytoClickDown3 then
                clickedDown3 = true
                abilitytoClickDown3 = false
            end 
        end
    end
end



function love.draw()
    if Scene == 0 then 
        actualmainmenu:draw()
    elseif Scene == 1 then
        rhythmlevelone:draw() 
        Beats:draw()
    elseif Scene == 2 then
        mainmenu:draw()
    elseif Scene == 3 then
        options:draw()
    elseif Scene == 4 then
        levelchooser:draw()
    end

    love.graphics.setColor(1, 1, 1)
end