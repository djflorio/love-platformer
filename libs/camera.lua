--[[
This was taken from "Cameras in Love2D Part 1: The Basics"
http://nova-fusion.com/2011/04/19/cameras-in-love2d-part-1-the-basics/
--]]

camera = {}
camera.x = 0
camera.y = 0

function camera:set()
  love.graphics.push()
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

return camera
