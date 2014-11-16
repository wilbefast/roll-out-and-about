
local Bomb = Class
{
  type = GameObject.newType("Bomb"),
  img = love.graphics.newImage("assets/bomb.png"),

  layer = 0,

  init = function(self, x, y)
    GameObject.init(self, x, y, 32, 32)
    self.dy = 32
    self.t = 1 + math.random()*2
  end
}
Bomb:include(GameObject)


--[[------------------------------------------------------------
Game loop
--]]--

function Bomb:draw()
  local x, y = self.x, self.y
  local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

  inColourCanvas(2)
  teal()
  rekt(snap_x - 8, snap_y - 8, 32, 24)

  inAlphaCanvas(2)
  draw(self.img, x, y, 0, 1, 1, 4, 4)
end

function Bomb:update(dt)

  self.x = self.x + self.dx*dt
  self.y = self.y + self.dy*dt

  self.t = self.t - dt
  if self.t <= 0 then
    self:explode()
  end
end

function Bomb:explode()
  self.purge = true
  audio:play_sound("explode")
  self.purge = true
  for i = 1, 10 do
    local a = math.random()*math.pi*2
    local dx = math.cos(a)
    local dy = math.sin(a)
    ExplodeParticle(self.x, self.y, dx, dy)
    BOOM = math.max(BOOM, 0.5)
  end
end

--[[------------------------------------------------------------
Export
--]]--


return Bomb