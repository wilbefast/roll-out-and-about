local w, h

local top, bottom, left, right = 104, 152, 32, 230

local Truck = Class
{
  type = GameObject.newType("Truck"),

	img = love.graphics.newImage("assets/truck_0.png"),
	img2 = love.graphics.newImage("assets/truck_1.png"),

	trans_img = {
		love.graphics.newImage("assets/robot_0.png"),
		love.graphics.newImage("assets/robot_1.png"),
		love.graphics.newImage("assets/robot_2.png")
	},

	attack_img = love.graphics.newImage("assets/robot_attack.png"),

	robot_img = {
		love.graphics.newImage("assets/robot_walk_0.png"),
		love.graphics.newImage("assets/robot_walk_1.png")
	},

	layer = 2,
	lives = 3,

  init = function(self, x, y)
    GameObject.init(self, x, y, 16, 8)
    self.t = 0
  	w = self.img:getWidth()
		h = self.img:getHeight()
		self.transformation = 0
		self.attack = 0
  end
}
Truck:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function Truck:draw()
	local x, y = self.x, self.y
	local snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

	-- colour
	inColourCanvas(2)
	if BOOM > 0 then
 		white()
 	else
 		darkBlue()
 	end

 	-- car colour
 	if self.transformation ~= 1 then
 		rekt(snap_x - 40, snap_y - 32, 80, 40)
 	end

 	-- bot colour
 	if self.transformation ~= 0 then
		rekt(snap_x - 32, snap_y - 60, 32, 104)
	end

 	-- car
	if self.transformation == 0 then
		inAlphaCanvas(2)
		if self.t > 1 then
	 		draw(self.img, x, y, 0, 1, 1, 32, 32)
	 	else
	 		draw(self.img2, x, y, 0, 1, 1, 32, 32)
	 	end

 	-- robot
	else
		local frame = math.min(#self.trans_img, math.floor(self.transformation*#self.trans_img) + 1)
		inAlphaCanvas(2)
		if self.transformation == 1 then
		if self.t > 1 then
	 		draw(self.robot_img[1], x, y, 0, 1, 1, 32, 64)
	 	else
	 		draw(self.robot_img[2], x, y, 0, 1, 1, 32, 64)
	 	end
		else
			draw(self.trans_img[frame], x, y, 0, 1, 1, 32, 64)
		end

		-- robot sword
		if self.attack > 0 then
			inColourCanvas(2)
			green()
			rekt(snap_x, snap_y - 60, 32, 104)
			inAlphaCanvas(2)
			draw(self.attack_img, x - 16, y, 0, 1, 1, 0, 64)
		end
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


	-- movement
	local speed
	if self.transformation == 1 then
		speed = 32
	elseif self.transformation == 0 then
		speed = 128
	else
		speed = 24
	end
	self.x, self.y = self.x + speed*kx*dt, self.y + speed*ky*dt

	-- borders
	if self.x < left then self.x = left end
	if self.x > right then self.x = right end
	if self.y < top then self.y = top end
	if self.y > bottom then self.y = bottom end

	self.t = self.t + dt*10
	if self.t > 2 then
		self.t = 0
	end

	-- transform
	if self.robot and (self.transformation < 1 )then
		self.transformation = math.min(1, self.transformation + 3*dt)
	elseif (not self.robot) and (self.transformation > 0) then
		self.transformation = math.max(0, self.transformation - 3*dt)
	end

	-- end attack
	self.attack = math.max(0, self.attack - 3*dt)
end

function Truck:eventCollision(other)
	if other:isType("Car") then
		other:explode()
		if self.transformation ~= 1 then
			self.lives = self.lives - 1
			if self.lives == 0 then
				self.purge = true
			end
		else
			-- attack!
			self.attack = 1
			score = score + 1
		end


	elseif other:isType("Bomb") then
		other:explode()
		self.lives = self.lives - 1
		if self.lives == 0 then
			self.purge = true
		end
	end



end

function Truck:transform()
	if self.robot and (self.transformation ~= 1) then
		return
	end
	if (not self.robot) and (self.transformation ~= 0) then
		return
	end
	self.robot = (not self.robot)
end

--[[------------------------------------------------------------
Export
--]]--


return Truck