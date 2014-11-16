local x = 0
local img
local img_lights
local w, h

local lights_x = 0

local skyline_back = {

	h = function()
		return h
	end,

	load = function()
		img = love.graphics.newImage("assets/skyline_back.png")
		img_lights = love.graphics.newImage("assets/streetlights_back.png")
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


		-- street lights
		inAlphaCanvas(2)
			draw(img_lights, lights_x, h + 16)
			draw(img_lights, lights_x + w, h + 16)
		inColourCanvas(2)
			grey()
			rekt(0, h + 16, w, 16)
	end,

	update = function(dt)
		x = x - dt*128
		if x < -w then
			x = 0
		end

		lights_x = lights_x - dt*144
		if lights_x < -w then
			lights_x = 0
		end

	end
}


return skyline_back