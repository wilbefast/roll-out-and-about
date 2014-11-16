local x, snap_x = 0, 0
local img
local w, h

local lights_x = 0
local light_w

local skyline_front = {

	load = function()
		img = love.graphics.newImage("assets/skyline_front.png")
		img_lights = love.graphics.newImage("assets/streetlights_front.png")
		w, h, light_w = img:getWidth(), img:getHeight(), img_lights:getWidth()
	end,
	
	draw = function()

		local y 

		-- street lights
		y = 192 - h - 8
		inAlphaCanvas(2)
			draw(img_lights, lights_x, y)
			draw(img_lights, lights_x + light_w, y)
		inColourCanvas(2)
			grey()
			rekt(0, y, w, 32)

		-- buildings
		y = 192 - h
		inAlphaCanvas(2)
			draw(img, snap_x, y)
			draw(img, snap_x + w, y)

		inColourCanvas(2)
			darkViolet()
			draw(img, snap_x, y)
			draw(img, snap_x + w, y)



	end,

	update = function(dt)
		x = x - dt*256
		if x < -w then
			x = 0
		end
		snap_x = math.floor(x/8)*8


		lights_x = lights_x - dt*222
		if lights_x < -light_w then
			lights_x = 0
		end

	end
}


return skyline_front