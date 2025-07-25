CombatGrid = {}

function getSelectedTile()
  local mouseX, mouseY = love.mouse.getPosition()
  local tileX = math.ceil(mouseX/50)
  local tileY = math.ceil(mouseY/50)
  if tileX > 16 then tileX = 16 end
  if tileX < 1 then tileX = 1 end
  if tileY > 12 then tileY = 12 end
  if tileY < 1 then tileY = 1 end
  return combatGird[tileX][tileY]
end

function isTileInSquareRange(centerX, centerY, x, y, range)
  if(x <= centerX + range and x >= centerX - range and
    y <= centerY + range and y >= centerY - range) then
    return true end
  return false
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
            if combatGird[i] and combatGird[i][j] then
                table.insert(tiles, combatGird[i][j])
            end
        end
    end

    return tiles
end
--capital cuz load is some buildin func idk
function CombatGrid:Load()
  combatGird = {}
  for i = 1, 16 do
    local combatRow = {}
    for j = 1, 12 do
        local tile = emptyTile_Combat:new()
        tile.pos = { x = i, y = j }
        table.insert(combatRow, tile)
    end
    table.insert(combatGird, combatRow)
  end
  for i = 1, 16 do
      for j = 1, 12 do
        --print(combatGird[i][j].codeName .. " " .. j .. " " .. i)
      end
  end
  for _, tile in ipairs(getTilesInSquareRange(2,2,1)) do
    --print("x:" .. tile.pos.x .. "y:" .. tile.pos.y)
  end 
end
function CombatGrid:draw()
    for i = 1, 16 do
      for j = 1, 12 do
        if(isTileInSquareRange(selectedChar.pos.x,selectedChar.pos.y,i,j,2) == true and (selectedChar.pos.x ~= i or selectedChar.pos.y~=j))       then 
          love.graphics.setColor(0,1,0)
        else love.graphics.setColor(1,1,1)
       end
        --end
        if(combatGird[i][j].objectOnTile) then
            if(combatGird[i][j].objectOnTile.isGood) then
              love.graphics.setColor(0,0,1)
            else
              love.graphics.setColor(1,.5,.5)
            end
          
        end        
        if(getSelectedTile().pos.x == i and getSelectedTile().pos.y == j) then
          love.graphics.setColor(1,1,0)
        end
        
        --end
        love.graphics.rectangle("fill", (i-1)*50, (j-1)*50, 50, 50)
        love.graphics.setColor(0,0,0)
        love.graphics.print(combatGird[i][j].pos.x .. " " .. combatGird[i][j].pos.y , (i-1)*50, (j-1)*50)
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