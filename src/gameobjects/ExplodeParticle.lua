
local ExplodeParticle = Class
{
  type = GameObject.newType("ExplodeParticle"),

  --img = love.graphics.newImage("assets/mine.png"),
  layer = 2,

  init = function(self, x, y, dx, dy)
    GameObject.init(self, x, y, 0, 0)
    self.dx = dx*128
    self.dy = dy*128
    self.t = 0
  end
}
ExplodeParticle:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function ExplodeParticle:draw()
  local r = -(math.pi/4) * math.floor(self.t)
  local x, y = self.x, self.y + self.h - math.sin(r)*4
  local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

  inColourCanvas(2)
  yellow()
  rekt(snap_x - 16, snap_y - 8, 32, 24)

  inAlphaCanvas(2)
  rekt(snap_x - 16, snap_y - 8, 32, 24)
end

function ExplodeParticle:update(dt)

  self.x = self.x + self.dx*dt
  self.y = self.y + self.dy*dt

  self.t = self.t + 2*dt

  if self.t > 1 then
    self.purge = true
  end
end

--[[------------------------------------------------------------
Export
--]]--


return ExplodeParticle