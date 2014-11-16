local state = gamestate.new()

--[[------------------------------------------------------------
Gamestate navigation
--]]--

function state:init()
end

function state:enter()
end


function state:leave()
end

--[[------------------------------------------------------------
Callbacks
--]]--


function state:keypressed(key, uni)
  if key=="escape" then
    love.event.push("quit")
  elseif key==" " then
    gamestate.switch(title)
  end

end


function state:update(dt)
	border.setColour(darkTeal) 
	-- scrolling
	skyline_back.update(dt)
	skyline_front.update(dt)

end

function state:draw()
 	-- skyline
	inAlphaCanvas(1)
		rekt(0, 0, w, h)
	skyline_back.draw()

	-- background
	local y = skyline_back.h()
	inColourCanvas(1)
		black()
		rekt(0, y, w, 32)

	-- road
	road.draw()

	-- foreground
	skyline_front.draw()
end

function state:draw_overlay()
 	inScreenCanvas()
 	love.graphics.translate(W*0.5, H*0.5)
 	teal()
 		rekt(-56, -48, 112, 56)
 	shader(blackAndWhite)
 	love.graphics.setFont(bigFont)
	love.graphics.printf("Game Over\n\nScore: " .. score, -96, -40, 192, "center")
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state