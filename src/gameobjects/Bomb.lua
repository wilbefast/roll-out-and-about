
local Bomb = Class
{
  type = GameObject.newType("Bomb"),

  img = love.graphics.newImage("assets/mine.png"),
  layer = 0,

  init = function(self, x, y)
    GameObject.init(self, x, y, 6, 6)
    self.t = 0
  end,

  BOOM = 0
}
Bomb:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function Bomb:draw()
  local r = -(math.pi/4) * math.floor(self.t)
  local x, y = self.x, self.y + self.h - math.sin(r)*4
  local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

  inColourCanvas(2)
  darkYellow()
  rekt(snap_x - 16, snap_y - 8, 32, 24)

  inAlphaCanvas(2)
  
  draw(self.img, x, y, r, 1, 1, 8, 8)
end

function Bomb:update(dt)

  self.t = self.t + 10*dt

  self.x = self.x - 256*dt
  if self.x < -100 then
    self.purge = true
    score = score + 1
  end
end

function Bomb:explode()
  self.purge = true
  for i = 1, 10 do
    local a = math.random()*math.pi*2
    local dx = math.cos(a)
    local dy = math.sin(a)
    ExplodeParticle(self.x, self.y, dx, dy)
    Bomb.BOOM = 1
  end
end


--[[------------------------------------------------------------
Export
--]]--


return Bomb