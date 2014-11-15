local W, H = 384, 288
local w, h = 256, 192
local gw, gh

local screenCanvas
local gameCanvas
local truck
local scale = 1

local skyline_back = require("skyline_back")
local skyline_front = require("skyline_front")

function love.load()

	gw, gh = love.graphics.getWidth(), love.graphics.getHeight()

	while (W*scale < gw) and (H*scale < gh) do
		scale = scale + 0.1
	end
	scale = scale - 0.1

	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	truck = love.graphics.newImage("truck.png")

	love.mouse.setVisible(false)

	screenCanvas = love.graphics.newCanvas(W, H) 
	gameCanvas = love.graphics.newCanvas(w, h)


	skyline_back.load()
	skyline_front.load()
end

local x, y = 100, 100

local r = 0

function white() love.graphics.setColor(255, 255, 255, 255) end
function black() love.graphics.setColor(0, 0, 0, 255) end

function love.draw()

	-- reset
	love.graphics.setBlendMode("alpha")
	love.graphics.origin()
	white()

 	-- prepare alpha canvas
	love.graphics.setCanvas(gameCanvas)

	 	black()
	 	love.graphics.rectangle("fill", 0, 0, w, h)

	 	white()
			
			skyline_back.draw()

			love.graphics.rectangle("fill", 0, 71, w, 1)

			love.graphics.setColor(0, 192, 192)
				love.graphics.rectangle("fill", 0, 72, w, 72)
			white()

			love.graphics.rectangle("fill", 0, 144, w, 2)

			love.graphics.draw(truck, x, y, r, 1, 1, 32, 16)

			skyline_front.draw()
		white()

	love.graphics.setCanvas(nil)

	-- render border
	love.graphics.setCanvas(screenCanvas)
	love.graphics.setBlendMode("alpha")
 	love.graphics.rectangle("fill", 0, 0, W, H)
 	

 	love.graphics.push()
	white()
 	love.graphics.translate(W*0.5, H*0.5)
			
		love.graphics.setBlendMode("alpha")
		love.graphics.draw(gameCanvas, 0, 0, 0, 1, 1, w/2, h/2)

	love.graphics.pop()
 	love.graphics.setCanvas(nil)

 	-- render to the screen 	
 	love.graphics.setBlendMode("alpha")
 	love.graphics.draw(screenCanvas, gw*0.5, gh*0.5, 0, scale, scale, W*0.5, H*0.5)

end

function love.update(dt)

	-- keyboard
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

	-- parallax
	skyline_back.update(dt)
	skyline_front.update(dt)

	-- turn avatar
	-- if kx > 0 then
	-- 	r = math.pi/4
	-- elseif kx < 0 then
	-- 	r = -math.pi/4
	-- else
	-- 	r = 0
	-- end

	-- move avatar
	x, y = x + 128*kx*dt, y + 128*ky*dt
	if x < 32 then x = 32 end
	if x > 96 then x = 96 end
	if y < 88 then y = 88 end
	if y > 128 then y = 128 end

end

function love.keypressed(key)
 if key == "escape" then
  love.event.quit()
 end
end