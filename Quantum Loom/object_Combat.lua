--object_Combat is the base "class?" (idk lua that much rn), so everything that is on the grid,
--inherets from it.
require"card_Combat"
object_Combat =
{
  pos = {
    x = 2,
    y = 1,
  },
  codeName= "baseObject",
  sprite = nil,
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
--Current stats
entety_Combat.currentHealth = 10
entety_Combat.currentSpeed = 10
entety_Combat.currentShield = 0
--Base stats
entety_Combat.maxHealth = 20
entety_Combat.baseSpeed = 5
function entety_Combat:moveEntety(x,y)
  --Removes itselfs from the tile its standing on
  if(combatGrid[x][y].objectOnTile == nil) then
    combatGrid[self.pos.x][self.pos.y].objectOnTile = nil
    self.pos.x = x
    self.pos.y = y
    combatGrid[self.pos.x][self.pos.y].objectOnTile = self
  end
end

function entety_Combat:dealDamage(damageToDeal, attacker)
  if(attacker.isGood == self.isGood) then
    --In this case, its friendly fire
    print("ff!")
  else
    if(damageToDeal > 0) then
    --if damage is 0 or less, nothing happens
    self.currentHealth = self.currentHealth - damageToDeal
    print("dealt " .. damageToDeal .. " damage to " .. self.codeName)
    end
  end

end
function entety_Combat:heal(healAmount)
  if(healAmount > 0) then
    --if heal is 0 or less, nothing happens
    self.currentHealth = self.currentHealth + healAmount
    if(self.currentHealth > self.maxHealth) then
      self.currentHealth = self.maxHealth
    end
  end
end
--enemy_Combat is used for... enemies =O
enemy_Combat = entety_Combat:new()
enemy_Combat.isGood = false
enemy_Combat.codeName = "enemy"

function enemy_Combat:getDebugText()
  return "Code Name: " .. self.codeName .. "\n" ..
         "Current Health: " .. self.currentHealth .. "\tMax Health: " .. self.maxHealth .. "\n" ..
         "Current Speed: " .. self.currentSpeed .. "\tBase Speed: " .. self.baseSpeed .. "\n" ..
         "Current Shield: " .. self.currentShield .. "\n\n"  
end
--char_Combat
char_Combat = entety_Combat:new()
char_Combat.isGood = true
char_Combat.codeName = "char"

char_Combat.fullDeck = {}
char_Combat.currentDeck = {}
char_Combat.currentGY = {}
char_Combat.currentHand = {}
char_Combat.cardToBePlayed = nil
function char_Combat:shuffleDeck()
  for i = #self.currentDeck, 2, -1 do
    local j = math.random(i)
    self.currentDeck[i], self.currentDeck[j] = self.currentDeck[j], self.currentDeck[i]
  end
end
function char_Combat:drawCard(drawAmount)
  for i = 1, drawAmount do
    if(self.currentDeck[1]) then
      table.insert(self.currentHand, self.currentDeck[1])
      table.remove(self.currentDeck, 1)
    else 
      self:moveGYToDeck()
    end
  end
end
function char_Combat:selectChar()
  --If you switch while planning to play a card, this prevents issues with it
  if(selectedChar) then selectedChar.cardToBePlayer = nil end
  selectedChar = getSelectedTile().objectOnTile
end
function char_Combat:moveGYToDeck()
  if(self.currentGY[1]) then
    table.insert(self.currentDeck,unpack(self.currentGY))
    self:shuffleDeck()
    self.currentGY = {}
  end
end
function char_Combat:getDebugText()
  fullDeckList = ""
  currentDeckList = ""
  currentHandList = ""
  currentGYList = ""
  for i=1, #self.fullDeck do
    fullDeckList = fullDeckList .. self.fullDeck[i].codeName .. "\n"
  end
  for i=1, #self.currentDeck do
    currentDeckList = currentDeckList .. self.currentDeck[i].codeName .. "\n"
  end  
  for i=1, #self.currentHand do
    currentHandList = currentHandList .. self.currentHand[i].codeName .. "\n"
  end  
  for i=1, #self.currentGY do
    currentGYList = currentGYList .. self.currentGY[i].codeName .. "\n"
  end
  return "Code Name: " .. self.codeName .. "\n" ..
         "Current Health: " .. self.currentHealth .. "\tMax Health: " .. self.maxHealth .. "\n" ..
         "Current Speed: " .. self.currentSpeed .. "\tBase Speed: " .. self.baseSpeed .. "\n" ..
         "Current Shield: " .. self.currentShield .. "\n\n" .. 
         "Full Deck in Order: \n" .. fullDeckList .. "\n" ..
         "Current Deck in Order: \n" .. currentDeckList .. "\n" ..
         "Current Hand in Order: \n" .. currentHandList .. "\n" ..
         "Current GY in Order: \n" .. currentGYList .. "\n"
end

--char_Tank is a class for the tank char. Since this is a prototype, i don't have a name for them yet..
function char_Tank()
    local o = char_Combat:new()

    o.codeName = "tank"
    o.fullDeck = 
    {
        move_Card:new(),
        handGranade_Card:new()
    }
    o.currentDeck = { unpack(o.fullDeck) }
    o.currentHand = {}
    o.currentGY = 
    {
      quickHeal_Card:new()
    }
    return o
end

--This will prob be that druid droid char idk
function char_Support()
    local o = char_Combat:new()

    o.codeName = "support"
    o.fullDeck = 
    {
        move_Card:new(),
        move_Card:new(),
        quickHeal_Card:new()
    }
    o.currentDeck = { unpack(o.fullDeck) }
    o.currentHand = {}

    return o
end
