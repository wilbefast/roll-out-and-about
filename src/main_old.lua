local W, H = 384, 288
local w, h = 256, 192
local gw, gh

local zxCanvas
local alphaCanvas
local colourCanvas
local shader
local lena
local truck
local truck_alpha
local zxScale = 1

function love.load()

	gw, gh = love.graphics.getWidth(), love.graphics.getHeight()

	while (W*zxScale < gw) and (H*zxScale < gh) do
		zxScale = zxScale + 0.1
	end
	zxScale = zxScale - 0.1


	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	lena = love.graphics.newImage("lena.jpg")
	truck = love.graphics.newImage("truck.png")
	truck_alpha = love.graphics.newImage("truck_alpha.png")

	love.mouse.setVisible(false)

	zxCanvas = love.graphics.newCanvas(W, H) 

	colourCanvas = love.graphics.newCanvas(w/8, h/8)

	alphaCanvas = love.graphics.newCanvas(w, h)

	shader = love.graphics.newShader("zx.fs")
	shader:send("colors", 
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

	-- prepare colour canvas
	love.graphics.setCanvas(colourCanvas)
	love.graphics.push()
	love.graphics.scale(1/8, 1/8)

	 	black()
	 	love.graphics.rectangle("fill", 0, 0, w, h)

		white()
		love.graphics.draw(truck, x, y, r, 1, 1, 32, 16)

	love.graphics.pop()
 	love.graphics.setCanvas(nil)

 	-- prepare alpha canvas
	love.graphics.setCanvas(alphaCanvas)

	 	black()
	 	love.graphics.rectangle("fill", 0, 0, w, h)

		white()
		love.graphics.draw(truck_alpha, x, y, r, 1, 1, 32, 16)

	love.graphics.setCanvas(nil)

	-- render border
	love.graphics.setCanvas(zxCanvas)
	love.graphics.setBlendMode("alpha")
 	love.graphics.rectangle("fill", 0, 0, W, H)
 	

 	love.graphics.push()
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
 	love.graphics.draw(zxCanvas, gw*0.5, gh*0.5, 0, zxScale, zxScale, W*0.5, H*0.5)

end

function love.update(dt)

	--r = r + dt

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

	-- move avatar
	x, y = x + 128*kx*dt, y + 128*ky*dt

end

function love.keypressed(key)
 if key == "escape" then
  love.event.quit()
 end
end