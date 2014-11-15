local x, y, snap_x, snap_y = 0, 0, 0, 0
local img
local w, h

local truck = {

	load = function()
		img = love.graphics.newImage("assets/truck.png")
		w = img:getWidth()
		h = img:getHeight()
	end,
	
	draw = function()
		inColourCanvas(2)
	 	darkBlue()
	 	rekt(snap_x - 40, snap_y - 24, 80, 48)

		inAlphaCanvas(2)
	 	draw(img, x, y, 0, 1, 1, 32, 16)
	end,

	update = function(dt)
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
		x, y = x + 128*kx*dt, y + 128*ky*dt
		if x < 32 then x = 32 end
		if x > 96 then x = 96 end
		if y < 88 then y = 88 end
		if y > 136 then y = 136 end

		-- snap position to nearest 8
		snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8
	end
}


return truck