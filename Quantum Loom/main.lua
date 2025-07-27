local miiui = require "Miiui.Miiui"
require "object_Combat"
require "CombatGrid"
require "card_Combat"
function love.load()
  io.stdout:setvbuf("no")
  love.window.setMode(1280, 720)
  print(love.graphics.getHeight(), love.graphics.getWidth())
  p1 = char_Support:new()
  p2 = char_Tank:new()
  enemy = enemy_Combat:new()
  p1.pos.x = 3
  p1.pos.y = 3
  enemy.pos.x = 5
  enemy.pos.y = 7
  p2.pos.x = 9
  p2.pos.y = 9
  huhuhuhuhuhuVprasaj = 32333435
  CombatGrid = require "CombatGrid"
  
  CombatGrid:Load()
  
  combatGrid[p2.pos.x][p2.pos.y].objectOnTile = p2
  combatGrid[p1.pos.x][p1.pos.y].objectOnTile = p1
  combatGrid[enemy.pos.x][enemy.pos.y].objectOnTile = enemy
  
  selectedChar = p2
  move = move_Card:new()
  granade = handGranade_Card:new()
  --p1.currentDeck = p1.fullDeck
  --p2.currentDeck = p2.fullDeck
  --print(granade:isTargetValid(), move.isTargetValid())
  --print("good?", p1.isGood)
  --print(selectedChar:getDebugText())
end
function love.update(dt)
  miiui.update(dt)
  --print("x", enemy.pos.x, "y", enemy.pos.y)
end

function love.draw()
    miiui.begin()
    love.graphics.setColor(1,1,1)
    love.graphics.print(selectedChar:getDebugText(), 900, 50)
    love.graphics.setColor(0,0,0)
    CombatGrid:draw()
    miiui.end_frame()
end

function love.keypressed(key)
    miiui.keypressed(key)
    --print("pos: " .. selectedChar.pos.x)
    if(key == "1") then
      if (selectedChar.fullDeck[1]:isTargetValid()) then
        selectedChar.fullDeck[1]:onPlay()
      end
    end
    
    if(key == "2") then
      if (selectedChar.fullDeck[2]:isTargetValid()) then
        selectedChar.fullDeck[2]:onPlay()
      end
    end
    
    if(key == "3" and selectedChar.fullDeck[3]) then
      if (selectedChar.fullDeck[3]:isTargetValid()) then
        selectedChar.fullDeck[3]:onPlay()
      end
    end
    
    if(key == "d") then 
      selectedChar:drawCard(1)
    end
end

function love.textinput(text)
    miiui.textinput(text)
end

function love.mousepressed(x, y, button)
  -- 1: right, 2: left, 3: middle, 4&5: side
  if(getSelectedTile().objectOnTile and button == 1) then
    if(getSelectedTile().objectOnTile.isGood) then getSelectedTile().objectOnTile:selectChar() end
  end
end