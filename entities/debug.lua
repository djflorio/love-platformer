local Class = require 'libs.hump.class'

local debug = Class{}

function debug:init(player, x, y, spacing)
  self.player = player
  self.x = x
  self.y = y
  self.spacing = spacing
end

function debug:draw()
  love.graphics.print("xVelocity: " .. self.player.xVelocity, self.x, self.y)
  love.graphics.print("yVelocity: " .. self.player.yVelocity, self.x, self.y + (1 * self.spacing))
  love.graphics.print("acc: " .. self.player.acc, self.x, self.y + (2 * self.spacing))
  love.graphics.print("maxSpeed: " .. self.player.maxSpeed, self.x, self.y + (3 * self.spacing))
  love.graphics.print("friction: " .. self.player.friction, self.x, self.y + (4 * self.spacing))
  love.graphics.print("gravity: " .. self.player.gravity, self.x, self.y + (5 * self.spacing))
  love.graphics.print("isJumping: " .. tostring(self.player.isJumping), self.x, self.y + (6 * self.spacing))
  love.graphics.print("isGrounded: " .. tostring(self.player.isGrounded), self.x, self.y + (7 * self.spacing))
  love.graphics.print("hasReachedMax: " .. tostring(self.player.hasReachedMax), self.x, self.y + (8 * self.spacing))
  love.graphics.print("jumpAcc: " .. self.player.jumpAcc, self.x, self.y + (9 * self.spacing))
  love.graphics.print("jumpMaxSpeed: " .. self.player.jumpMaxSpeed, self.x, self.y + (10 * self.spacing))
end

return debug
