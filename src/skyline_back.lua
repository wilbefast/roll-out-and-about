local x = 0
local img
local w, h

local skyline_back = {

	h = function()
		return h
	end,

	load = function()
		img = love.graphics.newImage("assets/skyline_back.png")
		w, h = img:getWidth(), img:getHeight()
	end,
	
	draw = function() 
		inAlphaCanvas(2)
		draw(img, x, 0)
		draw(img, x + w, 0)

		inColourCanvas(2)
		darkBlue()
		rekt(0, 0, w, h)

		inAlphaCanvas(1)
		black()
		rekt(0, 0, w, h)

		inColourCanvas(1)
		rekt(0, 0, w, h)

	end,

	update = function(dt)
		x = x - dt*128
		if x < -w then
			x = 0
		end
	end
}


return skyline_back