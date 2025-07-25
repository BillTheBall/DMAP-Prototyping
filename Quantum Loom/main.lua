local miiui = require "Miiui.Miiui"
require "object_Combat"
require "CombatGrid"

function love.load()
  io.stdout:setvbuf("no")
  p1 = char_Combat:new()
  p2 = char_Combat:new()
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
  combatGird[p2.pos.x][p2.pos.y].objectOnTile = p2
  combatGird[p1.pos.x][p1.pos.y].objectOnTile = p1
  combatGird[enemy.pos.x][enemy.pos.y].objectOnTile = enemy
  
  selectedChar = p2
end
function love.update(dt)
  miiui.update(dt)
  
end

function love.draw()
    miiui.begin()
    CombatGrid:draw()
    miiui.end_frame()
end

function love.keypressed(key)
    miiui.keypressed(key)
    --print("pos: " .. selectedChar.pos.x)
    
    if(key == "1") then
      --print("Move")
      
      if(isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, getSelectedTile().pos.x, getSelectedTile().pos.y, 2) and combatGird[getSelectedTile().pos.x][getSelectedTile().pos.y].objectOnTile == nil) then
        selectedChar:moveEntety(getSelectedTile().pos.x, getSelectedTile().pos.y)
      end
    end
    if(key == "2") then
      if (isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, getSelectedTile().pos.x, getSelectedTile().pos.y, 2)) then
        for _, tile in ipairs(getTilesInSquareRange(getSelectedTile().pos.x, getSelectedTile().pos.y, 3)) do
          if(tile.objectOnTile) then tile.objectOnTile:dealDamage(10, selectedChar) end
        end 
      end
    end
end

function love.textinput(text)
    miiui.textinput(text)
end

function love.mousepressed(x, y, button)
  -- 1: right, 2: left, 3: middle, 4&5: side
  if(getSelectedTile().objectOnTile and button == 1) then--(button == "1" and getSelectedTile().objectOnTile) then
    print(getSelectedTile().objectOnTile.codeName)
    if(getSelectedTile().objectOnTile.isGood) then selectedChar = getSelectedTile().objectOnTile end

  end
end