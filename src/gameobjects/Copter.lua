local top, bottom = 44, 52

local Copter = Class
{
  type = GameObject.newType("Copter"),

  img = love.graphics.newImage("assets/copter.png"),
  layer = 1,

  init = function(self, x, y)

    y = top + math.random(bottom - top)

    if y < top then y = top end
    if y > bottom then y = bottom end
    GameObject.init(self, x, y)

    self.t = 0
    self.bomb_timer = 1

    self.x = 0
    self.dx = useful.iSignedRand()*(12 + math.random()*4)


    if self.dx < 0 then
      self.x = w
    end
  end,
}
Copter:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function Copter:draw()
  local r = -(math.pi/4) * math.floor(self.t)
  local x, y = self.x, self.y - math.sin(r)*2
  local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

  inColourCanvas(2)
  if BOOM > 0 then
    yellow()
  else
    darkYellow()
  end
  rekt(snap_x - 20, snap_y - 12, 64, 32)

  inAlphaCanvas(2)
  
  draw(self.img, x, y, 0, 1, 1, 16, 16)
end

function Copter:update(dt)

  GameObject.update(self, dt)

  self.t = self.t + 10*dt

  self.bomb_timer = self.bomb_timer - dt
  if self.bomb_timer <= 0 then
    Bomb(self.x, self.y)
    self.bomb_timer = 2
  end

  if (self.x > w + 32) or (self.x < - 32) then
    self.purge = true
    score = score + 10
  end

end


--[[------------------------------------------------------------
Export
--]]--


return Copter