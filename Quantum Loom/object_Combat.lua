--object_Combat is the base "class?" (idk lua that much rn), so everything that is on the grid,
--inherets from it.
object_Combat =
{
  pos = {
    x = 2,
    y = 1,
  },
  codeName= "baseObject",
  sprite = love.graphics.newImage("sprites/tile.png"),
  tags = {}
}

function object_Combat:new()
  o =  
  {
      pos = {x = 1, y = 3},
      --codeName= "baseObject",
      --sprite = love.graphics.newImage("sprites/tile.png"),
      --tags = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

--emptyTile_Combat is for... empty tile on the combat grid =OOOOO.
emptyTile_Combat = object_Combat:new()
emptyTile_Combat.codeName = "emptyTile"
emptyTile_Combat.objectOnTile = nil
function emptyTile_Combat:playAnimation(quad)
  
end

--entety_Combat is used for everything that has hp. so like everything that isnt a stone or something.
entety_Combat = object_Combat:new()
entety_Combat.codeName = "abstract!"
entety_Combat.isGood = nil
entety_Combat.currentHealth = 10
entety_Combat.maxHealth = 20
entety_Combat.currentSpeed = 10

function entety_Combat:moveEntety(x,y)
  --Removes itselfs from the tile its standing on
  combatGird[self.pos.x][self.pos.y].objectOnTile = nil
  self.pos.x = x
  self.pos.y = y
  combatGird[self.pos.x][self.pos.y].objectOnTile = self
end

function entety_Combat:dealDamage(damageToDeal, attacker)
  if(attacker.isGood == self.isGood) then
    --In this case, its friendly fire
    print("ff!")
    print("uhu", huhuhuhuhuhuVprasaj)
    
    entety_Combat:a()
  else
    if(damageToDeal > 0) then
    --if damage is 0 or less, nothing happens
    self.currentHealth = self.currentHealth - damageToDeal
    print("dealt " .. damageToDeal .. " damage to " .. self.codeName)
    end
  end

end
function entety_Combat.a()
  print("uhu", huhuhuhuhuhuVprasaj)
end
function entety_Combat:heal(amountToHeal)
  if(damageToDeal > 0) then
    --if heal is 0 or less, nothing happens
    self.currentHealth = self.currentHealth + amountToHeal
    if(self.currentHealth > self.maxHealth) then
      self.currentHealth = slef.maxHealth
    end
  end
end
--enemy_Combat is used for... enemies =O
enemy_Combat = entety_Combat:new()
enemy_Combat.isGood = false
enemy_Combat.codeName = "enemy"

--char_Combat
char_Combat = entety_Combat:new()
char_Combat.isGood = true
char_Combat.codeName = "char"

char_Combat.fullDeck = {}
char_Combat.currentDeck = {}
char_Combat.currentGY = {}
