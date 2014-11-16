local x, snap_x = 0, 0
local img
local w, h

local skyline_front = {

	load = function()
		img = love.graphics.newImage("assets/skyline_front.png")
		w, h = img:getWidth(), img:getHeight()
	end,
	
	draw = function()

		local y = 192 - h
		inAlphaCanvas(2)
			draw(img, snap_x, y)
			draw(img, snap_x + w, y)

		inColourCanvas(2)
			darkViolet()
			rekt(0, y, w, h)
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