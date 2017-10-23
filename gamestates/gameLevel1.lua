-- Import our libraries
bump = require 'libs.bump.bump'
Gamestate = require 'libs.hump.gamestate'

-- Import our Entity system
local Entities = require 'entities.Entities'
local Entity = require 'entities.Entity'

-- Create our Gamestate
local gameLevel1 = {}

-- Import the Entities we build
local Player = require 'entities.player'
local Ground = require 'entities.ground'

-- Declare a couple of important variables
player = nil
world = nil

function gameLevel1:enter()
  -- Game levels do need collisions
  world = bump.newWorld(16) -- Create a world for bump to function in

  -- Initialize our Entity system
  Entities:enter()
  player = Player(world, 16, 16)
  ground_0 = Ground(world, 120, 360, 640, 16)
  ground_1 = Ground(world, 0, 448, 640, 16)

  -- Add instances of our entities to the Entity list
  Entities:addMany({player, ground_0, ground_1})
end

function gameLevel1:update(dt)
  Entities:update(dt) -- Execute the update function for each Entity
end

function gameLevel1:draw()
  Entities:draw() -- Execute the draw function of each Entity
end

return gameLevel1
