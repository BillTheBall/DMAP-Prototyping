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
  for _, tile in ipairs(getTilesInSquareRange(getSelectedTile().pos.x, getSelectedTile().pos.y, 1)) do
    if(tile.objectOnTile) then tile.objectOnTile:dealDamage(10, selectedChar) end
 end
end
function baseCard:isTargetValid()
  return isTileInSquareRange(selectedChar.pos.x, selectedChar.pos.y, getSelectedTile().pos.x, getSelectedTile().pos.y, 2)
end

handGranade_Card = baseCard:new()
handGranade_Card.codeName = "kaboom"