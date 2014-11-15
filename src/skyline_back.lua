local x = 0
local img
local w

local skyline_back = {

	load = function()
		img = love.graphics.newImage("assets/skyline_back.png")
		w = img:getWidth()
	end,
	
	draw = function() 
		inAlphaCanvas(1)
		draw(img, x, 0)
		draw(img, x + w, 0)

		inColourCanvas(1)
		darkBlue()
		rekt("fill", 0, 0, w, h)	
	end,

	update = function(dt)
		x = x - dt*128
		if x < -w then
			x = 0
		end
	end
}


return skyline_back