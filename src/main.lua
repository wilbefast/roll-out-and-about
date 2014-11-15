-------------------------------------------------------------------------------
-- UTILITY FUNCTIONS
-------------------------------------------------------------------------------
function draw(img, x, y, r, sx, sy, ox, oy) love.graphics.draw(img, x, y, r, sx, sy, ox, oy) end
function rekt(x, y, w, h) love.graphics.rectangle("fill", x, y, w, h) end
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
 		rekt(0, 0, 500, 500)
	white()
end

function clearAlpha()
 	love.graphics.setColor(0, 0, 0, 0)
 		rekt(0, 0, 500, 500)
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

-------------------------------------------------------------------------------
-- INCLUDES
-------------------------------------------------------------------------------
local skyline_back = require("skyline_back")
local skyline_front = require("skyline_front")
local truck = require("truck")

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
		{0, 0, 0, 1},  
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
	truck.load()
	skyline_back.load()
	skyline_front.load()
end


function love.draw()
	-- clear workspace
	for i = 1, 2 do
		colourCanvas[i]:clear()
		alphaCanvas[i]:clear()
	end

 	-- background
	inAlphaCanvas(1)
		rekt(0, 0, w, h)
	skyline_back.draw()

	local y = skyline_back.h()
	inColourCanvas(1)
		black()
		rekt(0, y, w, 32)

	-- road
	-- ... top border
		white()
		rekt(0, 64, w, 8)
	-- ... tarmac
	inColourCanvas(1)
		darkTeal()
		rekt(0, 72, w, 80)
	--... bottom border
	inColourCanvas(1)
		rekt(0, 152, w, 8)

	-- truck
	truck.draw()

	-- foreground
	skyline_front.draw()

	-- render border to screen
	canvas(screenCanvas)
	clearAlpha()
 	rekt(0, 0, W, H)
 	love.graphics.setColor(math.random(255), math.random(255), math.random(255))
 	rekt((W - w)*0.5, (H - h)*0.5, w, h)

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
	--draw(colourCanvas[1])
end

function love.update(dt)
	skyline_back.update(dt)
	skyline_front.update(dt)
	truck.update(dt)
end

function love.keypressed(key)
 if key == "escape" then
  love.event.quit()
 end
end