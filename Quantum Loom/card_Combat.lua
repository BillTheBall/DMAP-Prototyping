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
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function baseCard:onPlay()
  local areaDamage = 10
  local areaRange = 1
  for _, tile in ipairs(getTilesInSquareRange(getSelectedTile().pos.x, getSelectedTile().pos.y, areaRange)) do
    if(tile.objectOnTile) then tile.objectOnTile:dealDamage(areaDamage, selectedChar) end
 end
end
function baseCard:isTargetValid()
  local range = 2
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, getSelectedTile().pos.x, getSelectedTile().pos.y, range)
end

handGranade_Card = baseCard:new()
handGranade_Card.codeName = "kaboom"
function handGranade_Card:onPlay()
  
end