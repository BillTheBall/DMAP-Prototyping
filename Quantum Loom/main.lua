--Controls:
--1-9 to select a card in your hand (left side of the screen to see it in order) 
--d to draw a card from the full deck
--selecting a card colors all potential targets green
--enter to play the card
--left click on chars to switch
--right click on any object (so all non empty tiles) to see info about them

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
  
  inspectingObject = p2
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
    if(inspectingObject) then love.graphics.print(inspectingObject:getDebugText(), 900, 50) end
    love.graphics.setColor(0,0,0)
    CombatGrid:draw()
    miiui.end_frame()
end

function love.keypressed(key)
    miiui.keypressed(key)
    --print("pos: " .. selectedChar.pos.x)
    if(tonumber(key) and tonumber(key) <= #selectedChar.currentHand) then
      selectedChar.cardToBePlayed = selectedChar.currentHand[tonumber(key)]
    end
    if(key == "d") then 
      selectedChar:drawCard(1)
    end
    if (key == "return" and selectedChar.cardToBePlayed and selectedChar.cardToBePlayed:isTargetValid()) then
        selectedChar.cardToBePlayed:onPlay()
      end
end

function love.textinput(text)
    miiui.textinput(text)
end

function love.mousepressed(x, y, button)
  -- 1: right, 2: left, 3: middle, 4&5: side
  if(getSelectedTile().objectOnTile and button == 1 and getSelectedTile().objectOnTile.isGood) then
    getSelectedTile().objectOnTile:selectChar()
  end
  if(getSelectedTile().objectOnTile and button == 2) then
    inspectingObject = getSelectedTile().objectOnTile
  end

end
