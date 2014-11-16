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
  	gamestate.switch(game)
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
	rekt(-96, -40, 192, 56)
	rekt(-80, 24, 160, 48)

 	shader(blackAndWhite)
 	love.graphics.setFont(hugeFont)
	love.graphics.printf("ROLL OUT AND ABOUT", -96, -32, 192, "center")
 	love.graphics.setFont(font)
	love.graphics.printf("@wilbefast\n\n#RetroGameJam", -96, 32, 184, "center")
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state