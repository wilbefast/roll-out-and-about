local x, snap_x = 0, 0
local img
local w, h

local skyline_front = {

	load = function()
		img = love.graphics.newImage("assets/skyline_front.png")
		w = img:getWidth()
		h = img:getHeight()
	end,
	
	draw = function()


		inAlphaCanvas(1)
		draw(img, snap_x, 192 - h)
		draw(img, snap_x + w, 192 - h)

		inColourCanvas(1)
		darkRed()
		rekt("fill", 0, 192 - h, w, h)
	end,

	update = function(dt)
		x = x - dt*256
		if x < -w then
			x = 0
		end
		snap_x = math.floor(x/8)*8
	end
}


return skyline_front