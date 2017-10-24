-- Each level will inherit from this class which itself inherits from Gamestate.
-- This class is Gamestate but with function for loading up Tiled maps.

local bump = require 'libs.bump.bump'
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'
local sti = require 'libs.sti.sti'
local Entities = require 'entities.Entities'
local camera = require 'libs.camera'

local LevelBase = Class{
  __includes = Gamestate,
  init = function(self, mapFile)
    self.map = sti(mapFile, { 'bump' }) -- Use sti to open map file, tell sti we are using bump for collision handling
    self.world = bump.newWorld(32) -- Declare a world for collisons to occur in
    self.map:resize(love.graphics.getWidth(), love.graphics.getHeight()) -- Resize map to fill screen
    self.map:bump_init(self.world) -- Initialize the bump array for the map

    Entities:enter() -- Create the entities system.
  end,
  Entities = Entities, -- Make Entities a class variable for easy access.
  camera = camera
}

function LevelBase:keypressed(key)
  -- All levels will have a pause menu
  if Gamestate.current() ~= pause and key == 'p' then
    Gamestate.push(pause)
  end
end

function LevelBase:positionCamera(player, camera)
  local mapWidth = self.map.width * self.map.tilewidth
  local halfScreen = love.graphics.getWidth() / 2

  if player.x < (mapWidth - halfScreen) then
    boundX = math.max(0, player.x - halfScreen)
  else
    boundX = math.min(player.x - halfScreen, mapWidth - love.graphics.getWidth())
  end
  camera:setPosition(boundX, 0)
end

return LevelBase
