CombatGrid = {}
local gridWidth = 16
local gridHeight = 12
local tileWidth = 50
local tileHeight = 50

function getSelectedTile()
  local mouseX, mouseY = love.mouse.getPosition()
  local tileX = math.ceil(mouseX/tileWidth)
  local tileY = math.ceil(mouseY/tileHeight)
  if tileX > gridWidth then tileX = gridWidth end
  if tileX < 1 then tileX = 1 end
  if tileY > gridHeight then tileY = gridHeight end
  if tileY < 1 then tileY = 1 end
  return combatGrid[tileX][tileY]
end

function isTileInSquareRange(centerX, centerY, x, y, range)
  return (x <= centerX + range and x >= centerX - range and
    y <= centerY + range and y >= centerY - range) 
end

function isTileInCircleRange(centerX, centerY, x, y, range)
  if(math.abs(centerX-x) + math.abs(centerY-y) <= range) then
    return true
  end
  return false
end

function getTilesInSquareRange(centerX, centerY, range)
    local tiles = {}

    for i = centerY - range, centerY + range do
        for j = centerX - range, centerX + range do
            -- Make sure we're within bounds of the grid
            if combatGrid[i] and combatGrid[i][j] then
                table.insert(tiles, combatGrid[j][i])
                --print("x:", i, "y:", j)
            end
        end
    end

    return tiles
end
--capital cuz load is some buildin func idk

function CombatGrid:Load()
  combatGrid = {}
  for i = 1, gridWidth do
    local combatRow = {}
    for j = 1, gridHeight do
        local tile = emptyTile_Combat:new()
        tile.pos = { x = i, y = j }
        table.insert(combatRow, tile)
    end
    table.insert(combatGrid, combatRow)
  end
  for i = 1, gridWidth do
      for j = 1, gridHeight do
        --print(combatGrid[i][j].codeName .. " " .. j .. " " .. i)
      end
  end
end
local tile = love.graphics.newImage("Sprites/tile.png")
function CombatGrid:draw()
    for i = 1, gridWidth do
      for j = 1, gridHeight do
        local spriteToDraw = tile
        if (selectedChar and selectedChar.cardToBePlayed and selectedChar.cardToBePlayed:isTargetValid(i,j))then-- and (selectedChar.pos.x ~= i or selectedChar.pos.y~=j)) then 
          love.graphics.setColor(0,1,0)
          
        else love.graphics.setColor(1,1,1)
       end
        --end
        if(combatGrid[i][j].objectOnTile) then
            if(combatGrid[i][j].objectOnTile.isGood) then
              --love.graphics.setColor(0,0,1)
              spriteToDraw = love.graphics.newImage("Sprites/EnCharGuess2.png")
            else
              love.graphics.setColor(1,.5,.5)
            end
          
        end        
        if(getSelectedTile().pos.x == i and getSelectedTile().pos.y == j) then
          love.graphics.setColor(1,1,0)
        end
        
        --end
        --love.graphics.rectangle("fill", (i-1)*50, (j-1)*50, tileWidth, tileHeight)
        love.graphics.draw(spriteToDraw, (i-1)*50, (j-1)*50, 0, 1.5, 1.5)
        love.graphics.setColor(0,0,0)
        love.graphics.print(combatGrid[i][j].pos.x .. " " .. combatGrid[i][j].pos.y , (i-1)*tileWidth, (j-1)*tileHeight)
      end
    end
end
function CombatGrid:new()
  o =  
  {
    
  }
  setmetatable(o, self)
  self.__index = self
  return o
end
return CombatGrid:new()