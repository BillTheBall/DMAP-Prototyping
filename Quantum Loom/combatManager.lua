combatManager = {}
allChars = {}
allEnemies = {}

function combatManager:Load(encounterInfo)
  table.insert(allChars, char_Tank()) 
  allChars[1].pos.x = 3
  allChars[1].pos.y = 3
  table.insert(allChars, char_Support())
  allChars[2].pos.x = 6
  allChars[2].pos.y = 6
  table.insert(allChars, char_Support())
  allChars[3].pos.x = 9
  allChars[3].pos.y = 8
  table.insert(allEnemies, enemy_Combat:new()) 
  allEnemies[1].pos.x = 2
  allEnemies[1].pos.y = 7
  for i = 1, #allChars do
    combatGrid[allChars[i].pos.x][allChars[i].pos.y].objectOnTile = allChars[i]
  end  
  for i = 1, #allEnemies do
    combatGrid[allEnemies[i].pos.x][allEnemies[i].pos.y].objectOnTile = allEnemies[i]
  end
end

function combatManager:new()
  o =  
  {
    
  }
  setmetatable(o, self)
  self.__index = self
  return o
end
return combatManager:new()