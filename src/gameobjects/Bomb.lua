local top, bottom = 96, 134

local Bomb = Class
{
  type = GameObject.newType("Bomb"),

  img = love.graphics.newImage("assets/mine.png"),
  img_face = love.graphics.newImage("assets/mine_face.png"),
  layer = 0,

  init = function(self, x, y)
    if y < top then y = top end
    if y > bottom then y = bottom end
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
  rekt(snap_x - 20, snap_y - 12, 40, 32)

  inAlphaCanvas(2)
  
  draw(self.img, x, y, r, 1, 1, 8, 8)
  draw(self.img_face, x, y, 0, 1, 1, 8, 8)
end

function Bomb:update(dt)

  self.t = self.t + 10*dt

  self.x = self.x - 256*dt
  if self.x < -100 then
    self.purge = true
    if GameObject.getObjectOfType("Truck") then
      score = score + 1
    end
  end
end

function Bomb:explode()
  audio:play_sound("explode")
  self.purge = true
  for i = 1, 30 do
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