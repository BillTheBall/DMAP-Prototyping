--[[
How to play
  Left and Right arrows to move
  Space to reset players position to 0,0
]]


local Controls = require 'controls'

local Draw = require 'draw'
local physics = require 'physics'

local Collision = require 'collision'
local collision
local Camera = require 'camera'
local camera
local Player = require 'player'
local player
local Box = require 'box'
local box1

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  camera = Camera.Create(0, 0, 4)
  collision = Collision.Create()

  player = Player.Create(Draw, Velocity, physics, collision)
  box1 = Box.Create(10, -5, 10, 10, collision)
  box2 = Box.Create(-150, 50, 300, 10, collision)
  box3 = Box.Create(-80, 20, 40, 10, collision)
end

function love.update(dt)
  love.timer.sleep(0.01) -- FPS Tester
  
  Controls.Main(player, collision, dt)
  if love.keyboard.isDown("space") then
    collision.world:update(player.box, 0, 0)
    player.box.x = 0
    player.box.y = 0
  end
end

function Camera_Render()
  camera.cam:attach()
    player.sprite:Draw(player.box)
  camera.cam:detach()
end

function love.draw()
  love.graphics.setColor(1, 1, 1) -- White
  Camera_Render()

  love.graphics.setColor(1, 1, 1) -- White
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  love.graphics.print("player coords: " .. player.box.x .. " " .. player.box.x, 10, 20)
  love.graphics.print("player speed: " .. player.velocity.x.speed, 10, 40)
  love.graphics.print("player ACcel: " .. player.physics.x.acceleration, 10, 50)
  
  love.graphics.setColor(1, 0, 0) -- Red
  camera:Draw_Box(player.box)
  camera:Draw_Box(box1.box)
  camera:Draw_Box(box2.box)
end