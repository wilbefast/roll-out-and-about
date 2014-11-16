local top, bottom = 104, 152

local coloursLight = { yellow, yellow, yellow }
local coloursDark = { darkYellow, darkYellow, darkYellow }


-- local coloursLight = { green, teal, yellow }
-- local coloursDark = { darkGreen, darkTeal, darkYellow }

local Car = Class
{
  type = GameObject.newType("Car"),

  img = love.graphics.newImage("assets/car.png"),
  layer = 0,

  init = function(self, x, y)

    y = top + math.random(bottom - top)

    if y < top then y = top end
    if y > bottom then y = bottom end
    GameObject.init(self, x, y, 9, 9)
    self.t = 0

    self.dx = -300 + math.random()*200
    self.dy = math.random()*32 -math.random()*32

    self.colour = math.floor(math.random()*3) + 1
  end,
}
Car:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function Car:draw()
  local r = -(math.pi/4) * math.floor(self.t)
  local x, y = self.x, self.y - math.sin(r)*2
  local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

  inColourCanvas(2)
  if BOOM > 0 then
    (coloursLight[self.colour])()
  else
    (coloursDark[self.colour])()
  end
  rekt(snap_x - 20, snap_y - 12, 64, 32)

  inAlphaCanvas(2)
  
  draw(self.img, x, y, 0, 1, 1, 16, 16)
end

function Car:update(dt)

  GameObject.update(self, dt)

  self.t = self.t + 10*dt

  if self.x < -100 then
    self.purge = true
    if GameObject.getObjectOfType("Truck") then
      score = score + 2
    end
  end

  local t, b = road.top(), road.top() + road.width()
  if self.y < t then
    self.y = t
    self.dy = -self.dy
  end
  if self.y > b then
    self.y = b
    self.dy = -self.dy
  end

end

function Car:explode()
  audio:play_sound("explode")
  self.purge = true
  for i = 1, 30 do
    local a = math.random()*math.pi*2
    local dx = math.cos(a)
    local dy = math.sin(a)
    ExplodeParticle(self.x, self.y, dx, dy)
    BOOM = 1
  end
end


--[[------------------------------------------------------------
Export
--]]--


return Car