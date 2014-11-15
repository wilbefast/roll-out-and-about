-------------------------------------------------------------------------------
-- UTILITY FUNCTIONS
-------------------------------------------------------------------------------
function draw(img, x, y, r, sx, sy, ox, oy) love.graphics.draw(img, x, y, r, sx, sy, ox, oy) end
function rekt(m, x, y, w, h) love.graphics.rectangle(m, x, y, w, h) end
function scale(k) love.graphics.scale(k, k) end
function shader(s) love.graphics.setShader(s) end
function origin() love.graphics.origin() end
function mode(m) love.graphics.setBlendMode(m or "alpha") end
function white() love.graphics.setColor(255, 255, 255, 255) end
function black() love.graphics.setColor(0, 0, 0, 255) end
function yellow() love.graphics.setColor(255, 255, 0, 255) end
function blue() love.graphics.setColor(0, 0, 255, 255) end
function red() love.graphics.setColor(255, 0, 0, 255) end
function teal() love.graphics.setColor(0, 255, 255, 255) end
function violet() love.graphics.setColor(255, 0, 255, 255) end
function green() love.graphics.setColor(0, 255, 0, 255) end
function darkYellow() love.graphics.setColor(192, 192, 0, 255) end
function darkBlue() love.graphics.setColor(0, 0, 192, 255) end
function darkRed() love.graphics.setColor(192, 0, 0, 255) end
function darkTeal() love.graphics.setColor(0, 192, 192, 255) end
function darkViolet() love.graphics.setColor(192, 0, 192, 255) end
function darkGreen() love.graphics.setColor(0, 192, 0, 255) end
function reset()
	white()
	origin()
	mode("alpha")
	shader(nil)
end
function canvas(c) 
	love.graphics.setCanvas(c) 
	reset() 
end
function clear()
 	black()
 		rekt("fill", 0, 0, 500, 500)
	white()
end


-------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------

-- display
local W, H = 384, 288
w, h = 256, 192
local gw, gh
local screenCanvas
local alphaCanvas = {}
local colourCanvas = {}
function inAlphaCanvas(i) 
	canvas(alphaCanvas[i])
end
function inColourCanvas(i) 
	canvas(colourCanvas[i])
	scale(1/8)
end
local screenScale = 1
local palette

-- truck
local truck
local x, y = 100, 100

-------------------------------------------------------------------------------
-- INCLUDES
-------------------------------------------------------------------------------
local skyline_back = require("skyline_back")
local skyline_front = require("skyline_front")

-------------------------------------------------------------------------------
-- LOVE CALLBACKS
-------------------------------------------------------------------------------
function love.load()

	-- setup graphics
	gw, gh = love.graphics.getWidth(), love.graphics.getHeight()
	while (W*screenScale < gw) and (H*screenScale < gh) do
		screenScale = screenScale + 0.1
	end
	screenScale = screenScale - 0.1
	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	love.mouse.setVisible(false)

	-- palette shader
	palette = love.graphics.newShader("zx.fs")
	palette:send("colors", 
		{1, 1, 1, 1},  
		{1, 1, 1, 1},
		{1, 0, 0, 1},
		{0, 1, 0, 1},
		{0, 0, 1, 1},
		{1, 1, 0, 1},
		{0, 1, 1, 1},
		{1, 0, 1, 1},
		{0.8, 0.8, 0.8, 1},
		{0.8, 0, 0, 1},
		{0, 0.8, 0, 1},
		{0, 0, 0.8, 1},
		{0.8, 0.8, 0, 1},
		{0, 0.8, 0.8, 1},
		{0.8, 0, 0.8, 1})

	-- canvases
	screenCanvas = love.graphics.newCanvas(W, H)
	alphaCanvas = {
		love.graphics.newCanvas(w, h),
		love.graphics.newCanvas(w, h)
	}
	colourCanvas = {
		love.graphics.newCanvas(w/8, h/8),
		love.graphics.newCanvas(w/8, h/8)
	}

	-- game objects
	truck = love.graphics.newImage("truck.png")
	skyline_back.load()
	skyline_front.load()
end


function love.draw()
	-- snap position to nearest 8
	snap_x, snap_y = math.floor(x/8)*8, math.floor(y/8)*8

	-- clear workspace
	for i = 1, 1 do
		inColourCanvas(i)
		clear()
		inAlphaCanvas(i)
		clear()
	end

	-- colour 1
	inColourCanvas(1)
 	blue()
 	rekt("fill", snap_x - 40, snap_y - 24, 80, 48)

	-- alpha 1
	inAlphaCanvas(1)
 	draw(truck, x, y, 0, 1, 1, 32, 16)

 	-- skyline
	skyline_back.draw()
	skyline_front.draw()

	-- render border to screen
	canvas(screenCanvas)
	clear()
 	rekt("fill", 0, 0, W, H)

 	-- collapse colour/alpha into screen
 	for i = 1, 2 do
 		canvas(alphaCanvas[i])
 		mode("multiplicative")
 		shader(palette)
 		draw(colourCanvas[i], 0, 0, 0, 8, 8)

 		canvas(screenCanvas)
 		love.graphics.translate((W - w)*0.5, (H - h)*0.5)
 		draw(alphaCanvas[i])
 	end

 	-- finalise
 	canvas(nil)
 	clear()
	draw(screenCanvas, gw*0.5, gh*0.5, 0, screenScale, screenScale, W*0.5, H*0.5)



--[[

 	-- prepare alpha canvases
	love.graphics.setCanvas(alphaCanvas)

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

 	-- combine colour and alpha
 	for i = 1, 2 do


 	end


	-- render border
	love.graphics.setCanvas(screenCanvas)
	love.graphics.setBlendMode("alpha")
 	love.graphics.rectangle("fill", 0, 0, W, H)





 	

 	love.graphics.push()
	white()
 	love.graphics.translate(W*0.5, H*0.5)
			
			
		love.graphics.setBlendMode("alpha")
		white()
		love.graphics.setShader(shader)
			love.graphics.draw(colourCanvas, 0, 0, 0, 8, 8, w/16, h/16)
		love.graphics.setShader(nil)




		love.graphics.setBlendMode("multiplicative")
		white()
			love.graphics.draw(alphaCanvas, 0, 0, 0, 1, 1, w/2, h/2)

	love.graphics.pop()
 	love.graphics.setCanvas(nil)

 	-- render to the screen 	
 	love.graphics.setBlendMode("alpha")
 	love.graphics.draw(screenCanvas, gw*0.5, gh*0.5, 0, scale, scale, W*0.5, H*0.5)



]]


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