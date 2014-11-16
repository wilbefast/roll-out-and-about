
local ExplodeParticle = Class
{
  type = GameObject.newType("ExplodeParticle"),

  img = {},
  layer = 2,

  init = function(self, x, y, dx, dy)
    GameObject.init(self, x, y, 0, 0)
    

    local smoke, speed = math.random() > 0.5 

    if smoke then
      speed = 50 + math.random()*25
    else
      speed = 100 + math.random()*50
    end
    self.smoke = smoke
    self.dx = dx*speed
    self.dy = dy*speed
    self.t = 0
  end
}
ExplodeParticle:include(GameObject)

ExplodeParticle.load = function()
  for i = 0, 4 do
    table.insert(ExplodeParticle.img, 
      love.graphics.newImage("assets/explode_" .. tostring(i) .. ".png"))
  end
end

--[[------------------------------------------------------------
Game loop
--]]--

function ExplodeParticle:draw()
  local r = -(math.pi/4) * math.floor(self.t)
  local x, y = self.x, self.y + self.h - math.sin(r)*4
  local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

  inColourCanvas(2)
  if self.smoke then
    teal()
  else
    yellow()
  end
  rekt(snap_x, snap_y, 8, 8)

  inAlphaCanvas(2)
  local img = self.img[math.floor(self.t*#self.img) + 1]
  draw(img, snap_x, snap_y)
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