local W, H = 384, 288
local w, h = 256, 192

local alphaCanvas
local colourCanvas
local shader
local lena

function love.load()

	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	lena = love.graphics.newImage("lena.jpg")

	love.mouse.setVisible(false)

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

function white() love.graphics.setColor(255, 255, 255, 255) end
function black() love.graphics.setColor(0, 0, 0, 255) end

function love.draw()
	-- reset
	love.graphics.setBlendMode("alpha")
	love.graphics.origin()
	white()

	-- prepare colour canvas
	love.graphics.setCanvas(colourCanvas)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(lena, 0, 0, 0, 1/8, 1/8)

 	love.graphics.setCanvas(nil)

 	-- prepare alpha canvas
	love.graphics.setCanvas(alphaCanvas)

		 love.graphics.setColor(0, 0, 0, 255)
		 love.graphics.rectangle("fill", 0, 0, w, h)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", x - 50, y - 50, 100, 100)

	love.graphics.setCanvas(nil)


 	-- render to the screen
 	love.graphics.push()
 	love.graphics.translate((W - w)*0.5, (H - h)*0.5)
			
		love.graphics.setBlendMode("alpha")
		white()
		love.graphics.setShader(shader)
			love.graphics.draw(colourCanvas, 0, 0, 0, 8, 8)
		love.graphics.setShader(nil)

		love.graphics.setBlendMode("multiplicative")
			love.graphics.draw(alphaCanvas, 0, 0, 0, 1, 1)

	love.graphics.pop()

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

	-- move avatar
	x, y = x + 128*kx*dt, y + 128*ky*dt

end

function love.keypressed(key)
 if key == "escape" then
  love.event.quit()
 end
end