local x = 0
local img
local w

local skyline_back = {

	load = function()
		img = love.graphics.newImage("skyline_back.png")
		w = img:getWidth()
	end,
	
	draw = function() 
		love.graphics.draw(img, x, 0)
		love.graphics.draw(img, x + w, 0)
	end,

	update = function(dt)
		x = x - dt*128
		if x < -w then
			x = 0
		end
	end
}


return skyline_back