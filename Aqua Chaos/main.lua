local Controls = require 'controls'

local Draw = require 'draw'
local Velocity = require 'velocity'
local physics = require 'physics'
local Collider = require 'collider'

local Collision_Manager = require 'collision_manager'
local collision_manager
local Camera = require 'camera'
local camera
local Player = require 'player'
local player
local Box = require 'box'
local box1

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  camera = Camera.Create(0, 0, 4)
  collision_manager = Collision_Manager.Create()

  player = Player.Create(Draw, Velocity, physics, Collider, collision_manager)
  box1 = Box.Create(10, -5, 10, 10, Collider, collision_manager)
end

function love.update(dt)
  love.timer.sleep(0.01) -- FPS Tester
  
  Controls.Main(player, dt)
end

function Camera_Render()
  camera.cam:attach()
    player.sprite:Draw(player.position)
  camera.cam:detach()
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  Camera_Render()

  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  love.graphics.print("player speed: " .. player.velocity.speed.x, 10, 20)
  love.graphics.print("player ACcel: " .. player.walking.acceleration.x, 10, 30)

  love.graphics.setColor(1, 0, 0)
  player.collider:Draw(camera.cam, player.position)
  box1.collider:Draw(camera.cam, box1.position)

  collision_manager:Collision_Check(player.collider.box, player.position)
end