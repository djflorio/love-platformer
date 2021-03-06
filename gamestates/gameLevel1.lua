-- Import our libraries
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'

-- Import our base class
local LevelBase = require 'gamestates.LevelBase'

local Player = require 'entities.player'
local Debug = require 'entities.debug'
--local camera = require 'libs.camera'

player = nil
debug = nil

-- gameLevel1 extends LevelBase
local gameLevel1 = Class{
  __includes = LevelBase
}

function gameLevel1:init()
  LevelBase.init(self, 'assets/levels/level_1.lua')
end

function gameLevel1:enter()
  player = Player(self.world, 32, 64)
  debug = Debug(player, 5, 5, 15)
  LevelBase.Entities:add(player)
end

function gameLevel1:update(dt)
  self.map:update(dt) -- Remember, we inherited map from LevelBase
  LevelBase.Entities:update(dt)
  LevelBase.positionCamera(self, player, camera)
end

function gameLevel1:draw()
  camera:set() -- Attach the camera before drawing the entities
  self.map:draw(-camera.x, -camera.y)
  LevelBase.Entities:draw()
  camera:unset() -- Detatch after running to avoid weirdness
  debug:draw()
end

function gameLevel1:keypressed(key)
  LevelBase:keypressed(key)
end

return gameLevel1
