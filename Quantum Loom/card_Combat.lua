baseCard = 
{
  --there won't be any card types in the prototype ver, but they are like "filters", which char can have a card, so for ex.
  --if you have a char that is a swordsman, they couldn't use "shoot bow" card. But most cards would be general, idk. This is a problem
  --for the future it the game is chosen
  cardType = "unasinged!",
  displayName = "unasinged!",
  codeName = "unasinged!",
}

function baseCard:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function baseCard:onPlay()
  error("Called baseCard:onPlay(). You should always use an override of onPlay()!")
end

function baseCard:isTargetValid()
  error("Called baseCard:isTargetValid(). You should always use an override of isTargetValid()!")
end
function baseCard:moveFromHandToGY()
  --print(getmetatable(selectedChar.currentHand[1]),getmetatable(self))
  for i=1, #selectedChar.currentHand do
    if(selectedChar.currentHand[i] == self) then
      table.insert(selectedChar.currentGY, self)
      table.remove(selectedChar.currentHand, i)
    end
  end
end
handGranade_Card = baseCard:new()
handGranade_Card.codeName = "kaboom"
function handGranade_Card:isTargetValid(x,y)
  local targetX = x or getSelectedTile().pos.x
  local targetY = y or getSelectedTile().pos.y
  local range = 2
  --print(isTileInSquareRange(9, 9, targetX, targetY, range))
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, targetX, targetY, range)
end
function handGranade_Card:onPlay()
  local areaDamage = 10
  local areaRange = 1
  for _, tile in ipairs(getTilesInSquareRange(getSelectedTile().pos.x, getSelectedTile().pos.y, areaRange)) do
    if tile.objectOnTile then
      tile.objectOnTile:dealDamage(areaDamage, selectedChar)
    end
  end 
end

move_Card = baseCard:new()
move_Card.codeName = "move"

function move_Card:isTargetValid(x,y)
  local targetX = x or getSelectedTile().pos.x
  local targetY = y or getSelectedTile().pos.y
  local range = 2
  --print(isTileInSquareRange(9, 9, targetX, targetY, range))
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, targetX, targetY, range)
end
function move_Card:isTileValid(x, y)
    local range = 2
  --print(isTileInSquareRange(9, 9, targetX, targetY, range))
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, x, y, range)
end
function move_Card:onPlay()
  selectedChar:moveEntety(getSelectedTile().pos.x, getSelectedTile().pos.y)
  baseCard:moveFromHandToGY()
end

quickHeal_Card = baseCard:new()
quickHeal_Card.codeName = "quickHeal"

function quickHeal_Card:isTargetValid(x,y)
  local targetX = x or getSelectedTile().pos.x
  local targetY = y or getSelectedTile().pos.y
  local range = 4
  --Don't change the order. We are saving 1 if statment like this :stonks:
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, targetX, targetY, range) and combatGrid[targetX][targetY].objectOnTile and combatGrid[targetX][targetY].objectOnTile.isGood
end

function quickHeal_Card:onPlay()
  local healAmount = 3
  combatGrid[getSelectedTile().pos.x][getSelectedTile().pos.y].objectOnTile:heal(healAmount)
end