local miiui = require "Miiui.Miiui"
require "object_Combat"
require "CombatGrid"
require "card_Combat"
require "combatManager"
function love.load()
  io.stdout:setvbuf("no")
  love.window.setMode(1280, 720)
  print(love.graphics.getHeight(), love.graphics.getWidth())
  huhuhuhuhuhuVprasaj = 32333435
  CombatGrid = require "CombatGrid"
  combatManager = require "combatManager"
  CombatGrid:Load()
  combatManager:Load()
  
  selectedChar = nil
  inspectingObject = nil
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