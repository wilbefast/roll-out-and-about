
local Bomb = Class
{
  type = GameObject.newType("Bomb"),

  img = love.graphics.newImage("assets/mine.png"),

  init = function(self, x, y)
    GameObject.init(self, x, y, 4, 4)
    self.snap_x, self.snap_y = math.floor(x/8)*8, math.floor(y/8)*8
  end
}
Bomb:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function Bomb:draw(x, y)
  inColourCanvas(2)
  darkYellow()
  rekt(self.snap_x - 16, self.snap_y - 8, 32, 24)

  inAlphaCanvas(2)
  draw(self.img, self.x, self.y, 0, 1, 1, 8, 8)
end

function Bomb:update(dt)
  self.x = self.x - 256*dt
  if self.x < -100 then
    self.purge = true
  end

  -- snap position to nearest 8
  self.snap_x, self.snap_y = math.floor(self.x/8)*8, math.floor(self.y/8)*8
end


--[[------------------------------------------------------------
Export
--]]--


return Bomb