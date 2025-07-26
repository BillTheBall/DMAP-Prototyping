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

handGranade_Card = baseCard:new()
handGranade_Card.codeName = "kaboom"
function handGranade_Card:isTargetValid()
  local range = 2
  print("called")
  print("valid:",isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, getSelectedTile().pos.x, getSelectedTile().pos.y, 2) )
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, getSelectedTile().pos.x, getSelectedTile().pos.y, 2)
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

function move_Card:isTargetValid()
  local range = 2
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, getSelectedTile().pos.x, getSelectedTile().pos.y, range)
end

function move_Card:onPlay()
  selectedChar:moveEntety(getSelectedTile().pos.x, getSelectedTile().pos.y)
end

