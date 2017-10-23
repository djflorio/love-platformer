local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'

local player = Class{
  __includes = Entity -- Player class inherits our Entity class
}

function player:init(world, x, y)
  self.img = love.graphics.newImage('/assets/character_block.png')

  Entity.init(self, world, x, y, self.img:getWidth(), self.img:getHeight())

  -- Add our unique player values
  self.xVelocity = 0
  self.yVelocity = 0
  self.acc = 100
  self.maxSpeed = 600
  self.friction = 20
  self.gravity = 80

  self.isJumping = false
  self.isGrounded = false
  self.hasReachedMax = false
  self.jumpAcc = 500
  self.jumpMaxSpeed = 11

  self.world:add(self, self:getRect())
end

function player:collisionFilter(other)
  local x, y, w, h = self.world:getRect(other)
  local playerBottom = self.y + self.h
  local otherBottom = y + h

  if playerBottom <= y then -- bottom of player collides with top of platform.
    return 'slide'
  end
end

function player:update(dt)
  local prevX, prevY = self.x, self.y

  -- Apply friction
  self.xVelocity = self.xVelocity * (1 - math.min(dt * self.friction, 1))
  self.yVelocity = self.yVelocity * (1 - math.min(dt * self.friction, 1))

  -- Apply gravity
  self.yVelocity = self.yVelocity + self.gravity * dt

  if love.keyboard.isDown("left", "a") and self.xVelocity > -self.maxSpeed then
    self.xVelocity = self.xVelocity - self.acc * dt
  elseif love.keyboard.isDown("right", "d") and self.xVelocity < self.maxSpeed then
    self.xVelocity = self.xVelocity + self.acc * dt
  end

  if love.keyboard.isDown("up", "w") then
    if -self.yVelocity < self.jumpMaxSpeed and not self.hasReachedMax then
      self.yVelocity = self.yVelocity - self.jumpAcc * dt
    elseif math.abs(self.yVelocity) > self.jumpMaxSpeed then
      self.hasReachedMax = true
    end
    self.isGrounded = false
  end

  -- The goal locations, which are used for collision detection
  local goalX = self.x + self.xVelocity
  local goalY = self.y + self.yVelocity

  -- Move the player while testing for collisions
  self.x, self.y, collisions, len = self.world:move(self, goalX, goalY, self.collisionFilter)

  -- Loop through those collisions to see if anything important is happening
  for i, coll in ipairs(collisions) do
    if coll.touch.y > goalY then -- We touched below
      self.hasReachedMax = true
      self.isGrounded = false
    elseif coll.normal.y < 0 then
      self.hasReachedMax = false
      self.isGrounded = true
    end
  end
end

function player:draw()
  love.graphics.draw(self.img, self.x, self.y)
  local s = 5
  local ts = 15
  if DEBUG then
    love.graphics.print("xVelocity: " .. self.xVelocity, 5, s)
    love.graphics.print("yVelocity: " .. self.yVelocity, 5, s + (1*ts))
    love.graphics.print("acc: " .. self.acc, 5, s + (2*ts))
    love.graphics.print("maxSpeed: " .. self.maxSpeed, 5, s + (3*ts))
    love.graphics.print("friction: " .. self.friction, 5, s + (4*ts))
    love.graphics.print("gravity: " .. self.gravity, 5, s + (5*ts))
    love.graphics.print("isJumping: " .. tostring(self.isJumping), 5, s + (6*ts))
    love.graphics.print("isGrounded: " .. tostring(self.isGrounded), 5, s + (7*ts))
    love.graphics.print("hasReachedMax: " .. tostring(self.hasReachedMax), 5, s + (8*ts))
    love.graphics.print("jumpAcc: " .. self.jumpAcc, 5, s + (9*ts))
    love.graphics.print("jumpMaxSpeed: " .. self.jumpMaxSpeed, 5, s + (10*ts))
  end
end

return player
