local x = 0
local img
local w, h

local skyline_front = {

	load = function()
		img = love.graphics.newImage("skyline_front.png")
		w = img:getWidth()
		h = img:getHeight()
	end,
	
	draw = function()
		local snap_x = math.floor(x/8)*8

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
	end
}


return skyline_front