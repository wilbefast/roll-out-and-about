local w, h

local top, bottom, left, right = 96, 134, 32, 96

local Truck = Class
{
  type = GameObject.newType("Truck"),

	img = love.graphics.newImage("assets/truck_0.png"),
	img2 = love.graphics.newImage("assets/truck_1.png"),
	layer = 1,
	lives = 3,

  init = function(self, x, y)
    GameObject.init(self, x, y, 16, 8)
    self.t = 0
  	w = self.img:getWidth()
		h = self.img:getHeight()
  end
}
Truck:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function Truck:draw()
	local x, y = self.x, self.y - self.h
	local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

	inColourCanvas(2)
	if Bomb.BOOM > 0 then
 		white()
 	else
 		darkBlue()
 	end
 	rekt(snap_x - 40, snap_y - 16, 80, 37)

	inAlphaCanvas(2)
	if self.t > 1 then
 		draw(self.img, x, y, 0, 1, 1, 32, 16)
 	else
 		draw(self.img2, x, y, 0, 1, 1, 32, 16)
 	end
end

function Truck:update(dt)
	-- move with keyboard
	local kx, ky = 0, 0
	if love.keyboard.isDown("left") then
		kx = kx - 1
	end
	if love.keyboard.isDown("right") then
		kx = kx + 1
	end
	if love.keyboard.isDown("up") then
		ky = ky - 1
	end
	if love.keyboard.isDown("down") then
		ky = ky + 1
	end
	self.x, self.y = self.x + 128*kx*dt, self.y + 128*ky*dt
	if self.x < left then self.x = left end
	if self.x > right then self.x = right end
	if self.y < top then self.y = top end
	if self.y > bottom then self.y = bottom end

	self.t = self.t + dt*10
	if self.t > 2 then
		self.t = 0
	end
end

function Truck:eventCollision(other)
	if other:isType("Bomb") then
		other:explode()
		self.lives = self.lives - 1
		if self.lives == 0 then
			self.purge = true
		end
	end
end


--[[------------------------------------------------------------
Export
--]]--


return Truck