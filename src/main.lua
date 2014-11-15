local W, H = 384, 288
local w, h = 256, 192

local screen = love.graphics.newCanvas(w, h)

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	love.mouse.setVisible(false)
end

local x, y = 100, 100

function love.draw()

	love.graphics.setCanvas(screen)

		for i = 1, 50 do
			love.graphics.push()
				love.graphics.setColor(100 + math.random(100), 100 + math.random(100), 50 + math.random(100))
				local x, y, w, h = math.random(w), math.random(h), math.random(100), math.random(100)
				love.graphics.rectangle("fill", x - w*0.5, y - h*0.5, w, h)
			love.graphics.pop()
		end

		love.graphics.setColor(255, 0, 0)
	  	love.graphics.rectangle("fill", x - 20, y - 20, 40, 40)
	  love.graphics.setColor(255, 255, 255)

 	love.graphics.setCanvas(nil)

 	love.graphics.translate((W - w)*0.5, (H - h)*0.5)
 	love.graphics.draw(screen)

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