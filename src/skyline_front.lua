local x, snap_x = 0, 0
local img
local w, h

local skyline_front = {

	load = function()
		img = love.graphics.newImage("assets/skyline_front.png")
		w, h = img:getWidth(), img:getHeight()
	end,
	
	draw = function()


		inAlphaCanvas(2)
			draw(img, snap_x, 192 - h)
			draw(img, snap_x + w, 192 - h)

		inColourCanvas(2)
			darkViolet()
			rekt(0, 192 - h*0.5, w, h)
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